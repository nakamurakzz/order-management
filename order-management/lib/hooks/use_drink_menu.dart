import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

DrinkOrderList useDrinkMenu() {
  final drinkMenu = useState<Map<int, int>>({});

  void addOrder(int drinkId) {
    if (drinkMenu.value.containsKey(drinkId)) {
      drinkMenu.value[drinkId] = drinkMenu.value[drinkId]! + 1;
    } else {
      drinkMenu.value[drinkId] = 1;
    }
  }

  void removeOrder(int drinkId) {
    if (drinkMenu.value.containsKey(drinkId)) {
      drinkMenu.value[drinkId] = drinkMenu.value[drinkId]! - 1;
    }
  }

  return DrinkOrderList(
      drinkMenu: drinkMenu.value, addOrder: addOrder, removeOrder: removeOrder);
}

class DrinkOrderList {
  DrinkOrderList(
      {required this.drinkMenu,
      required this.addOrder,
      required this.removeOrder});
  final Map<int, int> drinkMenu;

  final void Function(int drinkId) addOrder;
  final void Function(int drinkId) removeOrder;
}
