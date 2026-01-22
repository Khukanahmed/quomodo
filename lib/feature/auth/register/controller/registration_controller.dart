// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RegistrationController extends GetxController {
//   final Map<String, int> _countryDigitLengths = {
//     'BD': 10, // Bangladesh (+880) 1XXXXXXXXX
//     'US': 10, // USA (+1) NXX NXX XXXX
//     'UK': 10, // UK (+44) 7XXX XXX XXX
//     'IN': 10, // India (+91) XXXXX XXXXX
//     'SA': 9, // Saudi Arabia (+966) 5X XXX XXXX
//     'AE': 9, // UAE (+971) 5X XXX XXXX
//     'PK': 10, // Pakistan (+92) 3XX XXXXXXX
//     'CA': 10, // Canada (+1) NXX NXX XXXX
//     'AU': 9, // Australia (+61) 4XX XXX XXX
//     'NZ': 9, // New Zealand (+64) 2X XXX XXX
//     'DE': 11, // Germany (+49) 1XX XXXXXXX
//     'FR': 9, // France (+33) 6X XX XX XX XX
//     'IT': 10, // Italy (+39) 3XX XXX XXXX
//     'ES': 9, // Spain (+34) 6XX XXX XXX
//     'NG': 10, // Nigeria (+234) 8XX XXX XXXX
//     'GH': 9, // Ghana (+233) 2X XXX XXX
//     'KE': 9, // Kenya (+254) 7XX XXX XXX
//     'BR': 11, // Brazil (+55) 9XXXX XXXXX
//     'MX': 10, // Mexico (+52) 1XX XXX XXXX
//     'RU': 10, // Russia (+7) 9XX XXX XXXX
//     'CN': 11, // China (+86) 1XX XXXX XXXX
//     'JP': 10, // Japan (+81) 90 XXXX XXXX
//     'KR': 10, // South Korea (+82) 10 XXXX XXXX
//     'SG': 8, // Singapore (+65) XXXX XXXX
//     'MY': 9, // Malaysia (+60) 1X XXX XXXX
//     'TH': 9, // Thailand (+66) 8X XXX XXX
//     'PH': 10, // Philippines (+63) 9XX XXX XXXX
//     'TR': 10, // Turkey (+90) 5XX XXX XXXX
//     'IR': 10, // Iran (+98) 9XX XXX XXXX
//     'IQ': 10, // Iraq (+964) 7XX XXX XXXX
//     'AF': 9, // Afghanistan (+93) 7X XXX XXX
//     // Add more countries as needed
//   };

//   String getCountryKeyFromCode(String code) {
//     switch (code) {
//       case '+234':
//         return 'NG';
//       case '+880':
//         return 'BD';
//       case '+1':
//         return 'US'; // USA/Canada
//       case '+44':
//         return 'UK';
//       case '+91':
//         return 'IN';
//       case '+966':
//         return 'SA';
//       case '+971':
//         return 'AE';
//       case '+92':
//         return 'PK';
//       case '+61':
//         return 'AU';
//       case '+64':
//         return 'NZ';
//       case '+49':
//         return 'DE';
//       case '+33':
//         return 'FR';
//       case '+39':
//         return 'IT';
//       case '+34':
//         return 'ES';
//       case '+233':
//         return 'GH';
//       case '+254':
//         return 'KE';
//       case '+55':
//         return 'BR';
//       case '+52':
//         return 'MX';
//       case '+7':
//         return 'RU';
//       case '+86':
//         return 'CN';
//       case '+81':
//         return 'JP';
//       case '+82':
//         return 'KR';
//       case '+65':
//         return 'SG';
//       case '+60':
//         return 'MY';
//       case '+66':
//         return 'TH';
//       case '+63':
//         return 'PH';
//       case '+90':
//         return 'TR';
//       case '+98':
//         return 'IR';
//       case '+964':
//         return 'IQ';
//       case '+93':
//         return 'AF';

//       default:
//         return code.replaceAll('+', '');
//     }
//   }

//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   var emailController = TextEditingController();

//   RxString selectedCountryCode = "+234".obs;

//   final isLoading = false.obs;
//   var isPasswordHidden = false.obs;
//   RxBool obscureText = true.obs;
//   RxInt remainingSeconds = 120.obs;
//   String? enteredOtp;
//   String? authToken;
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   String? fcmToken;

//   final String url = Urls.baseUrl;
//   Timer? _timer;

//   RxString registeredPhoneNumber = ''.obs;

