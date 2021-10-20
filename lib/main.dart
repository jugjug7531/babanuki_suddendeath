import 'package:flutter/material.dart';

import 'quiz/quiz_1.dart';
import 'quiz/quiz_2.dart';
import 'quiz_edit.dart';


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
        Quiz1.path: (context) => Quiz1(),
        Quiz2.path: (context) => Quiz2(),
        QuizEdit.path: (context) => QuizEdit(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  /* 問題選択ボタン */
  Widget questionButton(BuildContext context, String questionName, String questionPage){
    return TextButton(
      child: Text(
        questionName,
        style: const TextStyle(
          fontFamily: 'Kosugi',
          fontSize: 30,
        ),
      ),
      onPressed: (){
        //指定した画面に遷移する
        Navigator.pushNamed(context, questionPage);
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
            /* 問題ページ一覧 */
            questionButton(context, "問題１", Quiz1.path),
            questionButton(context, "問題２", Quiz2.path),
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
