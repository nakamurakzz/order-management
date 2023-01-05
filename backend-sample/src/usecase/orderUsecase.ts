import { OrderEntity } from "../domain/order";
import { ItemRepository, ItemRepositoryImpl } from "../infra/repository/itemRepository";
import { OrderRepository, OrderRepositoryImpl } from "../infra/repository/orderRepository";
import { OrderCreateParams } from "../presentation/type/order";

export class OrderUsecase {
  orderRepository: OrderRepository;
  itemRepository: ItemRepository;

  constructor() {
    this.orderRepository = new OrderRepositoryImpl();
    this.itemRepository = new ItemRepositoryImpl();
  }

  async findOrders() {
    return await this.orderRepository.getOrders();
  }

  async create(orderCreateParams: OrderCreateParams) {
    const items = await this.itemRepository.getItemIds();
    const order = OrderEntity.create(orderCreateParams, items);
    return await this.orderRepository.create(order);
  }
}