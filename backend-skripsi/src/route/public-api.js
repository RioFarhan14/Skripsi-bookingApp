import express from "express";
import userController from "../controller/user-controller.js";
import path from "path";
import { fileURLToPath } from "url"; // Pastikan ini ada

const publicRouter = new express.Router();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

publicRouter.post("/api/users", userController.register);
publicRouter.post("/api/users/login", userController.login);
publicRouter.get("/images/:filename", (req, res) => {
  const filename = req.params.filename;
  const filePath = path.join(__dirname, "../..", "upload/products", filename); // Sesuaikan path jika perlu

  res.sendFile(filePath, (err) => {
    if (err) {
      console.error("Error sending file:", err); // Log kesalahan
      res.status(err.status || 500).send("File not found"); // Kirim pesan jika file tidak ditemukan
    }
  });
});
export { publicRouter };
