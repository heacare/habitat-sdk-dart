import 'package:dwn_sdk/dwn_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final Awesome awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
