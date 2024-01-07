import 'package:famalys/pages/service/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool view = false;
  bool view2 = false;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _show(BuildContext ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (context) {
            return Builder(builder: (context) {
              return ErrorWidget("Пароли не совпадают");
            });
          });
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ElevatedButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              elevation: MaterialStatePropertyAll(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/back.png'),
              Text(
                'Назад',
                style: HelperFunctions.pGrey,
              )
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: HelperFunctions.paddingH15V10,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Безопасность",
                style: HelperFunctions.h1,
              ),
              Text(
                "Сменить пароль",
                style: HelperFunctions.h2,
              ),
              HelperFunctions.passwordInput(
                  "Новый пароль", view, context, oldPassword),
              HelperFunctions.passwordInput(
                  "Новый пароль (повторите)", view2, context, newPassword),
              ElevatedButton(
                  onPressed: () {
                    if (oldPassword.text == newPassword.text) {
                    } else {
                      _show(context);
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
                  child: HelperFunctions.buttonTemplate(
                      context, "Сохранить изменения"))
            ]),
      ),
    );
  }
}
