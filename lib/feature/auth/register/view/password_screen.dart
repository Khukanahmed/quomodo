// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/const/image_path.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_textfield.dart';
// import 'package:mfm_ebooks/core/style/global_text_style.dart';
// import 'package:mfm_ebooks/feature/auth/register/controller/registration_controller.dart';

// class PasswordScreen extends StatelessWidget {
//   PasswordScreen({super.key});
//   final RegistrationController controller = Get.put(RegistrationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(
//           top: 69,
//           bottom: 30,
//           left: 16,
//           right: 16,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.asset(ImagePath.splashImg, height: 100, width: 100),
//             ),
//             const SizedBox(height: 24),
//             Center(
//               child: Text(
//                 "create_account".tr,
//                 style: globalTextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Text(
//               "password".tr,
//               style: globalTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 5),
//             Obx(
//               () => CustomTextfield(
//                 controller: controller.passwordController,
//                 hintext: "enter_your_password".tr,
//                 obsecureText: controller.isPasswordHidden.value,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     controller.isPasswordHidden.value
//                         ? Icons.visibility_off_outlined
//                         : Icons.visibility_outlined,
//                     color: AppColors.textGrey,
//                   ),
//                   onPressed: controller.togglePasswordVisibility,
//                 ),
//               ),
//             ),

//             const Spacer(),
//             Obx(
//               () => IgnorePointer(
//                 ignoring: controller.isLoading.value,
//                 child: CustomSubmitButton(
//                   radius: 8,
//                   text: "sign_up".tr,
//                   onTap: () async {
//                     if (controller.passwordController.text.length >= 8) {
//                       await controller.createPassword();
//                     } else {
//                       EasyLoading.showError(
//                         "password_must_be_at_least_8_characters_long".tr,
//                       );
//                     }
//                   },

//                   textColor: AppColors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
