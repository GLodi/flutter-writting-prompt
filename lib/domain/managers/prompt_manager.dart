import 'package:rxdart/rxdart.dart';
import 'package:writing_prompt/data/remote/prompt_api.dart';
import 'package:writing_prompt/data/local/db_helper.dart';
import 'package:writing_prompt/data/models/prompt.dart';

/// Here I am also supposed to check whether I already have a
/// prompt or not.
class PromptManager {
  PromptApi _api;
  DbHelper _dbHelper;

  PromptManager(this._api, this._dbHelper);

  Observable<Prompt> getPrompt() =>
      Observable.fromFuture(_api.fetchPrompt());

  Observable<int> insertPrompt(Prompt prompt) =>
      Observable.fromFuture(_dbHelper.insert(prompt));

  Observable<List<Prompt>> getListOfPrompts() =>
      Observable.fromFuture(_dbHelper.getPrompts());

  Observable<int> updatePrompt(Prompt prompt) =>
      Observable.fromFuture(_dbHelper.update(prompt));

}