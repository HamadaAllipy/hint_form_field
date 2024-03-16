import 'package:flutter/material.dart';
import 'package:hint_form_field/hint_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Demo')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: HintFormField(
            hintFormat: '## # # # # ##',
          ),
        ),
        // body: PinCodeVerificationScreen(),
      ),
    );
  }
}
