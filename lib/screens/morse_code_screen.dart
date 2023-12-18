import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:signify/screens/speechToSign.dart';
import 'package:signify/widgets/app_bar.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:signify/utils/utils.dart' as utils;

class MorseCodeScreen extends StatefulWidget {
  const MorseCodeScreen({super.key});

  @override
  State<MorseCodeScreen> createState() => _MorseCodeScreenState();
}

class _MorseCodeScreenState extends State<MorseCodeScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  String _displaytext = 'Press the button and start speaking...';
  bool dot = false;
  bool dash = false;
  bool wordEnd = false;
  bool space = false;
  late AudioPlayer player;
  String input = "Input";
  late AudioCache cache;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    player = AudioPlayer();
    cache = player.audioCache;
    cache.loadAll(['audio/dot.mp3', 'audio/dash.mp3']);
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
                input = controller.text;
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
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (dash)
                        const Text(
                          "DASH",
                          style: TextStyle(fontSize: 64),
                        ),
                      if (dot)
                        const Text(
                          "DOT",
                          style: TextStyle(fontSize: 64),
                        ),
                      if (wordEnd)
                        const Text(
                          "WORD END",
                          style: TextStyle(fontSize: 64),
                        ),
                      if (space)
                        const Text(
                          "SPACE",
                          style: TextStyle(fontSize: 64),
                        ),
                    ],
                  ),
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
                      input,
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
                _displaytext = 'Press the button and start speaking...';
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
            glowColor: Theme.of(context).primaryColor,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.done : Icons.mic_none),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
          ),
          AvatarGlow(
            glowColor: Theme.of(context).primaryColor,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: false,
            child: FloatingActionButton(
              onPressed: () {
                _showInputDialog(context);
              },
              child: const Icon(Icons.text_fields),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
          ),
          AvatarGlow(
            glowColor: Theme.of(context).primaryColor,
            endRadius: 55.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: false,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpeechScreen()));
              },
              child: const Text(
                'SS',
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
      input = _text;
      translation(_text);
    }
  }

  void translation(String _text) async {
    print(_text);
    _displaytext = '';
    String speechStr = _text.toUpperCase();
    List<String> strArray = speechStr.split(" ");
    String morseText = "";
    for (String content in strArray) {
      for (int i = 0; i < content.length; i++) {
        String character = content[i];
        String moreVersion = utils.morseCode[character]!;
        for (int j = 0; j < moreVersion.length; j++) {
          morseText = morseText + moreVersion[j];
          setState(() {
            if (moreVersion[j] == '.') {
              dot = true;
              dash = false;
              wordEnd = false;
              space = false;
            } else if (moreVersion[j] == '-') {
              dot = false;
              dash = true;
              wordEnd = false;
              space = false;
            }
            _displaytext = morseText;
          });
          if (dot) {
            await player.play(AssetSource('audio/dot.mp3'));
          }
          if (dash) {
            await player.play(AssetSource('audio/dash.mp3'));
          }
          await Future.delayed(const Duration(milliseconds: 1000));
        }
        dot = false;
        dash = false;
        wordEnd = false;
        space = true;
        morseText = morseText + " ";
        setState(() {
          _displaytext = morseText;
        });
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      dot = false;
      dash = false;
      wordEnd = true;
      space = false;
      morseText = morseText + "  ";
      setState(() {
        _displaytext = morseText;
      });
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }
}
