import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          children: [
            Image.asset("assets/LOGO_IN_AUTH.png"),
            Image.asset("assets/FAMILIES_LOGIN.png"),
            const Text('Авторизация'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Моб. телефон или эл. адрес',
                fillColor: const Color.fromRGBO(239, 242, 255, 1),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Пароль',
                fillColor: const Color.fromRGBO(239, 242, 255, 1),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
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
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.transparent)),
                  child: Ink(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 166, 182, 1),
                          Color.fromRGBO(255, 232, 172, 1),
                          Color.fromRGBO(193, 237, 152, 1),
                          Color.fromRGBO(166, 228, 255, 1),
                        ]),
                      ),
                      child: const Text('Войти')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
