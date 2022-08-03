import 'dart:typed_data';

import './cid.dart';

abstract class Message {
  Message({
    this.data,
    required this.descriptor,
  });

  Uint8List? data;
  MessageDescriptor descriptor;
}

/// Information about a message
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
