import 'package:flutter/material.dart';
import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';
import 'package:writing_prompt/data/models/prompt.dart';
import 'package:writing_prompt/presentation/styles/colors.dart';
import 'package:writing_prompt/presentation/styles/dimensions.dart';
import 'package:writing_prompt/presentation/styles/strings.dart';
import 'package:writing_prompt/presentation/styles/text_styles.dart';
import 'package:writing_prompt/domain/bloc/block_provider.dart';

class PromptListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PromptListPageState();
  }
}

class _PromptListPageState extends State<PromptListPage> {
  PromptBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PromptBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('List', style: titleBarTextStyle(),),
        elevation: 0.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: screenPadding, left: screenPadding, right: screenPadding),
          child: StreamBuilder<List<Prompt>>(
            stream: bloc.promptHistory,
            builder: (context, snapshot) =>
              snapshot.data == null ?
                Text(
                    emptyHistory,
                    key : Key(key_empty_history_text)
                ) :
                ListView(
                  key: Key(key_history_list),
                  children: snapshot.data.map(_buildItem).toList(),
                ),
          ),
        ),
      ),
      backgroundColor: titleBarBackground,
    );
  }

  Widget _buildItem(Prompt prompt) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: screenPadding, right: screenPadding, bottom: listPadding, top: listPadding),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(prompt.english)
            ),
            Checkbox(
                value: prompt.done == null ? false : prompt.done,
                onChanged: (bool newValue) {
                  setState(() {
                    prompt.done = newValue;
                    bloc.promptUpdate.add(prompt);
                  });
                }
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: new Border(
              bottom: new BorderSide()
          )
      ),
    );
  }
}