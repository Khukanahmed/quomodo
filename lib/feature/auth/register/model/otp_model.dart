class OtpVerificationResponse {
  final bool success;
  final String message;
  final OtpData? data;

  OtpVerificationResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }
}

class OtpData {
  final String message;
  final String token;

  OtpData({required this.message, required this.token});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(message: json['message'], token: json['token']);
  }
}

class OtpRequest {
  final String phoneNumber;
  final int otp;

  OtpRequest({required this.phoneNumber, required this.otp});

  Map<String, dynamic> toJson() => {'phoneNumber': phoneNumber, 'otp': otp};
}
