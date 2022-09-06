import 'package:dwn_sdk/dwn_sdk.dart';

void main() {
  final DWN dwn = DWN(
    interfaces: <Interface>[
      CollectionsInterface(),
      //PermissionsInterface(),
    ],
  );
}
