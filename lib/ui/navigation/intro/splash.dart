import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/preferences.dart';
import '../../../res/dimens.dart';
import '../../../res/owner_colors.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () async {

      await Preferences.init();

      if (await Preferences.getLogin()) {
        Navigator.pushReplacementNamed(context, '/ui/maps');
      } else {
        Navigator.pushReplacementNamed(context, '/ui/maps');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack( children: [
        Container(height: double.infinity, child:
          Image.asset(
            'images/background_splash.png',
            fit: BoxFit.fitHeight,
          )),
          Container(height: double.infinity,decoration: BoxDecoration(
            color: Color(0xA36B9142),
          )),
          Container(margin: EdgeInsets.only(top: 20),child:
          Center(
            child: Image.asset(
              height: MediaQuery.of(context).size.height / 3,
              'images/main_icon_1.png',
            ),
          )),
        ],
        ),

          ),
      );
  }
}
