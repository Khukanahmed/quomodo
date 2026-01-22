// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/const/app_sizes.dart';
// import 'package:mfm_ebooks/core/global_widegts/app_text_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_back_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/dimentions.dart';

// import 'package:mfm_ebooks/core/style/global_text_style.dart';

// import 'package:mfm_ebooks/feature/auth/register/controller/registration_controller.dart';

// class OtpScreen2 extends StatelessWidget {
//   OtpScreen2({super.key});
//   final RegistrationController controller = Get.put(RegistrationController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,

//       body: Padding(
//         padding: EdgeInsets.only(left: 16, right: 16, bottom: 30),
//         child: Column(
//           children: [
//             customSizedBox(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomBackButton(),

//                 SizedBox(width: screenWidth() * 0.03),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "verification_code".tr,
//                         style: globalTextStyle(
//                           color: Colors.black,
//                           fontSize: MediaQuery.of(context).size.width * 0.045,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         "we_have_to_sent_the_code_verification_to_your_phone"
//                             .tr,
//                         softWrap: true,
//                         style: globalTextStyle(
//                           color: Colors.black,
//                           fontSize: screenWidth() * 0.035,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 50),
//             OtpTextField(
//               cursorColor: Colors.black,
//               numberOfFields: 4,
//               textStyle: globalTextStyle(
//                 fontSize: 24,
//                 lineHeight: 0.8,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               borderRadius: BorderRadius.circular(12),
//               fieldWidth: 47,
//               fieldHeight: 47,
//               borderWidth: 1,
//               contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//               showFieldAsBox: true,
//               borderColor: AppColors.primaryColor.withValues(alpha: 0.25),
//               enabledBorderColor: AppColors.primaryColor.withValues(
//                 alpha: 0.25,
//               ),
//               focusedBorderColor: AppColors.primaryColor.withValues(
//                 alpha: 0.25,
//               ),
//               onCodeChanged: (code) async {
//                 controller.enteredOtp = code;
//               },
//               onSubmit: (code) async {
//                 controller.enteredOtp = code;
//               },
//             ),
//             SizedBox(height: 20),

//             // Timer
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     AppTextButton(
//             //       text: "resend_code_in".tr,
//             //       onTap: () {
//             //         controller.startTimer();
//             //       },
//             //       textColor: AppColors.textGrey,
//             //       textSize: 14,
//             //       fontWeight: FontWeight.w400,
//             //     ),

//             //     Obx(
//             //       () => Text(
//             //         controller.formattedTime,
//             //         style: globalTextStyle(
//             //           color: Colors.black,
//             //           fontSize: 14,
//             //           fontWeight: FontWeight.w400,
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Obx(() {
//                   final canResend = controller.remainingSeconds.value == 0;
//                   return AppTextButton(
//                     text: "resend_code_in".tr,
//                     onTap:
//                         canResend
//                             ? () {
//                               controller.resendOTP();
//                               controller.startTimer();
//                             }
//                             : () {},
//                     textColor:
//                         canResend ? AppColors.textBlack : AppColors.textBlack,
//                     textSize: 14,
//                     fontWeight: canResend ? FontWeight.bold : FontWeight.w400,
//                     textDecoration: canResend ? TextDecoration.underline : null,
//                   );
//                 }),
//                 Obx(() {
//                   return Text(
//                     " ${controller.formattedTime}",
//                     style: globalTextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   );
//                 }),
//               ],
//             ),
          
//             SizedBox(height: 20),

//             const Spacer(),
//             CustomSubmitButton(
//               radius: 8,
//               text: "verify".tr,
//               onTap: () {
//                 debugPrint("DEBUG: Entered OTP: ${controller.enteredOtp}");
//                 if (controller.enteredOtp != null) {
//                   controller.verifyOtpAndNavigate(controller.enteredOtp!);
//                 } else {
//                   EasyLoading.showError("Please enter the OTP.");
//                 }
               
//               },
//               textColor: AppColors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
