class SignupRequest {
  final String phoneNumber;
  final String fullName;

  SignupRequest({required this.phoneNumber, required this.fullName});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'fullName': fullName};
  }
}

class SignupResponse {
  final bool success;
  final String message;
  final SignupUser data;

  SignupResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'],
      message: json['message'],
      data: SignupUser.fromJson(json['data']),
    );
  }
}

class SignupUser {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? profileImage;
  final String role;
  final String status;
  final int otp;
  final DateTime createdAt;
  final DateTime updatedAt;

  SignupUser({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.profileImage,
    required this.role,
    required this.status,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      role: json['role'],
      status: json['status'],
      otp: json['otp'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
