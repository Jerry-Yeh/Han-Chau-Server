import "dotenv/config";
import { PrismaPg } from "@prisma/adapter-pg";

import { PrismaClient, Prisma } from "../src/generated/prisma";
import exercises from "./data/exercises.json";

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
const prisma = new PrismaClient({ adapter });

async function main() {
  // 從所有 exercise 的 muscles 陣列中收集所有唯一的 muscle id
  const muscleIds = [...new Set(exercises.flatMap((e) => e.muscles))];

  // 先建立所有 Muscle 記錄
  await prisma.muscle.createMany({
    data: muscleIds.map((id) => ({ id })),
    skipDuplicates: true,
  });

  for (const exercise of exercises) {
    // upsert Exercise：存在就更新，不存在就建立
    await prisma.exercise.upsert({
      where: { id: exercise.id },
      update: {
        nameEn: exercise.nameEn,
        nameZh: exercise.nameZh,
        level: exercise.level,
        modality: exercise.modality,
        upperLowerCore: exercise.upperLowerCore,
        pushPull: exercise.pushPull,
        joint: exercise.joint,
        video: exercise.video ?? Prisma.JsonNull,
      },
      create: {
        id: exercise.id,
        nameEn: exercise.nameEn,
        nameZh: exercise.nameZh,
        level: exercise.level,
        modality: exercise.modality,
        upperLowerCore: exercise.upperLowerCore,
        pushPull: exercise.pushPull,
        joint: exercise.joint,
        video: exercise.video ?? Prisma.JsonNull,
      },
    });

    // Junction table：先清除再重建，確保 muscles 資料是最新的
    await prisma.exerciseMuscle.deleteMany({
      where: { exerciseId: exercise.id },
    });
    await prisma.exerciseMuscle.createMany({
      data: exercise.muscles.map((muscleId) => ({
        exerciseId: exercise.id,
        muscleId,
      })),
    });
  }

  console.log(`Seeded ${exercises.length} exercises`);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
