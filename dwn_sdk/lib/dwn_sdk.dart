/// An implementation of the DWN SDK in Dart. Provides applications with some
/// useful abstractions in common usage scenarios.
///
/// For details on the DWN protocol, check out the [DWN specifications](https://identity.foundation/decentralized-web-node/spec/#signed-data).
///
/// Currently, this library does not strictly follow the DWN specifications as
/// DWN is still in a draft state. Things may change rapidly.
library dwn_sdk;

//export 'package:jose/jose.dart';
export 'src/cid.dart';
export 'src/message.dart';
