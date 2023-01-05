import { Repository } from "typeorm";
import { Item } from "../entity/Item";
import { AppDataSource } from "../../data-source";
import { ItemEntity, itemFactory } from "../../domain/item";
export interface ItemRepository {
  getItems(): Promise<ItemEntity[]>;
  getItemIds(): Promise<number[]>;
  create(item: ItemEntity): Promise<ItemEntity>;
}

export class ItemRepositoryImpl implements ItemRepository {
  itemRepository: Repository<Item>;
  constructor() {
    this.itemRepository = AppDataSource.getRepository(Item);
  }
  async getItems(): Promise<ItemEntity[]> {
    const items = await this.itemRepository.find();
    return items.map(item => itemFactory(item));
  }

  async getItemIds(): Promise<number[]> {
    const items = await this.itemRepository.find(
      {
        select: {
          id: true,
        }
      },
    );
    return items.map(item => item.id);
  }


  async create(item: ItemEntity): Promise<ItemEntity> {
    const createdItem = await this.itemRepository.save(item);
    return itemFactory(createdItem);
  };
}