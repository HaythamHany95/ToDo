import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/auth/login/login_screen_delegate.dart';

class LoginScreenViewModel extends ChangeNotifier {
  /// holding data - handling logic
  /// the Scenairo
  final GlobalKey<FormState> formKey = GlobalKey();
  var emailController = TextEditingController(text: 'haytham@yahoo.com');
  var passwordController = TextEditingController(text: '12345678');
  late LoginScreenDelegete? delegate;

  void signIn() async {
    if (formKey.currentState?.validate() == true) {
      /// Todo: show loading
      delegate?.showLoading();

      try {
        /// `Sign In` with an existing [AuthUser] from `FirebaseAuth`
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // /// Read the existing [AuthUser]'s data from `FiresbaseFirestore` to show when navigate to `HomeScreen`

        // var authUser = await FirebaseManager.readAuthUserFromFirestore(
        //     userCredential.user?.uid ?? "");

        // /// Checking if there isn't a user in `FiresbaseFirestore` return and dont resume the operation down below
        // /// And Don't worry: It rarely happens
        // if (authUser == null) {
        //   return;
        // }

        // /// Save the current [AuthUser] to [AuthUserProvider] to use it among the app
        // var authUserProvider =
        //     Provider.of<AuthUserProvider>(context, listen: false);
        // authUserProvider.changeAuthUserWhenSignUpAndSignIn(authUser);

        /// Success
        // Todo: hide loading
        delegate?.hideLoading();

        /// todo : show message
        delegate?.showMessage("Successfully Logged in");

        /// Failure
      } on FirebaseAuthException catch (error) {
        if (error.code == 'invalid-credential') {
          /// todo: hide loading
          /// todo : show message
          delegate?.hideLoading();
          delegate?.showMessage("invalid-credential");
        }
      } catch (error) {
        /// todo: hide loading
        /// todo : show message
        delegate?.hideLoading();
        delegate?.showMessage("$error");
      }
    }
  }
}
