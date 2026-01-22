class ProfileUpdateResponse {
  final bool success;
  final String message;
  final ProfileData data;

  ProfileUpdateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      success: json['success'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
  final String id;
  final String fullName;
  final String? profileImage;
  final String phoneNumber;

  ProfileData({
    required this.id,
    required this.fullName,
    this.profileImage,
    required this.phoneNumber,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      fullName: json['fullName'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
