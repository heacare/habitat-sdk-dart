import 'package:json_annotation/json_annotation.dart';

import 'cid.dart';
import 'message.dart';

part 'permissions.g.dart';

/// A message to request permissions
@JsonSerializable()
class PermissionsRequestMessage extends Message<PermissionsRequestDescriptor> {
  /// Constructs a new PermissionsRequest message
  PermissionsRequestMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory PermissionsRequestMessage.fromJson(final Map<String, dynamic> json) =>
      _$PermissionsRequestMessageFromJson(json);
}

/// A message to grant permissions
@JsonSerializable()
class PermissionsGrantMessage extends Message<PermissionsGrantDescriptor> {
  /// Constructs a new PermissionsGrant message
  PermissionsGrantMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory PermissionsGrantMessage.fromJson(final Map<String, dynamic> json) =>
      _$PermissionsGrantMessageFromJson(json);
}

/// A [MessageDescriptor] for a [PermissionsRequestMessage]
@JsonSerializable()
class PermissionsRequestDescriptor extends MessageDescriptor {
  /// Constructor
  const PermissionsRequestDescriptor({
    required final super.nonce,
    final super.dataCid,
    final super.dataFormat,
    required this.grantedBy,
    required this.description,
    required this.grantedTo,
    required this.scope,
    this.permissionRequestId,
    this.conditions,
  }) : super(
          method: 'PermissionsGrant',
        );

  /// Deserialize object from JSON
  factory PermissionsRequestDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$PermissionsRequestDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$PermissionsRequestDescriptorToJson(this);

  /// A UUIDv4 String representing the PermissionRequest object the permission is being granted in relation to.
  final String? permissionRequestId;

  /// A description for the permissions request message
  final String description;

  /// The DID URI string of the party that is granting the permission.
  final String grantedBy;

  /// The DID URI string of the party that is being granted the permission.
  final String grantedTo;

  /// Describe the scope of the Permission.
  final PermissionScope scope;

  /// Describe the conditions of the Permission
  final PermissionConditions? conditions;
}

/// A [MessageDescriptor] for a [PermissionsGrantMessage]
@JsonSerializable()
class PermissionsGrantDescriptor extends MessageDescriptor {
  /// Constructor
  const PermissionsGrantDescriptor({
    required final super.nonce,
    final super.dataCid,
    final super.dataFormat,
    required this.permissionGrantId,
    required this.grantedBy,
    required this.description,
    required this.grantedTo,
    required this.expiry,
    required this.scope,
    this.permissionRequestId,
    this.delegatedFrom,
    this.conditions,
  }) : super(
          method: 'PermissionsGrant',
        );

  /// Deserialize object from JSON
  factory PermissionsGrantDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$PermissionsGrantDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$PermissionsGrantDescriptorToJson(this);

  /// A UUIDv4 String representing the reply object.
  final String permissionGrantId;

  /// A UUIDv4 String representing the PermissionRequest object the permission is being granted in relation to.
  final String? permissionRequestId;

  /// The description for the permission grant message
  final String description;

  /// The DID URI string of the party that is granting the permission.
  final String grantedBy;

  /// The DID URI string of the party that is being granted the permission.
  final String grantedTo;

  /// A UUIDv4 String matching the [permissionGrantId] of the [PermissionsGrantMessage] is is delegated from.
  final String? delegatedFrom;

  /// A Unix epoch timestamp that can be used to trigger revocation.
  final String expiry;

  /// Describe the scope of the Permission.
  final PermissionScope scope;

  /// Describe the conditions of the Permission
  final PermissionConditions? conditions;
}

/// The scope of the PermissionsMessage.
@JsonSerializable()
class PermissionScope {
  /// Create the PermissionScope.
  const PermissionScope({
    required this.method,
    this.schema,
  });

  /// Deserialize object from JSON
  factory PermissionScope.fromJson(final Map<String, dynamic> json) =>
      _$PermissionScopeFromJson(json);

  /// Serialize object to JSON
  Map<String, dynamic> toJson() => _$PermissionScopeToJson(this);

  /// The interface method the requesting party wants to invoke.
  final String method;

  /// A URI string that indicates the schema of the associated data
  final String? schema;
}

/// Represents the signing conditions of the object.
@JsonEnum()
enum PermissionAttestation {
  /// The object MUST NOT be signed
  prohibited,

  /// The object MAY be signed using a key linked to the DID of the owner of a Decentralized Web Node or authoring party
  optional,

  /// The object MUST be signed using a key linked to the DID of the owner of a Decentralized Web Node or authoring party
  required,
}

/// Represents the encryption conditions of the object.
@JsonEnum()
enum PermissionEncryption {
  /// The object MAY be encrypted using the key provided by the owner of a Decentralized Web Node
  optional,

  /// The object MUST be encrypted using the key provided by the owner of a Decentralized Web Node
  required,
}

/// Describes the conditions of the permission message
@JsonSerializable()
class PermissionConditions {
  /// Creates the PermissionCondition object
  const PermissionConditions({
    this.attestation,
    this.encryption,
    this.delegation,
    this.publication,
    this.sharedAccess,
  });

  /// Deserialize object from JSON
  factory PermissionConditions.fromJson(final Map<String, dynamic> json) =>
      _$PermissionConditionsFromJson(json);

  /// Serialize object to JSON
  Map<String, dynamic> toJson() => _$PermissionConditionsToJson(this);

  /// The signing conditions of the the object.
  final PermissionAttestation? attestation;

  /// The encryption conditions of the object
  final PermissionEncryption? encryption;

  /// Whether the issuing party is allowing the grantee the ability to delegate the capability.
  final bool? delegation;

  /// Whether the issuing party is allowing the grantee the ability to publish data tied to methods that support the public boolean value in their descriptor field sets.
  final bool? publication;

  /// Whether the requesting party wants the ability to use the permission against any object or data that aligns with the capability’s definition.
  final bool? sharedAccess;
}
