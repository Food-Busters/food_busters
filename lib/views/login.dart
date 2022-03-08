// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/home.dart";
import "package:food_busters/views/register.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: n.Stack([
        bgImage("clouds/surrounding_orange.webp"),
        n.Column([
          welcomeText(),
          loginForm(),
        ])
          ..mainCenter
          ..useParent(vCenter),
      ]),
    );
  }

  Align welcomeText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("WELCOME TO", style: smallStyle),
            Text("FOOD", style: bigStyle),
            Text("BUSTERS", style: bigStyle),
          ],
        ),
      ),
    );
  }

  Padding loginForm() {
    final t = useTranslation(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: n.Column([
          Form(
            key: formKey,
            child: n.Column([
              n.Text(t.username)
                ..fontSize = 20
                ..freezed,
              TextFormField(
                // validator: RequiredValidator(
                //   errorText: text.username_fail,
                // ),
                onSaved: (String? uname) {
                  username = uname ?? "";
                },
              ),
              const SizedBox(height: 12),
              n.Text(t.password)
                ..fontSize = 20
                ..freezed,
              TextFormField(
                // validator: RequiredValidator(
                //   errorText: text.password_fail,
                // ),
                obscureText: true,
                onSaved: (String? pw) {
                  password = pw ?? "";
                },
              ),
              n.Text(
                t.forget_password,
              )
                ..fontSize = 12
                ..useParent((v) => v..py = 8),
              ElevatedButton(
                child: n.Text(t.login)
                  ..fontSize = 20
                  ..freezed,
                style: loginRegisterBtn,
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    MyApp.of(context).state.username =
                        username.isNotEmpty ? username : "undefined";
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
              ),
            ])
              ..crossStart,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(color: Colors.grey, height: 2),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            style: loginRegisterBtn,
            child: Text(t.create_new_account),
          ),
        ])
          ..p = 12,
        decoration: const BoxDecoration(
          color: Color(0xFFBBDFC8),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
