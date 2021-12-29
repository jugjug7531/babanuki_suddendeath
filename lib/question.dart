/// 問題ページに渡す引数クラス
class Question{
  /// 問題選択時のタイトル
  String title = "";
  /// 問題文
  String problemStatement = "";
  /// 選択肢
  List<Choice> choices = [];

  /// コンストラクタ
  Question(
      this.title,
      this.problemStatement,
      this.choices
  );
}

/// 選択肢カード作成時に必要な情報をまとめたクラス
class Choice{
  /// 選択肢
  String choice = "";
  /// 答えの説明文
  String explanation = "";
  /// 答え
  String answer = "";

  /// コンストラクタ
  Choice(
    this.choice,
    this.explanation,
    this.answer
  );
}