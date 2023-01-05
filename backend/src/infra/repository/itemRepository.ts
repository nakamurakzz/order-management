import { Repository } from "typeorm";
import { Item } from "../entity/Item";
import { AppDataSource } from "../../data-source";
import { itemFactory } from "../../domain/item";
export interface ItemRepository {
  getItems(): Promise<Item[]>;
}

export class ItemRepositoryImpl implements ItemRepository {
  itemRepository: Repository<Item>;
  constructor() {
    this.itemRepository = AppDataSource.getRepository(Item);
  }
  async getItems(): Promise<Item[]> {
    const items = await this.itemRepository.find();
    return items.map(item => itemFactory(item));
  }
}