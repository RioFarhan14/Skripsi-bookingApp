import Joi from "joi";

const registerUserValidation = Joi.object({
  username: Joi.string().min(3).max(15).required(),
  password: Joi.string().min(3).max(64).required(),
  confirm_password: Joi.ref("password"),
  name: Joi.string().max(60).required(),
  user_phone: Joi.string()
    .min(11)
    .max(13)
    .pattern(/^[0-9]+$/)
    .required(),
});

const loginUserValidation = Joi.object({
  username: Joi.string().min(3).max(15).required(),
  password: Joi.string().min(3).max(64).required(),
});

const getUserValidation = Joi.string().min(11).max(11).required();

const updateUserValidation = Joi.object({
  user_id: Joi.string().min(11).max(11).required(),
  username: Joi.string().min(3).max(15).optional(),
  password: Joi.string().min(3).max(64).optional(),
  name: Joi.string().max(60).optional(),
  user_phone: Joi.string()
    .min(11)
    .max(13)
    .pattern(/^[0-9]+$/)
    .optional(),
});
export {
  registerUserValidation,
  loginUserValidation,
  getUserValidation,
  updateUserValidation,
};
