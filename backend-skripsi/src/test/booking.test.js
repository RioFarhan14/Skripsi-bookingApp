import supertest from "supertest";
import { web } from "../application/web.js";
import { logger } from "../application/logging.js";
import {
  createProductField,
  createTestAdmin,
  createTestBooking,
  createTestUser,
  removeTestAdmin,
  removeTestBooking,
  removeTestProductField,
  removeTestUser,
} from "./test-utils.js";

describe("GET /api/users/bookings", function () {
  beforeEach(async () => {
    await createTestUser();
    await createProductField();
    await createTestBooking();
  });
  afterEach(async () => {
    await removeTestBooking();
    await removeTestUser();
    await removeTestProductField();
  });

  it("should can get all booking", async () => {
    const result = await supertest(web)
      .get("/api/users/bookings")
      .set("Authorization", "test");

    expect(result.status).toBe(200);
    expect(result.body.data).toBeInstanceOf(Object);
  });

  it("should can get bookingByDate", async () => {
    const dateOnly = new Date("2024-07-07");
    const result = await supertest(web)
      .get("/api/users/bookings")
      .set("Authorization", "test")
      .send({
        product_id: 2,
        booking_date: dateOnly,
      });

    logger.info(result.body);
    expect(result.status).toBe(200);
    expect(result.body.data).toBeInstanceOf(Object);
  });
});
