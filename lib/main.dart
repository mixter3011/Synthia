import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assist/pages/home_page.dart';
import 'package:voice_assist/themes/theme_provider.dart';

void main() {
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ],
  child: const MyApp()
 ),
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synthia',
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

