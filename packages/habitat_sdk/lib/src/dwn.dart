import 'dart:typed_data';

import 'package:webcrypto/webcrypto.dart' show Hash;

/// Distributed Web Node interface
class DWN {
  /// A test property
  final bool test = true;

  /// A crypto test
  Future<void> testCrypto() async {
    final Uint8List bytes = Uint8List.fromList(<int>[0, 0, 0]);
    await Hash.sha256.digestBytes(bytes);
  }
}
