// Flutter imports:
import "package:flutter/material.dart";

// Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:niku/namespace.dart" as n;

// Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/home.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/surrounding_orange.png"),
        n.Column([
          headerText(),
          registerForm(),
        ])
          ..mainCenter
          ..useParent(vCenter),
      ]),
    );
  }

  Widget headerText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: n.Column([
        n.Row(const [
          Text("FOOD BUSTERS", style: bigStyle),
          Text("'s", style: smallStyle),
        ])
          ..crossBaseline
          ..alphabetic,
        const Text("Application", style: smallStyle),
      ])
        ..mainCenter
        ..crossStart
        ..p = 16,
    );
  }

  Widget registerForm() {
    final text = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: n.Column([
          Form(
            key: formKey,
            child: n.Column([
              Text(
                text.username,
                style: const TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: RequiredValidator(errorText: text.username_fail),
                onSaved: (String? uname) {
                  username = uname ?? "";
                },
              ),
              const SizedBox(height: 12),
              Text(
                text.email,
                style: const TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: MultiValidator([
                  RequiredValidator(
                    errorText: text.email_null,
                  ),
                  EmailValidator(
                    errorText: text.email_invalid,
                  )
                ]),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String? em) {
                  email = em ?? "";
                },
              ),
              const SizedBox(height: 12),
              Text(
                text.password,
                style: const TextStyle(fontSize: 20),
              ),
              TextFormField(
                validator: RequiredValidator(
                  errorText: text.password_fail,
                ),
                obscureText: true,
                onSaved: (String? pw) {
                  password = pw ?? "";
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                child: Text(
                  text.register,
                  style: const TextStyle(fontSize: 20),
                ),
                style: loginRegisterBtn,
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(username: username),
                      ),
                    );
                  }
                },
              ),
            ])
              ..crossStart,
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
