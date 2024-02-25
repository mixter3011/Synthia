import 'package:flutter/material.dart';
import 'package:voice_assist/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Stack(
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
               )
            ],
          ),
        ],
      ),
    );
  }
}
