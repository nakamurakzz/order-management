import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Order {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column("json")
    order!: { [key: number]: number; }[];

    @Column({ default: 1 })
    orderStatusTypeId!: number;
}
