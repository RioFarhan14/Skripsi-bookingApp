import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";

const generateTransactionId = async (user_id_token) => {
  const lastTransaction = await prismaClient.transaction.findFirst({
    orderBy: {
      transaction_id: "desc",
    },
  });

  let newIdNumber = 1;
  if (lastTransaction && lastTransaction.transaction_id) {
    const lastIdNumber = parseInt(
      lastTransaction.transaction_id.slice(0, 3),
      10
    );
    newIdNumber = lastIdNumber + 1;
  }

  // Mengambil tiga digit pertama dari userId
  const userPrefix = String(user_id_token).padStart(3, "0").substring(0, 3);

  const now = new Date();
  // Mengubah waktu menjadi string lokal di zona waktu Jakarta
  const jakartaTimeString = now.toLocaleString("en-US", {
    timeZone: "Asia/Jakarta",
  });

  // Membuat objek Date baru dari string lokal
  const date = new Date(jakartaTimeString);
  // Membuat tanggal menjadi DDMMYY
  const formattedDate = `${date.getDate().toString().padStart(2, "0")}${(
    date.getMonth() + 1
  )
    .toString()
    .padStart(2, "0")}${date.getFullYear().toString().slice(-2)}`;

  const userId = `${newIdNumber
    .toString()
    .padStart(3, "0")}${userPrefix}${formattedDate}`;
  return userId;
};

const calculateTotalAmount = (price, quantity, discount) => {
  let totalAmount = price * quantity;

  if (discount > 0) {
    totalAmount *= 1 - discount / 100;
  }

  return totalAmount;
};

const createTransactionRecord = async (user, user_id) => {
  const status = "PENDING";
  const result = await prismaClient.transaction.create({
    data: {
      transaction_id: user.transaction_id,
      transaction_date: user.transaction_date,
      total_amount: user.total_amount,
      status: status,
      discount: user.discount,
      user: {
        connect: {
          user_id: user_id,
        },
      },
    },
    select: {
      transaction_id: true,
      total_amount: true,
    },
  });

  if (!result) {
    throw new ResponseError(500, "Gagal membuat transaksi");
  }

  return result;
};

const createTransactionDetail = async (user, price) => {
  const result = await prismaClient.transaction_detail.create({
    data: {
      quantity: user.quantity,
      unit_price: price,
      transaction: {
        connect: {
          transaction_id: user.transaction_id,
        },
      },
      product: {
        connect: {
          product_id: user.product_id,
        },
      },
    },
  });

  if (!result) {
    throw new ResponseError(500, "Gagal membuat transaksi");
  }

  return;
};
export {
  calculateTotalAmount,
  createTransactionRecord,
  createTransactionDetail,
  generateTransactionId,
};
