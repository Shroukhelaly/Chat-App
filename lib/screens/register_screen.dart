import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/app_Text_form_field.dart';
import '../widgets/app_text_button.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                        'REGISTER',
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
                          return 'email must not be empty';
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
                        ),
                      ),
                      hintText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextButton(
                      text: 'Register',
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            final user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            Navigator.pushNamed(context, ChatScreen.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('The password provided is too weak.'),
                              ));
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'The account already exists for that email.'),
                              ));
                            }
                          } catch (e) {
                            print(e);
                          }
                          isLoading = false;
                          setState(() {});
                        }

                        // await FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //   email: emailController.text,
                        //   password: passwordController.text,
                        // )
                        //     .then((UserCredential user) {
                        //   print("user Registered Successfully");
                        //   // print(user.user!.email);
                        // }).catchError((error) {
                        //   print("user Registered Error: $error");
                        // });
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
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
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
