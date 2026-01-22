class CreatePasswordResponse {
  final bool success;
  final String message;
  final UserData data;

  CreatePasswordResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreatePasswordResponse.fromJson(Map<String, dynamic> json) {
    return CreatePasswordResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String fullName;
  final String? profileImage;
  final String phoneNumber;

  UserData({
    required this.id,
    required this.fullName,
    this.profileImage,
    required this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      fullName: json['fullName'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class CreatePasswordRequest {
  final String password;

  CreatePasswordRequest({required this.password});

  Map<String, dynamic> toJson() => {'password': password};
}
