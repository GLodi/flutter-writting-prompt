import 'package:test/test.dart';
import 'dart:async';
import 'dart:convert';
import 'package:writing_prompt/data/remote/prompt_api.dart';
import 'package:writing_prompt/data/models/prompt.dart';
import 'package:writing_prompt/domain/managers/prompt_manager.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  test("parse a simple Prompt object", () {
    const english = "name";
    const count = 10;
    const done = false;
    const jsonString =
        '{"english": "$english", "count": $count, "done": "$done"}';

    final parsed = json.decode(jsonString);

    final prompt = Prompt.fromJson(parsed);

    expect(prompt.english, english);
    expect(prompt.count, count);
    expect(prompt.done, done);
  });

  test("network testing", () async {
    PromptApi api = PromptApi();
    Prompt prompt = await api.fetchPrompt();
    expect(prompt.english, isNotNull);
    expect(prompt.count, isNotNull);
  });

  test("manager test", () async {
    const english = "name";
    const count = 10;
    var api = MockApi();
    var db = MockDbHelper();

    var promptRemote = MockPrompt();
    when(promptRemote.english).thenReturn(english);
    when(promptRemote.count).thenReturn(count);

    when(api.fetchPrompt()).thenAnswer((_) => Future(() => promptRemote));
    var prompt = Prompt(count, english, false);

    var manager = PromptManager(api, db);

    manager.getPrompt().listen(
        expectAsync1((value) {
          expect(value.english, prompt.english);
        }, count: 1));
  });
}