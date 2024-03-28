/// Boss's List of tasks
/// RegisterScreenViewModel Protocol
/// navigator || connector || delegate
abstract class RegisterScreenDelegate {
  showLoading();
  hideLoading();
  showMessage(String message);
  navigateToHomeScreen();
}
