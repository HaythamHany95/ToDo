// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/models/auth_user.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/screens/auth/widgets/auth_button.dart';
import 'package:to_do_app/screens/auth/widgets/auth_textform_field.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/dialog_util.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:to_do_app/utilities/myvalidation.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ///* [ MARK ] Variables: -
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController =
      TextEditingController(text: 'haytham@yahoo.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  final TextEditingController _confirPasswordController =
      TextEditingController(text: '12345678');
  bool _isPasswordSecure = true;
  bool _isConfirmSecure = true;

  ///* [ MARK ] Utilities:-
  void _signUp() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context);
      try {
        /// Create new [AuthUser] in `FiresbaseAuth`
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        /// Create [AuthUser] who `signedUp` above to `FiresbaseFirestore` to store his data
        AuthUser authUser = AuthUser(
            id: userCredential.user?.uid, email: _emailController.text);
        await FirebaseManager.addAuthUserToFirestore(authUser);

        /// Save the current [AuthUser] to [AuthUserProvider] to use it among the app
        var authUserProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authUserProvider.changeAuthUserWhenSignUpAndSignIn(authUser);

        /// Success
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context,
            title: "Register", content: "Signed Up Successfully");
        Navigator.pushNamedAndRemoveUntil(
            context, HomeTabsScreen.routeName, (Route<dynamic> route) => false);

        /// Failure
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context,
              title: "Error", content: "The password provided is too weak.");
        } else if (error.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context,
              title: "Error",
              content: "The account already exists for that email.",
              posActionName: "OK");
        }
      } catch (error) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context,
            title: "Error",
            content: "Error Occured: $error",
            posActionName: "OK");
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
            'Create Account',
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
                    height: MediaQuery.of(context).size.height * 0.09,
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
                  AuthTextFormField(
                    labelText: "Confirm Password",
                    controller: _confirPasswordController,
                    validator: (text) {
                      if (text != _passwordController.text) {
                        return 'Password does not confirmed';
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isConfirmSecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isConfirmSecure = !_isConfirmSecure;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
                  AuthButton(
                    title: "Sign Up",
                    onPressed: () {
                      _signUp();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
