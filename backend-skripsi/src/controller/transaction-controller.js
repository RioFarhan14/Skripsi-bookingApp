import { logger } from "../application/logging.js";
import bookingService from "../service/booking-service.js";
import midtransService from "../service/midtrans-Service.js";
import transactionService from "../service/transaction-service.js";
import { validateProduct } from "../utils/validate.js";

const getAll = async (req, res, next) => {
  try {
    const result = await transactionService.getAllTransaction(req.user.user_id);
    res.status(200).json({
      data: result,
    });
  } catch (e) {
    next(e);
  }
};

const getUserHistory = async (req, res, next) => {
  try {
    const result = await transactionService.getUserHistoryTransaction(
      req.user.user_id
    );
    res.status(200).json({
      data: result,
    });
  } catch (e) {
    next(e);
  }
};
const updateTransactionMidtrans = async (req, res, next) => {
  try {
    const result = await midtransService.updateNotificationStatusOnMidtrans(
      req.body
    );
    logger.info(result.message);
    res.status(200).json({
      status: "success",
      message: "OK",
    });
  } catch (e) {
    next(e);
  }
};

const create = async (req, res, next) => {
  try {
    const user_id_token = req.user.user_id;
    const request = req.body;
    request.user_id_token = user_id_token;

    // Mendapatkan tipe produk dari product_id
    const productType = await validateProduct(request.product_id);

    let result;
    if (productType.product_type === "field") {
      const bookingStatus = await bookingService.createBooking(request);
      result = await transactionService.create(bookingStatus);
    } else {
      result = await transactionService.create(request);
    }
    const transaction = await midtransService.createTransaction(
      result.transaction_id,
      result.total_amount
    );

    const updateTransaction = await midtransService.updateTransactionMidtrans(
      result.transaction_id,
      transaction.token,
      transaction.redirect_url
    );

    res.status(200).json({
      data: updateTransaction,
    });
  } catch (e) {
    next(e);
  }
};

export default {
  getAll,
  getUserHistory,
  create,
  updateTransactionMidtrans,
};
