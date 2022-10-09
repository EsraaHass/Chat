import 'package:chat/model/my_user.dart';
import 'package:chat/repository/repository.dart';
import 'package:chat/view/base/base.dart';
import 'package:chat/view/shared/constant/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Repository? repository;

  RegisterViewModel({this.repository});

  void creatAccount(
      String email, String password, String firstName, String lastName) async {
    navigator?.showLoading();
    try {
      var cerdintial = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser myUser = MyUser(
          id: cerdintial.user?.uid,
          firstName: firstName,
          lastName: lastName,
          email: email);

      var insertedUser = await repository?.insertUser(myUser);

      navigator?.hideLoading();
      if (insertedUser != null) {
        SharedData.myUser = insertedUser;
        navigator?.goToHome();
      } else {
        navigator
            ?.showMessage('something went wrong with username or password');
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
