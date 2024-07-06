import { validate } from "../validation/validation.js";
import {
  createUserValidation,
  deleteUsersValidation,
  getUserValidation,
  loginUserValidation,
  registerUserValidation,
  updateUsersValidation,
  updateUserValidation,
} from "../validation/user-validation.js";
import { prismaClient } from "../application/database.js";
import { ResponseError } from "../error/response-error.js";
import bcrypt from "bcrypt";
import { v4 as uuid } from "uuid";
import { request } from "express";

const generateUserId = async (role) => {
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

  if (role === "user") {
    const userId = `${newIdNumber
      .toString()
      .padStart(3, "0")}02${formattedDate}`;
    return userId;
  }
  const userId = `${newIdNumber.toString().padStart(3, "0")}01${formattedDate}`;
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
  const role = "user";
  user.user_id = await generateUserId(role);

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

const create = async (request) => {
  const user = validate(createUserValidation, request);

  // Menggunakan Promise.all untuk menjalankan query secara paralel
  const [checkUserInDatabase, existingUsername, existingPhone] =
    await Promise.all([
      prismaClient.user.findUnique({
        where: {
          user_id: user.user_id,
        },
        select: {
          role: true,
        },
      }),
      prismaClient.user.findFirst({
        where: {
          username: user.username,
        },
      }),
      prismaClient.user.findFirst({
        where: {
          user_phone: user.user_phone,
        },
      }),
    ]);

  if (!checkUserInDatabase) {
    throw new ResponseError(404, "User tidak ditemukan");
  }

  if (checkUserInDatabase.role !== "admin") {
    throw new ResponseError(403, "User tidak memiliki izin");
  }

  if (existingUsername) {
    throw new ResponseError(400, "Username sudah digunakan");
  }

  if (existingPhone) {
    throw new ResponseError(400, "Nomor telepon sudah digunakan");
  }
  user.password = await bcrypt.hash(user.password, 10);
  user.user_id = await generateUserId(user.role);

  return prismaClient.user.create({
    data: {
      user_id: user.user_id,
      name: user.name,
      username: user.username,
      password: user.password,
      user_phone: user.user_phone,
      role: user.role,
    },
    select: {
      username: true,
      name: true,
      user_phone: true,
      role: true,
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
    throw new ResponseError(404, "user tidak ditemukan");
  }
  return user;
};

const getUsers = async (user_id) => {
  user_id = validate(getUserValidation, user_id);

  const checkUserInDatabase = await prismaClient.user.findUnique({
    where: {
      user_id: user_id,
    },
    select: {
      role: true,
    },
  });

  if (!checkUserInDatabase) {
    throw new ResponseError(404, "user tidak ditemukan");
  }

  if (checkUserInDatabase.role !== "admin") {
    throw new ResponseError(403, "user tidak memiliki izin");
  }

  return prismaClient.user.findMany();
};

const update = async (request) => {
  const user = validate(updateUserValidation, request);

  const checkUserInDatabase = await prismaClient.user.count({
    where: {
      user_id: user.user_id,
    },
  });

  if (checkUserInDatabase != 1) {
    throw new ResponseError(404, "user tidak ditemukan");
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

const updateUsers = async (request) => {
  const user = validate(updateUsersValidation, request);

  const checkUserInDatabase = await prismaClient.user.findUnique({
    where: {
      user_id: user.user_id_token,
    },
    select: {
      role: true,
    },
  });

  if (!checkUserInDatabase) {
    throw new ResponseError(404, "user tidak ditemukan");
  }

  if (checkUserInDatabase.role !== "admin") {
    throw new ResponseError(403, "user tidak memiliki izin");
  }
  const checkUserId = await prismaClient.user.count({
    where: {
      user_id: user.user_id,
    },
  });

  if (checkUserId !== 1) {
    throw new ResponseError(404, "user_id tidak ditemukan");
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
  if (user.role) {
    data.role = user.role;
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

const logout = async (username) => {
  const user = await prismaClient.user.findUnique({
    where: {
      username: username,
    },
  });

  if (!user) {
    throw new ResponseError(404, "user tidak ditemukan");
  }

  return prismaClient.user.update({
    where: {
      username: username,
    },
    data: {
      token: null,
    },
    select: {
      username: true,
    },
  });
};

const deleteUsers = async (request) => {
  const user = validate(deleteUsersValidation, request);

  const checkUserInDatabase = await prismaClient.user.findUnique({
    where: {
      user_id: user.user_id_token,
    },
    select: {
      role: true,
    },
  });

  if (!checkUserInDatabase) {
    throw new ResponseError(404, "user tidak ditemukan");
  }

  if (checkUserInDatabase.role !== "admin") {
    throw new ResponseError(403, "user tidak memiliki izin");
  }
  const checkUserId = await prismaClient.user.count({
    where: {
      user_id: user.user_id,
    },
  });

  if (checkUserId !== 1) {
    throw new ResponseError(404, "user_id tidak ditemukan");
  }

  return prismaClient.user.delete({
    where: {
      user_id: user.user_id,
    },
  });
};
export default {
  register,
  login,
  get,
  update,
  logout,
  create,
  getUsers,
  updateUsers,
  deleteUsers,
};
