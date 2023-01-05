type ItemParams = { id: number, title: string, subTitle: string, price: number, itemTypeId: number; };

class ItemEntity {
  id: number;
  title: string;
  subTitle: string;
  price: number;
  itemTypeId: number;

  constructor(params: ItemParams) {
    this.checkItemTypeId(params);
    this.id = params.id;
    this.title = params.title;
    this.subTitle = params.subTitle;
    this.price = params.price;
    this.itemTypeId = params.itemTypeId;
  }

  /**
   * itemTypeId must be 1, 2, 3
   */
  private checkItemTypeId(params: ItemParams) {
    if (params.itemTypeId < 1 || params.itemTypeId > 3) {
      throw new Error("itemTypeId must be 1, 2 or 3");
    }
  }
}

export const itemFactory = (params: ItemParams) => {
  return new ItemEntity(params);
};