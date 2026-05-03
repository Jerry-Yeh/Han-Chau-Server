/*
  Warnings:

  - You are about to drop the column `end` on the `Exercise` table. All the data in the column will be lost.
  - You are about to drop the column `muscles` on the `Exercise` table. All the data in the column will be lost.
  - You are about to drop the column `start` on the `Exercise` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `Exercise` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Exercise" DROP COLUMN "end",
DROP COLUMN "muscles",
DROP COLUMN "start",
DROP COLUMN "url",
ADD COLUMN     "video" JSONB;

-- CreateTable
CREATE TABLE "Muscle" (
    "id" INTEGER NOT NULL,

    CONSTRAINT "Muscle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExerciseMuscle" (
    "exerciseId" INTEGER NOT NULL,
    "muscleId" INTEGER NOT NULL,

    CONSTRAINT "ExerciseMuscle_pkey" PRIMARY KEY ("exerciseId","muscleId")
);

-- AddForeignKey
ALTER TABLE "ExerciseMuscle" ADD CONSTRAINT "ExerciseMuscle_exerciseId_fkey" FOREIGN KEY ("exerciseId") REFERENCES "Exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExerciseMuscle" ADD CONSTRAINT "ExerciseMuscle_muscleId_fkey" FOREIGN KEY ("muscleId") REFERENCES "Muscle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
