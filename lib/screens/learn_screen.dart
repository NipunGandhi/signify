import 'package:flutter/material.dart';
import 'package:signify/utils/utils.dart';

class LearnSign extends StatefulWidget {
  const LearnSign({super.key});

  @override
  State<LearnSign> createState() => _LearnSignState();
}

class _LearnSignState extends State<LearnSign> {
  String _img = 'space';
  String _ext = '.png';
  String _path = 'assets/letters/';
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 10),
                child: Image(
                  image: AssetImage('$_path$_img$_ext'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  key: ValueKey<int>(_state),
                  width: MediaQuery.of(context).size.width,
                  height: (4 / 3) * MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.orange,
                padding: const EdgeInsets.all(8.0).copyWith(top: 15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Characters",
                          style: TextStyle(color: Colors.black, fontSize: 18, ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          crossAxisCount: 8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: letters.map((letter) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _path = 'assets/letters/';
                                  _ext = ".png";
                                  _img = letter;
                                  _state += 1;
                                });

                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    _path = 'assets/letters/';
                                    _img = 'space';
                                    _ext = '.png';

                                    _state = 0;
                                  });
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Words",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: words
                              .asMap()
                              .entries
                              .where((entry) => entry.key.isEven)
                              .map((entry) {
                            final letter = entry.value;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _path = 'assets/ISL_Gifs/';
                                  _ext = ".gif";
                                  _img = letter;
                                  _state += 1;
                                });
                                Future.delayed(const Duration(seconds: 5), () {
                                  setState(() {
                                    _path = 'assets/letters/';
                                    _img = 'space';
                                    _ext = '.png';
                                    _state = 0;
                                  });
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
