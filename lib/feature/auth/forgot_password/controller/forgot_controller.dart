


//class ForgotPasswordController extends GetxController {
  // final TextEditingController numberController = TextEditingController();
  // final TextEditingController newPasswordController = TextEditingController();
  // String? otpController = "";
  // final TextEditingController confirmPasswordController =
  //     TextEditingController();

  // var isNewPassword = false.obs;
  // var isConfirmPassword = false.obs;
  // RxInt remainingSeconds = 120.obs;
  // Timer? _timer;

  // RxString selectedCountryCode = "+234".obs;

  // String get formattedTime {
  //   int seconds = remainingSeconds.value;
  //   return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  // }

  // void startTimer() {
  //   // Cancel any existing timer
  //   _timer?.cancel();
  //   remainingSeconds.value = 120; // Reset to 30 seconds
   
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (remainingSeconds.value > 0) {
  //       remainingSeconds.value--;
  //     } else {
  //       timer.cancel();
  //       update(); // Force UI update when timer completes
  //     }
  //   });
  // }

  // void toggleNewPassword() {
  //   isNewPassword.value = !isNewPassword.value;
  // }

  // void toggleConfirmPassword() {
  //   isConfirmPassword.value = !isConfirmPassword.value;
  // }

  // // forget password method........
  // Future<void> forgetPassword() async {
  //   final url = Urls.forgetPassword;

    
  //   String countryCode = selectedCountryCode.value; // e.g. "+880"
  //   String number = numberController.text.trim(); // e.g. "1712345678"
  //   if (number.startsWith('0')) {
  //     number = number.substring(1);
  //   }
  //   String fullPhoneNumber = '$countryCode$number'; // e.g. "+8801712345678"

  //   log('Number: $fullPhoneNumber');
  //   if (fullPhoneNumber.isEmpty) {
  //     EasyLoading.showError("please_enter_your_number".tr);
  //     return;
  //   }

  //   try {
  //     EasyLoading.show(status: "loading".tr);

  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"phoneNumber": fullPhoneNumber}),
  //     );

  //     log('Request URL: ${Urls.forgetPassword}');
  //     log('Input Data (JSON): ${response.body}');
  //     log('Status code: ${response.statusCode}');

  //     var responseData = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess("forget_password_is_successful.".tr);
  //       Get.toNamed(AppRoutes.otpScreen);
  //     } else {

  //       final errorMessage =
  //           responseData["message"] ?? "failed_to_forget_password.".tr;

  //       // 👇 Custom handling based on error name
  //       if (responseData["err"] != null &&
  //           response.statusCode == 500 &&
  //           responseData["err"]["name"] == "NotFoundError") {
  //         EasyLoading.showError("incorrect_phone_number_please_try_again".tr);
  //       } else {
  //         EasyLoading.showError(errorMessage);
  //       }
  //       // EasyLoading.showError(
  //       //   responseData["message"] ?? "failed_to_forget_password.".tr,
  //       // );
  //     }
  //   } on SocketException {
  //     log("No Internet connection");
  //     EasyLoading.showError(
  //       "no_internet_connection. please_check_your_network.".tr,
  //     );
  //   } on TimeoutException {
  //     log("Request timed out");
  //     EasyLoading.showError(
  //       "server_is_taking_too_long_to_respond. please_try_again_later.".tr,
  //     );
  //   } on HttpException {
  //     log("HTTP Exception occurred");
  //     EasyLoading.showError("something_went_wrong. please_try_again.".tr);
  //   } on FormatException {
  //     log("Invalid JSON format");
  //     EasyLoading.showError(
  //       "server_response_was_not_in_the_expected_format.".tr,
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error: $e");
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  // // verify otp method........
  // Future<void> verifyOtp(String number) async {
  //   final url = Urls.verifyOtp;
  //   log("Sending OTP verification for number: $number");

  //   int otp = int.tryParse(otpController.toString()) ?? -1;

  //   if (otp < 0) {
  //     EasyLoading.showError("invalid_otp! please_enter_a_valid_number.".tr);
  //     return;
  //   }
  //   try {
  //     EasyLoading.show(status: "loading".tr);
  //     final body = json.encode({"phoneNumber": number.toString(), "otp": otp});

  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: body,
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     log('Request URL: $url');
  //     log('Input Data (JSON): ${response.body}');
  //     log('Status code: ${response.statusCode}');

  //     var responseData = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess("otp_verification_is_successful.".tr);
  //       Get.toNamed(AppRoutes.setNewPassword);
  //     } else {
  //       EasyLoading.showError(
  //         responseData["message"] ?? "failed_to_otp_verification.".tr,
  //       );
  //     }
  //   } on SocketException {
  //     log("No Internet connection");
  //     EasyLoading.showError(
  //       "no_internet_connection. please_check_your_network.".tr,
  //     );
  //   } on TimeoutException {
  //     log("Request timed out");
  //     EasyLoading.showError(
  //       "server_is_taking_too_long_to_respond. please_try_again_later.".tr,
  //     );
  //   } on HttpException {
  //     log("HTTP Exception occurred");
  //     EasyLoading.showError("something_went_wrong. please_try_again.".tr);
  //   } on FormatException {
  //     log("Invalid JSON format");
  //     EasyLoading.showError(
  //       "server_response_was_not_in_the_expected_format.".tr,
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  // // reset password method........
  // Future<void> resetPassword() async {
  //   final url = Urls.resetPassword;
  //   String newPassword = newPasswordController.text.trim();
  //   String confirmPassword = confirmPasswordController.text.trim();
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var token = preferences.getString('token');

  //   if (newPassword.isEmpty) {
  //     EasyLoading.showToast("please_enter_a_new_password".tr);
  //     return;
  //   } else if (newPassword.length < 8) {
  //     EasyLoading.showToast("password_must_be_at_least_8_characters_long".tr);
  //     return;
  //   }
  //   if (newPassword == confirmPassword) {
  //     try {
  //       EasyLoading.show(status: "loading".tr);
  //       final body = json.encode({
  //         "phoneNumber": numberController.text.trim(),
  //         "password": newPasswordController.text.trim(),
  //       });

  //       final response = await http.post(
  //         Uri.parse(url),
  //         body: body,
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "$token",
  //         },
  //       );

  //       log('Request URL: $url');
  //       log('Input Data (JSON): ${response.body}');
  //       log('Status code: ${response.statusCode}');

  //       if (response.statusCode == 200) {
  //         showSuccessDialog(
  //           message: "your_password_is_successfully\nchange!".tr,
  //           onTap: () {
  //             Get.toNamed(AppRoutes.welcome2);
  //           },
  //         );
  //       } else {
  //         var errorData = jsonDecode(response.body);
  //         EasyLoading.showError(
  //           errorData['message'] ?? "failed_to_reset_password".tr,
  //         );
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
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     } finally {
  //       EasyLoading.dismiss();
  //     }
  //   } else {
  //     EasyLoading.showError("the_passwords_do_not_match".tr);
  //   }
  // }

  // //===============================Resend OTP===============================
  // Future<void> resendOTP() async {
    
  //   try {
  //     final url = Urls.resendOtp;
      
  //     EasyLoading.show(status: "loading".tr);

  //     String rawNumber = numberController.text.trim().replaceAll(' ', '');
  //     if (rawNumber.startsWith('0')) {
  //       rawNumber = rawNumber.substring(1);
  //     }
  //     final formattedNumber = '${selectedCountryCode.value}$rawNumber'
  //         .replaceAll(RegExp(r'^(\+)?'), '+');

  //     final body = json.encode({"phoneNumber": formattedNumber});
  //     log("Sending OTP verification for number: $formattedNumber}");
   

  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: body,
  //       headers: {"Content-Type": "application/json"},
  //     );

  //     log('Request URL: $url');
  //     log('Status code: ${response.statusCode}');
  //     log('Input Data (JSON): ${response.body}');

     
  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess("resend_otp_verification_is_successful.".tr);
  //       startTimer();
  //     } else {
  //       var responseData = jsonDecode(response.body);
  //       EasyLoading.showError(
  //         responseData["message"] ?? "failed_to_resend_otp_verification.".tr,
  //       );
  //     }
  //   } on SocketException {
  //     log("No Internet connection");
  //     EasyLoading.showError(
  //       "no_internet_connection. please_check_your_network.".tr,
  //     );
  //   } on TimeoutException {
  //     log("Request timed out");
  //     EasyLoading.showError(
  //       "server_is_taking_too_long_to_respond. please_try_again_later.".tr,
  //     );
  //   } on HttpException {
  //     log("HTTP Exception occurred");
  //     EasyLoading.showError("something_went_wrong. please_try_again.".tr);
  //   } on FormatException {
  //     log("Invalid JSON format");
  //     EasyLoading.showError(
  //       "server_response_was_not_in_the_expected_format.".tr,
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   startTimer();
  // }

  // @override
  // void onClose() {
  //   _timer?.cancel();
  //   super.onClose();
  // }
//}
