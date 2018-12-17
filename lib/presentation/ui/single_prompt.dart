import 'package:flutter/material.dart';
import 'package:writing_prompt/data/models/prompt.dart';
import 'package:writing_prompt/presentation/styles/colors.dart';
import 'package:writing_prompt/presentation/styles/dimensions.dart';
import 'package:writing_prompt/presentation/styles/strings.dart';
import 'package:writing_prompt/presentation/styles/text_styles.dart';
import 'package:writing_prompt/presentation/utils/refresh_button.dart';
import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';
import 'package:writing_prompt/domain/bloc/block_provider.dart';

class SinglePromptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PromptBloc bloc = BlocProvider.of<PromptBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Single", style: titleBarTextStyle(),),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: StreamBuilder<Prompt>(
                  stream: bloc.prompt,
                  builder: (context, snapshot) =>
                      Text(
                        snapshot.data == null ? emptyPrompt : snapshot.data.english,
                        style: promptTextStyle(),
                        textAlign: TextAlign.center,
                        key: Key(key_prompt_text),
                      ),
                ),
                alignment: Alignment(0, 1),
              ),
            ),
            Expanded(
                child: Container(
                    child: RefreshPrompt(bloc),
                    alignment: Alignment(0, -1),
                ),
            ),
          ],
        ),
      ),
       backgroundColor: titleBarBackground,
    );
  }
}