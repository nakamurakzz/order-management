// api_client.dartのテスト

import 'package:flutter_test/flutter_test.dart';
import 'package:order_management/apis/api_client.dart';

void main() {
  test('ApiClient', () async {
    final apiClient = ApiClient();
    final items = await apiClient.getItems();
    print(items.toString());
    expect(items.length, 3);
  });
}
