import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../apis/api_client.dart';

final apiClientProvider = Provider((_) => apiClient);

final itemsProvider = FutureProvider<List<Item>>((ref) async {
  final apiClient = ref.watch(apiClientProvider);
  final items = await apiClient.getItems();
  return items;
});
