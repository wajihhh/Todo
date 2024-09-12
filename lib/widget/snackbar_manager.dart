import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarManager {
  void showSuccessSnackbar(
    BuildContext context,
    String message, {
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.snackbar('', '',
        boxShadows: [
          const BoxShadow(
              color: Colors.black, spreadRadius: 10, blurRadius: 100),
        ],
        backgroundColor: Colors.white,
        titleText: Container(),
        messageText: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 30,
              color: Colors.green,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
        snackPosition: position);
  }

  void showAlertSnackbar(BuildContext context, String message,
      {SnackPosition position = SnackPosition.TOP,
      String? buttonText,
      void Function()? buttonOnPressed}) {
    Get.snackbar('', '',
        boxShadows: [
          const BoxShadow(
              color: Colors.black, spreadRadius: 10, blurRadius: 100),
        ],
        backgroundColor: Colors.white,
        titleText: Container(),
        messageText: Row(
          children: [
            const Icon(
              CupertinoIcons.xmark_circle,
              size: 30,
              color: Colors.red,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        mainButton: buttonText != null
            ? TextButton(
                onPressed: buttonOnPressed,
                child: Text(buttonText),
              )
            : null,
        duration: const Duration(seconds: 2),
        snackPosition: position);
  }

  void showInfoSnackbar(BuildContext context, String message,
      {SnackPosition position = SnackPosition.TOP,
      String? buttonText,
      void Function()? buttonOnPressed}) {
    Get.snackbar('', '',
        boxShadows: [
          const BoxShadow(
              color: Colors.black, spreadRadius: 10, blurRadius: 100),
        ],
        backgroundColor: Colors.white,
        titleText: Container(),
        messageText: Row(
          children: [
            const Icon(
              CupertinoIcons.info_circle,
              size: 30,
              color: Colors.blue,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        mainButton: buttonText != null
            ? TextButton(
                onPressed: buttonOnPressed,
                child: Text(buttonText),
              )
            : null,
        duration: const Duration(seconds: 5),
        snackPosition: position);
  }
}

void showCenteredSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.grey,
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    duration: const Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey,
      content: Center(
        child: snackBar.content ?? Text(''), // Center the content
      ),
    ),
  );
}
