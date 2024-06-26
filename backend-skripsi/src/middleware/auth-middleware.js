import { error } from "winston";
import { prismaClient } from "../application/database";

export const authMiddleware = async (req, res, next) => {
  const token = req.get("Authorization");
  if (!token) {
    res
      .status(401)
      .json({
        errors: "Unathorized",
      })
      .end();
  } else {
    const user = await prismaClient.user.findFirst({
      where: {
        token: token,
      },
    });
    if (!user) {
      res
        .status(401)
        .json({
          errors: "Unathorized",
        })
        .end();
    } else {
      req.user = user;
      next();
    }
  }
};
