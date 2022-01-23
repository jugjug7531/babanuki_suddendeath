import 'package:flutter/material.dart';
import 'package:babanuki_suddendeath/model/question.dart';
import 'quiz_edit.dart';

/// クイズ一覧ページ
/// 
/// 新規クイズ追加や一覧から編集するクイズの選択や削除等をおこなう.
class QuizListPage extends StatefulWidget {
  const QuizListPage({Key? key}) : super(key: key);

  /// ページタイトル
  final String title = 'クイズ一覧';
  /// ページのパス
  static const String path = '/list';

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {

  void _tapQuiz(var item){
    // 問題編集ページに移動
    Navigator.pushNamed(context, QuizEdit.path, arguments: item);
  }

  @override
  Widget build(BuildContext context){

    // 全問題
    // `ModalRoute.of()`メソッドを使用してページ遷移時の引数を取得
    Questions args = ModalRoute.of(context)!.settings.arguments as Questions;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          // 問題一覧をカード形式で表示
          for (var item in args.questionList) 
            Card(
              child: ListTile(
                title: Text(item.title),
                onTap: () => _tapQuiz(item),
              ),
            ),
        ],
      ),
      // 新規問題作成ページ
      floatingActionButton: FloatingActionButton(
        heroTag: "edit",
        onPressed: () {
          //Navigator.pushNamed(context, QuizEdit.path, arguments: args);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}