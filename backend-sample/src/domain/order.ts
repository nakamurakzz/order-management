type OrderParams = { id?: number, order: { [key: number]: number; }[], orderStatusTypeId: number; };

// orderStatus
const ORDER_STATUS_TYPE_ID = {
  inProgress: 1,
  completed: 2,
  canceled: 3
};

export class OrderEntity {
  id?: number;
  order: { [key: number]: number; }[];
  orderStatusTypeId: number;

  constructor(params: OrderParams) {
    this.checkOrderStatusTypeId(params);
    this.id = params.id;
    this.order = params.order;
    this.orderStatusTypeId = params.orderStatusTypeId;
  }

  /**
   * orderStatusTypeId must be 1, 2, 3
   */
  private checkOrderStatusTypeId(params: OrderParams) {
    if (params.orderStatusTypeId < ORDER_STATUS_TYPE_ID.inProgress || params.orderStatusTypeId > ORDER_STATUS_TYPE_ID.canceled) {
      throw new Error("orderStatusTypeId must be 1, 2 or 3");
    }
  }

  static create(params: Omit<OrderParams, "id" | "orderStatusTypeId">, itemIds: number[]) {
    if (params.order.map(o => Object.keys(o)).filter((key) => !itemIds.includes(Number(key))).length > 0) {
      throw new Error("order must be itemIds");
    };
    return new OrderEntity({
      id: undefined,
      order: params.order,
      orderStatusTypeId: ORDER_STATUS_TYPE_ID.inProgress,
    });
  }
}

export const orderFactory = (params: OrderParams) => {
  return new OrderEntity(params);
};