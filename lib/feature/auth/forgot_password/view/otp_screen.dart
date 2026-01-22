// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/const/app_sizes.dart';
// import 'package:mfm_ebooks/core/global_widegts/app_text_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_back_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/style/global_text_style.dart';
// import 'package:mfm_ebooks/feature/auth/forgot_password/controller/forgot_controller.dart';

// class OtpScreen extends StatelessWidget {
//   OtpScreen({super.key});

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

//                   SizedBox(width: 24),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "verification_code".tr,
//                           style: globalTextStyle(
//                             color: Colors.black,
//                             fontSize: MediaQuery.of(context).size.width * 0.045,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "we_have_to_sent_the_code_verification_to_your_phone"
//                               .tr,
//                           softWrap: true,
//                           style: globalTextStyle(
//                             color: Colors.black,
//                             fontSize: screenWidth() * 0.035,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 50),
//               OtpTextField(
//                 cursorColor: Colors.black,
//                 numberOfFields: 4,
//                 textStyle: globalTextStyle(
//                   fontSize: 24,
//                   lineHeight: 0.8,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 fieldWidth: 47,
//                 fieldHeight: 47,
//                 borderWidth: 1,
//                 contentPadding: EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 15,
//                 ),
//                 showFieldAsBox: true,
//                 borderColor: AppColors.primaryColor.withValues(alpha: 0.25),
//                 enabledBorderColor: AppColors.primaryColor.withValues(
//                   alpha: 0.25,
//                 ),
//                 focusedBorderColor: AppColors.primaryColor.withValues(
//                   alpha: 0.25,
//                 ),
//                 onSubmit: (value) {
//                   controller.otpController = value;
//                 },
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Obx(() {
//                     final canResend = controller.remainingSeconds.value == 0;
//                     return AppTextButton(
//                       text: "resend_code_in".tr,
//                       onTap:
//                           canResend
//                               ? () {
//                                 controller.resendOTP();
//                                 controller.startTimer();
//                               }
//                               : () {},
//                       textColor:
//                           canResend ? AppColors.textBlack : AppColors.textBlack,
//                       textSize: 14,
//                       fontWeight: canResend ? FontWeight.bold : FontWeight.w400,
//                       textDecoration:
//                           canResend ? TextDecoration.underline : null,
//                     );
//                   }),
//                   Obx(() {
//                     return Text(
//                       " ${controller.formattedTime}",
//                       style: globalTextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     );
//                   }),
//                 ],
//               ),

//               SizedBox(height: 20),

//               const Spacer(),
//               CustomSubmitButton(
//                 radius: 8,
//                 text: "verify".tr,
//                 onTap: () {
//                   String rawNumber = controller.numberController.text
//                       .trim()
//                       .replaceAll(' ', '');
//                   if (rawNumber.startsWith('0')) {
//                     rawNumber = rawNumber.substring(1);
//                   }
//                   final formattedNumber =
//                       '${controller.selectedCountryCode.value}$rawNumber'
//                           .replaceAll(RegExp(r'^(\+)?'), '+');

//                   controller.verifyOtp(formattedNumber);
//                   debugPrint(
//                     "Sending OTP verification for number: $formattedNumber",
//                   );
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
