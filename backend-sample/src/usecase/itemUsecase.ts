import { ItemRepository, ItemRepositoryImpl } from "../infra/repository/itemRepository";

export class ItemUsecase {
  itemRepository: ItemRepository;
  constructor() {
    this.itemRepository = new ItemRepositoryImpl();
  }

  async findItems() {
    return await this.itemRepository.getItems();
  }
}