import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'package:writing_prompt/data/local/db_helper.dart';
import 'package:writing_prompt/data/remote/prompt_api.dart';
import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';
import 'package:writing_prompt/domain/managers/prompt_manager.dart';
import 'package:writing_prompt/presentation/styles/colors.dart';
import 'package:writing_prompt/presentation/styles/strings.dart';
import 'package:writing_prompt/presentation/ui/home.dart';

void main() {
  // Another poor man's DI.
  final injector = Injector.getInjector();
  injector.map<DbHelper>((i) =>
    new DbHelper(), isSingleton: true);
  injector.map<PromptApi>((i) =>
    new PromptApi(), isSingleton: true);
  injector.map<PromptManager>((i) =>
    new PromptManager(i.get<PromptApi>(), i.get<DbHelper>()));
  injector.map<PromptBloc>((i) =>
    new PromptBloc(i.get<PromptManager>()));

  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        scaffoldBackgroundColor: titleBarBackground,
        canvasColor: bottomBarBackground,
        primaryColor: titleBarBackground,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.white54),
              subhead: TextStyle(fontFamily: 'Garamond', fontSize: 10.0))
      ),
      home: HomePage(),
    );
  }
}