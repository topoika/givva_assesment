import 'pagination.dart';

class Fundraiser {
  String? id;
  String? fundraiserTypeName;
  String? name;
  String? identifier;
  String? shortDescription;
  String? images;
  double? targetAmount;
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? closedAt;
  DateTime? archivedAt;
  String? keyword;
  String? groupId;
  String? groupName;
  Fundraiser({
    this.id,
    this.fundraiserTypeName,
    this.name,
    this.identifier,
    this.shortDescription,
    this.images,
    this.targetAmount,
    this.deadline,
    this.createdAt,
    this.closedAt,
    this.archivedAt,
    this.keyword,
    this.groupId,
    this.groupName,
  });

  factory Fundraiser.fromMap(Map<String, dynamic> map) {
    return Fundraiser(
      id: map['id'] != null ? map['id'] as String : null,
      fundraiserTypeName: map['fundraiserTypeName'] != null
          ? map['fundraiserTypeName'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      identifier: map['identifier'] != null
          ? map['identifier'] as String
          : null,
      shortDescription: map['shortDescription'] != null
          ? map['shortDescription'] as String
          : null,
      images: map['images'] != null ? map['images'] as String : null,
      targetAmount: map['targetAmount'] != null
          ? map['targetAmount'] as double
          : null,
      deadline: map['deadline'] != null
          ? DateTime.parse(map['deadline'] as String)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      closedAt: map['closedAt'] != null
          ? DateTime.parse(map['closedAt'] as String)
          : null,
      archivedAt: map['archivedAt'] != null
          ? DateTime.parse(map['archivedAt'] as String)
          : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      groupId: map['groupId'] != null ? map['groupId'] as String : null,
      groupName: map['groupName'] != null ? map['groupName'] as String : null,
    );
  }
}

class FundraiserData {
  List<Fundraiser> items;
  Pagination pagination;

  FundraiserData({required this.items, required this.pagination});

  factory FundraiserData.fromMap(
    List<Map<String, dynamic>> listData,
    Map<String, dynamic> paginationData,
  ) {
    return FundraiserData(
      items: listData.map((item) => Fundraiser.fromMap(item)).toList(),
      pagination: Pagination.fromMap(paginationData),
    );
  }
}
