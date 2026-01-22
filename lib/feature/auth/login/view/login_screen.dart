// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/global_widegts/app_text_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_textfield.dart';
// import 'package:mfm_ebooks/core/route/routes.dart';
// import 'package:mfm_ebooks/core/style/global_text_style.dart';
// import 'package:mfm_ebooks/feature/auth/forgot_password/controller/forgot_controller.dart';
// import 'package:mfm_ebooks/feature/auth/login/controller/login_controller.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   final LoginController controller = Get.put(LoginController());
//   final ForgotPasswordController forgotPasswordController = Get.put(
//     ForgotPasswordController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     bottom: 30,
//                     left: 16,
//                     right: 16,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,

//                     children: [
//                       // Mobile Number Field
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "mobile_number".tr,
//                             style: globalTextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           CustomTextfield(
//                             controller: controller.numberController,
//                             hintext: "enter_your_number_here".tr,
//                             textInputType: TextInputType.phone,
//                             prefixIcon: Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: CountryCodePicker(
//                                 onChanged: (code) {
//                                   controller.selectedCountryCode.value =
//                                       code.dialCode ?? "+234"; // fallback
//                                 },
//                                 initialSelection: 'NG',
//                                 favorite: ['NG', 'BD', 'US'],
//                                 showCountryOnly: false,
//                                 showOnlyCountryWhenClosed: false,
//                                 alignLeft: false,
//                                 textStyle: GoogleFonts.inter(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColors.textBlack,
//                                 ),
//                                 padding: EdgeInsets.zero,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           // CustomTextfield(
//                           //   controller: controller.numberController,
//                           //   hintext: "enter_your_number_here".tr,
//                           //   //textInputType: TextInputType.number,
//                           // ),
//                           // const SizedBox(height: 16),

//                           // Password Field
//                           Text(
//                             "password".tr,
//                             style: globalTextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Obx(
//                             () => CustomTextfield(
//                               controller: controller.passwordController,
//                               hintext: "enter_your_password".tr,
//                               obsecureText: controller.isPasswordHidden.value,
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   controller.isPasswordHidden.value
//                                       ? Icons.visibility_off_outlined
//                                       : Icons.visibility_outlined,
//                                   color: AppColors.textGrey,
//                                 ),
//                                 onPressed: controller.togglePasswordVisibility,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       ),

//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: IntrinsicWidth(
//                           child: AppTextButton(
//                             text: "forgot_password?".tr,
//                             fontWeight: FontWeight.w700,
//                             onTap: () {
//                               Get.toNamed(AppRoutes.forgotPassword);
//                             },
//                             textColor: Color(0xff4C4C4C),
//                             textDecoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       CustomSubmitButton(
//                         text: "login".tr,
//                         radius: 8,
//                         onTap: () {
//                           controller.login();
//                         },
//                         textColor: AppColors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
