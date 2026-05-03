/*
  Warnings:

  - You are about to drop the `Exercise` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ExerciseMuscle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Muscle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutPlanTemplate` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutPlanTemplateExercise` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutRecord` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutRecordExercise` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WorkoutRecordExerciseSet` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ExerciseMuscle" DROP CONSTRAINT "ExerciseMuscle_exerciseId_fkey";

-- DropForeignKey
ALTER TABLE "ExerciseMuscle" DROP CONSTRAINT "ExerciseMuscle_muscleId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutPlanTemplate" DROP CONSTRAINT "WorkoutPlanTemplate_userId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutPlanTemplateExercise" DROP CONSTRAINT "WorkoutPlanTemplateExercise_exerciseId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutPlanTemplateExercise" DROP CONSTRAINT "WorkoutPlanTemplateExercise_workoutPlanTemplateId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutRecord" DROP CONSTRAINT "WorkoutRecord_planId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutRecord" DROP CONSTRAINT "WorkoutRecord_userId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutRecordExercise" DROP CONSTRAINT "WorkoutRecordExercise_exerciseId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutRecordExercise" DROP CONSTRAINT "WorkoutRecordExercise_workoutRecordId_fkey";

-- DropForeignKey
ALTER TABLE "WorkoutRecordExerciseSet" DROP CONSTRAINT "WorkoutRecordExerciseSet_workoutRecordExerciseId_fkey";

-- DropTable
DROP TABLE "Exercise";

-- DropTable
DROP TABLE "ExerciseMuscle";

-- DropTable
DROP TABLE "Muscle";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "WorkoutPlanTemplate";

-- DropTable
DROP TABLE "WorkoutPlanTemplateExercise";

-- DropTable
DROP TABLE "WorkoutRecord";

-- DropTable
DROP TABLE "WorkoutRecordExercise";

-- DropTable
DROP TABLE "WorkoutRecordExerciseSet";

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercise" (
    "id" INTEGER NOT NULL,
    "name_en" TEXT NOT NULL,
    "name_zh" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "modality" INTEGER NOT NULL,
    "upper_lower_core" INTEGER NOT NULL,
    "push_pull" INTEGER NOT NULL,
    "joint" INTEGER NOT NULL,
    "video" JSONB,

    CONSTRAINT "exercise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "muscle" (
    "id" INTEGER NOT NULL,

    CONSTRAINT "muscle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercise_muscle" (
    "exercise_id" INTEGER NOT NULL,
    "muscle_id" INTEGER NOT NULL,

    CONSTRAINT "exercise_muscle_pkey" PRIMARY KEY ("exercise_id","muscle_id")
);

-- CreateTable
CREATE TABLE "workout_plan_template" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "workout_plan_template_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workout_plan_template_exercise" (
    "id" TEXT NOT NULL,
    "exercise_id" INTEGER NOT NULL,
    "sets" INTEGER NOT NULL,
    "reps" INTEGER NOT NULL,
    "workout_plan_template_id" TEXT NOT NULL,

    CONSTRAINT "workout_plan_template_exercise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workout_record" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "plan_id" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "time" TEXT NOT NULL,

    CONSTRAINT "workout_record_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workout_record_exercise" (
    "id" TEXT NOT NULL,
    "exercise_id" INTEGER NOT NULL,
    "workout_record_id" TEXT NOT NULL,

    CONSTRAINT "workout_record_exercise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workout_record_exercise_set" (
    "id" TEXT NOT NULL,
    "reps" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "workout_record_exercise_id" TEXT NOT NULL,

    CONSTRAINT "workout_record_exercise_set_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "exercise_muscle" ADD CONSTRAINT "exercise_muscle_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercise_muscle" ADD CONSTRAINT "exercise_muscle_muscle_id_fkey" FOREIGN KEY ("muscle_id") REFERENCES "muscle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_plan_template" ADD CONSTRAINT "workout_plan_template_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_plan_template_exercise" ADD CONSTRAINT "workout_plan_template_exercise_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_plan_template_exercise" ADD CONSTRAINT "workout_plan_template_exercise_workout_plan_template_id_fkey" FOREIGN KEY ("workout_plan_template_id") REFERENCES "workout_plan_template"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_record" ADD CONSTRAINT "workout_record_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_record" ADD CONSTRAINT "workout_record_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "workout_plan_template"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_record_exercise" ADD CONSTRAINT "workout_record_exercise_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_record_exercise" ADD CONSTRAINT "workout_record_exercise_workout_record_id_fkey" FOREIGN KEY ("workout_record_id") REFERENCES "workout_record"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workout_record_exercise_set" ADD CONSTRAINT "workout_record_exercise_set_workout_record_exercise_id_fkey" FOREIGN KEY ("workout_record_exercise_id") REFERENCES "workout_record_exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
