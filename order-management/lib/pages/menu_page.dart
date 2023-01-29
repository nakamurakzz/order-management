import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:order_management/models/item.dart';
import 'package:order_management/providers/api_provider.dart';
import '../apis/api_client.dart';
import '../providers/order_provider.dart';

class MenuPage extends HookConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderCountorController =
        ref.read(orderCounterNotifierProvider.notifier);
    final orderCountor = ref.watch(orderCounterNotifierProvider);
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.free_breakfast)),
                  Tab(icon: Icon(Icons.cake)),
                ],
              ),
              title: const Text('Drink & Cake Menu'),
            ),
            body: ref.watch(itemsProvider).when(
                loading: () => const Center(child: Text('Loading...')),
                error: (error, stack) => Text(error.toString()),
                data: (items) {
                  return TabBarView(
                    children: [
                      // Icon(Icons.directions_transit),
                      ListView(
                        restorationId: 'list_demo_list_view',
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: items
                            .where((item) =>
                                item.itemTypeId.value ==
                                ItemTypeIdEnum.drink.value)
                            .map((drink) {
                          return ListTile(
                            leading: const Icon(Icons.free_breakfast_rounded),
                            title: Row(children: [
                              Text(drink.title.value),
                              const Spacer(),
                              incrementButton(drink.id, orderCountorController,
                                  orderCountor),
                            ]),
                            subtitle: Text("${drink.price.value.toString()}円 "),
                          );
                        }).toList(),
                      ),
                      ListView(
                        restorationId: 'list_demo_list_view',
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: items
                            .where((item) =>
                                item.itemTypeId.value ==
                                ItemTypeIdEnum.cake.value)
                            .map((food) {
                          return ListTile(
                            leading: const Icon(Icons.cake_rounded),
                            title: Row(children: [
                              Text(food.title.value),
                              const Spacer(),
                              incrementButton(food.id, orderCountorController,
                                  orderCountor),
                            ]),
                            subtitle: Text("${food.price.value.toString()}円 "),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        orderCountorController.clear();
                      },
                      child: const Text('リセット'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        if (orderCountor.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('メニューから選択してください。'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        final result =
                            await apiClient.postOrder(order: orderCountor);
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('注文しました。'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          orderCountorController.clear();
                          Navigator.pop(context);
                          return;
                        }
                        // エラー処理
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('注文に失敗しました。店員をお呼びください。'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text('注文'),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

Widget incrementButton(
  int drinkId,
  OrderCounterNotifier orderCountorController,
  Map<int, int> orderCountor,
) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          orderCountorController.increment(drinkId);
        },
      ),
      Text((orderCountor[drinkId] ?? 0).toString()),
      IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          orderCountorController.decrement(drinkId);
        },
      ),
    ],
  );
}
