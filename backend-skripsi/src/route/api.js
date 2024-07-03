import express from "express";
import userController from "../controller/user-controller.js";
import productController from "../controller/product-controller.js";
import { authMiddleware } from "../middleware/auth-middleware.js";

const userRouter = new express.Router();
userRouter.use(authMiddleware);
userRouter.get("/api/users/current", userController.get);
userRouter.patch("/api/users/current", userController.update);
userRouter.delete("/api/users/logout", userController.logout);
//product
userRouter.get("/api/users/products", productController.get);
userRouter.get("/api/users/products/field", productController.getField);
userRouter.get(
  "/api/users/products/membership",
  productController.getMembership
);
userRouter.post("/api/users/products", productController.create);
userRouter.patch("/api/users/products", productController.update);
userRouter.delete("/api/users/products", productController.deleteProduct);

export { userRouter };
