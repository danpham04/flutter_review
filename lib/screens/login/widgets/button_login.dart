import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 300,
        height: 50,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue, Color.fromARGB(255, 243, 137, 172)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homeScreens);
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Center(
                child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
