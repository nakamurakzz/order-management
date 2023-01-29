// Itemモデル
class Item {
  final int id;
  final ItemTitle title; // 値オブジェクト
  final ItemSubTitle subtitle;
  final ItemPrice price;
  final ItemTypeId itemTypeId;
  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.itemTypeId,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: ItemTitle(value: json['title']),
      subtitle: ItemSubTitle(value: json['subTitle']),
      price: ItemPrice(value: json['price']),
      itemTypeId: ItemTypeId(value: json['itemTypeId']),
    );
  }
}

// 以下、値オブジェクト
class ItemTitle {
  final String value;
  ItemTitle({required this.value}) {
    // titleは32文字以下
    if (value.length > 32) {
      throw Exception('ItemTitleのvalueが32文字を超えています');
    }
  }
}

class ItemPrice {
  final int value;
  ItemPrice({required this.value}) {
    // priceは0以上
    if (value < 0) {
      throw Exception('ItemPriceのvalueが0未満です');
    }
  }
}

class ItemSubTitle {
  final String value;
  ItemSubTitle({required this.value}) {
    // subtitleは64文字以下
    if (value.length > 64) {
      throw Exception('ItemSubTitleのvalueが64文字を超えています');
    }
  }
}

class ItemTypeId {
  final int value;
  ItemTypeId({required this.value}) {
    // valueはItemTypeIdEnumの値のみ
    if (value != ItemTypeIdEnum.drink.value &&
        value != ItemTypeIdEnum.cake.value) {
      throw Exception('ItemTypeIdのvalueが不正です');
    }
  }
}

// ItemTypeIdのEnum
enum ItemTypeIdEnum {
  drink(1),
  cake(2);

  const ItemTypeIdEnum(this.value);
  final int value;
}
