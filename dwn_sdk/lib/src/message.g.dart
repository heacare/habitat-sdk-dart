// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      data: _$JsonConverterFromJson<String, Uint8List>(
          json['data'], const JsonBase64UrlConverter().fromJson),
      descriptor: MessageDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'data': _$JsonConverterToJson<String, Uint8List>(
          instance.data, const JsonBase64UrlConverter().toJson),
      'descriptor': instance.descriptor,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

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