//   Future<void> _loadToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     authToken = prefs.getString('token');
//     debugPrint(
//       'Token loaded from SharedPreferences: ${authToken != null ? "exists" : "null"}',
//     );
//   }

//   bool isValidPhoneNumberForCountry(String phoneNumber, String countryCode) {
//     // Remove all non-digit characters
//     var digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

//     // Special handling for Nigeria: remove leading zero if present
//     if (countryCode == 'NG' &&
//         digitsOnly.length == 11 &&
//         digitsOnly.startsWith('0')) {
//       digitsOnly = digitsOnly.substring(1);
//     }

//     // Get the expected length for this country
//     final expectedLength = _countryDigitLengths[countryCode] ?? 10;

//     debugPrint('Expected length: $expectedLength');

//     // Check length matches
//     if (digitsOnly.length != expectedLength) {
//       return false;
//     }

//     // Country-specific additional validation (if needed)
//     switch (countryCode) {
//       case 'BD': // Bangladesh
//         return digitsOnly.startsWith('1'); // BD numbers start with 1
//       case 'SA': // Saudi Arabia
//         return digitsOnly.startsWith('5'); // SA mobile numbers start with 5
//       case 'AE': // UAE
//         return digitsOnly.startsWith('5'); // UAE mobile numbers start with 5
//       case 'IN': // India
//         return RegExp(
//           r'^[6-9]',
//         ).hasMatch(digitsOnly); // IN numbers start with 6-9
//       case 'PK': // Pakistan
//         return digitsOnly.startsWith('3'); // PK mobile numbers start with 3
//       case 'NG': // Nigeria
//         return RegExp(
//           r'^[789]',
//         ).hasMatch(digitsOnly); // NG numbers start with 7,8,9
//       case 'GH': // Ghana
//         return digitsOnly.startsWith('2'); // GH mobile numbers start with 2
//       case 'KE': // Kenya
//         return digitsOnly.startsWith('7'); // KE mobile numbers start with 7
//       case 'MY': // Malaysia
//         return digitsOnly.startsWith('1'); // MY mobile numbers start with 1
//       case 'TH': // Thailand
//         return digitsOnly.startsWith('8') ||
//             digitsOnly.startsWith('9'); // TH numbers start with 8 or 9
//       case 'PH': // Philippines
//         return digitsOnly.startsWith('9'); // PH numbers start with 9
//       case 'TR': // Turkey
//         return digitsOnly.startsWith('5'); // TR mobile numbers start with 5
//       case 'IR': // Iran
//         return digitsOnly.startsWith('9'); // IR mobile numbers start with 9
//       case 'IQ': // Iraq
//         return digitsOnly.startsWith('7'); // IQ mobile numbers start with 7
//       case 'AF': // Afghanistan
//         return digitsOnly.startsWith('7'); // AF mobile numbers start with 7
//       case 'UK': // United Kingdom
//         return digitsOnly.startsWith('7'); // UK mobile numbers start with 7
//       case 'US': // United States
//       case 'CA': // Canada
//         return RegExp(
//           r'^[2-9]',
//         ).hasMatch(digitsOnly); // US/CA area codes start with 2-9
//       case 'AU': // Australia
//         return digitsOnly.startsWith('4'); // AU mobile numbers start with 4
//       case 'NZ': // New Zealand
//         return digitsOnly.startsWith('2'); // NZ mobile numbers start with 2
//       case 'DE': // Germany
//         return digitsOnly.startsWith('1'); // DE mobile numbers start with 1
//       case 'FR': // France
//         return digitsOnly.startsWith('6') ||
//             digitsOnly.startsWith('7'); // FR mobile numbers start with 6 or 7
//       case 'IT': // Italy
//         return digitsOnly.startsWith('3'); // IT mobile numbers start with 3
//       case 'ES': // Spain
//         return digitsOnly.startsWith('6') ||
//             digitsOnly.startsWith('7'); // ES mobile numbers start with 6 or 7
//       case 'BR': // Brazil
//         return digitsOnly.startsWith('9'); // BR mobile numbers start with 9
//       case 'MX': // Mexico
//         return digitsOnly.startsWith('1'); // MX mobile numbers start with 1
//       case 'RU': // Russia
//         return digitsOnly.startsWith('9'); // RU mobile numbers start with 9
//       case 'CN': // China
//         return digitsOnly.startsWith('1'); // CN mobile numbers start with 1
//       case 'JP': // Japan
//         return digitsOnly.startsWith('9'); // JP mobile numbers start with 9
//       case 'KR': // South Korea
//         return digitsOnly.startsWith('1'); // KR mobile numbers start with 1
//       case 'SG': // Singapore
//         return RegExp(
//           r'^[89]',
//         ).hasMatch(digitsOnly); // SG mobile numbers start with 8 or 9
//       // Add more country-specific rules as needed
//       default:
//         return true;
//     }
//   }

