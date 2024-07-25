import { request, response } from "express";
import { validate } from "../validation/validation.js";
import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";
import {
  createTransactionValidation,
  getTransactionValidation,
} from "../validation/transaction-validation.js";
import { getCurrentTime } from "../utils/timeUtils.js";
import {
  validateMembership,
  validateProduct,
  validateUser,
} from "../utils/validate.js";
import {
  calculateTotalAmount,
  createTransactionDetail,
  createTransactionRecord,
  generateTransactionId,
} from "../helpers/transactionHelpers.js";

const getAllTransaction = async (user_id) => {
  user_id = validate(getTransactionValidation, user_id);

  const checkUserInDatabase = await validateUser(user_id);

  if (checkUserInDatabase.role !== "admin") {
    throw new ResponseError(403, "user tidak memiliki izin akses");
  }

  return prismaClient.transaction.findMany();
};

const getUserHistoryTransaction = async (user_id) => {
  user_id = validate(getTransactionValidation, user_id);

  const checkUserInDatabase = await validateUser(user_id);

  if (checkUserInDatabase.role !== "user") {
    throw new ResponseError(403, "user tidak memiliki izin akses");
  }

  return prismaClient.transaction.findMany({
    where: {
      user_id: user_id,
      OR: [{ status: "PAID" }, { status: "CANCELLED" }],
    },
    select: {
      transaction_date: true,
      status: true,
      payment: true,
      transaction_date: true,
      transaction_details: {
        select: {
          product: {
            select: {
              product_name: true,
              product_type: true,
            },
          },
        },
      },
    },
  });
};

const create = async (request) => {
  const user = validate(createTransactionValidation, request);

  // validasi user_id pada database
  const checkUserInDatabase = await validateUser(user.user_id_token);

  if (checkUserInDatabase.role === "admin" && !user.user_id) {
    throw new ResponseError(400, "user_id wajib diisi");
  }

  // validasi product_id pada database
  const checkProductInDatabase = await validateProduct(user.product_id);

  // Gunakan user_id jika admin dan gunakan user_id_token jika user
  const user_id =
    checkUserInDatabase.role == "admin" ? user.user_id : user.user_id_token;

  // Dapatkan waktu sekarang timezone jakarta
  const currentTime = getCurrentTime();
  const isMember = await validateMembership(user_id, currentTime);

  if (!isMember) {
    user.discount = 0;
  } else {
    user.discount = 20;
  }

  user.total_amount = calculateTotalAmount(
    checkProductInDatabase.price,
    user.quantity,
    user.discount
  );

  user.transaction_id = await generateTransactionId(user.user_id_token);

  user.transaction_date = getCurrentTime();

  const CreateTransaction = await createTransactionRecord(user, user_id);

  await createTransactionDetail(user, checkProductInDatabase.price);

  const result = {};
  result.transaction_id = CreateTransaction.transaction_id;
  result.total_amount = CreateTransaction.total_amount;
  return result;
};

const update = async (request) => {
  const result = await prismaClient.booking.update({
    where: {
      booking_id: request.orderId,
    },
    data: {
      status: request.status,
    },
  });

  if (result) {
    prismaClient.transaction.update({
      where: { transaction_id: request.orderId },
      data: {
        status: request.status,
      },
    });
  }
};

export default {
  getAllTransaction,
  getUserHistoryTransaction,
  update,
  create,
};
