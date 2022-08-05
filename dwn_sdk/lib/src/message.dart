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
  final MessageData? data;

  /// A descriptor object describing the message.
  final MessageDescriptor descriptor;

  /// Optional authorization for the message.
  final MessageAuthorization? authorization;

  /// Optional attestation for the message.
  final MessageAttestation? attestation;
}

/// The message data. May be encrypted
class MessageData {
	/// Constructs a message data wrapper
	MessageData({
		this.data,
		this.encryptedData,
	}) : assert(data == null || encryptedData == null, 'message data can only be encrypted or unencrypted');

  /// Constructs a JWE from a flattened or general JSON representation.
  factory MessageData.fromJson(final dynamic json)	{
	if (json is String) {
		return MessageData(data: _base64UrlConverter.fromJson(json));
	}
	if (json is Map<String, dynamic>) {
		return MessageData(encryptedData: JWE.fromJson(json));
	}
	throw const FormatException("message data is not a string or object");
  }

 /// Unencrypted message data
  final Uint8List? data;
  /// Encrypted message data
  final JWE? encryptedData;

  static const JsonBase64UrlConverter _base64UrlConverter = JsonBase64UrlConverter();

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

  /// Constructs a JWS from a flattened or general JSON representation.
  MessageAuthorization.fromJson(super.json);
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

  /// Constructs a JWS from a flattened or general JSON representation.
  MessageAttestation.fromJson(super.json);
}
