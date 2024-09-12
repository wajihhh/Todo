import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/signin/sign_in_view_model.dart';
import '../signup/register_page.dart';
import '../widget/custom_button.dart';
import '../widget/custom_loader.dart';
import '../widget/custom_textfield.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(SignInViewModel());

    return Obx(
      () => CustomLoaderWidget(
        isTrue: model.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Form(
              key: model.pageFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("Welcome Back!",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("Sign in to continue",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                placeholdertext: "joshluis@mail.com",
                                labeltext: "Email Address",
                                controller: model.emailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                textInputType: TextInputType.text,
                                labeltext: "Password",
                                placeholdertext: "********",
                                sufixIcon: true,
                                controller: model.passwordController,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 20,
                              alignment: Alignment.center,
                              child: !model.invalidCreds.value
                                  ? null
                                  : Text(
                                      'Invalid e-mail or password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    side: const BorderSide(
                                        color: Color(0xffA188FF)),
                                    activeColor: const Color(0xffA188FF),
                                    value: model.rememberMe.value,
                                    onChanged: (bool? value) =>
                                        model.rememberMe(value),
                                  ),
                                  Text(
                                    "Remember me",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            // fontSize: 14,
                                            // fontWeight: FontWeight.w400,
                                            ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: "Sign In",
                            // width: 300.sp,
                            height: 55,
                            width: 330,
                            onTap: () => model.signIn(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () => Get.off(() => const SignUpView()),
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context).brightness ==
                                          Brightness.dark
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
                            height: 10,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "sign up with google",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
