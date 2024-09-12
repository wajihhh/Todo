import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/signin/sign_in.dart';
import 'package:todo_getx/signin/sign_in_view_model.dart';
import 'package:todo_getx/token_manager.dart';
import 'dashboard/dashboard_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    Get.put(SignInViewModel());

    // Perform token validation and navigation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _checkAuthStatus();
      },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _checkAuthStatus() async {
    // Simulate a delay for splash screen
    await Future.delayed(Duration(seconds: 2));

    // Check token validity
    final token = await TokenManager().getToken();
    final isLoggedIn = token.isNotEmpty;

    // Navigate based on authentication status
    if (isLoggedIn) {
      Get.offAll(() => DashboardView());
    } else {
      Get.offAll(() => SignInView());
    }
  }
}
