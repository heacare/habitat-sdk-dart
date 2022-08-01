import 'package:jose/jose.dart' as jose;

/// JWE abstraction layer
class JWE {
  /// Constructs a JWE from a flattened or general JSON representation
  JWE.fromJson(final Map<String, dynamic> json)
      : _impl = jose.JsonWebEncryption.fromJson(json);

  final jose.JsonWebEncryption _impl;

  /// Returns the general JSON representation of the JWE
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = _impl.toJson();
    if (_impl.recipients.length == 1) {
      v
        ..remove('header')
        ..remove('encrypted_key');
      v['recipients'] = _impl.recipients
          .map((final jose.JoseRecipient r) => r.toJson())
          .toList();
    }
    return v;
  }

  /// Returns the decrypted payload for a specific key
  Future<JosePayload> getPayload(final JWKStore keyStore) async {
    final jose.JosePayload payload = await _impl.getPayload(keyStore._impl);
    return JosePayload(payload);
  }
}

/// JWS abstraction layer
class JWS {
  /// Constructs a JWS from a flattened or general JSON representation
  JWS.fromJson(final Map<String, dynamic> json)
      : _impl = jose.JsonWebSignature.fromJson(json);

  final jose.JsonWebSignature _impl;

  /// Returns the general JSON representation of the JWS
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = _impl.toJson();
    if (_impl.recipients.length == 1) {
      v
        ..remove('protected')
        ..remove('header')
        ..remove('signature');
      v['signatures'] = _impl.recipients
          .map((final jose.JoseRecipient r) => r.toJson())
          .toList();
    }
    return v;
  }

  /// Returns the verified payload for a specific key
  Future<JosePayload> getPayload(final JWKStore keyStore) async {
    final jose.JosePayload payload = await _impl.getPayload(keyStore._impl);
    return JosePayload(payload);
  }
}

/// JWK abstraction layer
class JWK {
  /// Constructs a JWK from a JSON representation
  JWK.fromJson(final Map<String, dynamic> json)
      : _impl = jose.JsonWebKey.fromJson(json) {
    assert(
      _impl.usableForOperation('sign') || _impl.usableForAlgorithm('verify'),
      'key should be usable for at least signing or verification',
    );
    assert(
      _impl.usableForOperation('decrypt') ||
          _impl.usableForAlgorithm('encrypt'),
      'key should be usable for at least decryption or encryption',
    );
  }

  final jose.JsonWebKey _impl;
}

/// Wrapper for JsonWebKeyStore
class JWKStore {
  /// Constructs a key store for JWK keys
  JWKStore() : _impl = jose.JsonWebKeyStore();

  final jose.JsonWebKeyStore _impl;

  /// Adds a key to this store
  void addKey(final JWK key) {
    _impl.addKey(key._impl);
  }
}

/// Wrapper for JosePayload
class JosePayload extends jose.JosePayload {
  /// Wrap a jose.JosePayload
  JosePayload(final jose.JosePayload inner)
      : super(inner.data, inner.protectedHeader);
}
