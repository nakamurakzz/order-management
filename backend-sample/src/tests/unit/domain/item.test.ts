import { ItemEntity, itemFactory } from "../../../domain/item";

describe("Item", () => {
  test("should be able to create an item", () => {
    const item = itemFactory({
      id: 1,
      title: "title",
      subTitle: "subTitle",
      price: 100,
      itemTypeId: 1,
    });
    expect(item.id).toBe(1);
  });

  test("should throw an error when itemTypeId is not 1, 2 or 3", () => {
    expect(() => {
      itemFactory({
        id: 1,
        title: "title",
        subTitle: "subTitle",
        price: 100,
        itemTypeId: 4,
      });
    }).toThrow("itemTypeId must be 1, 2 or 3");
  });

  test("should create an item", () => {
    const item = ItemEntity.create({
      title: "title",
      subTitle: "subTitle",
      price: 100,
      itemTypeId: 1,
    });
    expect(item.id).toBeUndefined();
  });
});