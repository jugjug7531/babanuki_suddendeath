import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

/// 全問題リスト
@JsonSerializable(explicitToJson: true)
class Questions{
  /// 問題リスト
  List<Question> questionList = [];

  /// fromJson
  factory Questions.fromJson(Map<String, dynamic> json) => _$QuestionsFromJson(json);
  /// toJson
  Map<String, dynamic> toJson() => _$QuestionsToJson(this);

  /// コンストラクタ
  Questions({
      required this.questionList,
  });
}

/// 問題ページに渡す引数クラス
@JsonSerializable(explicitToJson: true)
class Question{
  /// 問題選択時のタイトル
  String title = "";
  /// 問題文
  String problemStatement = "";
  /// 選択肢
  List<Choice> choices = [];

  /// fromJson
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  /// toJson
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  /// コンストラクタ
  Question({
      required this.title,
      required this.problemStatement,
      required this.choices
  });
}

/// 選択肢カード作成時に必要な情報をまとめたクラス
@JsonSerializable()
class Choice{
  /// 選択肢
  String choice = "";
  /// 答えの説明文
  String explanation = "";
  /// 答え
  String answer = "";

  /// fromJson
  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  /// toJson
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);

  /// コンストラクタ
  Choice({
    required this.choice,
    required this.explanation,
    required this.answer
  });
}