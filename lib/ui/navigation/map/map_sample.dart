import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:arbocanoas/config/application_messages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/preferences.dart';
import '../../../global/application_constant.dart';
import '../../../model/user.dart';
import '../../../res/dimens.dart';
import '../../../web_service/links.dart';
import '../../../web_service/service_response.dart';
import '../../components/custom_app_bar.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  final postRequest = PostRequest();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<Marker> mMarkers = [];

  @override
  void initState() {
    saveFcm();
    super.initState();
  }

  Future<List<Map<String, dynamic>>> listAll() async {
    try {
      final body = {"token": ApplicationConstant.TOKEN};

      print('HTTP_BODY: $body');

      final json = await postRequest.sendPostRequest(Links.LIST_ALL, body);

      List<Map<String, dynamic>> _map = [];
      _map = List<Map<String, dynamic>>.from(jsonDecode(json));

      print('HTTP_RESPONSE: $_map');

      final Uint8List markerIcon =
      await getBytesFromAsset('images/tree_icon.png', 100);

      for (var i = 0; i < _map.length; i++) {

        final response = User.fromJson(_map[i]);

        mMarkers.add(
          Marker(
            visible: true,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            markerId: MarkerId(response.id.toString()),
            position: LatLng(double.parse(response.latitude.toString().replaceAll(",", ".")), double.parse(response.longitude.toString().replaceAll(",", "."))),
          ),
        );

        _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(response.latitude.toString().replaceAll(",", ".")), double.parse(response.longitude.toString().replaceAll(",", "."))),
          zoom: Dimens.zoomMap,
        );

      }

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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
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

/*  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: "", isVisibleNotificationsButton: true),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: listAll(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // if (snapshot.hasData) {
                  return Stack(children: [
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
                    Visibility(
                      visible: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: double.infinity,
                              child: Card(
                                  elevation: Dimens.elevationApplication,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimens.minRadiusApplication),
                                  ),
                                  margin: EdgeInsets.all(
                                      Dimens.minMarginApplication),
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        Dimens.paddingApplication),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 20,
                                      )
                                    ]),
                                  )))
                        ],
                      ),
                    ),
                  ]);
            /*  } else {
                return Container();
              }*/
            }));
  }
/*
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
