// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message<D> _$MessageFromJson<D extends MessageDescriptor>(
  Map<String, dynamic> json,
  D Function(Object? json) fromJsonD,
) =>
    Message<D>(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: fromJsonD(json['descriptor']),
      authorization: json['authorization'] == null
          ? null
          : MessageAuthorization.fromJson(
              json['authorization'] as Map<String, dynamic>),
      attestation: json['attestation'] == null
          ? null
          : MessageAttestation.fromJson(
              json['attestation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson<D extends MessageDescriptor>(
  Message<D> instance,
  Object? Function(D value) toJsonD,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['descriptor'] = toJsonD(instance.descriptor);
  writeNotNull('authorization', instance.authorization);
  writeNotNull('attestation', instance.attestation);
  return val;
}

MessageDescriptor _$MessageDescriptorFromJson(Map<String, dynamic> json) =>
    MessageDescriptor(
      nonce: json['nonce'] as String,
      method: json['method'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
    );

Map<String, dynamic> _$MessageDescriptorToJson(MessageDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
    'method': instance.method,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  return val;
}
