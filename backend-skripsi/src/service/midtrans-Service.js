import midtransClient from "midtrans-client";
import { MIDTRANS_CLIENT_KEY, MIDTRANS_SECRET_KEY } from "../utils/constant.js";
import { ResponseError } from "../error/response-error.js";
import { prismaClient } from "../application/database.js";
import crypto from "crypto";
import {
  updateTransactionFail,
  updateTransactionSuccess,
} from "../helpers/transactionHelpers.js";

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

const updateNotificationStatusOnMidtrans = async (request) => {
  const checkTransaction = await prismaClient.transaction.findUnique({
    where: {
      transaction_id: request.order_id,
    },
  });

  if (!checkTransaction) {
    return;
  }

  const hash = crypto
    .createHash("sha512")
    .update(
      `${checkTransaction.transaction_id}${request.status_code}${request.gross_amount}${MIDTRANS_SECRET_KEY}`
    )
    .digest("hex");

  if (request.signature_key !== hash) {
    return {
      status: "error",
      message: "Invalid Signature Key",
    };
  }

  let responseData = null;
  let transactionStatus = request.transaction_status;
  let fraudStatus = request.fraud_status;

  if (transactionStatus == "capture") {
    if (fraudStatus == "accept") {
      await updateTransactionSuccess(
        checkTransaction.transaction_id,
        request.payment_type
      );
    }
  } else if (transactionStatus == "settlement") {
    await updateTransactionSuccess(
      checkTransaction.transaction_id,
      request.payment_type
    );
  } else if (
    transactionStatus == "cancel" ||
    transactionStatus == "deny" ||
    transactionStatus == "expire"
  ) {
    await updateTransactionFail(checkTransaction.transaction_id);
  }

  return {
    status: "success",
    message: "Berhasil Update",
  };
};

export default {
  createTransaction,
  updateTransactionMidtrans,
  updateNotificationStatusOnMidtrans,
};
