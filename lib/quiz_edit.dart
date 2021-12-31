import 'dart:typed_data';
import 'dart:convert';

import 'package:babanuki_suddendeath/model/question.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 現在日時をString型に変換
import 'package:file_selector/file_selector.dart'; //ファイルの保存と読み込み
import "package:universal_html/html.dart" as html;

/// クイズ作成ページ
/// 
/// クイズの追加・削除・保存・ロードなど

class QuizEdit extends StatefulWidget {
  QuizEdit({Key? key}) : super(key: key);

  final String title = 'クイズ作成';
  static const String path = '/edit/';

  /// 編集するクイズのリストインデックス
  int argsQuizIndex = 0;

  @override
  State<QuizEdit> createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {

  String dropdownValue = "";

  /// 問題入力欄Widget
  Widget questionTextField(Question question){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: TextField(
        controller: TextEditingController(text: question.problemStatement), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '問題',
        ),
        onChanged: (String value){
          question.problemStatement = value;        
        },
      )          
    );
  }

  /// 選択肢入力欄Widget
  Widget choiceTextField(Choice choice){
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 5),
      child: TextField(
        controller: TextEditingController(text: choice.choice), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '選択肢',
        ),
        onChanged: (String value){
          choice.choice = value;
        },
      )
    );
  }

  /// 解説入力欄Widget
  Widget explainTextField(Choice choice){
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 5),
      child: TextField(
        controller: TextEditingController(text: choice.explanation), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '解説',
        ),
        onChanged: (String value){
          choice.explanation = value;
        },
      )          
    );
  }

  /// 問題選択用ドロップダウンボタン
  Widget quizDropDownButton(List<String> quizTitleList){
    return DropdownButton<String>(
            value: quizTitleList[widget.argsQuizIndex],
            icon: const Icon(Icons.list),
            elevation: 16,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 18
            ),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                int val = quizTitleList.indexOf(newValue!);
                if(val != -1){
                  widget.argsQuizIndex = val;
                }else{
                  widget.argsQuizIndex = 0;
                }
              });
            },
            items: quizTitleList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
  }
  
  @override
  Widget build(BuildContext context) {
    // `ModalRoute.of()`メソッドを使用してページ遷移時の引数を取得
    Questions args = ModalRoute.of(context)!.settings.arguments as Questions;

    // 選択肢全体
    List<Widget> choiceForm = [];

    // 問題タイトルリスト
    List<String> quizTitleList = [];

    // 問題タイトルリスト作成
    for(var question in args.questionList){
      quizTitleList.add(question.title);
    }

    // 選択肢欄の作成
    for(int i = 0; i < args.questionList[widget.argsQuizIndex].choices.length; i++){
      choiceForm.add(choiceTextField(args.questionList[widget.argsQuizIndex].choices[i]));
      choiceForm.add(explainTextField(args.questionList[widget.argsQuizIndex].choices[i]));
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
              "編集する問題",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            )
          ),
          // 水平に並べる
          Row(
            children: [
              // 編集する問題を選ぶボタン
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child:quizDropDownButton(quizTitleList),
              ),
              // タイトル画面に戻るボタン
              ElevatedButton(
                child: const Text('問題選択ページに戻る'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),  
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
          questionTextField(args.questionList[widget.argsQuizIndex]),
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
        label: const Text('Download'),
        icon: const Icon(Icons.download),
        onPressed: () async {
          String? path = await getSavePath(acceptedTypeGroups: [
            XTypeGroup(label: 'json', extensions: ['json'])
          ], suggestedName: "babanuki_quiz.json");
          if (path == null) {
            return;
          }
          if (path == "") { // 空文字の場合、AnchorElementでDLリンクを作成 → 発火
            // ファイル名に入れる現在日時を取得
            DateTime now = DateTime.now();
            String nowString = DateFormat('yyyyMMddHHmmss').format(now); 
            final anchor = html.AnchorElement(
              href: "data:application/json;charset=utf-8," +
                jsonEncode(args.toJson()));
            anchor.download = nowString+"_babanukiQuiz.json";
            anchor.click();
          } else {
            final data =
                Uint8List.fromList(json.encode(args.toJson()).codeUnits);
            const mimeType = "application/json";
            final file = XFile.fromData(data, mimeType: mimeType);
            await file.saveTo(path);
          }
        },
      ) 
    );
  }
}