import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifierのサブクラス
class OrderCounterNotifier extends StateNotifier<Map<int, int>> {
  OrderCounterNotifier(this.ref) : super({});
  final Ref ref;

  void increment(int id) {
    if (state.containsKey(id)) {
      state = {...state, id: state[id]! + 1};
    } else {
      state = {...state, id: 1};
    }
  }

  void decrement(int id) {
    if (state.containsKey(id) && state[id]! > 0) {
      state = {...state, id: state[id]! - 1};
    }
  }
}

final orderCounterNotifierProvider =
    StateNotifierProvider<OrderCounterNotifier, Map<int, int>>(
  // サブクラスのStateNotifierにrefを渡すことも出来る
  (ref) => OrderCounterNotifier(ref),
);
