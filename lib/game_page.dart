import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fruit_puzzles/home_page.dart';
import 'package:fruit_puzzles/utility.dart';
import 'level_page.dart';

class GamePage extends StatefulWidget {
  int levelNo;
  int pos;

  GamePage(this.levelNo, this.pos);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Utils.LEVELNO = widget.levelNo;

    _initImages();
  }

  List<String> ansLst = [];
  List randomLst = [];
  List tempLst = [];
  List posLst = [];

  bool states = false;

  Future _initImages() async {
    ansLst = Utils.imagePaths[Utils.LEVELNO]
        .split("/")[2]
        .split(".")[0]
        .split(""); // [a, p, p, l, e]

    List randomCharLst = "abcdefghijklmnopqrstuvwxyz".split("");
    randomCharLst.shuffle();

    randomLst = randomCharLst.getRange(0, 16 - ansLst.length).toList();
    randomLst.addAll(ansLst);
    randomLst.shuffle(); // [a, b, a, x, n, n, a, j, a, d]

    tempLst = List.filled(ansLst.length, "");

    posLst = List.filled(ansLst.length, 100);

    setState(() {
      states = true;
    });
  }

  Future<bool> goBack() {
    if (widget.pos == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const MyHomePage();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const LevelPage();
        },
      ));
    }

    return Future.value();
  }

  skipBtn() async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Skip"),
          titleTextStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
          ),
          titlePadding: const EdgeInsets.only(left: 25.0, top: 20.0),
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(
            gapPadding: 30.0,
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "Are you sure you want to skip this level?\nYou can play skipped leves later by clicking on LEVEL menu from main screen.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String pastStatus =
                          Utils.prefs.getString("status${Utils.LEVELNO}") ??
                              Utils.PENDING;

                      if (pastStatus == Utils.PENDING) {
                        await Utils.prefs
                            .setString("status${Utils.LEVELNO}", Utils.SKIP);
                        Utils.statusLst[Utils.LEVELNO] = Utils.SKIP;

                        Utils.LEVELNO++;
                        await Utils.prefs.setInt("levelNo", Utils.LEVELNO);

                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GamePage(Utils.LEVELNO, widget.pos);
                            },
                          ),
                        );
                      } else {
                        Utils.LEVELNO++;
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return GamePage(Utils.LEVELNO, widget.pos);
                          },
                        ));
                      }
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => goBack(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Puzzles ${Utils.LEVELNO + 1}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              fontFamily: "Lora",
            ),
          ),
          centerTitle: true,
          shadowColor: Colors.white,
          elevation: 10.0,
          backgroundColor: Colors.purpleAccent,
          toolbarHeight: 70.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  onPressed: () => skipBtn(),
                  tooltip: "Skip",
                  hoverColor: Colors.green,
                  highlightColor: Colors.purpleAccent,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                  icon: const Icon(Icons.skip_next,
                      color: Colors.red, size: 30.0)),
            ),
          ],
        ),
        body: states
            ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: (totalWidth * 45.0) / 100.0,
                width: (totalWidth * 45.0) / 100.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Image.asset(
                  Utils.imagePaths[Utils.LEVELNO],
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Container(
              height: 80,
              color: Colors.green,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: ansLst.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        if (tempLst[index] != "") {
                          setState(() {
                            randomLst[posLst[index]] = tempLst[index];
                            tempLst[index] = "";
                            posLst[index] = 100;
                          });
                        }
                      },
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tempLst[index].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 33.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: (totalHeight * 35.0) / 100.0,
              width: totalWidth,
              color: Colors.red,
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 1.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                scrollDirection: Axis.vertical,
                itemCount: 16,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () async {
                      for (int i = 0; i < tempLst.length; i++) {
                        if (tempLst[i] == "") {
                          setState(() {
                            tempLst[i] = randomLst[index];
                            randomLst[index] = "";
                            posLst[i] = index;
                            speak(tempLst[i]);
                          });

                          if (listEquals(tempLst, ansLst)) {
                            String pastStatus = Utils.prefs.getString(
                                "status${Utils.LEVELNO}") ??
                                Utils.PENDING;

                            if (pastStatus == Utils.PENDING) {
                              await Utils.prefs.setString(
                                  "status${Utils.LEVELNO}",
                                  Utils.CLEAR);
                              Utils.statusLst[Utils.LEVELNO] =
                                  Utils.CLEAR;

                              Utils.LEVELNO++;
                              await Utils.prefs
                                  .setInt("levelNo", Utils.LEVELNO);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GamePage(
                                        Utils.LEVELNO, widget.pos);
                                  },
                                ),
                              );
                            } else if (pastStatus == Utils.SKIP) {
                              await Utils.prefs.setString(
                                  "status${Utils.LEVELNO}",
                                  Utils.CLEAR);
                              Utils.statusLst[Utils.LEVELNO] =
                                  Utils.CLEAR;

                              Utils.LEVELNO++;
                              int lastlevel = Utils.prefs.getInt("levelNo") ?? 0;
                              if(Utils.LEVELNO>lastlevel)
                              {
                                await Utils.prefs.setInt("levelNo", Utils.LEVELNO);
                              }

                              await Utils.prefs
                                  .setInt("levelNo", Utils.LEVELNO);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GamePage(
                                        Utils.LEVELNO, widget.pos);
                                  },
                                ),
                              );
                            } else if (pastStatus == Utils.CLEAR) {
                              Utils.LEVELNO++;

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return GamePage(
                                        Utils.LEVELNO, widget.pos);
                                  },
                                ),
                              );
                            } else {
                              print("Lose");
                            }
                          }

                          break;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "${randomLst[index].toUpperCase()}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 33.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
