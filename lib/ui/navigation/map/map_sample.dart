import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:arbocanoas/config/application_messages.dart';
import 'package:arbocanoas/ui/components/alert_dialog_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/preferences.dart';
import '../../../global/application_constant.dart';
import '../../../model/tree.dart';
import '../../../model/user.dart';
import '../../../res/dimens.dart';
import '../../../res/owner_colors.dart';
import '../../../res/styles.dart';
import '../../../web_service/links.dart';
import '../../../web_service/service_response.dart';
import '../../components/alert_dialog_filter.dart';
import '../../components/custom_app_bar.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Tree? _actualItem = null;

  final postRequest = PostRequest();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final TextEditingController queryController = TextEditingController();

  final TextEditingController speciesController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController managementController = TextEditingController();
  final TextEditingController nbhController = TextEditingController();

  List<Marker> mMarkers = [];

  @override
  void initState() {
    saveFcm();
    // listAll("");
    super.initState();
  }

  @override
  void dispose() {
    queryController.dispose();

    speciesController.dispose();
    localController.dispose();
    managementController.dispose();
    nbhController.dispose();

    super.dispose();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //canoas
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-29.911244, -51.176982),
    zoom: Dimens.zoomMap,
  );

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<List<Map<String, dynamic>>> listAll(String? query) async {
    mMarkers.clear();

    try {
      var body = {};

      if (query != "") {
        body = {"busca": query, "token": ApplicationConstant.TOKEN};
      } else {
        body = {"token": ApplicationConstant.TOKEN};
      }

      print('HTTP_BODY: $body');

      final json = await postRequest.sendPostRequest(Links.LIST_ALL, body);

      List<Map<String, dynamic>> _map = [];
      _map = List<Map<String, dynamic>>.from(jsonDecode(json));

      print('HTTP_RESPONSE: $_map');

      final Uint8List markerIcon =
          await getBytesFromAsset('images/tree_icon.png', 100);

      for (var i = 0; i < _map.length; i++) {
        final response = Tree.fromJson(_map[i]);

        mMarkers.add(
          Marker(
            visible: true,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                shape: Styles().styleShapeBottomSheet,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (BuildContext context) {
                  return InfoAlertDialog(
                      title: "#" + response.codigo! + " | " + response.nome!,
                      tree: response);
                },
              );
            },
            markerId: MarkerId(response.id.toString()),
            position: LatLng(
                double.parse(response.latitude.toString().replaceAll(",", ".")),
                double.parse(
                    response.longitude.toString().replaceAll(",", "."))),
          ),
        );
      }

      setState(() {});
      return _map;
    } catch (e) {
      throw Exception('HTTP_ERROR: $e');
    }
  }

  Future<List<Map<String, dynamic>>> listAllFilter() async {
    mMarkers.clear();

    try {
      var body = {};

      // if (query != "") {

      body = {
        "especie": speciesController.text,
        "local": localController.text,
        "manejo": managementController.text,
        "bairro": nbhController.text,
        "token": ApplicationConstant.TOKEN
      };
      // } else {
      //   body = {"token": ApplicationConstant.TOKEN};
      // }

      print('HTTP_BODY: $body');

      final json = await postRequest.sendPostRequest(Links.LIST_ALL, body);

      List<Map<String, dynamic>> _map = [];
      _map = List<Map<String, dynamic>>.from(jsonDecode(json));

      print('HTTP_RESPONSE: $_map');

      final Uint8List markerIcon =
          await getBytesFromAsset('images/tree_icon.png', 100);

      for (var i = 0; i < _map.length; i++) {
        final response = Tree.fromJson(_map[i]);

        mMarkers.add(
          Marker(
            visible: true,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                shape: Styles().styleShapeBottomSheet,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (BuildContext context) {
                  return InfoAlertDialog(
                      title: "#" + response.codigo! + " | " + response.nome!,
                      tree: response);
                },
              );
            },
            markerId: MarkerId(response.id.toString()),
            position: LatLng(
                double.parse(response.latitude.toString().replaceAll(",", ".")),
                double.parse(
                    response.longitude.toString().replaceAll(",", "."))),
          ),
        );
      }

      setState(() {});
      return _map;
    } catch (e) {
      throw Exception('HTTP_ERROR: $e');
    }
  }

  Future<void> saveFcm() async {
    try {
      await Preferences.init();
      String? savedFcmToken = await Preferences.getInstanceTokenFcm();
      String? currentFcmToken = await _firebaseMessaging.getToken();
      if (savedFcmToken != null && savedFcmToken == currentFcmToken) {
        print('FCM: não salvou');
        return;
      }

      var _type = "";

      if (Platform.isAndroid) {
        _type = ApplicationConstant.FCM_TYPE_ANDROID;
      } else if (Platform.isIOS) {
        _type = ApplicationConstant.FCM_TYPE_IOS;
      } else {
        return;
      }

      final body = {
        "type": _type,
        "registration_id": currentFcmToken,
        "token": ApplicationConstant.TOKEN,
      };

      print('HTTP_BODY: $body');

      final json = await postRequest.sendPostRequest(Links.SAVE_FCM, body);

      List<Map<String, dynamic>> _map = [];
      _map = List<Map<String, dynamic>>.from(jsonDecode(json));

      print('HTTP_RESPONSE: $_map');

      final response = User.fromJson(_map[0]);

      if (response.status == "01") {
        await Preferences.saveInstanceTokenFcm("token", currentFcmToken!);
        setState(() {});
      } else {}
    } catch (e) {
      throw Exception('HTTP_ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            scrollGesturesEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            markers: mMarkers.toSet(),
            zoomControlsEnabled: false,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: Dimens.marginApplication),
            padding: EdgeInsets.all(Dimens.paddingApplication),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: Dimens.marginApplication,
                  ),
                  FloatingActionButton(
                      onPressed: () async {
                        final result = await showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          context: context,
                          shape: Styles().styleShapeBottomSheet,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (BuildContext context) {
                            return FilterAlertDialog(
                              speciesController: speciesController,
                              localController: localController,
                              managementController: managementController,
                              nbhController: nbhController,
                            );
                          },
                        );
                        if (result == true) {
                          listAllFilter();
                        }
                      },
                      child: Icon(
                        Icons.filter_list,
                        color: OwnerColors.colorPrimaryDark,
                        size: 24,
                      ),
                      backgroundColor: Colors.white,
                      mini: true),
                  SizedBox(
                    width: Dimens.minMarginApplication,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/ui/notifications");
                      },
                      child: Icon(
                        Icons.notifications_rounded,
                        color: OwnerColors.colorPrimaryDark,
                        size: 24,
                      ),
                      backgroundColor: Colors.white,
                      mini: true),
                ],
              ),
              SizedBox(
                height: Dimens.marginApplication,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextField(
              //         controller: queryController,
              //         decoration: InputDecoration(
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: OwnerColors.colorPrimary, width: 1.5),
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.grey, width: 1.0),
              //           ),
              //           hintText: 'Pesquisar pelo nome ou código...',
              //           hintStyle: TextStyle(color: Colors.grey),
              //           border: OutlineInputBorder(
              //             borderRadius:
              //                 BorderRadius.circular(Dimens.radiusApplication),
              //             borderSide: BorderSide.none,
              //           ),
              //           filled: true,
              //           fillColor: Colors.white,
              //           contentPadding:
              //               EdgeInsets.all(Dimens.textFieldPaddingApplication),
              //         ),
              //         keyboardType: TextInputType.text,
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: Dimens.textSize5,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: Dimens.marginApplication),
              //     Expanded(
              //       flex: 0,
              //       child: Container(
              //           margin: EdgeInsets.all(2),
              //           child: InkWell(
              //               onTap: () {
              //                 listAll(queryController.text.toString());
              //               },
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(
              //                       Dimens.minRadiusApplication),
              //                 ),
              //                 color: Colors.white,
              //                 child: Padding(
              //                   padding: EdgeInsets.all(
              //                       Dimens.minPaddingApplication),
              //                   child: Icon(Icons.search,
              //                       size: 30,
              //                       color: OwnerColors.colorPrimaryDark),
              //                 ),
              //               ))),
              //     ),
              //   ],
              // ),
            ]),
          ),
        ]));
  }
/*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
