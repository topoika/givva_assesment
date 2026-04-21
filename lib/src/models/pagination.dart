class Pagination {
  int page;
  int size;
  int totalCount;
  int totalPages;
  bool hasNext;
  bool hasPrevious;

  Pagination({
    required this.page,
    required this.size,
    required this.totalCount,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      page: map['page'] as int,
      size: map['size'] as int,
      totalCount: map['totalCount'] as int,
      totalPages: map['totalPages'] as int,
      hasNext: map['hasNext'] as bool,
      hasPrevious: map['hasPrevious'] as bool,
    );
  }
}
