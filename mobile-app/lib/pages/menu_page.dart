import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:order_management/providers/api_provider.dart';

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
              title: const Text('Tabs Demo'),
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
                            .where((item) => item.itemTypeId == 1)
                            .map((drink) {
                          return ListTile(
                            leading: const Icon(Icons.free_breakfast),
                            title: Row(children: [
                              Text(drink.title),
                              const Spacer(),
                              incrementButton(drink.id, orderCountorController,
                                  orderCountor),
                            ]),
                            subtitle: Text("${drink.price.toString()}円 "),
                          );
                        }).toList(),
                      ),
                      ListView(
                        restorationId: 'list_demo_list_view',
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: items
                            .where((item) => item.itemTypeId == 2)
                            .map((food) {
                          return ListTile(
                            leading: const Icon(Icons.free_breakfast),
                            title: Row(children: [
                              Text(food.title),
                              const Spacer(),
                              incrementButton(food.id, orderCountorController,
                                  orderCountor),
                            ]),
                            subtitle: Text("${food.price.toString()}円 "),
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
                        Navigator.pop(context);
                      },
                      child: const Text('戻る'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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

// TODO: APIから取得するデータとしたい
enum DrinkMenu {
  coffee(1, "うまいコーヒー", "うまくてオススメ", 380),
  tea(2, "おいしいお茶", "おいしい", 280),
  juice(3, "おいしいジュース", "オレンジ100%", 180),
  water(4, "おいしい水", "天然水", 0),
  water2(5, "おいしい水", "天然水", 0),
  water3(6, "おいしい水", "天然水", 0),
  water4(7, "おいしい水", "天然水", 0),
  water5(8, "おいしい水", "天然水", 0),
  water6(9, "おいしい水", "天然水", 0),
  water7(10, "おいしい水", "天然水", 0),
  water8(11, "おいしい水", "天然水", 0),
  water9(12, "おいしい水", "天然水", 0);

  const DrinkMenu(this.id, this.title, this.subTitle, this.price);

  final int id;
  final String title;
  final String subTitle;
  final int price;
}

enum FoodMenu {
  curry(1001, "うまいカレー", "うまくてオススメ", 380),
  rice(1002, "おいしいご飯", "おいしい", 280),
  noodle(1003, "おいしい麺", "自家製麺使用", 180);

  const FoodMenu(this.id, this.title, this.subTitle, this.price);

  final int id;
  final String title;
  final String subTitle;
  final int price;
}
