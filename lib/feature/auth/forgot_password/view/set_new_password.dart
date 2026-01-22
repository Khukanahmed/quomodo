// // ignore_for_file: prefer_const_constructors_in_immutables

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/const/app_sizes.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_back_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_textfield.dart';
// import 'package:mfm_ebooks/core/style/global_text_style.dart';
// import 'package:mfm_ebooks/feature/auth/forgot_password/controller/forgot_controller.dart';

// class SetNewPasswordScreen extends StatelessWidget {
//   SetNewPasswordScreen({super.key});

//   final ForgotPasswordController controller = Get.put(
//     ForgotPasswordController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,

//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
//           child: Column(
//             children: [
//               SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomBackButton(),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "set_new_password".tr,
//                         style: globalTextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       SizedBox(
//                         width: screenWidth() * 0.7,
//                         child: Text(
//                           "create_your_new_password_so_you_can_share_your_memories_again"
//                               .tr,
//                           style: globalTextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           softWrap: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 55),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "new_password".tr,
//                   style: globalTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5),
//               Obx(
//                 () => CustomTextfield(
//                   controller: controller.newPasswordController,
//                   hintext: "enter_your_password".tr,
//                   obsecureText: controller.isNewPassword.value,
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       controller.isNewPassword.value
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined,
//                       color: AppColors.textGrey,
//                     ),
//                     onPressed: controller.toggleNewPassword,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "confirm password".tr,
//                   style: globalTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),

//               Obx(
//                 () => CustomTextfield(
//                   controller: controller.confirmPasswordController,
//                   hintext: "enter_your_password_again".tr,
//                   obsecureText: controller.isConfirmPassword.value,
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       controller.isConfirmPassword.value
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined,
//                       color: AppColors.textGrey,
//                     ),
//                     onPressed: controller.toggleConfirmPassword,
//                   ),
//                 ),
//               ),

//               const Spacer(),
//               CustomSubmitButton(
//                 radius: 8,
//                 text: "save".tr,
//                 onTap: () {
//                   controller.resetPassword();
//                 },
//                 textColor: AppColors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
