//mulai
import { web } from "./application/web.js";
import { logger } from "./application/logging.js";
import { PORT } from "./utils/constant.js";

web.listen(PORT, () => {
  logger.info("aplikasi mulai berjalan");
});
