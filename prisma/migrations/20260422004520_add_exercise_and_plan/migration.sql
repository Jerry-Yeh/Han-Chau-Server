-- CreateTable
CREATE TABLE "Exercise" (
    "id" INTEGER NOT NULL,
    "nameEn" TEXT NOT NULL,
    "nameZh" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "muscles" INTEGER[],
    "modality" INTEGER NOT NULL,
    "upperLowerCore" INTEGER NOT NULL,
    "pushPull" INTEGER NOT NULL,
    "joint" INTEGER NOT NULL,
    "url" TEXT,
    "start" INTEGER,
    "end" INTEGER,

    CONSTRAINT "Exercise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkoutPlanTemplate" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "WorkoutPlanTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkoutPlanTemplateExercise" (
    "id" TEXT NOT NULL,
    "exerciseId" INTEGER NOT NULL,
    "sets" INTEGER NOT NULL,
    "reps" INTEGER NOT NULL,
    "workoutPlanTemplateId" TEXT NOT NULL,

    CONSTRAINT "WorkoutPlanTemplateExercise_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "WorkoutPlanTemplate" ADD CONSTRAINT "WorkoutPlanTemplate_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutPlanTemplateExercise" ADD CONSTRAINT "WorkoutPlanTemplateExercise_exerciseId_fkey" FOREIGN KEY ("exerciseId") REFERENCES "Exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutPlanTemplateExercise" ADD CONSTRAINT "WorkoutPlanTemplateExercise_workoutPlanTemplateId_fkey" FOREIGN KEY ("workoutPlanTemplateId") REFERENCES "WorkoutPlanTemplate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutRecord" ADD CONSTRAINT "WorkoutRecord_planId_fkey" FOREIGN KEY ("planId") REFERENCES "WorkoutPlanTemplate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkoutRecordExercise" ADD CONSTRAINT "WorkoutRecordExercise_exerciseId_fkey" FOREIGN KEY ("exerciseId") REFERENCES "Exercise"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
