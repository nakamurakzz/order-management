import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hooks/use_drink_menu.dart';
import '../providers/order_provider.dart';

class MenuPage extends HookConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    final drinkMenu = useDrinkMenu();
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
          body: TabBarView(
            children: [
              // Icon(Icons.directions_transit),
              ListView(
                restorationId: 'list_demo_list_view',
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: DrinkMenu.values.map((drink) {
                  return ListTile(
                    leading: const Icon(Icons.free_breakfast),
                    title: Row(children: [
                      Text(drink.title),
                      Spacer(),
                      incrementButton(drink.drinkId, drinkMenu),
                    ]),
                    subtitle: Text("${drink.price.toString()}円 "),
                  );
                }).toList(),
              ),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

Widget incrementButton(int drinkId, DrinkOrderList drinkMenu) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          drinkMenu.addOrder(drinkId);
        },
      ),
      Text(drinkMenu.drinkMenu.toString()),
      IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          drinkMenu.removeOrder(drinkId);
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
  water(4, "おいしい水", "天然水", 0);

  const DrinkMenu(this.drinkId, this.title, this.subTitle, this.price);

  final int drinkId;
  final String title;
  final String subTitle;
  final int price;
}
