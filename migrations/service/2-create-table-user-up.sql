USE `service`;
CREATE TABLE IF NOT EXISTS `user` (
    `id_user` BINARY(16) PRIMARY KEY NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) DEFAULT NULL,
    `phone` VARCHAR(16) DEFAULT NULL
);