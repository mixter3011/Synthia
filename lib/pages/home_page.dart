import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assist/components/features_box.dart';
import 'package:voice_assist/components/my_drawer.dart';
import 'package:voice_assist/services/openai_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // This allows the body to be drawn behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Set elevation to 0 to remove the shadow
        title: const Text('SYNTHIA', style: TextStyle(fontFamily: 'Cera Pro'),),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background GIF
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg.gif', // Replace with your GIF file
                fit: BoxFit.fill,
              ),
            ),
            // Main content
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      height: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/assistant.webp',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // chat bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                    color: Colors.blue.shade100.withOpacity(0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Hello, How can I assist \n               you', 
                     style: TextStyle(
                      fontFamily: 'Cera Pro',
                       color: Colors.blue.shade900,
                       fontSize: 25,
                      ),
                     ),
                  ),
                 ),
                 Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 22,
                  ),
                  child: Text(
                    'Here are a few features',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Colors.blue.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                   ),
                 ),
                 // feature list
                 Column(
                  children: [
                    FeatureBox(
                      color: Colors.grey.shade200.withOpacity(0.3), 
                      headerText: 'ChatGPT', 
                      descriptionText: 'A smarter way to stay organized and informed with ChatGPT',
                    ),
                    FeatureBox(
                      color: Colors.grey.shade200.withOpacity(0.3), 
                      headerText: 'Dall-E', 
                      descriptionText: 'Get inspired and Stay Creative with your personal assistant',
                    ),
                    FeatureBox(
                      color: Colors.grey.shade200.withOpacity(0.3), 
                      headerText: 'Smart Voice Assistant', 
                      descriptionText: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                    ),
                  ],
                 )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue.shade200.withOpacity(0.5),
            onPressed: () async {
              if (await speechToText.hasPermission && speechToText.isNotListening) {
                await startListening();
              } else if(speechToText.isListening) {
                final speech = await openAIService.isArtPromptAPI(lastWords);
                await systemSpeak(speech);
                await stopListening();
              } else {
                initSpeechToText();
              }
            },
            child: const Icon(Icons.mic),
          ),
    );
  }
}
