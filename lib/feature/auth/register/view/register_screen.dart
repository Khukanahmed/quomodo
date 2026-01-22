// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_textfield.dart';
// import 'package:mfm_ebooks/core/style/global_text_style.dart';
// import 'package:mfm_ebooks/feature/auth/register/controller/registration_controller.dart';

// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});
//   final RegistrationController controller = Get.put(RegistrationController());

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
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "name".tr,
//                         style: globalTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       CustomTextfield(
//                         controller: controller.nameController,
//                         hintext: "enter_your_name_here".tr,
//                       ),
//                       const SizedBox(height: 16),

//                       Text(
//                         "mobile_number".tr,
//                         style: globalTextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       CustomTextfield(
//                         controller: controller.phoneController,
//                         hintext: "enter_your_number_here".tr,
//                         textInputType: TextInputType.phone,

//                         prefixIcon: Container(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: CountryCodePicker(
//                             onChanged: (code) {
//                               controller.selectedCountryCode.value =
//                                   code.dialCode ?? "+234"; // fallback
//                             },
//                             initialSelection: 'NG',
//                             favorite: ['NG', 'BD', 'US'],
//                             showCountryOnly: false,
//                             showOnlyCountryWhenClosed: false,
//                             alignLeft: false,
//                             textStyle: GoogleFonts.inter(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: AppColors.textBlack,
//                             ),
//                             padding: EdgeInsets.zero,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),

//                       //
//                       const SizedBox(height: 50),
//                       CustomSubmitButton(
//                         radius: 8,
//                         text: "next".tr,
//                         onTap: () {
//                           controller.registerUser();
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
