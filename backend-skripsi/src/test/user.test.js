import { prismaClient } from "../application/database.js";
import { logger } from "../application/logging.js";
import { web } from "../application/web.js";
import supertest from "supertest";
import {
  createTestUser,
  createTestUser2,
  removeTestUser,
  removeTestUser2,
} from "./test-utils.js";

describe("POST /api/users", function () {
  afterEach(async () => {
    await removeTestUser();
  });

  it("should can register new user", async () => {
    const result = await supertest(web).post("/api/users").send({
      username: "test",
      password: "1234567890",
      confirm_password: "1234567890",
      name: "test",
      user_phone: "0812345678910",
    });
    expect(result.status).toBe(200);
    expect(result.body.data.username).toBe("test");
    expect(result.body.data.name).toBe("test");
    expect(result.body.data.user_phone).toBe("0812345678910");
    expect(result.body.data.password).toBeUndefined();
  });

  it("should reject if request is invalid", async () => {
    const result = await supertest(web).post("/api/users").send({
      username: "",
      password: "",
      confirm_password: "",
      name: "",
      user_phone: "",
    });

    logger.info(result.body);
    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });

  it("should reject if username already registered", async () => {
    let result = await supertest(web).post("/api/users").send({
      username: "test",
      password: "1234567890",
      confirm_password: "1234567890",
      name: "test",
      user_phone: "0812345678910",
    });
    expect(result.status).toBe(200);
    expect(result.body.data.username).toBe("test");
    expect(result.body.data.name).toBe("test");
    expect(result.body.data.user_phone).toBe("0812345678910");
    expect(result.body.data.password).toBeUndefined();

    result = await supertest(web).post("/api/users").send({
      username: "test",
      password: "1234567890",
      confirm_password: "1234567890",
      name: "test",
      user_phone: "0812345678911",
    });

    logger.info(result.body);
    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });

  it("should reject if user_phone already registered", async () => {
    let result = await supertest(web).post("/api/users").send({
      username: "test",
      password: "1234567890",
      confirm_password: "1234567890",
      name: "test",
      user_phone: "0812345678910",
    });
    expect(result.status).toBe(200);
    expect(result.body.data.username).toBe("test");
    expect(result.body.data.name).toBe("test");
    expect(result.body.data.user_phone).toBe("0812345678910");
    expect(result.body.data.password).toBeUndefined();

    result = await supertest(web).post("/api/users").send({
      username: "admin",
      password: "1234567890",
      confirm_password: "1234567890",
      name: "test",
      user_phone: "0812345678910",
    });

    logger.info(result.body);
    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });
});

describe("POST /api/users/login", function () {
  beforeEach(async () => {
    await createTestUser();
  });
  afterEach(async () => {
    await removeTestUser();
  });
  it("Should login success", async () => {
    const result = await supertest(web).post("/api/users/login").send({
      username: "test",
      password: "1234567890",
    });

    logger.info(result.body);
    expect(result.status).toBe(200);
    expect(result.body.data.token).toBeDefined();
    expect(result.body.data.token).not.toBe("test");
  });

  it("should reject login if request invalid", async () => {
    const result = await supertest(web).post("/api/users/login").send({
      username: "",
      password: "",
    });
    logger.info(result.body);
    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });
  it("should reject login if password is wrong", async () => {
    const result = await supertest(web).post("/api/users/login").send({
      username: "test",
      password: "12345675456",
    });
    logger.info(result.body);
    expect(result.status).toBe(401);
    expect(result.body.errors).toBeDefined();
  });
  it("should reject login if username is wrong", async () => {
    const result = await supertest(web).post("/api/users/login").send({
      username: "testi",
      password: "1234567890",
    });
    logger.info(result.body);
    expect(result.status).toBe(401);
    expect(result.body.errors).toBeDefined();
  });
});

describe("GET /api/users/current", function () {
  beforeEach(async () => {
    await createTestUser();
  });
  afterEach(async () => {
    await removeTestUser();
  });

  it("should can get current user", async () => {
    const result = await supertest(web)
      .get("/api/users/current")
      .set("Authorization", "test");

    expect(result.status).toBe(200);
    expect(result.body.data.username).toBe("test");
    expect(result.body.data.name).toBe("test");
    expect(result.body.data.user_phone).toBe("12345678910");
  });

  it("should reject get user if token invalid", async () => {
    const result = await supertest(web)
      .get("/api/users/current")
      .set("Authorization", "admin");

    expect(result.status).toBe(401);
    expect(result.body.errors).toBeDefined();
  });
});

describe("PATCH /api/users/current", function () {
  beforeEach(async () => {
    await createTestUser();
    await createTestUser2();
  });
  afterEach(async () => {
    await removeTestUser();
    await removeTestUser2();
  });
  it("should can update user", async () => {
    const result = await supertest(web)
      .patch("/api/users/current")
      .set("Authorization", "test")
      .send({
        name: "Rio",
        user_phone: "081234659392",
      });

    logger.info(result.body);
    expect(result.status).toBe(200);
    expect(result.body.data.name).toBe("Rio");
    expect(result.body.data.user_phone).toBe("081234659392");
  });

  it("should reject if username already registered", async () => {
    const result = await supertest(web)
      .patch("/api/users/current")
      .set("Authorization", "test")
      .send({
        username: "Riofarhan",
      });

    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });

  it("should reject if user_phone already registered", async () => {
    const result = await supertest(web)
      .patch("/api/users/current")
      .set("Authorization", "test")
      .send({
        user_phone: "12345678911",
      });

    expect(result.status).toBe(400);
    expect(result.body.errors).toBeDefined();
  });

  it("should reject if request not valid", async () => {
    const result = await supertest(web)
      .patch("/api/users/current")
      .set("Authorization", "test123")
      .send({});

    expect(result.status).toBe(401);
    expect(result.body.errors).toBeDefined();
  });
});
