import midtransClient from "midtrans-client";
import { MIDTRANS_CLIENT_KEY, MIDTRANS_SECRET_KEY } from "../utils/constant.js";
import { ResponseError } from "../error/response-error.js";
import { prismaClient } from "../application/database.js";

const snap = new midtransClient.Snap({
  isProduction: false,
  serverKey: MIDTRANS_SECRET_KEY,
  clientKey: MIDTRANS_CLIENT_KEY,
});

const createTransaction = async (orderId, grossAmount) => {
  try {
    const parameter = {
      transaction_details: {
        order_id: orderId,
        gross_amount: grossAmount,
      },
    };

    const transaction = await snap.createTransaction(parameter);
    return transaction;
  } catch (error) {
    throw new ResponseError(
      500,
      `Failed to create Midtrans transaction: ${error.message}`
    );
  }
};

const updateTransactionMidtrans = async (
  transaction_id,
  token,
  redirect_url
) => {
  const result = await prismaClient.transaction.update({
    where: {
      transaction_id: transaction_id,
    },
    data: {
      snap_token: token,
      snap_redirect_url: redirect_url,
    },
    select: {
      snap_token: true,
    },
  });

  return result;
};

export default { createTransaction, updateTransactionMidtrans };
