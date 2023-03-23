import 'package:famalys/pages/auth/login_page.dart';
import 'package:famalys/pages/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../service/helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            children: [
              Image.asset("assets/LOGO_IN_AUTH.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Регистрация',
                style: TextStyle(
                    color: Color.fromRGBO(125, 132, 168, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 242, 255, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: tel,
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    AuthService().registerUserWithEmailandPassword(
                        tel.text, tel.text, password.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/Acuarela2.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Уже есть аккаунт?',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        nextScreenReplace(context, const LoginPage());
                      },
                      child: const Text(
                        'Войти',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
              const Text(
                'Регистрируясь, вы принимаете наши yсловия, политику использования данных и политику в отношении файлов cookie.',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
