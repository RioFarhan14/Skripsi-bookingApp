import express from "express";
import userController from "../controller/user-controller.js";
import path from "path";
import transactionController from "../controller/transaction-controller.js";

const publicRouter = express.Router();
const baseDir = process.cwd();

publicRouter.post("/api/users", userController.register);
publicRouter.post("/api/users/login", userController.login);
publicRouter.post(
  "/api/transaction/notification",
  transactionController.updateTransactionMidtrans
);
publicRouter.get("/images/:filename", (req, res) => {
  const filename = req.params.filename;
  const filePath = path.join(baseDir, "upload/products", filename);

  res.sendFile(filePath, (err) => {
    if (err) {
      console.error("Error sending file:", err);
      res.status(err.status || 500).send("File not found");
    }
  });
});
export { publicRouter };
