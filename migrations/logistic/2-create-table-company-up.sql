USE `logistic`;
CREATE TABLE IF NOT EXISTS `company`
(
    `id_company` BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
    `title`      VARCHAR(255)           NOT NULL,
    `address`    VARCHAR(255)                    DEFAULT NULL,
    `phone`      VARCHAR(16)                     DEFAULT NULL,
    `website`    VARCHAR(255)                    DEFAULT NULL
)
    CHARACTER SET = utf8mb4
    COLLATE utf8mb4_unicode_ci
;