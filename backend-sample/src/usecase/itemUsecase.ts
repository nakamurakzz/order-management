import { ItemEntity } from "../domain/item";
import { ItemRepository, ItemRepositoryImpl } from "../infra/repository/itemRepository";
import { ItemCreateParams } from "../presentation/type/item";

export class ItemUsecase {
  itemRepository: ItemRepository;
  constructor() {
    this.itemRepository = new ItemRepositoryImpl();
  }

  async findItems() {
    return await this.itemRepository.getItems();
  }

  async create(itemCreateParams: ItemCreateParams) {
    const item = ItemEntity.create(itemCreateParams);
    return await this.itemRepository.create(item);
  }
}