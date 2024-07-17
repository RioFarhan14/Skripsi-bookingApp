import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";

const calculateEndTime = (startTime, duration) => {
  // Parsing startTime menjadi jam dan menit
  const [hours, minutes] = startTime.split(":").map(Number);

  // Menghitung endTime
  const startDateTime = new Date();
  startDateTime.setHours(hours);
  startDateTime.setMinutes(minutes);

  const endDateTime = new Date(
    startDateTime.getTime() + duration * 60 * 60 * 1000
  );

  // Formatting end_time ke dalam format "HH:mm"
  const endHours = endDateTime.getHours().toString().padStart(2, "0");
  const endMinutes = endDateTime.getMinutes().toString().padStart(2, "0");

  return `${endHours}:${endMinutes}`;
};

const validateSchedule = async (data) => {
  const checkSchedule = await prismaClient.booking.findMany({
    where: {
      booking_date: data.booking_date,
      product_id: data.product_id,
      OR: [
        {
          start_time: {
            lt: data.end_time,
            gt: data.start_time,
          },
        },
        {
          end_time: {
            gt: data.start_time,
            lt: data.end_time,
          },
        },
        {
          start_time: data.start_time,
          end_time: data.end_time,
        },
      ],
    },
  });

  if (checkSchedule.length > 0) {
    throw new ResponseError(
      400,
      "Booking pada tanggal dan waktu tersebut sudah ada"
    );
  }

  return;
};

const generateBookingId = async (user_id_token) => {
  // Mencari booking_id yang terakhir dibuat
  const lastBooking = await prismaClient.booking.findFirst({
    orderBy: {
      booking_id: "desc",
    },
  });

  let newIdBooking = 1;
  if (lastBooking && lastBooking.booking_id) {
    const lastIdBooking = parseInt(lastBooking.booking_id.slice(0, 3), 10);
    newIdBooking = lastIdBooking + 1;
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

  return `${newIdBooking
    .toString()
    .padStart(3, "0")}${userPrefix}${formattedDate}`;
};

const validateBookingId = async (set) => {
  const checkBookingId = await prismaClient.booking.findUnique({
    where: set,
    select: {
      booking_id: true,
      booking_date: true,
      product_id: true,
      start_time: true,
      end_time: true,
    },
  });

  if (!checkBookingId) {
    throw new ResponseError(400, "booking_id tidak ditemukan");
  }
  return checkBookingId;
};

const validateLimitTime = (start_time, end_time) => {
  const startLimit = "09:00";
  const endLimit = "22:00";

  if (start_time < startLimit || end_time > endLimit) {
    throw new ResponseError(
      400,
      "waktu harus lebih dari 09:00 dan kurang dari 22:00"
    );
  }
  return;
};
export {
  calculateEndTime,
  validateSchedule,
  generateBookingId,
  validateBookingId,
  validateLimitTime,
};