//   bool isPossiblePhoneNumber(String phoneNumber) {
//     // Basic check for minimum length
//     if (phoneNumber.length < 8 || phoneNumber.length > 15) {
//       return false;
//     }

//     // Check if it contains only digits and optional + prefix
//     return RegExp(r'^\+?[0-9]{8,15}$').hasMatch(phoneNumber);
//   }

//   Future<void> registerUser() async {
//     EasyLoading.show(status: "loading".tr);
//     final fullName = nameController.text.trim();

//     // Get the trimmed input and remove all spaces
//     String rawNumber = phoneController.text.trim().replaceAll(' ', '');

//     // Remove leading '0' if present
//     if (rawNumber.startsWith('0')) {
//       rawNumber = rawNumber.substring(1);
//     }

//     // Build the full phone number with country code
//     final phoneNumber = '${selectedCountryCode.value}$rawNumber'.replaceAll(
//       RegExp(r'^(\+)?'),
//       '+',
//     ); // Ensures '+' is prefixed properly

//     registeredPhoneNumber.value = phoneNumber;

//     debugPrint("📞 Full Phone Number sent to API: $phoneNumber");
//     debugPrint("Full Name: $fullName");

//     if (fullName.isEmpty || phoneNumber.isEmpty) {
//       EasyLoading.showError("'error', all_fields_are_required".tr);
//       return;
//     }

//     // --- Enhanced validation block starts here ---
//     final countryKey = getCountryKeyFromCode(selectedCountryCode.value);
//     final expectedLength = _countryDigitLengths[countryKey] ?? 10;
//     final digitsOnly = phoneController.text.trim().replaceAll(
//       RegExp(r'[^0-9]'),
//       '',
//     );
//     String normalizedDigits = digitsOnly;
//     if (countryKey == 'NG' &&
//         digitsOnly.length == 11 &&
//         digitsOnly.startsWith('0')) {
//       normalizedDigits = digitsOnly.substring(1);
//     }

//     // Check length first
//     if (normalizedDigits.length != expectedLength) {
//       EasyLoading.showError(
//         "Phone number must be $expectedLength digits for ${selectedCountryCode.value}",
//       );
//       return;
//     }

//     // Then check country-specific rules
//     bool countryRuleValid = true;
//     switch (countryKey) {
//       case 'BD':
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'NG':
//         countryRuleValid = RegExp(r'^[789]').hasMatch(normalizedDigits);
//         break;
//       case 'SA': // Saudi Arabia
//         countryRuleValid = normalizedDigits.startsWith('5');
//         break;
//       case 'AE': // UAE
//         countryRuleValid = normalizedDigits.startsWith('5');
//         break;
//       case 'IN': // India
//         countryRuleValid = RegExp(r'^[6-9]').hasMatch(normalizedDigits);
//         break;
//       case 'PK': // Pakistan
//         countryRuleValid = normalizedDigits.startsWith('3');
//         break;
//       case 'GH': // Ghana
//         countryRuleValid = normalizedDigits.startsWith('2');
//         break;
//       case 'KE': // Kenya
//         countryRuleValid = normalizedDigits.startsWith('7');
//         break;
//       case 'MY': // Malaysia
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'TH': // Thailand
//         countryRuleValid =
//             normalizedDigits.startsWith('8') ||
//             normalizedDigits.startsWith('9');
//         break;
//       case 'PH': // Philippines
//         countryRuleValid = normalizedDigits.startsWith('9');
//         break;
//       case 'TR': // Turkey
//         countryRuleValid = normalizedDigits.startsWith('5');
//         break;
//       case 'IR': // Iran
//         countryRuleValid = normalizedDigits.startsWith('9');
//         break;
//       case 'IQ': // Iraq
//         countryRuleValid = normalizedDigits.startsWith('7');
//         break;
//       case 'AF': // Afghanistan
//         countryRuleValid = normalizedDigits.startsWith('7');
//         break;
//       case 'UK': // United Kingdom
//         countryRuleValid = normalizedDigits.startsWith('7');
//         break;
//       case 'US': // United States
//       case 'CA': // Canada
//         countryRuleValid = RegExp(r'^[2-9]').hasMatch(normalizedDigits);
//         break;
//       case 'AU': // Australia
//         countryRuleValid = normalizedDigits.startsWith('4');
//         break;
//       case 'NZ': // New Zealand
//         countryRuleValid = normalizedDigits.startsWith('2');
//         break;
//       case 'DE': // Germany
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'FR': // France
//         countryRuleValid =
//             normalizedDigits.startsWith('6') ||
//             normalizedDigits.startsWith('7');
//         break;
//       case 'IT': // Italy
//         countryRuleValid = normalizedDigits.startsWith('3');
//         break;
//       case 'ES': // Spain
//         countryRuleValid =
//             normalizedDigits.startsWith('6') ||
//             normalizedDigits.startsWith('7');
//         break;
//       case 'BR': // Brazil
//         countryRuleValid = normalizedDigits.startsWith('9');
//         break;
//       case 'MX': // Mexico
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'RU': // Russia
//         countryRuleValid = normalizedDigits.startsWith('9');
//         break;
//       case 'CN': // China
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'JP': // Japan
//         countryRuleValid = normalizedDigits.startsWith('9');
//         break;
//       case 'KR': // South Korea
//         countryRuleValid = normalizedDigits.startsWith('1');
//         break;
//       case 'SG': // Singapore
//         countryRuleValid = RegExp(r'^[89]').hasMatch(normalizedDigits);
//         break;
//       // Add more country-specific rules as needed
//     }

