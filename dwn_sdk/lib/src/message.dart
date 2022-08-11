/// The base message types provide basic facilities for encryption, signing,
/// authorization and basic descriptor information.
///
/// Messages with additional descriptor are expected to subclass
/// MessageDescriptor and be JSON serializable as well.
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

import 'cid.dart';
import 'jose.dart';
import 'utils/json_converter.dart';

part 'message.g.dart';

/// Builder for a message descriptor from a descriptor JSON object.
typedef MessageDescriptorBuilder<D> = D Function(Map<String, dynamic> json);

/// All DWN messaging is transacted via Message objects.
///
/// See https://identity.foundation/decentralized-web-node/spec/#messages
@JsonSerializable(genericArgumentFactories: true)
class Message<D extends MessageDescriptor> {
  /// Constructs a new message.
  Message({
    this.data,
    required this.descriptor,
    this.authorization,
    this.attestation,
  })  : assert(
          data == null || descriptor.dataFormat != null,
          'descriptor must have a dataFormat',
        ),
        assert(
          data == null || descriptor.dataCid != null,
          'descriptor must have a dataCid',
        );

  /// Constructs a message from a flattened or general JSON representation.
  ///
  /// Pass in a builder for the descriptor.
  factory Message.fromJson(
    final Map<String, dynamic> json,
    final MessageDescriptorBuilder<D> descriptorBuilder,
  ) =>
      _$MessageFromJson<D>(json, (final Object? json) {
        if (json is Map<String, dynamic>) {
          return descriptorBuilder(json);
        }
        throw const FormatException('message descriptor must be an object');
      });

  /// Optional message data, encrypted or unencrypted.
  final MessageData? data;

  /// A descriptor object describing the message.
  final D descriptor;

  /// Optional authorization for the message.
  final MessageAuthorization? authorization;

  /// Optional attestation for the message.
  final MessageAttestation? attestation;

  /// Returns the JSON representation of the message.
  Map<String, dynamic> toJson() =>
      _$MessageToJson(this, (final D object) => object.toJson());
}

/// The message data. May be encrypted.
class MessageData {
  /// Constructs a message data wrapper.
  const MessageData({
    this.data,
    this.encryptedData,
  }) : assert(
          data == null || encryptedData == null,
          'message data can only be encrypted or unencrypted',
        );

  /// Constructs a JWE from a flattened or general JSON representation.
  factory MessageData.fromJson(final dynamic json) {
    if (json is String) {
      return MessageData(data: _base64UrlConverter.fromJson(json));
    }
    if (json is Map<String, dynamic>) {
      return MessageData(encryptedData: JWE.fromJson(json));
    }
    throw const FormatException('message data is not a string or object');
  }

  /// Unencrypted message data.
  final Uint8List? data;

  /// Encrypted message data.
  final JWE? encryptedData;

  static const JsonBase64UrlConverter _base64UrlConverter =
      JsonBase64UrlConverter();

  /// Returns a JSON string when data is unencrypted, otherwise return the
  /// general representation of the JWE.
  dynamic toJson() {
    if (data != null) {
      return _base64UrlConverter.toJson(data!);
    }
    if (encryptedData != null) {
      return encryptedData!.toJson();
    }
  }
}

/// Information about a message.
///
/// See https://identity.foundation/decentralized-web-node/spec/#messages
@JsonSerializable()
class MessageDescriptor {
  /// Constructs a message descriptor.
  const MessageDescriptor({
    required this.nonce,
    required this.method,
    this.dataCid,
    this.dataFormat,
  });

  /// Construct a message descriptor from JSON.
  factory MessageDescriptor.fromJson(final Map<String, dynamic> json) =>
      _$MessageDescriptorFromJson(json);

  /// Cryptographically random string that ensures each object is unique.
  final String nonce;

  /// String that matches a DWN method.
  final String method;

  /// If the message is associated with data, this is required and must contain a stringified CID v1 of the DAG PB encoded data.
  final CID? dataCid;

  /// If the message is associated with data, this must correspond to a registered IANA Media Type, or the other stings pending registration as specified in DWN.
  final String? dataFormat;

  /// Convert a message descriptor to JSON.
  Map<String, dynamic> toJson() => _$MessageDescriptorToJson(this);
}

/// Some messages may require authorization material for processing them.
///
/// See https://identity.foundation/decentralized-web-node/spec/#message-authorization
class MessageAuthorization extends JWS {
  /// Wrap an existing JsonWebSignature.
  const MessageAuthorization(super.jws);

  /// Constructs a JWS from a flattened or general JSON representation.
  // ignore: use_super_parameters
  MessageAuthorization.fromJson(final Map<String, dynamic> json)
      : super.fromJson(json);
}

/// Some messages may require attestation by a signer.
///
/// See https://identity.foundation/decentralized-web-node/spec/#signed-data
class MessageAttestation extends JWS {
  /// Wrap an existing JsonWebSignature.
  ///
  /// To build a JsonWebSignature, use JsonWebSignatureBuilder:
  ///
  /// ```dart
  /// import 'package:dwn_sdk/dwn_sdk.dart';
  ///
  /// var builder = JsonWebSignatureBuilder();
  /// ...
  /// builder.payload = ...
  /// builder.addRecipient(key);
  /// var jws = builder.build(key);
  /// var authorization = MessageAuthorization(jws);
  /// ...
  /// ```
  const MessageAttestation(super.jws);

  /// Constructs a JWS from a flattened or general JSON representation.
  // ignore: use_super_parameters
  MessageAttestation.fromJson(final Map<String, dynamic> json)
      : super.fromJson(json);
}
