import 'package:get/get.dart';

import '../../Data/Models/ListModel.dart';
import '../../Data/Models/Network_Response.dart';
import '../../Data/Services/Network_Caller.dart';
import '../../Data/Utils/Urls.dart';

import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String ? _errorMessage ;

  bool get inProgress => _inProgress;

  String ? get  errorMessage => _errorMessage;


  Future<bool> signInSystem(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };



    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, requestBody);

    if (response.isSuccess) {
      print('ResponseData : ${response.responseData}');
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token.toString());
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
