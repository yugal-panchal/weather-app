import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController passConfirmController;

@override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    passConfirmController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passController,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
            obscureText: true,
          ),
          TextField(
            controller: passConfirmController,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text("SignUp"),
          )
        ],
      ),
    );
  }
}
