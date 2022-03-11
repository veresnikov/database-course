USE `service`;
CREATE TABLE IF NOT EXISTS `software` (
    `id_software` BINARY(16) PRIMARY KEY NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `manufacture` VARCHAR(255) DEFAULT NULL,
    `characteristics` VARCHAR(255) DEFAULT NULL
);