//mulai
import { web } from "./application/web.js";
import { logger } from "./application/logging.js";
import { PORT } from "./utils/constant.js";
import job from "./utils/cron-job.js";

job;
web.listen(PORT, () => {
  logger.info("aplikasi mulai berjalan");
});
