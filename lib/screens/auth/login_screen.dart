import 'package:flutter/material.dart';
import 'package:to_do_app/screens/auth/register_screen.dart';
import 'package:to_do_app/screens/auth/widgets/auth_button.dart';
import 'package:to_do_app/screens/auth/widgets/auth_textform_field.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/screens/home_tabs/tasks/tasks_tab.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:to_do_app/utilities/myvalidation.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController =
      TextEditingController(text: 'haytham@yahoo.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  bool _isPasswordSecure = true;
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
            'Login',
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
                      if (_formKey.currentState?.validate() == true) {
                        Navigator.pushReplacementNamed(
                            context, HomeTabsScreen.routeName);
                      }
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
