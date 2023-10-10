import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Dia;ogue_utils.dart';
import 'package:todo/HOUSE/homeScreen.dart';
import 'package:todo/authentication/login/login_screen.dart';
import 'package:todo/components/custom_text_field.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'diana');

  var emailController = TextEditingController(text: 'diana@5.com');

  var passwordController = TextEditingController(text: '567890');

  var confirmPassController = TextEditingController(text: '567890');

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
                  label: 'User name',
                  controller: nameController,
                  valiadtor: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter user name';
                    }
                    return null;
                  },
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
                CustomTxtFormField(
                  label: 'confirm password',
                  keyboardType: TextInputType.number,
                  controller: confirmPassController,
                  valiadtor: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter confirmation pass';
                    }
                    if (text != passwordController.text) {
                      return 'pass doesnt match';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      register(context);
                    },
                    child: Text(
                      'register',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10)),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text("Already have an account"))
              ],
            ),
          ),
        )
      ],
    ));
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogueUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        FirebaseUtils.addUserToFireStore(myUser);

        await FirebaseUtils.addUserToFireStore(myUser);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUer(myUser);

        DialogueUtils.hideLoading(context);
        DialogueUtils.showMsg(context, 'Reg success',
            title: 'success', posActionName: 'ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });

        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMsg(context, 'The password provided is too weak.',
              title: 'error', posActionName: 'ok');

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogueUtils.hideLoading(context);
          DialogueUtils.showMsg(
              context, 'The account already exists for that email..',
              title: 'error', posActionName: 'ok');

          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogueUtils.hideLoading(context);
        DialogueUtils.showMsg(context, '${e.toString()}',
            title: 'error', posActionName: 'ok');

        print(e);
      }
    }
  }
}
