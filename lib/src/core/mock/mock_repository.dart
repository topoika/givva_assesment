// ───────────────────────────────────────────
// mock/mock_repository.dart
// ───────────────────────────────────────────

import 'mock_data.dart';

Future<Map<String, dynamic>> fetchFundraisers({
  required String tab, // 'community' | 'subgroup' | 'archived'
  required int page, // 0-based
}) async {
  await Future.delayed(const Duration(milliseconds: 800));
  final data = {
    'community': [mockCommunityPage1, mockCommunityPage2],
    'subgroup': [mockSubgroupPage1, mockSubgroupPage2],
    'archived': [mockArchivedPage1, mockArchivedPage2],
  };

  final pagination = {
    'community': [mockCommunityPaginationPage1, mockCommunityPaginationPage2],
    'subgroup': [mockSubgroupPaginationPage1, mockSubgroupPaginationPage2],
    'archived': [mockArchivedPaginationPage1, mockArchivedPaginationPage2],
  };

  return {
    "status": 200,
    "message": "ok",
    "result": {
      "data": data[tab]![page],
      "pagination": pagination[tab]![page],
      "sorting": null,
    },
  };
}