//     if (!countryRuleValid) {
//       String errorMessage =
//           "Invalid phone number format for ${selectedCountryCode.value}";
//       if (countryKey == 'BD') {
//         errorMessage += ". Number must start with 1";
//       }
//       if (countryKey == 'NG') {
//         errorMessage += ". Nigerian numbers must start with 7, 8, or 9";
//       }
//       if (countryKey == 'SA' || countryKey == 'AE') {
//         errorMessage += ". Number must start with 5";
//       }
//       if (countryKey == 'IN') {
//         errorMessage += ". Indian numbers must start with 6, 7, 8, or 9";
//       }
//       if (countryKey == 'PK') {
//         errorMessage += ". Pakistani numbers must start with 3";
//       }
//       if (countryKey == 'GH') {
//         errorMessage += ". Ghanaian numbers must start with 2";
//       }
//       if (countryKey == 'KE') {
//         errorMessage += ". Kenyan numbers must start with 7";
//       }
//       if (countryKey == 'MY') {
//         errorMessage += ". Malaysian numbers must start with 1";
//       }
//       if (countryKey == 'TH') {
//         errorMessage += ". Thai numbers must start with 8 or 9";
//       }
//       if (countryKey == 'PH') {
//         errorMessage += ". Philippine numbers must start with 9";
//       }
//       if (countryKey == 'TR') {
//         errorMessage += ". Turkish numbers must start with 5";
//       }
//       if (countryKey == 'IR') {
//         errorMessage += ". Iranian numbers must start with 9";
//       }
//       if (countryKey == 'IQ' || countryKey == 'AF') {
//         errorMessage += ". Number must start with 7";
//       }
//       if (countryKey == 'UK') {
//         errorMessage += ". UK numbers must start with 7";
//       }
//       if (countryKey == 'US' || countryKey == 'CA') {
//         errorMessage += ". US/Canada numbers must start with 2-9";
//       }
//       if (countryKey == 'AU') {
//         errorMessage += ". Australian numbers must start with 4";
//       }
//       if (countryKey == 'NZ') {
//         errorMessage += ". New Zealand numbers must start with 2";
//       }
//       if (countryKey == 'DE') {
//         errorMessage += ". German numbers must start with 1";
//       }
//       if (countryKey == 'FR') {
//         errorMessage += ". French numbers must start with 6 or 7";
//       }
//       if (countryKey == 'IT') {
//         errorMessage += ". Italian numbers must start with 3";
//       }
//       if (countryKey == 'ES') {
//         errorMessage += ". Spanish numbers must start with 6 or 7";
//       }
//       if (countryKey == 'BR') {
//         errorMessage += ". Brazilian numbers must start with 9";
//       }
//       if (countryKey == 'MX') {
//         errorMessage += ". Mexican numbers must start with 1";
//       }
//       if (countryKey == 'RU') {
//         errorMessage += ". Russian numbers must start with 9";
//       }
//       if (countryKey == 'CN') {
//         errorMessage += ". Chinese numbers must start with 1";
//       }
//       if (countryKey == 'JP') {
//         errorMessage += ". Japanese numbers must start with 9";
//       }
//       if (countryKey == 'KR') {
//         errorMessage += ". South Korean numbers must start with 1";
//       }
//       if (countryKey == 'SG') {
//         errorMessage += ". Singapore numbers must start with 8 or 9";
//       }
//       EasyLoading.showError(errorMessage);
//       return;
//     }
//     // --- Enhanced validation block ends here ---

