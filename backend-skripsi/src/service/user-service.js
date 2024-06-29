import { validate } from "../validation/validation.js";
import {
  getUserValidation,
  loginUserValidation,
  registerUserValidation,
  updateUserValidation,
} from "../validation/user-validation.js";
import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";
import bcrypt from "bcrypt";
import { v4 as uuid } from "uuid";
import { request } from "express";

const generateUserId = async () => {
  const lastUser = await prismaClient.user.findFirst({
    orderBy: {
      user_id: "desc",
    },
  });

  let newIdNumber = 1;
  if (lastUser && lastUser.user_id) {
    const lastIdNumber = parseInt(lastUser.user_id.slice(0, 3), 10);
    newIdNumber = lastIdNumber + 1;
  }

  const date = new Date();
  const formattedDate = `${date.getDate().toString().padStart(2, "0")}${(
    date.getMonth() + 1
  )
    .toString()
    .padStart(2, "0")}${date.getFullYear().toString().slice(-2)}`;

  const userId = `${newIdNumber.toString().padStart(3, "0")}02${formattedDate}`;
  return userId;
};

const register = async (request) => {
  const user = validate(registerUserValidation, request);
  // Check for existing username
  const existingUsername = await prismaClient.user.findFirst({
    where: {
      username: user.username,
    },
  });

  if (existingUsername) {
    throw new ResponseError(400, "Username sudah digunakan");
  }

  // Check for existing phone number
  const existingPhone = await prismaClient.user.findFirst({
    where: {
      user_phone: user.user_phone,
    },
  });

  if (existingPhone) {
    throw new ResponseError(400, "Nomor telepon sudah digunakan");
  }

  user.password = await bcrypt.hash(user.password, 10);
  user.user_id = await generateUserId();
  const role = "user";

  return prismaClient.user.create({
    data: {
      user_id: user.user_id,
      name: user.name,
      username: user.username,
      password: user.password,
      user_phone: user.user_phone,
      role: role,
    },
    select: {
      username: true,
      name: true,
      user_phone: true,
    },
  });
};

const login = async (request) => {
  const loginRequest = validate(loginUserValidation, request);

  const user = await prismaClient.user.findUnique({
    where: {
      username: loginRequest.username,
    },
    select: {
      username: true,
      password: true,
    },
  });

  if (!user) {
    throw new ResponseError(401, "Username atau Password salah");
  }
  const isPasswordValid = await bcrypt.compare(
    loginRequest.password,
    user.password
  );
  if (!isPasswordValid) {
    throw new ResponseError(401, "Username atau Password salah");
  }
  const token = uuid().toString();

  return prismaClient.user.update({
    data: {
      token: token,
    },
    where: {
      username: user.username,
    },
    select: {
      token: true,
    },
  });
};

const get = async (user_id) => {
  user_id = validate(getUserValidation, user_id);
  const user = await prismaClient.user.findUnique({
    where: {
      user_id: user_id,
    },
    select: {
      username: true,
      name: true,
      user_phone: true,
    },
  });

  if (!user) {
    throw new ResponseError(404, "user is not found");
  }
  return user;
};

const update = async (request) => {
  const user = validate(updateUserValidation, request);

  const totalUserInDatabase = await prismaClient.user.count({
    where: {
      user_id: user.user_id,
    },
  });

  if (totalUserInDatabase != 1) {
    throw new ResponseError(404, "user is not found");
  }

  const data = {};
  if (user.username) {
    // Check for existing username
    const existingUsername = await prismaClient.user.findFirst({
      where: {
        username: user.username,
      },
    });

    if (existingUsername) {
      throw new ResponseError(400, "Username sudah digunakan");
    } else {
      data.username = user.username;
    }
  }
  if (user.password) {
    data.password = await bcrypt.hash(user.password, 10);
  }
  if (user.name) {
    data.name = user.name;
  }
  if (user.user_phone) {
    // Check for existing phone number
    const existingPhone = await prismaClient.user.findFirst({
      where: {
        user_phone: user.user_phone,
      },
    });

    if (existingPhone) {
      throw new ResponseError(400, "Nomor telepon sudah digunakan");
    } else {
      data.user_phone = user.user_phone;
    }
  }

  return prismaClient.user.update({
    where: {
      user_id: user.user_id,
    },
    data: data,
    select: {
      username: true,
      name: true,
      user_phone: true,
    },
  });
};

export default {
  register,
  login,
  get,
  update,
};
