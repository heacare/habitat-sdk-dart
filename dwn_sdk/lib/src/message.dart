import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

import 'cid.dart';
import 'jose.dart';
import 'utils/json_converter.dart';

part 'message.g.dart';

/// All DWN messaging is transacted via Message objects.
///
/// See https://identity.foundation/decentralized-web-node/spec/#messages
@JsonSerializable()
abstract class Message {
  /// Constructs a new message.
  Message({
    this.data,
    required this.descriptor,
    this.authorization,
    this.attestation,
  });

  /// The raw message data in bytes.
  @JsonBase64UrlConverter()
  final Uint8List? data;

  /// A descriptor object describing the message.
  final MessageDescriptor descriptor;

  /// Optional authorization for the message.
  final MessageAuthorization? authorization;

  /// Optional attestation for the message.
  final MessageAttestation? attestation;
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

  /// Cryptographically random string that ensures each object is unique.
  final String nonce;

  /// String that matches a DWN method.
  final String method;

  /// If the message is associated with data, this is required and must contain a stringified CID v1 of the DAG PB encoded data.
  final CID? dataCid;

  /// If the message is associated with data, this must correspond to a registered IANA Media Type, or the other stings pending registration as specified in DWN.
  final String? dataFormat;
}

/// Some messages may require authorization material for processing them.
///
/// See https://identity.foundation/decentralized-web-node/spec/#message-authorization
class MessageAuthorization extends JWS {
  /// Wrap an existing JsonWebSignature.
  MessageAuthorization(super.jws);
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
  MessageAttestation(super.jws);
}
