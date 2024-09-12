import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/user_service.dart';
import '../signin/sign_in.dart';
import '../widget/snackbar_manager.dart';

class SignUpViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  RxBool isLoading = false.obs;

  RxBool invalidCreds = false.obs;
  final pageFormKey = GlobalKey<FormState>();

  GetStorage box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> signUp() async {
    if (!pageFormKey.currentState!.validate()) {
      return;
    }
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      SnackbarManager()
          .showAlertSnackbar(Get.context!, "Please fill in all fields");
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      SnackbarManager()
          .showInfoSnackbar(Get.context!, "Please enter valid email");
      return;
    }

    if (passwordController.text.trim().length <= 6) {
      SnackbarManager().showInfoSnackbar(
          Get.context!, "Password should be greater than 6 digits");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;

    if (await UserService().signUp(
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      password: passwordController.text.removeAllWhitespace,
    )) {
      isLoading.value = false;
      box.write('name', nameController.text.trim());

      // final user = fullNameController.text.split(' ').first;
      SnackbarManager()
          .showSuccessSnackbar(Get.context!, 'User added successfully.');

      Get.off(
        () => const SignInView(),
      );
    } else {
      invalidCreds(true);
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