//     isLoading.value = true;
//     debugPrint("Loading Started");

//     try {
//       debugPrint("Making API Request to: $url/users/register");
//       debugPrint(
//         "Request Payload: {fullName: $fullName, phoneNumber: $phoneNumber}",
//       );

//       final response = await http.post(
//         Uri.parse("$url/users/register"),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'fullName': fullName,
//           'phoneNumber': phoneNumber,
//           'fcmToken': fcmToken,
//         }),
//       );

//       if (kDebugMode) {
//         print("Status: ${response.statusCode}");
//         print("Body: ${response.body}");
//       }

//       isLoading.value = false;

//       if (response.statusCode == 201) {
//         EasyLoading.showSuccess("registration_successful".tr);
//         final data = jsonDecode(response.body);
//         final otp = data['data']['otp'];
//         debugPrint("Received OTP: $otp");
//         debugPrint("Received Phone: $phoneNumber");

//         Get.toNamed(
//           AppRoutes.otpScreen2,
//           arguments: {'phoneNumber': phoneNumber, 'otp': otp},
//         );
//         nameController.clear();
//         phoneController.clear();
//         passwordController.clear();
//       } else {
//         final body = jsonDecode(response.body);
//         final message = body['message'] ?? "signup_failed".tr;
//         EasyLoading.showError("${"failed".tr}: $message");

//         debugPrint("Registration Failed with Status: ${response.statusCode}");
//       }
//     } catch (e) {
//       isLoading.value = false;
//       debugPrint("Exception Occurred: ${e.toString()}");
//       EasyLoading.showError("error, something_went_wrong".tr);
//     }
//   }

//   Future<void> fetchUserData() async {
//     try {
//       if (authToken == null) {
//         await _loadToken();
//         if (authToken == null) {
//           throw Exception('No authentication token available');
//         }
//       }

//       isLoading.value = true;
//       final response = await http.get(
//         Uri.parse('$url/auth/profile'),
//         headers: {
//           'Authorization': '$authToken',
//           'Content-Type': 'application/json',
//         },
//       );
//       isLoading.value = false;

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);

//         final hasPassword =
//             data['data']?['password']?.toString().isNotEmpty ?? false;

//         if (hasPassword) {
//           Get.offAllNamed(AppRoutes.homeScreen);
//         } else {
//           Get.toNamed(AppRoutes.passwordScreen);
//         }
//       } else if (response.statusCode == 401) {
//         await _clearToken();
//         EasyLoading.showError("session_expired. please_login_again.".tr);
//         Get.offAllNamed(AppRoutes.welcome2);
//       } else {
//         throw Exception(
//           'Failed with status ${response.statusCode}: ${response.body}',
//         );
//       }
//     } catch (e, stack) {
//       isLoading.value = false;
//       debugPrint("Error fetching user data: $e");
//       debugPrint("Stack trace: $stack");

//       final errorMessage = e is FormatException
//           ? 'Invalid server response'
//           : e.toString().replaceAll(RegExp(r'^Exception: '), '');

//       EasyLoading.showError(errorMessage);

//       if (e.toString().contains('JsonWebTokenError') ||
//           e.toString().contains('401')) {
//         await _clearToken();
//         Get.offAllNamed(AppRoutes.welcome2);
//       }
//     }
//   }

//   Future<void> verifyOtpAndNavigate(String enteredOtp) async {
//     EasyLoading.show(status: "loading".tr);

//     try {
//       final args = Get.arguments;
//       final phone = args['phoneNumber'];
//       final originalOtp = args['otp'];

//       if (enteredOtp != originalOtp.toString()) {
//         EasyLoading.showError("invalid_otp".tr);
//         return;
//       }
//       final response = await http.post(
//         Uri.parse("$url/auth/verify-otp"),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"phoneNumber": phone, "otp": int.parse(enteredOtp)}),
//       );

//       debugPrint("✅ Response Body 🧾: ${response.body}");

