import { prismaClient } from "../application/database.js";
import bcrypt from "bcrypt";
export const removeTestUser = async () => {
  const result = await prismaClient.user.count({
    where: {
      username: "test",
    },
  });
  if (result !== 1) {
    return;
  }
  return await prismaClient.user.delete({
    where: {
      username: "test",
    },
  });
};

export const removeTestUser2 = async () => {
  const result = await prismaClient.user.count({
    where: {
      username: "Riofarhan",
    },
  });
  if (result !== 1) {
    return;
  }
  return await prismaClient.user.delete({
    where: {
      username: "Riofarhan",
    },
  });
};

export const removeTestAdmin = async () => {
  await prismaClient.user.delete({
    where: {
      username: "admin",
    },
  });
};
export const removeTestProduct = async () => {
  const result = await prismaClient.product.count({
    where: {
      product_id: 1,
    },
  });
  if (!result) {
    return;
  }
  return await prismaClient.product.delete({
    where: {
      product_id: 1,
    },
  });
};

export const removeTestProductField = async () => {
  await prismaClient.product.deleteMany({
    where: {
      product_type: "field",
    },
  });
};

export const removeTestProductMembership = async () => {
  await prismaClient.product.deleteMany({
    where: {
      product_type: "membership",
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

export const createTestAdmin = async () => {
  await prismaClient.user.create({
    data: {
      user_id: await generateUserId(),
      username: "admin",
      password: await bcrypt.hash("1234567890", 10),
      name: "admin",
      user_phone: "12345678111",
      token: "admin",
      role: "admin",
    },
  });
};

export const createTestProduct = async () => {
  await prismaClient.product.create({
    data: {
      product_id: 1,
      product_name: "Lapangan A",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });
};

export const createProductField = async () => {
  await prismaClient.product.create({
    data: {
      product_name: "Lapangan A",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_name: "Lapangan B",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_name: "Lapangan C",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });
};

export const createProductMembership = async () => {
  await prismaClient.product.create({
    data: {
      product_name: "Membership 1 Bulan",
      product_type: "membership",
      price: 100000,
      description: "membership",
      image_url: "www.membership.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_name: "Membership 2 Bulan",
      product_type: "membership",
      price: 100000,
      description: "membership",
      image_url: "www.membership.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_name: "Membership 3 Bulan",
      product_type: "membership",
      price: 100000,
      description: "membership",
      image_url: "www.membership.com",
    },
  });
};

export const createTestHelp = async () => {
  await prismaClient.help.create({
    data: {
      help_id: 1,
      title: "Booking",
      message: "Booking bisa dilakukan dengan metode pembayaran gopay",
    },
  });
};

export const removeHelpTest = async () => {
  const result = await prismaClient.help.count({
    where: {
      title: "Booking",
    },
  });
  if (!result) {
    return;
  }
  return prismaClient.help.deleteMany({
    where: {
      title: "Booking",
    },
  });
};
