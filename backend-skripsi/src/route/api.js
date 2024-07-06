import express from "express";
import userController from "../controller/user-controller.js";
import productController from "../controller/product-controller.js";
import { authMiddleware } from "../middleware/auth-middleware.js";
import helpController from "../controller/help-controller.js";

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
userRouter.post("/api/users/products", productController.create);
userRouter.patch("/api/users/products", productController.update);
userRouter.delete("/api/users/products", productController.deleteProduct);

//helpService
userRouter.get("/api/users/help", helpController.get);
userRouter.post("/api/users/help", helpController.create);
userRouter.patch("/api/users/help", helpController.update);
userRouter.delete("/api/users/help", helpController.deleteHelp);

export { userRouter };
