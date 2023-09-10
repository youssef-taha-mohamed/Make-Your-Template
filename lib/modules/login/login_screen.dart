import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var emailController_2 = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        //leading: const Icon(Icons.menu),
        title: const Text("First App"),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.notification_add,
        //       size: 32,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       // print("<<I Like My Home>>");
        //     },
        //     icon: const Icon(
        //       Icons.search,
        //       size: 32,
        //     ),
        //   ),
        // ],
        //elevation: 11,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  createTextField(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    validator: (va) {
                      if (va!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  createTextField(
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    validator: (va) {
                      if (va!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    label: "Password",
                    prefixIcon: Icons.lock,
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  defuaaltButton(
                    text: 'login',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        //print("Email Address ${emailController.text}");
                        //print("Password${passwordController.text}");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have any Account?"),
                      TextButton(
                          onPressed: () {}, child: const Text("Register Now")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
