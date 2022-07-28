import 'package:jose/jose.dart';

/// JWE abstraction layer
class JWE {
  /// Constructs a JWE from a flattened or general JSON representation
  JWE.fromJson(final Map<String, dynamic> json)
      : _impl = JsonWebEncryption.fromJson(json);

  final JsonWebEncryption _impl;

  /// Returns the general JSON representation of the JWE
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = _impl.toJson();
    if (_impl.recipients.length == 1) {
      v
        ..remove('header')
        ..remove('encrypted_key');
      v['recipients'] =
          _impl.recipients.map((final JoseRecipient r) => r.toJson()).toList();
    }
    return v;
  }
}

/// JWS abstraction layer
class JWS {
  /// Constructs a JWS from a flattened or general JSON representation
  JWS.fromJson(final Map<String, dynamic> json)
      : _impl = JsonWebSignature.fromJson(json);

  final JsonWebSignature _impl;

  /// Returns the general JSON representation of the JWS
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = _impl.toJson();
    if (_impl.recipients.length == 1) {
      v
        ..remove('header')
        ..remove('encrypted_key');
      v['recipients'] =
          _impl.recipients.map((final JoseRecipient r) => r.toJson()).toList();
    }
    return v;
  }
}
