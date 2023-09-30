import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAiTest{
  Future<String> generateText(String prompt) async {
    final apiKey = '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'; // Replace with your OpenAI API key
    final url = 'https://api.openai.com/v1/engines/davinci/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: '{"prompt": "$prompt", "max_tokens": 50}',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final generatedText = data['choices'][0]['text'] as String;
      return generatedText;
    } else {
      final Map<String, dynamic> data = json.decode(response.body);
      final message = data['error']['message'] as String;
      throw Exception('Failed to generate text: ${message}');
    }
  }

}