import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:writing_prompt/data/models/prompt.dart';

class PromptApi {
  final url ='https://ineedaprompt.com/dictionary/default/prompt?q=adj+noun+adv+verb+noun+location';

  Future<Prompt> fetchPrompt() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return compute(parsePrompt, response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

}

Prompt parsePrompt(String responseBody)  {
  final parsed = json.decode(responseBody);
  return Prompt.fromJson(parsed);
}