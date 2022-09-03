import 'package:flutter/material.dart';

void showMassege(BuildContext context, String message,
    {String? positiveActionName,
    VoidCallback? positiveAction,
    String? negativeActionName,
    VoidCallback? negativeAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (positiveActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (positiveAction != null) {
            positiveAction();
          }
        },
        child: Text(positiveActionName)));
  }
  if (negativeActionName != null) {
    actions.add(
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negativeAction != null) {
              negativeAction();
            }
          },
          child: Text(negativeActionName)),
    );
  }

  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: actions,
        );
      },
      barrierDismissible: isCancelable);
}

void showLoadingDialog(BuildContext context, String message,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 15,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}
