import 'package:writing_prompt/data/local/db_helper.dart';
import 'package:writing_prompt/data/remote/prompt_api.dart';
import 'package:writing_prompt/data/models/prompt.dart';
import 'package:mockito/mockito.dart';
import 'package:writing_prompt/domain/bloc/prompt_bloc.dart';

class MockPrompt extends Mock implements Prompt {}
class MockDbHelper extends Mock implements DbHelper {}
class MockApi extends Mock implements PromptApi {}
class MockBloc extends Mock implements PromptBloc {}