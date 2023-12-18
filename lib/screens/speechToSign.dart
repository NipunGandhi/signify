import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:signify/widgets/app_bar.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:signify/utils/utils.dart' as utils;

import 'morse_code_screen.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  String _img = 'space';
  String _ext = '.png';
  String _path = 'assets/letters/';
  String _displaytext = 'Press the button and start speaking...';
  int _state = 0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _showInputDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Dialog'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter the message',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                translation(controller.text);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image(
                  image: AssetImage('$_path$_img$_ext'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  key: ValueKey<int>(_state),
                  width: MediaQuery.of(context).size.width,
                  height: (4 / 3) * MediaQuery.of(context).size.width,
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.orange,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 0.04 * MediaQuery.of(context).size.height,
                    child: Text(
                      _displaytext,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.orange,
                indent: 20,
                endIndent: 20,
              ),
            ],
          ),
        ),
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 1),
            () {
              setState(() {
                _text = '';
                _path = 'assets/letters/';
                _img = 'space';
                _ext = '.png';
                _displaytext = 'Press the button and start speaking...';
                _state = 0;
              });
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            animate: _isListening,
            glowColor: Colors.orange,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
          ),
          AvatarGlow(
            glowColor: Colors.orange,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: false,
            child: FloatingActionButton(
              onPressed: () {
                _showInputDialog(context);
              },
              child: const Icon(Icons.text_fields),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
          AvatarGlow(
            glowColor: Colors.orange,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: false,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MorseCodeScreen()));
              },
              child: const Text(
                'MC',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
        debugLogging: true,
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      translation(_text);
      _state = 0;
    }
  }

  void translation(String _text) async {
    _displaytext = '';
    String speechStr = _text.toLowerCase();
    List<String> strArray = speechStr.split(" ");
    for (String content in strArray) {
      if (utils.words.contains(content)) {
        String file = content;
        int idx = utils.words.indexOf(content);
        int _duration = int.parse(utils.words.elementAt(idx + 1));

        setState(() {
          _state += 1;
          _displaytext += content;
          _path = 'assets/ISL_Gifs/';
          _img = file;
          _ext = '.gif';
        });
        await Future.delayed(Duration(milliseconds: _duration));
      } else {
        String file = content;
        if (utils.hello.contains(file)) {
          file = 'hello';
          int idx = utils.words.indexOf(file);
          int _duration = int.parse(utils.words.elementAt(idx + 1));
          setState(() {
            _state += 1;
            _displaytext += content;
            _path = 'assets/ISL_Gifs/';
            _img = file;
            _ext = '.gif';
          });
          await Future.delayed(Duration(milliseconds: _duration));
        } else if (utils.you.contains(file)) {
          file = 'you';
          int idx = utils.words.indexOf(file);
          int _duration = int.parse(utils.words.elementAt(idx + 1));
          setState(() {
            _state += 1;
            _displaytext += content;
            _path = 'assets/ISL_Gifs/';
            _img = file;
            _ext = '.gif';
          });
          await Future.delayed(Duration(milliseconds: _duration));
        } else {
          for (var i = 0; i < content.length; i++) {
            if (utils.letters.contains(content[i])) {
              String char = content[i];
              setState(() {
                _state += 1;
                _displaytext += char;
                _path = 'assets/letters/';
                _img = char;
                _ext = '.png';
              });
              await Future.delayed(const Duration(milliseconds: 500));
            } else {
              String letter = content[i];
              setState(() {
                _state += 1;
                _displaytext += letter;
                _path = 'assets/letters/';
                _img = 'space';
                _ext = '.png';
              });
              await Future.delayed(const Duration(milliseconds: 500));
            }
          }
        }
      }
      setState(() {
        _state += 1;
        _displaytext += " ";
        _path = 'assets/letters/';
        _img = 'space';
        _ext = '.png';
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}
