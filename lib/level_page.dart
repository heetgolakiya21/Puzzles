import 'package:flutter/material.dart';
import 'package:fruit_puzzles/game_page.dart';
import 'package:fruit_puzzles/utility.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  int Levelno = Utils.prefs.getInt("levelNo") ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Puzzles",
          style: TextStyle(
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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
          itemCount: Utils.imagePaths.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // Clear Level
            if (Utils.statusLst[index] == Utils.CLEAR) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GamePage(index, 2);
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.red, width: 1.0),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Center(
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Image.asset(
                        "img/level_img/tick.png",
                        height: 20.0,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ],
                  ),
                ),
              );
            } else if (Utils.statusLst[index] == Utils.SKIP) {
              return InkWell(
                onTap: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GamePage(index, 2);
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.red, width: 1.0),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else if (index == Levelno) {
              return InkWell(
                onTap: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GamePage(index, 2);
                      },
                    ),
                  );
                },
                child: Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: Text("${index + 1}"),
                ),
              );
            }
            // Pending Level
            else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.red, width: 1.0),
                ),
                padding: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Center(
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Image.asset(
                      "img/level_img/lock.png",
                      height: 20.0,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
