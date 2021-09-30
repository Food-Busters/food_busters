import "package:flutter/material.dart";
import "package:food_busters/main.dart";
import "package:form_field_validator/form_field_validator.dart";

const smallStyle = TextStyle(fontSize: 20);
const bigStyle = TextStyle(fontSize: 28);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            welcomeText(),
            loginForm(),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Username",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              validator:
                  RequiredValidator(errorText: "Username cannot be null"),
              onSaved: (String? uname) {
                username = uname ?? "";
              },
            ),
            const SizedBox(height: 12),
            const Text(
              "Password",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              validator:
                  RequiredValidator(errorText: "Password cannot be null"),
              obscureText: true,
              onSaved: (String? pw) {
                password = pw ?? "";
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Forget Password?",
                style: TextStyle(fontSize: 12),
              ),
            ),
            ElevatedButton(
              child: const Text(
                ">",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget welcomeText() {
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
          Text("BUSTER", style: bigStyle),
        ],
      ),
    ),
  );
}
