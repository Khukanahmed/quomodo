class GetUserModel {
  final String id;
  final String? password;
  final String? fullName;
  final int? point;
  final int? purchaseCount;
  final String? profileImage;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetUserModel({
    required this.id,
    this.password,
    this.fullName,
    this.point,
    this.purchaseCount,
    this.profileImage,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      id: json['id'],
      password: json['password'],
      fullName: json['fullName'],
      point: json['point'],
      purchaseCount: json['purchaseCount'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
