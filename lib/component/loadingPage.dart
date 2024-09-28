import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tagr/constant/colors.dart';

class loadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SpinKitChasingDots(color: Color.fromARGB(255, 0, 57, 43),),
      ),
    );
  }

}