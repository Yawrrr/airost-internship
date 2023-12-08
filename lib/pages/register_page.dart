
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
// ignore_for_file: use_build_context_synchronously

>>>>>>> 8b3f3ab0e76ceda66a5114a6ebd0e4bcabd48a84
import 'package:flutter/material.dart';
import 'package:helep_v1/Components/my_button.dart';
import 'package:helep_v1/Components/my_text_field.dart';
import 'package:helep_v1/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up function
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password don\' match')));
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(usernameController.text,
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
                'Let\'s create a account for you',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(
                height: 15,
              ),

              //username textfield
              MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obsecureText: false),

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
                height: 20,
              ),

              //password textfield
              MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obsecureText: true),

              SizedBox(
                height: 25,
              ),

              //confirm password textfield
              Mybutton(onTap: signUp, text: 'Sign Up'),

              SizedBox(
                height: 25,
              ),

              //not a member? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member?'),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: widget.ontap,
                    child: Text(
                      'Sign In',
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
