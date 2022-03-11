USE `logistic`;
CREATE TABLE IF NOT EXISTS `client`
(
    `id_client`  BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
    `id_company` BINARY(16)             NOT NULL,
    `first_name` VARCHAR(255)           NOT NULL,
    `last_name`  VARCHAR(255)           NOT NULL,
    `phone`      VARCHAR(16)                     DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_company`) REFERENCES `company` (`id_company`) ON DELETE CASCADE
)
    CHARACTER SET = utf8mb4
    COLLATE utf8mb4_unicode_ci
;