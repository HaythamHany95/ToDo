// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase/firebase_manager.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/auth_user_provider.dart';
import 'package:to_do_app/screens/auth/login/login_screen_delegate.dart';
import 'package:to_do_app/screens/auth/login/login_screen_viewmodel.dart';
import 'package:to_do_app/screens/auth/register/register_screen.dart';
import 'package:to_do_app/screens/auth/widgets/auth_button.dart';
import 'package:to_do_app/screens/auth/widgets/auth_textform_field.dart';
import 'package:to_do_app/screens/home_tabs/home_tabs_screen.dart';
import 'package:to_do_app/utilities/dialog_util.dart';
import 'package:to_do_app/utilities/my_theme.dart';
import 'package:to_do_app/utilities/myvalidation.dart';

///localization_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements LoginScreenDelegete {
  bool _isPasswordSecure = true;
  var viewModel = LoginScreenViewModel();

  ///* [ MARK ] STF LifeCycle :-
  @override
  void initState() {
    super.initState();
    viewModel.delegate = this;
  }

  @override
  Widget build(BuildContext context) {
    var appConfigProvider = Provider.of<AppConfiguresProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          (appConfigProvider.currentMode == ThemeMode.light)
              ? 'assets/images/splash_icon.png'
              : 'assets/images/splash_icon_dark.png',
          opacity: (appConfigProvider.currentMode == ThemeMode.light)
              ? const AlwaysStoppedAnimation(0.8)
              : const AlwaysStoppedAnimation(0.7),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: (appConfigProvider.currentMode == ThemeMode.light)
              ? Colors.white.withOpacity(0.85)
              : MyTheme.darkBackgroundColor.withOpacity(0.8),
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
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: (appConfigProvider.currentMode == ThemeMode.light)
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: MyTheme.primaryColor)
                          : Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: MyTheme.whiteColor),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    AuthTextFormField(
                      labelText: AppLocalizations.of(context)!.email,
                      controller: viewModel.emailController,
                      validator: MyValidation.validateEmail,
                    ),
                    AuthTextFormField(
                      labelText: AppLocalizations.of(context)!.pass,
                      controller: viewModel.passwordController,
                      validator: MyValidation.validatePassword,
                      obscureText: _isPasswordSecure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordSecure = !_isPasswordSecure;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color:
                              (appConfigProvider.currentMode == ThemeMode.light)
                                  ? MyTheme.primaryColor
                                  : MyTheme.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    AuthButton(
                      title: AppLocalizations.of(context)!.login,
                      onPressed: () {
                        viewModel.signIn();
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.havent_acc,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  showLoading() {
    DialogUtils.showLoading(context, message: "Loading...");
  }

  @override
  showMessage(String message) {
    DialogUtils.showMessage(context, title: "", content: message);
  }
}
