import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/app_Text_form_field.dart';
import 'package:chat_app/widgets/app_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  bool isPassHide = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: const Color(0xff2B475E),
      child: Scaffold(
        backgroundColor: const Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'LOGIN',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' password must not be empty ';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextFormField(
                        controller: passwordController,
                        inputType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' password must not be empty ';
                          }
                        },
                        obscureText: isPassHide,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassHide = !isPassHide;
                              });
                            },
                            icon: Icon(
                              isPassHide
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextButton(
                      text: 'Login',
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            final user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            Navigator.pushNamed(context, ChatScreen.id,
                                arguments: emailController.text);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      buttonColor: Colors.white,
                      textColor: const Color(0xff2B475E),
                      borderRadius: 4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
