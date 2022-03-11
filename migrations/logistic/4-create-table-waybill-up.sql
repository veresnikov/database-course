USE `logistic`;
CREATE TABLE IF NOT EXISTS `waybill`
(
    `id_waybill`    BINARY(16) PRIMARY KEY NOT NULL DEFAULT (UUID_TO_BIN(UUID())),
    `id_company`    BINARY(16)             NOT NULL,
    `from`          BINARY(16)             NOT NULL,
    `to`            BINARY(16)             NOT NULL,
    `status`        INT                             DEFAULT NULL,
    `sent_date`     DATETIME               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `received_date` DATETIME                        DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_company`) REFERENCES `company` (`id_company`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`from`) REFERENCES `client` (`id_client`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`to`) REFERENCES `client` (`id_client`) ON DELETE CASCADE
)
    CHARACTER SET = utf8mb4
    COLLATE utf8mb4_unicode_ci
;