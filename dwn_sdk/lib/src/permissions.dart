import 'dart:typed_data';

import './cid.dart';
import './message.dart';

/// A message to request permissions
class PermissionsRequestMessage extends Message {
  /// Constructs a new PermissionsRequest message
  PermissionsRequestMessage({
    final Uint8List? data,
    required final PermissionsRequestDescriptor descriptor,
  }) : super(descriptor: descriptor, data: data);
}

/// A message to grant permissions
class PermissionsGrantMessage extends Message {
  /// Constructs a new PermissionsGrant message
  PermissionsGrantMessage({
    final Uint8List? data,
    required final PermissionsGrantDescriptor descriptor,
  }) : super(descriptor: descriptor, data: data);
}

/// A [MessageDescriptor] for a [PermissionsRequestMessage]
class PermissionsRequestDescriptor extends MessageDescriptor {
  /// Constructor
  const PermissionsRequestDescriptor({
    required final String nonce,
    required this.grantedBy,
    required this.description,
    required this.grantedTo,
    required this.scope,
    final CID? dataCid,
    final String? dataFormat,
    this.permissionRequestId,
    this.conditions,
  }) : super(
          nonce: nonce,
          method: 'PermissionsGrant',
          dataCid: dataCid,
          dataFormat: dataFormat,
        );

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
class PermissionsGrantDescriptor extends MessageDescriptor {
  /// Constructor
  const PermissionsGrantDescriptor({
    required final String nonce,
    required this.permissionGrantId,
    required this.grantedBy,
    required this.description,
    required this.grantedTo,
    required this.expiry,
    required this.scope,
    final CID? dataCid,
    final String? dataFormat,
    this.permissionRequestId,
    this.delegatedFrom,
    this.conditions,
  }) : super(
          nonce: nonce,
          method: 'PermissionsGrant',
          dataCid: dataCid,
          dataFormat: dataFormat,
        );

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
class PermissionScope {
  /// Create the PermissionScope.
  const PermissionScope({
    required this.method,
    this.schema,
  });

  /// The interface method the requesting party wants to invoke.
  final String method;

  /// A URI string that indicates the schema of the associated data
  final String? schema;
}

/// Represents the signing conditions of the object.
enum PermissionAttestation {
  /// The object MUST NOT be signed
  prohibited,

  /// The object MAY be signed using a key linked to the DID of the owner of a Decentralized Web Node or authoring party
  optional,

  /// The object MUST be signed using a key linked to the DID of the owner of a Decentralized Web Node or authoring party
  required,
}

/// Represents the encryption conditions of the object.
enum PermissionEncryption {
  /// The object MAY be encrypted using the key provided by the owner of a Decentralized Web Node
  optional,

  /// The object MUST be encrypted using the key provided by the owner of a Decentralized Web Node
  required,
}

/// Describes the conditions of the permission message
class PermissionConditions {
  /// Creates the PermissionCondition object
  const PermissionConditions({
    this.attestation,
    this.encryption,
    this.delegation,
    this.publication,
    this.sharedAccess,
  });

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
