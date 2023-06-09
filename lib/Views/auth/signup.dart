import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/FirebaseServices.dart';
import '../widgets/constants.dart';
import '../widgets/input.dart';
import '../widgets/mybutton.global.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RegistreState();
  }
}

class RegistreState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _passwdConfirmController = TextEditingController();
  final FirebaseServices FB = FirebaseServices();

  Future? signUp() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        // ignore: unused_local_variable
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Get.offAll(() => const Login()) ;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        Timer(const Duration(seconds: 6), () {
          Navigator.pop(context);
        });
      } catch (e) {
        print(e);
        Timer(const Duration(seconds: 6), () {
          Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF021638)
          : Colors.white,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "yha".tr,
            ),
            InkWell(
              onTap: () => Get.off(const Login()),
              child: Text(
                "login".tr,
                style: TextStyle(
                  color: myColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: myColor,
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 20,
                  ),
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Image.asset(
                        "images/register.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "cya".tr,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      //Input c'est un classe declarer dans le package widget
                      Input(
                        label: "Email",
                        hint: "email@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        isObscure: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enteremail'.tr;
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'entervalidemail'.tr;
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.email_outlined),
                        controller: emailController,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //Mot de passe
                      Input(
                        label: "pw".tr,
                        hint: "...........",
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'plpass'.tr;
                          } else if (value.length < 8) {
                            return 'pssm'.tr;
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //confirme mdp
                      Input(
                        label: "cpw".tr,
                        hint: "...........",
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'cpwr'.tr;
                          }
                          if (value != passwordController.text) {
                            return 'pwcp'.tr;
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        controller: _passwdConfirmController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //MyButton c'est un classe declarer dans le package widget
                      //btn pour connexion
                      MyButton(
                        text: "register".tr,
                        color: myColor,
                        onPressed: signUp,
                        textColor: Colors.white,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
