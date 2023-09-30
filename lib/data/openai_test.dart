import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAiTest{
  Future<String> generateText(String prompt) async {
    final apiKey = '';
    final url = 'https://api.openai.com/v1/chat/completions';

    final requestData = {
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": prompt}],
      "temperature": 0.7
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData), // Use jsonEncode to serialize the data
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