//       if (response.statusCode == 200) {
//         EasyLoading.showSuccess("otp_verifed".tr);
//         final body = jsonDecode(response.body);
//         final token = body['data']['token'];

//         // Save token to SharedPreferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//         authToken = token;

//         // Immediately fetch user data
//         await fetchUserData();
//       } else {
//         final error = jsonDecode(response.body);
//         EasyLoading.showError(error['message'] ?? "verification failed".tr);
//       }
//     } catch (e) {
//       debugPrint("OTP verification error: $e");
//       EasyLoading.showError('Error: ${e.toString()}');
//     }
//   }

//   Future<void> createPassword() async {
//     final password = passwordController.text.trim();
//     debugPrint('[Password Update] Starting with password: $password');

//     // Validate password
//     if (password.isEmpty) {
//       EasyLoading.showError("password_cannot_be_empty".tr);
//       return;
//     }

//     if (password.length < 8) {
//       EasyLoading.showError("password_must_be_at_least_8_characters_long".tr);
//       return;
//     }

//     // Load token if not available
//     if (authToken == null) {
//       await _loadToken();
//       if (authToken == null) {
//         EasyLoading.showError("session_expired. please_login_again.".tr);
//         Get.offAllNamed(AppRoutes.welcome2);
//         return;
//       }
//     }

//     isLoading.value = true;

//     try {
//       // Create the properly formatted request
//       var request =
//           http.MultipartRequest('PUT', Uri.parse('$url/users/profile'))
//             ..headers['Authorization'] = '$authToken'
//             ..fields['data'] = jsonEncode({'password': password});

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         // var password_set = true;
//         final responseData = jsonDecode(response.body);
//         if (responseData['success'] == true) {
//           showSuccessDialog(
//             message: "your_account_is_succesfully_created!".tr,
//             onTap: () {
//               Get.toNamed(AppRoutes.bottomNavScreen);
//             },
//           );
//         } else {
//           EasyLoading.showError(responseData['message'] ?? "update_failed".tr);
//         }
//         nameController.clear();
//         phoneController.clear();
//         passwordController.clear();
//       } else if (response.statusCode == 400) {
//         final error = jsonDecode(response.body);
//         EasyLoading.showError(error['message'] ?? "invalid_request_format".tr);
//       } else if (response.statusCode == 401) {
//         await _handleTokenExpired();
//       } else {
//         EasyLoading.showError('${"server_error".tr}: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error updating password: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> _handleTokenExpired() async {
//     debugPrint('[Password Update] Token expired or invalid');
//     await _clearToken();
//     EasyLoading.showError("session_expired. please_login_again.".tr);
//   }

//   Future<void> _clearToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     authToken = null;
//   }

//   void togglePasswordVisibility() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }

//   String get formattedTime {
//     int seconds = remainingSeconds.value;
//     return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
//   }

//   //===============================Resend OTP===============================
//   Future<void> resendOTP() async {
//     try {
//       final url = Urls.resendOtp;
//       debugPrint("DEBUG: Resend OTP URL: $url");

//       EasyLoading.show(status: "loading".tr);

//       final formattedNumber = registeredPhoneNumber.value;

//       debugPrint("DEBUG: Final formatted number to send: $formattedNumber");

//       final body = json.encode({"phoneNumber": formattedNumber});
//       log("Sending Resend OTP verification for number: $formattedNumber}");

//       final response = await http.post(
//         Uri.parse(url),
//         body: body,
//         headers: {"Content-Type": "application/json"},
//       );

//       log('Request URL: $url');
//       log('Status code: ${response.statusCode}');
//       log('Input Data (JSON): ${response.body}');

//       if (response.statusCode == 200) {
//         EasyLoading.showSuccess("resend_otp_verification_is_successful.".tr);
//         startTimer();
//       } else {
//         var responseData = jsonDecode(response.body);
//         EasyLoading.showError(
//           responseData["message"] ?? "failed_to_resend_otp_verification.".tr,
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
//   }

//   void startTimer() {
//     // Cancel any existing timer
//     _timer?.cancel();
//     remainingSeconds.value = 120; // Reset to 30 seconds

//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (remainingSeconds.value > 0) {
//         remainingSeconds.value--;
//       } else {
//         timer.cancel();
//         update(); // Force UI update when timer completes
//       }
//     });
//   }

//   @override
//   void onInit() {
//     startTimer();
//     _loadToken();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     emailController.dispose();
//     _timer?.cancel();
//     super.onClose();
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
