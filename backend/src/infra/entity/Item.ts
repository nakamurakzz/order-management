import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Item {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column()
    title!: string;

    @Column()
    subTitle!: string;

    @Column()
    price!: number;

    @Column()
    itemTypeId!: number;
}
