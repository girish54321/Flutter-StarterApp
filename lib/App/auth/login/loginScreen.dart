import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/App/auth/login/loginUI.dart';
import 'package:reqres_app/App/auth/signUp/SignUpScreen.dart';
import 'package:reqres_app/network/dataModel/LoginSuccess.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/remote_data_source.dart';
import 'package:reqres_app/network/util/helper.dart';
import 'package:reqres_app/widget/dismissKeyBoardView.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validEmail = false, validPassword = false, rememberMe = true;

  void goBack(context) {
    Helper().goBack();
  }

  void changeVaildEmail(bool value) {
    setState(() {
      validEmail = value;
    });
  }

  void changevalidPassword(bool value) {
    setState(() {
      validPassword = value;
    });
  }

  void changeRemember(bool value) {
    setState(() {
      rememberMe = value;
    });
  }

  void loginUser() {
    GetStorage box = GetStorage();
    print("Login Tap: ");
    if (_formKey.currentState!.validate()) {
      Helper().dismissKeyBoard(context);
      Helper().showLoading();
      print("Login Tap: 2");

      RemoteDataSource _apiResponse = RemoteDataSource(Client());
      var parameter = {
        "email": "eve.holt@reqres.in",
        "password": "cityslickasss"
      };
      print("Login Tap: 3");

      Future<Result> result = _apiResponse.userLogin(parameter);
      result.then((value) {
        if (value is SuccessState) {
          Helper().hideLoading();
          print("Login Tap: 5");

          var res = value.value as LoginSuccess;
          print("Loand and save the result" + res.token!);
          box.write('token', res.token);
          // Get.off(HomeScreen());
        } else {
          print(value);
          print("Login Tap: 6");
        }
      });
    } else {
      print("Login Tap: 7");

      // Helper().vibratPhone();
    }
    setState(() {});
    print("Login Tap: 8");
  }

  void createAccount() {
    Helper().dismissKeyBoard(context);
    Helper().goToPage(context: context, child: SignUpScreen());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyBoardView(
      child: LoginScreenUI(
          emailController: emailController,
          passwordController: passwordController,
          validEmail: validEmail,
          validPassword: validPassword,
          changeVaildEmail: changeVaildEmail,
          changevalidPassword: changevalidPassword,
          changeRemember: changeRemember,
          rememberMe: rememberMe,
          formKey: _formKey,
          createAccount: createAccount,
          loginUser: loginUser),
    );
  }
}
