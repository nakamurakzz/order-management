import { orderFactory, OrderEntity } from "../../../domain/order";

describe("Order", () => {
  test("should be able to create an order", () => {
    const order = orderFactory({
      id: 1,
      order: [{ 1: 1 }],
      orderStatusTypeId: 1,
    });
    expect(order.id).toBe(1);
  });

  test("should throw an error when orderStatusTypeId is not 1, 2 or 3", () => {
    expect(() => {
      orderFactory({
        id: 1,
        order: [{ 1: 1 }],
        orderStatusTypeId: 4,
      });
    }).toThrow("orderStatusTypeId must be 1, 2 or 3");
  });

  test("should throw an error when order is not itemIds", () => {
    expect(() => {
      OrderEntity.create({
        order: [{ 4: 1 }, { 2: 1 }],
      }, [1, 2, 3]);
    }).toThrow("order must be itemIds");
  });

  test("should create an order", () => {
    const order = OrderEntity.create({
      order: [{ 1: 1 }, { 2: 1 }],
    }, [1, 2, 3]);
    expect(order.id).toBeUndefined();
  });
});