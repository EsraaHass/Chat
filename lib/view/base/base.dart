import 'package:chat/view/shared/constant/dialogDetails.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoading({String message = 'Loading...'});

  void hideLoading();

  void showMessage(String message,
      {String? positiveActionName,
      VoidCallback? positiveAction,
      String? negativeActionName,
      VoidCallback? negativeAction,
      bool isCancelable = true});
}

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideLoading() {
    hideLoadingDialog(context);
  }

  @override
  void showLoading({String message = 'Loading...'}) {
    showLoadingDialog(context, message);
  }

  @override
  void showMessage(String message,
      {String? positiveActionName,
      VoidCallback? positiveAction,
      String? negativeActionName,
      VoidCallback? negativeAction,
      bool isCancelable = true}) {
    showMassegeDialog(context, message,
        positiveActionName: positiveActionName,
        positiveAction: positiveAction,
        isCancelable: isCancelable);
  }
}
