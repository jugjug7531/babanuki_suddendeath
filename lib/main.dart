import 'package:flutter/material.dart';

import 'quiz/quiz_base.dart';
import 'quiz_edit.dart';

import 'question.dart';

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

  //暫定：ここに問題を置く
  final List<Question> questions = [
    Question(
      "Q1 都道府県",
      "東北地方の県を選べ（１つは不正解）",
      [
        Choice(
          "青森県",
          "リンゴ有名",
          "true"
        ),
        Choice(
          "秋田県",
          "きりたんぽ有名",
          "true"
        ),
        Choice(
          "宮崎県",
          "九州地方です",
          "false"
        ),
        Choice(
          "岩手県",
          "わんこそば有名",
          "true"
        ),
        Choice(
          "山形県",
          "果物有名",
          "true"
        ),
        Choice(
          "福島県",
          "喜多方ラーメン有名",
          "true"
        )
      ]
    ),
    Question(
      "Q2 単位",
      "SI基本単位を選べ（２つは不正解）",
      [
        Choice(
          "メートル(m)",
          "長さ",
          "true"
        ),
        Choice(
          "ニュートン(N)",
          "力",
          "false"
        ),
        Choice(
          "ケルビン(K)",
          "熱力学温度",
          "true"
        ),
        Choice(
          "ボルト(V)",
          "電圧. 電流(I)はSI基本単位",
          "false"
        ),
        Choice(
          "秒(s)",
          "時間",
          "true"
        ),
        Choice(
          "カンデラ(cd)",
          "光度",
          "true"
        )
      ]
    )
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  // 問題選択ボタン
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
            for(int i = 0; i < widget.questions.length; i++)
              questionButton(context, QuizBase.path, widget.questions[i])
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
