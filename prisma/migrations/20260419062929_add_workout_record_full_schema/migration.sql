/*
  Warnings:

  - You are about to drop the `Record` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Record" DROP CONSTRAINT "Record_userId_fkey";

-- DropTable
DROP TABLE "Record";

-- CreateTable
CREATE TABLE "WorkoutRecord" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "planId" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "time" TEXT NOT NULL,

    CONSTRAINT "WorkoutRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkoutRecordExercise" (
    "id" TEXT NOT NULL,
    "exerciseId" INTEGER NOT NULL,
    "workoutRecordId" TEXT NOT NULL,

    CONSTRAINT "WorkoutRecordExercise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkoutRecordExerciseSet" (
    "id" TEXT NOT NULL,
    "reps" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "workoutRecordExerciseId" TEXT NOT NULL,

    CONSTRAINT "WorkoutRecordExerciseSet_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "WorkoutRecord" ADD CONSTRAINT "WorkoutRecord_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutRecordExercise" ADD CONSTRAINT "WorkoutRecordExercise_workoutRecordId_fkey" FOREIGN KEY ("workoutRecordId") REFERENCES "WorkoutRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutRecordExerciseSet" ADD CONSTRAINT "WorkoutRecordExerciseSet_workoutRecordExerciseId_fkey" FOREIGN KEY ("workoutRecordExerciseId") REFERENCES "WorkoutRecordExercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
