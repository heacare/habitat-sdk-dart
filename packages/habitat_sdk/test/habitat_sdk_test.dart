import 'package:habitat_sdk/habitat_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('dwn', () {
    final DWN dwn = DWN();

    setUp(() {
      // Additional setup goes here.
    });

    test('has a test property', () {
      expect(dwn.test, true);
    });

    test('can do crypto', () {
      dwn.testCrypto();
    });
  });
}
