/*
  Warnings:

  - The primary key for the `bookings` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `memberships` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `notifications` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `transaction_details` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `transactions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The values [success] on the enum `transactions_status` will be removed. If these variants are still used in the database, this will fail.

*/
-- DropForeignKey
ALTER TABLE `transaction_details` DROP FOREIGN KEY `transaction_details_transaction_id_fkey`;

-- AlterTable
ALTER TABLE `bookings` DROP PRIMARY KEY,
    MODIFY `booking_id` VARCHAR(12) NOT NULL,
    MODIFY `status` ENUM('booked', 'pending', 'cancelled', 'completed') NOT NULL,
    MODIFY `booking_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD PRIMARY KEY (`booking_id`);

-- AlterTable
ALTER TABLE `memberships` DROP PRIMARY KEY,
    MODIFY `membership_id` VARCHAR(12) NOT NULL,
    ADD PRIMARY KEY (`membership_id`);

-- AlterTable
ALTER TABLE `notifications` DROP PRIMARY KEY,
    MODIFY `notification_id` VARCHAR(8) NOT NULL,
    MODIFY `notification_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD PRIMARY KEY (`notification_id`);

-- AlterTable
ALTER TABLE `transaction_details` DROP PRIMARY KEY,
    MODIFY `transaction_detail_id` VARCHAR(7) NOT NULL,
    MODIFY `transaction_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`transaction_detail_id`);

-- AlterTable
ALTER TABLE `transactions` DROP PRIMARY KEY,
    MODIFY `transaction_id` VARCHAR(12) NOT NULL,
    MODIFY `status` ENUM('paid', 'pending', 'failed') NOT NULL,
    ADD PRIMARY KEY (`transaction_id`);

-- CreateTable
CREATE TABLE `Help` (
    `help_id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(60) NOT NULL,
    `message` VARCHAR(225) NOT NULL,

    PRIMARY KEY (`help_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transaction_details` ADD CONSTRAINT `transaction_details_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `transactions`(`transaction_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
