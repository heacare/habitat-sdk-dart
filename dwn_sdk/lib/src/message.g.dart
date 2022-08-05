// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDescriptor _$MessageDescriptorFromJson(Map<String, dynamic> json) =>
    MessageDescriptor(
      nonce: json['nonce'] as String,
      method: json['method'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
    );

Map<String, dynamic> _$MessageDescriptorToJson(MessageDescriptor instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'method': instance.method,
      'dataCid': instance.dataCid,
      'dataFormat': instance.dataFormat,
    };
