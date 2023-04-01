import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_auth_firebase/main.dart';
import 'package:login_auth_firebase/home_Screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    //showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user not found") {
        print("no user found for that email");
      }
    }
    return user;
  }

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Firebase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hi, Register Here",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (email) =>
              //     email != null && EmailValidator.validate(email)
              //         ? "Enter a valid email"
              //         : null,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.grey[10],
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.black,
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _passwordController,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) => value != null && value.length < 6
              //     ? "Enter the min 6 characters"
              //     : null,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.grey[10],
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Do you have an account already? ",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  print("Email:${_emailController.text}");
                  print("Email:${_passwordController.text}");
                  /** Here we are going to place our sign in with email code */

                  User? user = await createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                //color: Colors.amber,
              ),
            ),
            Text("Or"),
            ElevatedButton(
              onPressed: () {
                /** Here we are going place our Authentication System Code */
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyWidget()));
              },
              child: Text("Login"),
              //color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
