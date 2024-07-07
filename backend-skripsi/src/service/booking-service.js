import { request } from "express";
import { validate } from "../validation/validation.js";
import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";
import { getBookingValidation } from "../validation/booking-validation.js";

const get = async (request) => {
  const user = validate(getBookingValidation, request);

  // Cek apakah user ada di database
  const checkUserInDatabase = await prismaClient.user.count({
    where: {
      user_id: user.user_id,
    },
  });

  if (checkUserInDatabase !== 1) {
    throw new ResponseError(404, "user tidak ditemukan");
  }

  // Cek jika product_id dan booking_date keduanya ada
  if (user.product_id && user.booking_date) {
    const result = await prismaClient.booking.findMany({
      where: {
        product_id: user.product_id,
        booking_date: user.booking_date,
        status: "booked",
      },
      select: {
        booking_id: true,
        booking_date: true,
        start_time: true,
        end_time: true,
        user: {
          select: {
            name: true,
          },
        },
      },
    });

    if (!result || result.length === 0) {
      return;
    }
    return result;
  }

  // Jika hanya salah satu dari product_id atau booking_date yang ada, lempar error
  if (user.product_id || user.booking_date) {
    if (!user.product_id) {
      throw new ResponseError(400, "Lapangan belum dipilih");
    } else {
      throw new ResponseError(400, "tanggal belum diisi");
    }
  }

  // Jika tidak ada parameter, kembalikan semua data booking
  return prismaClient.booking.findMany();
};

export default {
  get,
};
