//mulai
import { web } from "./application/web.js";
import { logger } from "./application/logging.js";
import { dotenv } from "dotenv";

dotenv.config();

const PORT = process.env.PORT;

web.listen(PORT, () => {
  logger.info("aplikasi mulai berjalan");
});
