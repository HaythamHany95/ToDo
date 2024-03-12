// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/screens/auth/register_screen.dart';
import 'package:to_do_app/screens/auth/widgets/auth_button.dart';
import 'package:to_do_app/screens/auth/widgets/auth_textform_field.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/dialog_util.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:to_do_app/utilities/myvalidation.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///* [ MARK ] Variables :-
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController =
      TextEditingController(text: 'haytham@yahoo.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  bool _isPasswordSecure = true;

  ///* [ MARK ] Utilities :-
  void _signIn() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context);
      try {
        /// `Sign In` with an existing [AuthUser] from `FirebaseAuth`
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        /// Read the existing [AuthUser]'s data from `FiresbaseFirestore` to show when navigate to `HomeScreen`

        var authUser = await FirebaseManager.readAuthUserFromFirestore(
            userCredential.user?.uid ?? "");

        /// Checking if there isn't a user in `FiresbaseFirestore` return and dont resume the operation down below
        /// And Don't worry: It rarely happens
        if (authUser == null) {
          return;
        }

        /// Save the current [AuthUser] to [AuthUserProvider] to use it among the app
        var authUserProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authUserProvider.changeAuthUserWhenSignUpAndSignIn(authUser);

        /// Success
        DialogUtils.hideLoading(context);
        Navigator.pushReplacementNamed(context, HomeTabsScreen.routeName);

        /// Failure
      } on FirebaseAuthException catch (error) {
        if (error.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context,
              title: "Error",
              content: "Wrong email or password",
              posActionName: "OK");
        }
      } catch (error) {
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(context,
            title: "Error", content: "$error", posActionName: "OK");
      }
    }
  }

  ///* [ MARK ] STF LifeCycle :-
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        'assets/images/splash_icon.png',
        opacity: const AlwaysStoppedAnimation(0.8),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        appBar: AppBar(
          title: const Text(
            '',
          ),
          toolbarHeight: 100,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: MyTheme.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.primaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  AuthTextFormField(
                    labelText: "Email",
                    controller: _emailController,
                    validator: MyValidation.validateEmail,
                  ),
                  AuthTextFormField(
                    labelText: "Password",
                    controller: _passwordController,
                    validator: MyValidation.validatePassword,
                    obscureText: _isPasswordSecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordSecure = !_isPasswordSecure;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  AuthButton(
                    title: "Login",
                    onPressed: () {
                      _signIn();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        "Don't have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 12),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
