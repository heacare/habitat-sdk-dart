import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

import 'cid.dart';
import 'utils/json_converter.dart';

part 'message.g.dart';

@JsonSerializable()
abstract class Message {
  /// Constructs a new message
  Message({
    this.data,
    required this.descriptor,
  });

  /// The raw message data in bytes
  @JsonBase64UrlConverter()
  final Uint8List? data;

  /// A descriptor object describing the message
  final MessageDescriptor descriptor;
}

/// Information about a message
@JsonSerializable()
class MessageDescriptor {
  /// Constructs a message descriptor
  const MessageDescriptor({
    required this.nonce,
    required this.method,
    this.dataCid,
    this.dataFormat,
  });

  /// Cryptographically random string that ensures each object is unique
  final String nonce;

  /// String that matches a DWN method
  final String method;

  /// If the message is associated with data, this is required and must contain a stringified CID v1 of the DAG PB encoded data
  final CID? dataCid;

  /// If the message is associated with data, this must correspond to a registered IANA Media Type, or the other stings pending registration as specified in DWN
  final String? dataFormat;
}
