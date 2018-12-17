// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writing_prompt/data/models/prompt.dart';

import 'package:writing_prompt/main.dart';
import 'package:writing_prompt/presentation/styles/strings.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'mocks.dart';

import 'package:writing_prompt/data/local/db_helper.dart';
import 'package:writing_prompt/data/remote/prompt_api.dart';
import 'package:writing_prompt/domain/managers/prompt_manager.dart';
import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';

void main() {
  const bottomBarKey = Key(key_bottom_bar);

  final injector = Injector.getInjector();
  injector.map<String>((i) =>
  'https://ineedaprompt.com/dictionary/default/prompt?q=adj+noun+adv+verb+noun+location', key: 'api_url');
  injector.map<DbHelper>((i) =>
    new DbHelper(), isSingleton: true);
  injector.map<PromptApi>((i) =>
    new PromptApi(), isSingleton: true);
  injector.map<PromptManager>((i) =>
    new PromptManager(i.get<PromptApi>(), i.get<DbHelper>()), isSingleton: true);
  injector.map<PromptBloc>((i) =>
    new PromptBloc(i.get<PromptManager>()), isSingleton: true);

  testWidgets('When we open app, home is selected', (WidgetTester tester) async {
    var bloc = MockBloc();
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    expect(find.byKey(Key(key_bottom_bar)), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.list), findsOneWidget);
    // current index is 0
    BottomNavigationBar bar = tester.firstWidget(find.byKey(bottomBarKey));
    expect(bar.currentIndex, 0);
  });


  testWidgets('When we click on lists, the index changes and the new page appears', (WidgetTester tester) async {
    var bloc = MockBloc();
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    await tester.tap(
        find.byIcon(Icons.list)
    );
    await tester.pump();
    // current index is 1
    BottomNavigationBar bar = tester.firstWidget(find.byKey(Key(key_bottom_bar)));
    expect(bar.currentIndex, 1);
  });

  testWidgets('Correct text appears on widget', (WidgetTester tester) async {
    var bloc = MockBloc();
    const text = "String test";
    List<Prompt> list = List<Prompt>();
    list.add(Prompt(10, text, false));
    when(bloc.prompt).thenAnswer((_) => Stream.fromIterable(list));
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    await tester.pump();

    Text textWidget = tester.firstWidget(find.byKey(Key(key_prompt_text)));
    expect(textWidget.data, text);
  });

  testWidgets('When we cannot fetch a prompt, display empty message', (WidgetTester tester) async {
    var bloc = MockBloc();
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    await tester.pump();

    Text textWidget = tester.firstWidget(find.byKey(Key(key_prompt_text)));
    expect(textWidget.data, emptyPrompt);
  });

  testWidgets('When no history, display empty message', (WidgetTester tester) async {
    var bloc = MockBloc();
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    await tester.tap(
        find.byIcon(Icons.list)
    );
    await tester.pump();

    Text text = tester.firstWidget(find.byKey(Key(key_empty_history_text)));
    expect(text.data, emptyHistory);
  });

  testWidgets('Correct number of items on history', (WidgetTester tester) async {
    var bloc = MockBloc();
    const text = "String test";
    List<List<Prompt>> promptLists = List<List<Prompt>>();
    List<Prompt> list = List<Prompt>();
    list.add(Prompt(10, text, false));
    promptLists.add(list);
    when(bloc.promptHistory).thenAnswer((_) => Stream.fromIterable(promptLists));
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    await tester.pump();

    await tester.tap(
        find.byIcon(Icons.list)
    );

    await tester.pump();
    // second pump is to guarantee that the stream is sent
    await tester.pump();

    ListView listView = tester.firstWidget(find.byKey(Key(key_history_list)));
    expect(listView.childrenDelegate.estimatedChildCount, 1);
  });
}
