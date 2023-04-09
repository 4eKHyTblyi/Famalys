import 'package:async/src/result/result.dart';
import 'package:famalys/pages/auth/register_page.dart';
import 'package:famalys/pages/home_page.dart';
import 'package:famalys/pages/service/auth_service.dart';
import 'package:famalys/pages/service/provider/vk_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famalys/pages/service/helper.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool passwordHide = true;

  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
  }

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
                      hintText: 'Эл. адрес',
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
                  child: TextFormField(
                    obscuringCharacter: '•',
                    obscureText: passwordHide,
                    controller: password,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordHide = !passwordHide;
                          });
                        },
                      ),
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(125, 132, 168, 1)),
                      hintText: 'Пароль',
                      fillColor: const Color.fromRGBO(239, 242, 255, 1),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          const Color.fromARGB(
                                              255, 255, 179, 15) // Your color
                                      ),
                                  child: Checkbox(
                                    activeColor:
                                        const Color.fromARGB(255, 247, 175, 21),
                                    value: _isChecked,
                                    onChanged: ((value) {
                                      _handleRemeberme(value ?? false);
                                    }),
                                  ))),
                          const SizedBox(width: 10.0),
                          const Text("Запомнить меня",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Rubic')),
                        ],
                      ),
                      TextButton(
                        child: const Text('Забыли пароль?'),
                        onPressed: () {},
                      ),
                    ]),
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
                          width: MediaQuery.of(context).size.width * 0.5,
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

                          provider.googleLogin(context);
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
                            print(await res);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Ошибка авторизации: ${res.asError!.error}'),
                              ),
                            );
                          } else {
                            VKLoginResult result = await res.asFuture;
                            if (!result.isCanceled) {
                              final token = await plugin.accessToken;
                              Result<VKUserProfile?>? profileRes = token != null
                                  ? await plugin.getUserProfile()
                                  : null;

                              VKUserProfile? profile;

                              if (profileRes != null) {
                                profile = await profileRes.asFuture;
                              }

                              if (token != null) {
                                try {
                                  if (profile != null) {
                                    final email = '${profile.userId}@test.ru';
                                    final password = profile.userId.toString();
                                    AuthService()
                                        .loginWithUserNameandPassword(
                                            email, password)
                                        .then((value) {
                                      if (value != true) {
                                        AuthService()
                                            .registerUserWithEmailandPassword(
                                                '${profile!.firstName} ${profile.lastName}',
                                                email,
                                                password,
                                                profile.photo200,
                                                '@${profile.firstName.toLowerCase()}_${profile.lastName.toLowerCase()}_${profile.userId}')
                                            .then((value) {
                                          if (value == true) {
                                            nextScreen(context, HomePage());
                                          }
                                        });
                                      } else {
                                        nextScreen(context, HomePage());
                                      }
                                    });
                                  }
                                } on Exception catch (e) {
                                  print(e);
                                }
                              }
                            } else {
                              showSnackBar(
                                  'Авторизация отменена', context, Colors.red);
                            }
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

  void _handleRemeberme(bool value) {
    print("Handle Rember Me");
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', tel.text);
        prefs.setString('password', password.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        tel.text = _email ?? "";
        password.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}
