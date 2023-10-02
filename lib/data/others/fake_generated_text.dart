import 'dart:math';
import 'package:flutter/material.dart';



class FakeGenerator extends ChangeNotifier{
  List<String> possileResponses = [
    'As an AI language model ... you know what? No!',
    'Why don\'t you do a google search instead',
    'Please leave me alone :)',
    'Hi there! This response is hardcoded so it\'s probably not what you want'
  ];
  // String generatedText = '';
  Future<String>  generate(String query) async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => possileResponses[Random().nextInt(possileResponses.length)]
    );
  }
}