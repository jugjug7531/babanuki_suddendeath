import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert'; //jsonDecode()を使用するため
import 'dart:async' show Future;

import 'quiz/quiz_base.dart';
import 'quiz_edit.dart';
import 'model/question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String title = 'ババ抜きサドンデスクイズ';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // デフォルトのルーティング
      initialRoute: '/',
      // ルーティングの一覧を設定
      routes: {
        '/': (context) => MyHomePage(title : title),
        QuizBase.path: (context) => QuizBase(),
        QuizEdit.path: (context) => QuizEdit(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  /// 問題リスト(jsonファイルから読み込む)
  Questions questions = Questions(questionList: [
    Question(
      title: "Q1 都道府県",
      problemStatement: "東北地方の県を選べ（１つは不正解）",
      choices: [
        Choice(
          choice: "青森県",
          explanation: "リンゴ有名",
          answer: "true"
        ),
        Choice(
          choice: "秋田県",
          explanation: "きりたんぽ有名",
          answer: "true"
        ),
        Choice(
          choice: "宮崎県",
          explanation: "九州地方です",
          answer: "false"
        ),
        Choice(
          choice: "岩手県",
          explanation: "わんこそば有名",
          answer: "true"
        ),
        Choice(
          choice: "山形県",
          explanation: "果物有名",
          answer: "true"
        ),
        Choice(
          choice: "福島県",
          explanation: "喜多方ラーメン有名",
          answer: "true"
        )
      ]
    )
  ]);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  /// jsonファイルを読み込み
  Future<String> _jsonFileLoad() async {
    const String path = 'json/quiz.json';
    String jsonString = "";
    try {
      jsonString = await rootBundle.loadString(path);
    } on FlutterError {
      //print('Faild to open $path');
    }
    return jsonString;
  }

  @override
  void initState(){
    super.initState();
    // jsonファイルから問題を読み込む
    _jsonFileLoad().then((value) {
      setState(() {
        widget.questions = Questions.fromJson(jsonDecode(value));
      });
    });
  }

  /// 問題選択ボタン
  Widget questionButton(BuildContext context, String questionPage, Question arg){
    return TextButton(
      child: Text(
        arg.title,
        style: const TextStyle(
          fontFamily: 'Kosugi',
          fontSize: 30,
        ),
      ),
      onPressed: (){
        //指定した画面に遷移する
        Navigator.pushNamed(context, questionPage, arguments: arg);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "問題選択",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            // 問題ページ一覧
            for(int i = 0; i < widget.questions.questionList.length; i++)
              questionButton(context, QuizBase.path, widget.questions.questionList[i])
          ]
        ),
      ),
      // クイズ編集ページ移動ボタン
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Edit'),
        icon: const Icon(Icons.edit),
        onPressed: (){
          Navigator.pushNamed(context, QuizEdit.path);
        },
      ),
    );
  }
}
