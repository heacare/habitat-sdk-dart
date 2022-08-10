/// This abstraction layer exists solely to change the output format of jose
/// to always use the general representation, even when there exists only 1
/// recipient.

import 'package:jose2/jose2.dart' as jose;

export 'package:jose2/jose2.dart'
    show
        JsonWebKey,
        JsonWebKeyStore,
        JoseHeader,
        JoseRecipient,
        JosePayload,
        JoseException;

/// JWE abstraction layer.
class JWE {
  /// Constructs a JWE from an existing JsonWebEncryption.
  JWE(this.jwe);

  /// Constructs a JWE from a flattened or general JSON representation.
  JWE.fromJson(final Map<String, dynamic> json) : jwe = _fromJson(json);

  static jose.JsonWebEncryption _fromJson(final Map<String, dynamic> json) =>
      jose.JsonWebEncryption.fromJson(json);

  /// The inner JsonWebEncryption object.
  final jose.JsonWebEncryption jwe;

  /// Returns the general JSON representation of the JWE.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = jwe.toJson();
    if (jwe.recipients.length == 1) {
      v
        ..remove('header')
        ..remove('encrypted_key');
      v['recipients'] = jwe.recipients
          .map((final jose.JoseRecipient r) => r.toJson())
          .toList();
    }
    return v;
  }
}

/// JWS abstraction layer.
class JWS {
  /// Constructs a JWS from an existing JsonWebSignature.
  JWS(this.jws);

  /// Constructs a JWS from a flattened or general JSON representation.
  JWS.fromJson(final Map<String, dynamic> json) : jws = _fromJson(json);

  static jose.JsonWebSignature _fromJson(final Map<String, dynamic> json) =>
      jose.JsonWebSignature.fromJson(json);

  /// The inner JsonWebSignature object.
  final jose.JsonWebSignature jws;

  /// Returns the general JSON representation of the JWS.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> v = jws.toJson();
    if (jws.recipients.length == 1) {
      v
        ..remove('protected')
        ..remove('header')
        ..remove('signature');
      v['signatures'] = jws.recipients
          .map((final jose.JoseRecipient r) => r.toJson())
          .toList();
    }
    return v;
  }
}
