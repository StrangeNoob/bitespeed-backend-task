/*
  Warnings:

  - You are about to drop the `Link` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[linkedId]` on the table `Contact` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `linkPrecedence` to the `Contact` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Contact` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "LinkPrecedence" AS ENUM ('secondary', 'primary');

-- DropForeignKey
ALTER TABLE "Link" DROP CONSTRAINT "Link_primaryContactId_fkey";

-- DropForeignKey
ALTER TABLE "Link" DROP CONSTRAINT "Link_secondaryContactId_fkey";

-- DropIndex
DROP INDEX "Contact_email_key";

-- DropIndex
DROP INDEX "Contact_phoneNumber_key";

-- AlterTable
ALTER TABLE "Contact" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "linkPrecedence" "LinkPrecedence" NOT NULL,
ADD COLUMN     "linkedId" INTEGER,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- DropTable
DROP TABLE "Link";

-- CreateIndex
CREATE UNIQUE INDEX "Contact_linkedId_key" ON "Contact"("linkedId");
