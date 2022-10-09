import 'package:chat/repository/repository.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/shared/constant/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var authServices = FirebaseAuth.instance;
  Repository? repository;

  LoginViewModel({this.repository});

  void login(String email, String password) async {
    navigator?.showLoading();
    try {
      var cerdintial = await authServices.signInWithEmailAndPassword(
          email: email, password: password);

      var retriveUser =
          await repository?.retriveUserById(cerdintial.user?.uid ?? '');

      navigator?.hideLoading();
      if (retriveUser == null) {
        navigator?.showMessage('something went wrong with username or password',
            positiveActionName: 'ok');
      } else {
        SharedData.myUser = retriveUser;
        navigator?.goToHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      if (e.code == 'weak-password') {
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('something went wrong, please try again.');
    }
  }
}
