import bookingService from "../service/booking-service";

const get = async (req, res, next) => {
  try {
    const user_id = req.user.user_id;
    const request = req.body;
    request.user_id = user_id;
    const result = await bookingService.get(request);
    res.status(200).json({
      data: result,
    });
  } catch (e) {
    next(e);
  }
};

export default {
  get,
};
