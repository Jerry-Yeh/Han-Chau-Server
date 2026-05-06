import { Router, Request, Response } from "express";
import { prisma } from "../lib/prisma";

const router = Router();

router.get("/", async (req: Request, res: Response) => {
  const offset = parseInt((req.query.offset as string) ?? "0", 10);
  const limit = parseInt((req.query.limit as string) ?? "20", 10);

  const [data, total] = await Promise.all([
    prisma.exercise.findMany({
      skip: offset,
      take: limit,
      include: {
        muscles: { select: { muscleId: true } },
      },
    }),
    prisma.exercise.count(),
  ]);

  res.json({
    data: data.map((exercise) => ({
      ...exercise,
      muscles: exercise.muscles.map((m) => m.muscleId),
    })),
    total,
    offset,
    limit,
  });
});

export default router;
