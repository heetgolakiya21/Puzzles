import 'package:flutter/material.dart';
import 'package:fruit_puzzles/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils().initImages();

    push();
  }

  push() async {
    Utils.prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < Utils.imagePaths.length; i++) {
      String status = Utils.prefs.getString("status$i") ?? Utils.PENDING;
      Utils.statusLst.add(status);
    }

    await Future.delayed(const Duration(milliseconds: 500));

    await Navigator.pushReplacementNamed(context, "home_page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.purpleAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        alignment: Alignment.center,
        child: Image.asset(
          "img/logo.png",
          height: 120,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
