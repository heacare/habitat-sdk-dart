// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: MessageDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
      authorization: json['authorization'] == null
          ? null
          : MessageAuthorization.fromJson(JsonWebSignature.fromJson(
              json['authorization'] as Map<String, dynamic>)),
      attestation: json['attestation'] == null
          ? null
          : MessageAttestation.fromJson(JsonWebSignature.fromJson(
              json['attestation'] as Map<String, dynamic>)),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'data': instance.data,
      'descriptor': instance.descriptor,
      'authorization': instance.authorization,
      'attestation': instance.attestation,
    };

MessageDescriptor _$MessageDescriptorFromJson(Map<String, dynamic> json) =>
    MessageDescriptor(
      nonce: json['nonce'] as String,
      method: json['method'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as Map<String, dynamic>),
      dataFormat: json['dataFormat'] as String?,
    );

Map<String, dynamic> _$MessageDescriptorToJson(MessageDescriptor instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'method': instance.method,
      'dataCid': instance.dataCid,
      'dataFormat': instance.dataFormat,
    };
