USE `service`;
CREATE TABLE IF NOT EXISTS `computer` (
    `id_computer` BINARY(16) PRIMARY KEY NOT NULL,
    `location` INT NOT NULL,
    `id_owner` BINARY(16) NOT NULL,
    `last_service` DATE DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_owner`) REFERENCES `user` (`id_user`) ON DELETE CASCADE
);