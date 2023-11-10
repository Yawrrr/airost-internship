// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:helep_v1/Components/my_button.dart';
import 'package:helep_v1/Components/my_text_field.dart';
import 'package:helep_v1/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f5f5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              //logo
              Center(
                child: Icon(
                  Icons.message,
                  size: 80,
                  color: Colors.blue[200],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //welcome back massage
              Text(
                'Welcome back you\'ve been missed',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(
                height: 15,
              ),

              //email textfield
              MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obsecureText: false),

              SizedBox(
                height: 20,
              ),

              //password textfield
              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true),

              SizedBox(
                height: 25,
              ),

              //sign in button
              Mybutton(onTap: signIn, text: 'Sign In'),

              SizedBox(
                height: 25,
              ),

              //not a member? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
