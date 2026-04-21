import '../../core/mock/mock_repository.dart';
import '../../models/fundraiser.dart';

class FundraiserRepo {
  Future<FundraiserData> getFundraisers({
    required String tab,
    required int page,
  }) async {
    try {
      final response = await fetchFundraisers(tab: tab, page: page);
      final status = response['status'] as int?;
      if (status != 200) {
        throw Exception(response['message']?.toString());
      }
      final result = response['result'] as Map<String, dynamic>?;
      if (result == null) {
        throw Exception('Invalid response: missing result');
      }
      final rawData = result['data'] as List<dynamic>?;
      final rawPagination = result['pagination'] as Map<String, dynamic>?;
      if (rawData == null || rawPagination == null) {
        throw Exception('Invalid response: missing data or pagination');
      }
      final normalizedItems = rawData
          .map((item) => item as Map<String, dynamic>)
          .toList();
      return FundraiserData.fromMap(normalizedItems, rawPagination);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
