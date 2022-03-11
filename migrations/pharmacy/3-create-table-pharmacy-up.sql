USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `pharmacy` (
    `id_pharmacy` BINARY(16) PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(16) DEFAULT NULL,
    `website` VARCHAR(255) DEFAULT NULL
);