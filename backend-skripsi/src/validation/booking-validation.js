import Joi from "joi";

const getBookingValidation = Joi.object({
  user_id: Joi.string().length(11).required(),
  product_id: Joi.number().integer().optional(),
  booking_date: Joi.date().optional(),
});

export { getBookingValidation };
