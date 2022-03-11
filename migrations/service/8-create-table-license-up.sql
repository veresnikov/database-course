USE `service`;
CREATE TABLE IF NOT EXISTS `license` (
    `id_license` BINARY(16) PRIMARY KEY NOT NULL ,
    `id_software` BINARY(16) NOT NULL,
    `id_owner` BINARY(16) NOT NULL,
    CONSTRAINT FOREIGN KEY (`id_owner`) REFERENCES `user` (`id_user`)  ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_software`) REFERENCES `software` (`id_software`)  ON DELETE CASCADE
);