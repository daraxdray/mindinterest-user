import 'package:equatable/equatable.dart';

class TmiUser extends Equatable {
  TmiUser({
    this.id,
    this.name,
    this.phone,
    this.gender,
    this.ageRange,
    this.referer,
    this.needToTalk,
    this.relationshipStatus,
    this.relationshipDuration,
    this.parentalStatus,
    this.profileImg,
    this.updatedAt,
    this.createdAt,
  });

  TmiUser.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
    phone = json['phone']?.toString();
    gender = json['gender']?.toString();
    ageRange = json['age_range']?.toString();
    referer = json['referer']?.toString();
    needToTalk = json['need_to_talk']?.toString();
    relationshipStatus = json['relationship_status']?.toString();
    relationshipDuration = json['relationship_duration']?.toString();
    parentalStatus = json['parental_status']?.toString();
    profileImg = json['profile_img']?.toString();
    updatedAt = DateTime.tryParse(json['updatedAt'].toString());
    createdAt = DateTime.tryParse(json['createdAt'].toString());
  }

  TmiUser copyWith({
    int? id,
    String? name,
    String? phone,
    String? gender,
    String? ageRange,
    String? referer,
    String? needToTalk,
    String? relationshipStatus,
    String? relationshipDuration,
    String? parentalStatus,
    String? profileImg,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) =>
      TmiUser(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        ageRange: ageRange ?? this.ageRange,
        referer: referer ?? this.referer,
        needToTalk: needToTalk ?? this.needToTalk,
        relationshipStatus: relationshipStatus ?? this.relationshipStatus,
        relationshipDuration: relationshipDuration ?? this.relationshipDuration,
        parentalStatus: parentalStatus ?? this.parentalStatus,
        profileImg: profileImg ?? this.profileImg,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  late final int? id;
  late final String? name;
  late final String? phone;
  late final String? gender;
  late final String? ageRange;
  late final String? referer;
  late final String? needToTalk;
  late final String? relationshipStatus;
  late final String? relationshipDuration;
  late final String? parentalStatus;
  late final String? profileImg;
  late final DateTime? updatedAt;
  late final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['age_range'] = ageRange;
    data['referer'] = referer;
    data['need_to_talk'] = needToTalk;
    data['relationship_status'] = relationshipStatus;
    data['relationship_duration'] = relationshipDuration;
    data['parental_status'] = parentalStatus;
    data['profile_img'] = profileImg;
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['createdAt'] = createdAt?.toIso8601String();
    return data;
  }

  @override
  List<Object> get props => [name!, id!, phone!, gender!, ageRange!];
}
