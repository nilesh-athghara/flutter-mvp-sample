import 'package:rapidparty/base/model/base_model.dart';
import 'package:rapidparty/base/model/error_response.dart';
import 'package:rapidparty/server/server_api.dart';
import 'package:simple_permissions/simple_permissions.dart';

abstract class BaseContract {
  void onError(String messageError);
  void showMessage(String message);
}

abstract class BasePresenter {
  final BaseContract view;
  ServerAPI api;
  bool isDispose = false;

  BasePresenter(this.view) {
    api = ServerAPI();
  }

  void dispose() {
    isDispose = true;
  }

  void handleResponse(String message) {
    if (!isDispose) {
      if (message == "Success" || message == "Updated")
        view.showMessage(message);
      else
        view.onError(message);
    }
  }

  bool checkAuthorized(String message) {
    if (message == "Not Authorized") {
      return false;
    }
    return true;
  }

  void checkError(res) {
    if (res != null) {
      if (res is ErrorResponse)
        view.onError(res.message ?? "Some Error has occurred");
      else if (res is String)
        view.onError(res ?? "Some Error has occurred");
      else
        view.onError("Some Error has occurred");
    } else
      view.onError("Some Error has occurred");
  }

  String encode(BaseModel model) {
    return api.encode(model);
  }

  dynamic decode(String data) {
    return api.decode(data);
  }

  // Future<bool> requestPermission(PermissionGroup permission) async {
  //   final List<PermissionGroup> permissions = <PermissionGroup>[permission];
  //   final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
  //       await PermissionHandler().requestPermissions(permissions);
  //   PermissionStatus _permissionStatus = permissionRequestResult[permission];
  //   return _permissionStatus == PermissionStatus.granted;
  // }
  Future<bool> requestPermission(Permission permission) async {
    final res = await SimplePermissions.requestPermission(permission);
    print("RE-> $res");
    return res == PermissionStatus.authorized;
  }
}
