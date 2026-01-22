class OtpVerificationResponse {
  final String token;
  final String? message;

  OtpVerificationResponse({required this.token, this.message});

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      token: json['data']['token'],
      message: json['message'],
    );
  }
}
