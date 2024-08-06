import express from "express";
import userController from "../controller/user-controller.js";
import productController from "../controller/product-controller.js";
import { authMiddleware } from "../middleware/auth-middleware.js";
import helpController from "../controller/help-controller.js";
import bookingController from "../controller/booking-controller.js";
import transactionController from "../controller/transaction-controller.js";
import multerMiddleware from "../middleware/multer-middleware.js";
import notificationController from "../controller/notification-controller.js";

const userRouter = new express.Router();
userRouter.use(authMiddleware);
// user
userRouter.get("/api/users/current", userController.get);
userRouter.patch("/api/users/current", userController.update);
userRouter.delete("/api/users/logout", userController.logout);

//admin
userRouter.get("/api/users", userController.getUsers);
userRouter.post("/api/users/create", userController.create);
userRouter.patch("/api/users/update", userController.updateUsers);
userRouter.delete("/api/users/delete", userController.deleteUsers);

//productService
userRouter.get("/api/users/products", productController.get);
userRouter.get("/api/users/products/field", productController.getField);
userRouter.get(
  "/api/users/products/membership",
  productController.getMembership
);
userRouter.post(
  "/api/users/products",
  multerMiddleware,
  productController.create
);
userRouter.patch("/api/users/products", productController.update);
userRouter.delete("/api/users/products", productController.deleteProduct);

//helpService
userRouter.get("/api/users/help", helpController.get);
userRouter.post("/api/users/help", helpController.create);
userRouter.patch("/api/users/help", helpController.update);
userRouter.delete("/api/users/help", helpController.deleteHelp);

//BookingService
userRouter.get("/api/users/booking", bookingController.getAllBooking);
userRouter.get(
  "/api/users/bookings",
  bookingController.getBookingByProductAndDate
);
userRouter.get("/api/users/current/booking", bookingController.getUserBooking);
userRouter.post("/api/users/booking", bookingController.create);
userRouter.patch("/api/users/booking", bookingController.update);
userRouter.delete("/api/users/booking", bookingController.deleteBooking);

//TransactionService
userRouter.get("/api/users/transaction", transactionController.getAll);
userRouter.get(
  "/api/users/current/transaction",
  transactionController.getUserHistory
);
userRouter.post("/api/users/transaction", transactionController.create);

//NotificationService
userRouter.post("/api/users/notification", notificationController.create);
userRouter.post(
  "/api/users/notification/category",
  notificationController.createCategoryNotif
);
userRouter.get("/api/users/notification", notificationController.get);
userRouter.post(
  "/api/users/notificationRead",
  notificationController.notifIsRead
);

export { userRouter };
