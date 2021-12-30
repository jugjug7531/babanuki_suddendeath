// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      questionList: (json['questionList'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'questionList': instance.questionList.map((e) => e.toJson()).toList(),
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      title: json['title'] as String,
      problemStatement: json['problemStatement'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'problemStatement': instance.problemStatement,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      choice: json['choice'] as String,
      explanation: json['explanation'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'choice': instance.choice,
      'explanation': instance.explanation,
      'answer': instance.answer,
    };
