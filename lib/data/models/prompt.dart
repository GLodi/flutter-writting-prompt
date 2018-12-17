class Prompt {
  int count;
  String english;
  bool done;

  Prompt(this.count, this.english, this.done);

  Prompt.fromMap(Map<String, dynamic> map) {
    count = map['count'];
    english = map['english'];
    done = map['done'] == 1;
  }

  Prompt.fromJson(Map json) {
    count = json['count'] as int;
    english = json['english'] as String;
    done = json['done'] == 'true';
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'count' : count,
      'english': english,
      'done': done == true ? 1 : 0
    };
    return map;
  }

}