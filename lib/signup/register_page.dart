import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/signup/register_view_model.dart';
import '../signin/sign_in.dart';
import '../widget/custom_button.dart';
import '../widget/custom_loader.dart';
import '../widget/custom_textfield.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(SignUpViewModel());
    return Obx(
      () => CustomLoaderWidget(
        isTrue: model.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: const Color(0xff472EC9),
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Form(
                      key: model.pageFormKey,
                      child: signUpForm(model, context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpForm(SignUpViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text("Sign Up To Get Started!",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 20)),
            const SizedBox(
              height: 10,
            ),

            CustomTextField(
              textInputType: TextInputType.text,
              labeltext: 'name',
              placeholdertext: '*********',
              sufixIcon: true,
              controller: model.nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              // textInputType: TextInputType.emailAddress,
              labeltext: 'Email Address',
              placeholdertext: 'joshluis@gmail.com',
              controller: model.emailController,
            ),
            const SizedBox(
              height: 10,
            ),

            CustomTextField(
              textInputType: TextInputType.text,
              labeltext: 'Password',
              placeholdertext: '*********',
              sufixIcon: true,
              controller: model.passwordController,
            ),

            const SizedBox(
              height: 25,
            ),
            CustomButton(
              onTap: () => model.signUp(),
              height: 55,
              width: 330,
              text: "Register Account",
            ),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Get.off(() => const SignInView()),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).brightness == Brightness.dark
                        ? const TextStyle(
                            color: Color(
                              0xff6B46F6,
                            ),
                            decorationColor: Color(0xff6B46F6),
                            decoration: TextDecoration.underline,
                          )
                        : const TextStyle(
                            color: Color(
                              0xffFFC100,
                            ),
                            decorationColor: Color(0xffFFC100),
                            decoration: TextDecoration.underline,
                          ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "sign up with google",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 15),
              ),
            )
            // SizedBox(height: 10,),
            // Text("Sign Up With Google")
          ],
        ),
      ),
    );
  }
}
