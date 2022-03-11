USE `logistic`;
CREATE TABLE IF NOT EXISTS `cargo`
(
    `id_cargo`    BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
    `id_owner`    BINARY(16)             NOT NULL,
    `title`       VARCHAR(255)             NOT NULL,
    `description` VARCHAR(255)           NOT NULL,
    `count`       INT                             DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_owner`) REFERENCES `client` (`id_client`) ON DELETE CASCADE
)
    CHARACTER SET = utf8mb4
    COLLATE utf8mb4_unicode_ci
;