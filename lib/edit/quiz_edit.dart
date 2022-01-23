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
  static const String path = '/edit';

  /// トグル表示更新用の選択肢正誤リスト
  List<bool> isCorrect = [];

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

  /// 選択肢の正誤設定ボタン
  Widget setChoiceAnswerButton(Choice choice, int index){
    return Switch(
            value: widget.isCorrect[index],
            activeColor: Colors.orange,
            activeTrackColor: Colors.red,
            inactiveThumbColor: Colors.blue,
            inactiveTrackColor: Colors.green,
            onChanged: (val){
              if(val==true){
                choice.answer = "true";
              }else{
                choice.answer = "false";
              }
              setState(() {
                widget.isCorrect[index] = val;
              }); 
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    // `ModalRoute.of()`メソッドを使用してページ遷移時の引数を取得
    Question args = ModalRoute.of(context)!.settings.arguments as Question;

    // 選択肢全体
    List<Widget> choiceForm = [];

    // トグル表示更新用選択肢正誤リストの初期化
    widget.isCorrect.clear();
    for(int i = 0; i < args.choices.length; i++){
      widget.isCorrect.add(args.choices[i].answer == "true");
    }
      
    // 選択肢欄の作成
    for(int i = 0; i < args.choices.length; i++){
      choiceForm.add(
        // 選択肢の正誤設定
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
          child:Row(
            children: [
              Text(
                "選択肢"+(i+1).toString()+": ",
                style: const TextStyle(
                  fontSize: 16,
                )
              ),
              const Text(
                "X",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                )
              ),
              setChoiceAnswerButton(args.choices[i], i),
              const Text(
                "O",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                )
              ),
            ],
          )
        )
      );
      choiceForm.add(choiceTextField(args.choices[i]));
      choiceForm.add(explainTextField(args.choices[i]));
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
          questionTextField(args),
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