// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mfm_ebooks/core/network_caller/endpoints.dart';
// import 'package:mfm_ebooks/core/route/routes.dart';
// import 'package:mfm_ebooks/feature/profile/controller/profile_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class LoginController extends GetxController {
//   final TextEditingController numberController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   RxString selectedCountryCode = "+234".obs;

//   var isPasswordHidden = false.obs;
//   RxBool obscureText = true.obs;

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   String? fcmToken;
//   void togglePasswordVisibility() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }

//   // login method...............
//   Future<void> login() async {
//     try {
//       EasyLoading.show(status: "loading".tr);
//       final url = Urls.login;

//       String countryCode = selectedCountryCode.value; // e.g. "+880"
//       String number = numberController.text.trim(); // e.g. "1712345678"
//       if (number.startsWith('0')) {
//         number = number.substring(1);
//       }
//       String fullPhoneNumber = '$countryCode$number'; // e.g. "+8801712345678"
//       String password = passwordController.text.trim();

//       debugPrint("📞 Full Phone Number sent to API: $fullPhoneNumber");
    
//       if (number.isEmpty) {
//         EasyLoading.showToast("please_enter_your_number".tr);
//         return;
//       } else if (password.isEmpty) {
//         EasyLoading.showToast("please_enter_your_password".tr);
//         return;
//       } else if (password.length < 8) {
//         EasyLoading.showToast("password_can't_be_less_than_8_character".tr);
//         return;
//       }
//       final Map<String, String> inputData = {
//         "phoneNumber": fullPhoneNumber,
//         "password": password,
//         "fcmToken": fcmToken ?? "",
//       };

//       log('Request URL: $url');
//       log('Input Data (JSON): ${jsonEncode(inputData)}');

//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "Application/json"},
//         body: jsonEncode(inputData),
//       );

//       log("Response Status Code: ${response.statusCode}");
//       log("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);

//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         sharedPreferences.setString('token', data['data']['token']);

//         // Fetch the latest user profile using the existing ProfileController
//         final profileController = Get.put(ProfileController());
//         await profileController.getProfile();
        
//         EasyLoading.showSuccess("login_successful!".tr);

//         // Get.offAndToNamed(AppRoutes.bottomNavScreen);
//         Get.offAllNamed(AppRoutes.bottomNavScreen);
//         numberController.clear();
//         passwordController.clear();
//       } else {
//         var responseData = jsonDecode(response.body);
//         EasyLoading.showError(responseData["message"]);
//       }
//     } on SocketException {
//       log("No Internet connection");
//       EasyLoading.showError(
//         "no_internet_connection. please_check_your_network.".tr,
//       );
//     } on TimeoutException {
//       log("Request timed out");
//       EasyLoading.showError(
//         "server_is_taking_too_long_to_respond. please_try_again_later.".tr,
//       );
//     } on HttpException {
//       log("HTTP Exception occurred");
//       EasyLoading.showError("something_went_wrong. please_try_again.".tr);
//     } on FormatException {
//       log("Invalid JSON format");
//       EasyLoading.showError(
//         "server_response_was_not_in_the_expected_format.".tr,
//       );
//     } catch (e) {
//       log("Unexpected error: $e");
//     } finally {
//       EasyLoading.dismiss();
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     initializeFCM();
//   }

//   Future<void> initializeFCM() async {
//     try {
//       NotificationSettings settings = await _firebaseMessaging
//           .requestPermission(alert: true, badge: true, sound: true);

//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         if (kDebugMode) {
//           print('User granted permission for notifications');
//         }
//         fcmToken = await _firebaseMessaging.getToken();
//         if (kDebugMode) {
//           print('FCM Token: $fcmToken');
//         }
//       } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
//         if (kDebugMode) {
//           print('User denied permission for notifications');
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error initializing FCM: $e');
//       }
//     }
//   }
// }
