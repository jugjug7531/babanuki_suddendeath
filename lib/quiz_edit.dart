//import 'dart:html';

import 'package:flutter/material.dart';

/// クイズ作成ページ
/// 
/// クイズの追加・削除・保存・ロードなど

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key}) : super(key: key);

  final String title = 'クイズ作成';
  static const String path = '/edit/';

  @override
  State<QuizEdit> createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {

  /// 選択肢
  List<Map<String, String>> questions = [
    {
      "choice": "青森県",
      "explanation" : "リンゴ有名",
      "answer": "true"
    },
    {
      "choice": "秋田県",
      "explanation" : "きりたんぽ有名",
      "answer": "true"
    },
    {
      "choice": "宮崎県",
      "explanation" : "九州地方です",
      "answer": "false"
    },
    {
      "choice": "岩手県",
      "explanation" : "わんこそば有名",
      "answer": "true"
    },
    {
      "choice": "山形県",
      "explanation" : "果物有名",
      "answer": "true"
    },
    {
      "choice": "福島県",
      "explanation" : "喜多方ラーメン有名",
      "answer": "true"
    }
  ];
  /// 問題番号
  int questionNumber = 0;
  /// 選択肢の数(quiz_baseにも関わるため別のところで定義すべき？)
  final int choiceTotalNum = 6;

  /// 問題入力欄Widget
  Widget questionTextField(int questionNum){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: TextField(
        controller: TextEditingController(text: questions[questionNum]['question']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '問題',
        ),
        onChanged: (String value){
          debugPrint("問題 : ${value}");
          questions[questionNum]['question'] = value;        
        },
      )          
    );
  }

  /// 選択肢入力欄Widget
  Widget choiceTextField(int questionNum, int choiceNum){
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 5),
      child: TextField(
        controller: TextEditingController(text: questions[choiceNum]['choice']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '選択肢',
        ),
        onChanged: (String value){
          debugPrint("選択肢${choiceNum} : ${value}");
          questions[choiceNum]['choice'] = value;
        },
      )
    );
  }

  ///解説入力欄Widget
  Widget explainTextField(int questionNum, int choiceNum){
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 5),
      child: TextField(
        controller: TextEditingController(text: questions[choiceNum]['explanation']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '解説',
        ),
        onChanged: (String value){
          debugPrint("解説${choiceNum} : ${value}");
          questions[choiceNum]['explanation'] = value;
        },
      )          
    );
  }

  @override
  Widget build(BuildContext context) {
    ///選択肢全体
    List<Widget> choiceForm = [];

    for(int i = 0; i < choiceTotalNum; i++){
      choiceForm.add(choiceTextField(questionNumber, i));
      choiceForm.add(explainTextField(questionNumber, i));
      choiceForm.add(const SizedBox(height: 15));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:ListView (
        children: <Widget>[
          const SizedBox(height: 10),
          // "問題"テキスト
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "問題",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            )
          ),
          // 問題文入力欄
          questionTextField(questionNumber),
          const SizedBox(height: 20),
          // "選択肢"テキスト
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "選択肢",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            )
          ),
          const SizedBox(height: 10),
          //全選択肢入力欄
          Column(children:choiceForm)
        ],
      ),
      // クイズ保存ボタン
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        onPressed: (){
          debugPrint("保存する処理を実装する");
        },
      ) 
    );
  }
}