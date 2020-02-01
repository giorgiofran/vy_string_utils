import 'dart:io';

import 'package:vy_string_utils/src/support_classes.dart';
import 'package:vy_string_utils/vy_string_utils.dart';
import 'package:test/test.dart';

void main() {
  File testFile =
      File('${Directory.current.path}/test/abstract_class_case.dart');
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
      expect(result.source.length, 3511);
      expect(result.comments.length, 8);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments.first.content,
          sourceTest.substring(result.comments.first.startContent,
              result.comments.first.endContent));
      expect(result.comments.first.content,
          result.comments.first.rawSourceContent(sourceTest));
      expect(result.comments.first.rawSourceContent(sourceTest),
          result.comments.first.rawTargetContent(result.source));
      expect('///${result.comments.first.rawSourceContent(sourceTest)}\r\n',
          result.comments.first.wholeTargetContent(result.source));

      expect(
          result.comments.last.content,
          '* This function has no meanings\r\n'
          '   * Just to test some language statements.\r\n   ');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.startContent,
              result.comments.last.endContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('/*${result.comments.last.rawSourceContent(sourceTest)}*/',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('Split&Log Single Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLog,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.source.length, 3419);
      expect(result.comments.length, 8);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments[2].content,
          ' Max velocity:\r\n'
          '    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n'
          '  ');
      expect(result.comments[3].content, ' This is calculated');
      expect(
          result.comments.last.content,
          '* This function has no meanings\r\n'
          '   * Just to test some language statements.\r\n   ');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('/*${result.comments.last.rawSourceContent(sourceTest)}*/',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('Split&Lose Single Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.source.length, 3419);
      expect(result.comments.length, 4);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments[2].content,
          ' Max velocity:\r\n    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n  ');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('/*${result.comments.last.rawSourceContent(sourceTest)}*/',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('Split&Log Doc Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLog);
      expect(result.source.length, 3401);
      expect(result.comments.length, 8);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments[2].content,
          ' Max velocity:\r\n'
          '    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n'
          '  ');
      expect(result.comments[3].content, ' This is calculated');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('/*${result.comments.last.rawSourceContent(sourceTest)}*/',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('Split&Lose Doc Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLose);
      expect(result.source.length, 3401);
      expect(result.comments.length, 6);
      expect(
          result.comments.first.content,
          ' Max velocity:\r\n'
          '    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n'
          '  ');
      expect(result.comments[1].content, ' This is calculated');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('/*${result.comments.last.rawSourceContent(sourceTest)}*/',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('Split&Log Block Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLog,
          CommentBehavior.preserve);
      expect(result.source.length, 3331);
      expect(result.comments.length, 8);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments[2].content,
          ' Max velocity:\r\n'
          '    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n'
          '  ');
      expect(result.comments[3].content, ' This is calculated');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.startPosition,
          result.comments.last.startContent);
      expect(
          result.comments.last.startPosition, result.comments.last.endContent);
      expect(
          result.comments.last.startPosition, result.comments.last.endPosition);

      expect(() => result.comments.last.rawTargetContent(result.source),
          throwsStateError);
      expect(() => result.comments.last.wholeTargetContent(result.source),
          throwsStateError);
    });
    test('Split&Lose Block Comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve);
      expect(result.source.length, 3331);
      expect(result.comments.length, 6);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(result.comments[2].content, ' This is calculated');
      expect(result.comments[3].content, ' To be set');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.rawSourceContent(sourceTest),
          result.comments.last.rawTargetContent(result.source));
      expect('//${result.comments.last.rawSourceContent(sourceTest)}\r\n',
          result.comments.last.wholeTargetContent(result.source));
    });
    test('All Split&Log', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLog);
      expect(result.source.length, 3129);
      expect(result.comments.length, 8);
      expect(result.comments.first.content,
          ' This class represent a generic vehicle,');
      expect(
          result.comments[2].content,
          ' Max velocity:\r\n'
          '    This is not always simple to calculate,\r\n'
          '    So it is kept optional\r\n'
          '  ');
      expect(result.comments[3].content, ' This is calculated');
      expect(
          result.comments.last.content,
          sourceTest.substring(result.comments.last.sourceStartContent,
              result.comments.last.sourceEndContent));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.content,
          result.comments.last.rawSourceContent(sourceTest));
      expect(result.comments.last.startPosition,
          result.comments.last.startContent);
      expect(
          result.comments.last.startPosition, result.comments.last.endContent);
      expect(
          result.comments.last.startPosition, result.comments.last.endPosition);

      expect(() => result.comments.last.rawTargetContent(result.source),
          throwsStateError);
      expect(() => result.comments.last.wholeTargetContent(result.source),
          throwsStateError);
    });
    test('All Split&Lose', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLose);
      expect(result.source.length, 3129);
      expect(result.comments.isEmpty, true);
      expect(() => result.comments.last.content, throwsStateError);
      expect(() => result.comments.last.rawTargetContent(result.source),
          throwsStateError);
      expect(() => result.comments.last.wholeTargetContent(result.source),
          throwsStateError);
    });
  });
  group('Annotations', () {
    setUp(() {});

    test('Source equal to target', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.annotations.isNotEmpty, isTrue);
      expect(result.annotations.length, 7);
      expect(result.annotations[5].identifier, 'Annotate');
      expect(
          result.annotations[5].content,
          "Annotate('Method - 2', '2018-1-1', "
          "author: 'Unknown', language: 'Rust')");
      expect(
          result.annotations[5].content,
          sourceTest.substring(result.annotations[5].sourceStartContent,
              result.annotations[5].sourceEndContent));
      expect(
          result.annotations[5].content,
          result.source.substring(result.annotations[5].startContent,
              result.annotations[5].endContent));

      expect(result.annotations[5].sourceStartContent,
          result.annotations[5].startContent);
      expect(result.annotations[5].sourceEndContent,
          result.annotations[5].endContent);

      expect(result.annotations[5].startPosition + 1,
          result.annotations[5].startContent);
      expect(
          result.annotations[5].endPosition, result.annotations[5].endContent);
      expect(result.annotations[5].content,
          result.annotations[5].rawSourceContent(sourceTest));
      expect(result.annotations[5].content,
          result.annotations[5].rawTargetContent(result.source));
      expect('@${result.annotations[5].content}',
          result.annotations[5].wholeTargetContent(result.source));
    });
    test('Missing single line comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.annotations.isNotEmpty, isTrue);
      expect(result.annotations.length, 7);
      expect(result.annotations[5].identifier, 'Annotate');
      expect(
          result.annotations[5].content,
          "Annotate('Method - 2', '2018-1-1', "
          "author: 'Unknown', language: 'Rust')");
      expect(
          result.annotations[5].content,
          sourceTest.substring(result.annotations[5].sourceStartContent,
              result.annotations[5].sourceEndContent));
      expect(
          result.annotations[5].content,
          result.source.substring(result.annotations[5].startContent,
              result.annotations[5].endContent));

      expect(
          result.annotations[5].sourceStartContent -
              result.annotations[5].startContent,
          result.annotations[5].sourceEndContent -
              result.annotations[5].endContent);

      expect(result.annotations[5].startPosition + 1,
          result.annotations[5].startContent);
      expect(
          result.annotations[5].endPosition, result.annotations[5].endContent);
      expect(result.annotations[5].content,
          result.annotations[5].rawSourceContent(sourceTest));
      expect(result.annotations[5].content,
          result.annotations[5].rawTargetContent(result.source));
      expect('@${result.annotations[5].content}',
          result.annotations[5].wholeTargetContent(result.source));
    });
    test('Missing All comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLose);
      expect(result.annotations.isNotEmpty, isTrue);
      expect(result.annotations.length, 7);
      expect(result.annotations[5].identifier, 'Annotate');
      expect(
          result.annotations[5].content,
          "Annotate('Method - 2', '2018-1-1', "
          "author: 'Unknown', language: 'Rust')");
      expect(
          result.annotations[5].content,
          sourceTest.substring(result.annotations[5].sourceStartContent,
              result.annotations[5].sourceEndContent));
      expect(
          result.annotations[5].content,
          result.source.substring(result.annotations[5].startContent,
              result.annotations[5].endContent));

      expect(
          result.annotations[5].sourceStartContent -
              result.annotations[5].startContent,
          result.annotations[5].sourceEndContent -
              result.annotations[5].endContent);

      expect(result.annotations[5].startPosition + 1,
          result.annotations[5].startContent);
      expect(
          result.annotations[5].endPosition, result.annotations[5].endContent);
      expect(result.annotations[5].content,
          result.annotations[5].rawSourceContent(sourceTest));
      expect(result.annotations[5].content,
          result.annotations[5].rawTargetContent(result.source));
      expect('@${result.annotations[5].content}',
          result.annotations[5].wholeTargetContent(result.source));
    });
  });
  group('Statements', () {
    setUp(() {});

    test('Source equal to target', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.preserve,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect(result.statements.length, 3);
      expect(
          result.statements[0].content, "import 'annotation_test_case.dart'");
      expect(result.statements[0].wholeTargetContent(result.source),
          "import 'annotation_test_case.dart';");
      expect(result.statements[1].content,
          "\r\n\r\nenum Fuel { gasoline, diesel, hydrogen, methane, manPower }");
      expect(result.statements[1].content,
          result.statements[1].rawSourceContent(sourceTest));
      expect(result.statements[1].rawTargetContent(result.source),
          result.statements[1].rawSourceContent(sourceTest));
      expect(result.statements[1].sourceContent(sourceTest),
          "enum Fuel { gasoline, diesel, hydrogen, methane, manPower }");
      expect(result.statements[1].targetContent(result.source),
          result.statements[1].sourceContent(sourceTest));
      expect(result.statements[2].statements[0].sourceContent(sourceTest),
          'static const String powerful = "She said:\\" I\'ve seen a rocket!\\""');
      expect(
          result.statements[2].statements[15].statements[0]
              .targetContent(result.source),
          'this.name, this.maxVelocityInKmH');
      expect(
          result.statements[2].statements[15].statements[0]
              .wholeTargetContent(result.source),
          '{this.name, this.maxVelocityInKmH}');
    });
    test('Missing single line comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.preserve,
          CommentBehavior.preserve);
      expect('', 'Todo');
    });
    test('Missing All comments', () {
      AnalysisResult result = analyzeDartSourceBasic(
          sourceTest,
          CommentBehavior.splitAndLose,
          CommentBehavior.splitAndLog,
          CommentBehavior.splitAndLose);
      expect('', 'Todo');
    });
  });
}
