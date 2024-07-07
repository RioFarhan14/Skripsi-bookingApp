import { prismaClient } from "../application/database.js";
import bcrypt from "bcrypt";

export const removeTestUsername = async () => {
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

export const removeTestUser = async () => {
  const date = getFormattedDate();
  const result = await prismaClient.user.count({
    where: {
      user_id: `00102${date}`,
    },
  });
  if (result !== 1) {
    return;
  }
  return await prismaClient.user.delete({
    where: {
      user_id: `00102${date}`,
    },
  });
};
export const removeTestUser2 = async () => {
  const date = getFormattedDate();
  const result = await prismaClient.user.count({
    where: {
      user_id: `00202${date}`,
    },
  });
  if (result !== 1) {
    return;
  }
  return await prismaClient.user.delete({
    where: {
      user_id: `00202${date}`,
    },
  });
};

export const removeTestAdmin = async () => {
  const date = getFormattedDate();
  const result = await prismaClient.user.count({
    where: {
      user_id: `00301${date}`,
    },
  });
  if (result !== 1) {
    return;
  }
  return await prismaClient.user.delete({
    where: {
      user_id: `00301${date}`,
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

export const createTestUser = async () => {
  const date = getFormattedDate();
  await prismaClient.user.create({
    data: {
      user_id: `00102${date}`,
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
  const date = getFormattedDate();
  await prismaClient.user.create({
    data: {
      user_id: `00202${date}`,
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
  const date = getFormattedDate();
  await prismaClient.user.create({
    data: {
      user_id: `00301${date}`,
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
      product_id: 2,
      product_name: "Lapangan A",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_id: 3,
      product_name: "Lapangan B",
      product_type: "field",
      price: 100000,
      description: "ini adalah lapangan futsal yang berada di paling depan",
      image_url: "wwww.indo.com",
    },
  });

  await prismaClient.product.create({
    data: {
      product_id: 4,
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

export const getFormattedDate = () => {
  const today = new Date(); // Mendapatkan tanggal hari ini

  // Ambil tanggal, bulan, dan tahun dari today
  const day = String(today.getDate()).padStart(2, "0"); // Mendapatkan tanggal dengan leading zero jika kurang dari 10
  const month = String(today.getMonth() + 1).padStart(2, "0"); // Mendapatkan bulan dengan leading zero jika kurang dari 10
  const year = today.getFullYear().toString().slice(-2); // Mendapatkan dua digit terakhir tahun

  // Gabungkan tanggal, bulan, dan tahun dalam format yang diinginkan (DDMMYY)
  const formattedDate = `${day}${month}${year}`;

  return formattedDate;
};

export const createTestBooking = async () => {
  const date = getFormattedDate();
  const timeOnly = new Date("2024-07-07T18:00:00");
  const dateOnly = new Date("2024-07-07");
  return await prismaClient.booking.create({
    data: {
      booking_id: `001001${date}`,
      status: "booked",
      booking_date: dateOnly,
      start_time: timeOnly,
      end_time: timeOnly,
      user: {
        connect: {
          user_id: `00102${date}`,
        },
      },
      product: {
        connect: {
          product_id: 2,
        },
      },
    },
  });
};

export const removeTestBooking = async () => {
  const date = getFormattedDate();
  return await prismaClient.booking.delete({
    where: {
      booking_id: `001001${date}`,
    },
  });
};
