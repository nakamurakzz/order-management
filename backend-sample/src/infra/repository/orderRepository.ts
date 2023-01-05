import { Repository } from "typeorm";
import { Order } from "../entity/Order";
import { AppDataSource } from "../../data-source";
import { OrderEntity, orderFactory } from "../../domain/order";
export interface OrderRepository {
  getOrders(): Promise<OrderEntity[]>;
  create(order: OrderEntity): Promise<OrderEntity>;
}

export class OrderRepositoryImpl implements OrderRepository {
  orderRepository: Repository<Order>;
  constructor() {
    this.orderRepository = AppDataSource.getRepository(Order);
  }
  async getOrders(): Promise<OrderEntity[]> {
    const orders = await this.orderRepository.find();
    return orders.map(order => orderFactory(order));
  }

  async create(order: OrderEntity): Promise<OrderEntity> {
    const createdOrder = await this.orderRepository.save(order);
    return orderFactory(createdOrder);
  }
}