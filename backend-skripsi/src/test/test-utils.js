import { prismaClient } from "../application/database.js";
import bcrypt from "bcrypt";
export const removeTestUser = async () => {
  await prismaClient.user.deleteMany({
    where: {
      username: "test",
    },
  });
};

export const removeTestUser2 = async () => {
  await prismaClient.user.deleteMany({
    where: {
      username: "Riofarhan",
    },
  });
};
const generateUserId = async () => {
  const lastUser = await prismaClient.user.findFirst({
    orderBy: {
      user_id: "desc",
    },
  });

  let newIdNumber = 1;
  if (lastUser && lastUser.user_id) {
    const lastIdNumber = parseInt(lastUser.user_id.slice(0, 3), 10);
    newIdNumber = lastIdNumber + 1;
  }

  const date = new Date();
  const formattedDate = `${date.getDate().toString().padStart(2, "0")}${(
    date.getMonth() + 1
  )
    .toString()
    .padStart(2, "0")}${date.getFullYear().toString().slice(-2)}`;

  const userId = `${newIdNumber.toString().padStart(3, "0")}02${formattedDate}`;
  return userId;
};
export const createTestUser = async () => {
  await prismaClient.user.create({
    data: {
      user_id: await generateUserId(),
      username: "test",
      password: await bcrypt.hash("1234567890", 10),
      name: "test",
      user_phone: "12345678910",
      token: "test",
      role: "user",
    },
  });
};

export const createTestUser2 = async () => {
  await prismaClient.user.create({
    data: {
      user_id: await generateUserId(),
      username: "Riofarhan",
      password: await bcrypt.hash("1234567890", 10),
      name: "test",
      user_phone: "12345678911",
      token: "test2",
      role: "user",
    },
  });
};
