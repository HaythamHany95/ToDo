import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/auth/register/register_screen_delegate.dart';

/// The Boss
class RegisterScreenViewModel extends ChangeNotifier {
  /// ViewModel Class : holding Data & handling logic

  // Data
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController =
      TextEditingController(text: 'haytham@yahoo.com');
  final TextEditingController passwordController =
      TextEditingController(text: '12345678');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '12345678');

  late RegisterScreenDelegate delegate;

  // Logic
  void register() async {
    if (formKey.currentState?.validate() == true) {
      ///TODO:  Show Loading
      /// The Boss wants the intern to do this
      delegate.showLoading();
      try {
        /// Create new [AuthUser] in `FiresbaseAuth`
        var userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // /// Create [AuthUser] who `signedUp` above to `FiresbaseFirestore` to store his data
        // AuthUser authUser = AuthUser(
        //     id: userCredential.user?.uid, email: _emailController.text);
        // await FirebaseManager.addAuthUserToFirestore(authUser);

        // /// Save the current [AuthUser] to [AuthUserProvider] to use it among the app
        // var authUserProvider =
        //     Provider.of<AuthUserProvider>(context, listen: false);
        // authUserProvider.changeAuthUserWhenSignUpAndSignIn(authUser);

        /// Success
        ///// TODO: hide loading
        /////TODO: show message
        delegate.hideLoading();
        delegate.showMessage("Register Successfuly");

        /// Failure
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          ///// TODO: hide loading
          /////TODO: show message
          delegate.hideLoading();
          delegate.showMessage("Weak-Password");
        } else if (error.code == 'email-already-in-use') {
          ///// TODO: hide loading
          /////TODO: show message
          delegate.hideLoading();
          delegate.showMessage("Email already in user");
        }
      } catch (error) {
        ///// TODO: hide loading
        /////TODO: show message
        delegate.hideLoading();
        delegate.showMessage("$error");
      }
    }
  }
}
