import 'package:famalys/pages/auth/register_page.dart';
import 'package:famalys/pages/home_page.dart';
import 'package:famalys/pages/service/auth_service.dart';
import 'package:famalys/pages/service/provider/vk_provider.dart';
import 'package:flutter/material.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:provider/provider.dart';

import '../service/provider/google_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset("assets/LOGO_IN_AUTH.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text('Авторизация'),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 242, 255, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: tel,
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Введите корректный email";
                    },
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(125, 132, 168, 1)),
                      hintText: 'Моб. телефон или эл. адрес',
                      fillColor: Color.fromRGBO(239, 242, 255, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 242, 255, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(125, 132, 168, 1)),
                      hintText: 'Пароль',
                      fillColor: const Color.fromRGBO(239, 242, 255, 1),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text('Забыли пароль?'),
                    onPressed: () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (tel.text == "") {
                              showSnackBar(
                                  'Поле телефона пустое!', context, Colors.red);
                            } else {
                              if (password.text == "") {
                                showSnackBar(
                                    'Поле пароля пустое!', context, Colors.red);
                              } else {
                                AuthService()
                                    .loginWithUserNameandPassword(
                                        tel.text, password.text)
                                    .then((value) {
                                  if (value == true) {
                                    showSnackBar('Вы успешно вошли!', context,
                                        Colors.green);
                                    nextScreen(context, const HomePage());
                                  } else {
                                    print(password.text);
                                    if (value != null) {
                                      showSnackBar(value, context, Colors.red);
                                    }
                                  }
                                });
                              }
                            }
                          }
                        },
                        clipBehavior: Clip.antiAlias,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/Acuarela2.png'),
                                fit: BoxFit.cover),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(255, 166, 182, 1),
                              Color.fromRGBO(255, 232, 172, 1),
                              Color.fromRGBO(193, 237, 152, 1),
                              Color.fromRGBO(166, 228, 255, 1),
                            ]),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Войти',
                            style:
                                TextStyle(fontSize: 20, color: Colors.blueGrey),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);

                          provider.googleLogin();
                        },
                        child: Image.asset('assets/google.png')),
                    TextButton(
                        onPressed: () async {
                          final plugin = VKLogin();

                          await plugin.initSdk();

                          final res = await plugin.logIn(scope: [
                            VKScope.email,
                          ]);

                          if (res.isError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Log In failed: ${res.asError!.error}'),
                              ),
                            );
                          } else {
                            final loginResult = res.asValue!.value;
                          }
                        },
                        child: Image.asset('assets/vk.png')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ещё нет аккаунта?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          nextScreenReplace(context, const RegisterPage());
                        },
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
