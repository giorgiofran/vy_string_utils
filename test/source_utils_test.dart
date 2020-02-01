import 'dart:io';

import 'package:vy_string_utils/src/support_classes.dart';
import 'package:vy_string_utils/vy_string_utils.dart';
import 'package:test/test.dart';

void main() {
  File testFile = File('${Directory.current.path}/test/comment_case.dart');
  String sourceTest = testFile.readAsStringSync();
  group('Comments', () {
    setUp(() {});

    test('Preserve All Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.source, sourceTest);
      expect(result.source.length, 681);
      expect(result.comments.length, 9);
      expect(result.comments.first.content, ' Test Line1');
    });
    test('Split&Log Single Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLog,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      //expect(result.source, sourceTest);
      expect(result.source.length, 633);
      expect(result.comments.length, 9);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, ' standard comment');
      expect(result.comments[3].content, 'block comment ');
    });
    test('Split&Lose Single Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      //expect(result.source, sourceTest);
      expect(result.source.length, 633);
      expect(result.comments.length, 6);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, 'block comment ');
    });
    test('Split&Log Doc Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLog);
      expect(result.source.length, 626);
      expect(result.comments.length, 9);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, ' standard comment');
      expect(result.comments[3].content, 'block comment ');
    });
    test('Split&Lose Doc Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLose);
      expect(result.source.length, 626);
      expect(result.comments.length, 6);
      expect(result.comments.first.content, ' standard comment');
      expect(result.comments[1].content, 'block comment ');
    });
    test('Split&Log Block Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLog,
          CommentBehavior.preserve);
      expect(result.source.length, 570);
      expect(result.comments.length, 9);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, ' standard comment');
      expect(result.comments[3].content, 'block comment ');
    });
    test('Split&Lose Block Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve);
      expect(result.source.length, 570);
      expect(result.comments.length, 6);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, ' standard comment');
      expect(result.comments[3].content, ' Class description');
    });
    test('All Split&Log', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLog);
      expect(result.source.length, 467);
      expect(result.comments.length, 9);
      expect(result.comments.first.content, ' Test Line1');
      expect(result.comments[2].content, ' standard comment');
      expect(result.comments[3].content, 'block comment ');
    });
    test('All Split&Lose', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLose);
      expect(result.source.length, 467);
      expect(result.comments.isEmpty, true);
    });
  });
}
