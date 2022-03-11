USE `service`;
CREATE TABLE IF NOT EXISTS `software_equipment` (
    `id_computer` BINARY(16) NOT NULL,
    `id_software` BINARY(16) NOT NULL,
    CONSTRAINT FOREIGN KEY (`id_computer`) REFERENCES `computer` (`id_computer`)  ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_software`) REFERENCES `software` (`id_software`)  ON DELETE CASCADE
);