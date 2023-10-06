import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fruit_puzzles/game_page.dart';
import 'package:fruit_puzzles/level_page.dart';
import 'package:fruit_puzzles/utility.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Do you want to exit ?",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        fontFamily: "Lora"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => exit(0),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade800),
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: const Text("No",
                            style: TextStyle(color: Colors.black)),
                      )
                    ],
                  )
                ],
              ),
            ),
            shadowColor: Colors.purpleAccent,
            elevation: 10.0,
            backgroundColor: Colors.purpleAccent,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    double containerHeight = (totalHeight * 50.0) / 100.0;
    double containerWidth = (totalWidth * 70.0) / 100.0;

    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.purpleAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: totalHeight - statusBar,
            width: totalWidth,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.purpleAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          "Puzzles",
                          style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                              fontFamily: "KaushanScript"),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                int levelNo =
                                    Utils.prefs.getInt("levelNo") ?? 0;
                                await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return GamePage(levelNo, 1);
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.red,
                                fixedSize: Size((containerWidth * 75.0) / 100.0,
                                    (containerHeight * 20.0) / 100.0),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: (containerWidth * 11.5) / 100.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lora",
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const LevelPage();
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.red,
                                fixedSize: Size((containerWidth * 75.0) / 100.0,
                                    (containerHeight * 20.0) / 100.0),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(
                                "Level",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: (containerWidth * 11.5) / 100.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lora",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
