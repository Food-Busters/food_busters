import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/home.dart";
import "package:food_busters/views/register.dart";
import "package:form_field_validator/form_field_validator.dart";

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
      body: Stack(
        children: [
          bgImage("assets/images/clouds/surrounding.png"),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                welcomeText(),
                loginForm(),
              ],
            ),
          ),
        ],
      ),
    );
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
            Text("BUSTERS", style: bigStyle),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Username",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator: RequiredValidator(
                        errorText: "Username cannot be null",
                      ),
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
                      validator: RequiredValidator(
                        errorText: "Password cannot be null",
                      ),
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
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(username: username),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
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
                child: const Text("Create new Account"),
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFBBDFC8),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
