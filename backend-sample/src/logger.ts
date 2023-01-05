import log4js from "log4js";

log4js.configure({
  appenders: {
    console: { type: "console", layout: { type: "colored", } },
  },
  categories: {
    default: { appenders: ["console"], level: "debug" },
  },
});
export const logger = log4js.getLogger();
