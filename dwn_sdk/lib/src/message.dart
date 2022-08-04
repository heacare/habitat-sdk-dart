import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

import './cid.dart';
import 'utils/json_converter.dart';

part 'message.g.dart';

@JsonSerializable()
abstract class Message {
  Message({
    this.data,
    required this.descriptor,
  });

  @JsonBase64UrlConverter()
  Uint8List? data;
  MessageDescriptor descriptor;
}

/// Information about a message
@JsonSerializable()
class MessageDescriptor {
  const MessageDescriptor({
    required this.nonce,
    required this.method,
    this.dataCid,
    this.dataFormat,
  });

  final String nonce;
  final String method;
  final CID? dataCid;
  final String? dataFormat;
}
