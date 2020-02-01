import 'annotation_test_case.dart';

enum Fuel { gasoline, diesel, hydrogen, methane, manPower }

/// This class represent a generic vehicle,
/// Basic characteristics are: engine, number of wheels, weight
@Annotate('Class - 1', '2012-1-1', author: 'Unknown', language: 'Dart')
@Annotate('Class - 2', '2015-1-1', author: 'Unknown', language: 'cSharp')
abstract class Vehicle {
  static const String powerful = "She said:\" I've seen a rocket!\"";
  static const String veryPowerful = 'He said:" I\'ve seen a rocket!\"';
  static const String history =
      'The dollar sign as we know it (\$) was not yet in use.';
  static const String manual =
      r'Multiple compounds are delimited by lines consisting of four dollar signs ($$$$). ';
  static const String definition = '''
 The dollar sign or peso sign (\$ or Cifrão symbol.svg),
is a symbol used to indicate the units of various currencies around the world, 
including the peso and the US dollar.
''';
  static const String continues =
      r''''The symbol can interchangeably have one or two vertical strokes.' 
In common usage, the sign appears to the left of the amount specified,
 e.g. '$1', read as "one dollar".
''';
  static const String newLine = '\n';
  static const String backslashN = r'\n';

  @Annotate('Field - 1', '2013-1-1', author: 'Unknown', language: 'Python')
  @Annotate('Field - 2', '2019-1-1', author: 'Unknown', language: 'c')
  final double powerInKw;
  final int numberOfWheels;
  final double weightInKg;
  final Fuel fuel;
  /* Max velocity:
    This is not always simple to calculate,
    So it is kept optional
  */
  double maxVelocityInKmH;
  // This is calculated
  double weightPerWheel;
  // To be set
  String name = 'It\'s a generic value';

  Vehicle(this.powerInKw, this.weightInKg, this.fuel, int numberOfWheels,
      {this.name, this.maxVelocityInKmH})
      : numberOfWheels = numberOfWheels ?? 4 {
    if (numberOfWheels > 20) {
      throw ArgumentError(
          'Please, check the number of wheels, $numberOfWheels seems too much');
    } else if (numberOfWheels < 1) {
      throw ArgumentError('Please, check the number of wheels, '
          '$numberOfWheels seems very limiting');
    } else {
      weightPerWheel = weightInKg / numberOfWheels;
    }
  }

  // simple getter
  double get powerToWeightRatio => powerInKw / weightInKg;
  //In case we forgot to set the name
  set description(String _value) => name = _value;

  @Annotate('Method - 1', '2014-1-1', author: 'Unknown', language: 'JavaScript')
  /** This function has no meanings
   * Just to test some language statements.
   */
  @Annotate('Method - 2', '2018-1-1', author: 'Unknown', language: 'Rust')
  bool doStrangeThings(String check, {int number}) {
    bool _returnBool(int valueToBeChecked) {
      return valueToBeChecked == 10;
    }

    number ??= check.length;
    if (check == newLine) {
      return true;
    }
    if (check.length != number) {
      return false;
    }
    @Annotate('Method Field', '2017-1-1', author: 'Unknown', language: 'Java')
    List<int> numbers = <int>[1, 2, 3, 4, 5, 6, 7];
    int index = 0;
    Map<int, int> progressive = <int, int>{};
    int total = 0;
    numbers.forEach((int num) {
      total += num;
      index++;
      progressive[index] = total;
    });
    for (int idx in progressive.keys) {
      print('Index $idx, Progressive $total');
    }
    return _returnBool(total);
  }
}
