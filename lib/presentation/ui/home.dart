import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';
import 'package:writing_prompt/presentation/styles/strings.dart';
import 'package:writing_prompt/presentation/ui/prompt_list.dart';
import 'package:writing_prompt/presentation/ui/single_prompt.dart';
import 'package:writing_prompt/domain/bloc/block_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    if (_children.isEmpty) {
      buildChildren(context);
    }
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        key: Key(key_bottom_bar),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(navigationSinglePrompt),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text(navigationPromptList),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void buildChildren(BuildContext context) {
    _children = [
      BlocProvider(child: SinglePromptPage(), bloc: Injector.getInjector().get<PromptBloc>()),
      BlocProvider(child: PromptListPage(), bloc: Injector.getInjector().get<PromptBloc>())
    ];
  }
}