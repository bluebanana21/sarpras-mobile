import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:get/state_manager.dart';
import 'package:sarpras_mobile/controllers/navigationController.dart';
import 'package:sarpras_mobile/models/user.dart';
import 'package:sarpras_mobile/screens/Home.dart';

class Logincontroller extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String _message = "";

  Future<void> submit(BuildContext context) async {
    User user = User(email: email.text.trim(), password: password.text.trim());

    bool validatedResult = validateUser(user);
    if (validatedResult) {
      User? userData = await authenticateUser(user);
      if (userData != null) {
        print('gooo tooo hommmmmmmmeeeeeee');

        Get.put<User>(userData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MaterialApp.router(
                routerConfig: NavigationController.router,
              );
            },
          ),
        );
      } else {
        await showMessage(
          context: Get.context!,
          title: 'Error!',
          message: 'Incorrect user credentials',
        );
      }
    } else {
      await showMessage(
        context: Get.context!,
        title: 'Error: ',
        message: _message,
      );
    }
  }

  bool validateUser(User user) {
    if (user.email == null || user.password == null) {
      _message = "empty email or password";
      return false;
    }
    if (user.email.toString().isEmpty) {
      _message = "Email cannot be empty";
      return false;
    }
    if (user.password.toString().isEmpty) {
      _message = "Password cannot be empty";
      return false;
    }
    return true;
  }

  Future<User?> authenticateUser(User user) async {
    Dio dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));
    String _apiUrl = "http://127.0.0.1:8000/api/login";

    try {
      Map<String, dynamic> requestData = {
        'email': user.email,
        'password': user.password,
      };

      final response = await dio.post(_apiUrl, data: requestData);
      if (response.statusCode == 200) {
        final data = response.data['user'];
        return User.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  showMessage({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
