USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `client` (
    `id_client` BINARY(16) PRIMARY KEY NOT NULL,
    `id_pharmacy` BINARY(16) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(16) DEFAULT NULL,
    `perconal_discount` TINYINT DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_pharmacy`) REFERENCES `pharmacy` (`id_pharmacy`) ON DELETE CASCADE
);