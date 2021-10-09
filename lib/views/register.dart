import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/home.dart";
import "package:form_field_validator/form_field_validator.dart";

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
      body: Stack(
        children: [
          bgImage("assets/images/clouds/surrounding.png"),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                headerText(),
                registerForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Text("FOOD BUSTERS", style: bigStyle),
                Text("'s", style: smallStyle),
              ],
            ),
            const Text("Application", style: smallStyle),
          ],
        ),
      ),
    );
  }

  Widget registerForm() {
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
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Please input Email"),
                        EmailValidator(errorText: "Invalid Email")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? em) {
                        email = em ?? "";
                      },
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 12),
                    ElevatedButton(
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: loginRegisterBtn,
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          Navigator.of(context).pop();
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
