This is just a mix of 2 different Flutter BLoC architectures:

@Vanethos's https://github.com/Vanethos/flutter-writting-prompt/blob/develop/lib/presentation/ui/home.dart

@boeledi's https://github.com/boeledi/Streams-Block-Reactive-Programming-in-Flutter

I liked the architecture of the former, but I also felt like it could be
improved upon with the help of a BlockProvider, provided by the latter.

Because in Flutter there is no straightforward dependency injection methodology at
this time, I decided to try @jonsawell's flutter_simple_dependency_injection:
https://github.com/jonsamwell/flutter_simple_dependency_injection.
All dependencies are created in main.dart and then requested by the single pages.

This project is intended for me to try the BLoC architecture in Flutter.