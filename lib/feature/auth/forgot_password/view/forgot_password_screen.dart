// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   ForgotPasswordScreen({super.key});

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
//                         "reset_password".tr,
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
//                           "please_enter_your_number_to_reset_the_password".tr,
//                           style: globalTextStyle(
//                             color: Color(0xff000000),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
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
//                   "number".tr,
//                   style: globalTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               CustomTextfield(
//                 controller: controller.numberController,
//                 hintext: "enter_your_number_here".tr,
//                 prefixIcon: Container(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: CountryCodePicker(
//                     onChanged: (code) {
//                       controller.selectedCountryCode.value =
//                           code.dialCode ?? "+234"; // fallback
//                     },
//                     initialSelection: 'NG',
//                     favorite: ['NG', 'BD', 'US'],
//                     showCountryOnly: false,
//                     showOnlyCountryWhenClosed: false,
//                     alignLeft: false,
//                     textStyle: GoogleFonts.inter(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.textBlack,
//                     ),
//                     padding: EdgeInsets.zero,
//                   ),
//                 ),
//               ),

//               const Spacer(),
//               CustomSubmitButton(
//                 text: "continue".tr,
//                 radius: 8,
//                 onTap: () {
//                   controller.forgetPassword();
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
