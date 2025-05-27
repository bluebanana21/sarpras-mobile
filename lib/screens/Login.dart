import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sarpras_mobile/widgets/InputBox.dart';
import 'package:sarpras_mobile/controllers/loginController.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Logincontroller controller = Get.put(Logincontroller());
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Login'),
                InputBox(
                  isSecured: false,
                  hint: 'Username',
                  txtController: controller.email,
                ),
                SizedBox(height: 20),
                InputBox(
                  isSecured: false,
                  hint: 'Password',
                  txtController: controller.password,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: Get.width / 2,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      print('Login Credentials ========');
                      print('${controller.email.text}');
                      print('${controller.password.text}');
                      await controller.submit();
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
