import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Dia;ogue_utils.dart';
import 'package:todo/HOUSE/homeScreen.dart';
import 'package:todo/authentication/register/register_screen.dart';
import 'package:todo/components/custom_text_field.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'diana@5.com');

  var passwordController = TextEditingController(text: '567890');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/SIGN IN – 1.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                CustomTxtFormField(
                  label: 'email address',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  valiadtor: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter email address';
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return 'please enter valid email address';
                    }
                    return null;
                  },
                ),
                CustomTxtFormField(
                  label: 'password',
                  keyboardType: TextInputType.number,
                  controller: passwordController,
                  valiadtor: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter password';
                    }
                    if (text.length < 6) {
                      return 'password should be greater than 6 chars';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'login',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an acc?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      DialogueUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUer(user);

        DialogueUtils.hideLoading(context);
        DialogueUtils.showMsg(context, 'log success',
            title: 'success', posActionName: 'ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });

        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMsg(context, 'No user found for that email.',
              title: 'error', posActionName: 'ok');

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMsg(
              context, 'Wrong password provided for that user',
              title: 'error', posActionName: 'ok');

          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogueUtils.hideLoading(context);
        DialogueUtils.showMsg(context, '${e.toString()}',
            title: 'error', posActionName: 'ok');

        print(e.toString());
      }
    }
  }
}
