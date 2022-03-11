USE `service`;
CREATE TABLE IF NOT EXISTS `hardware_equipment` (
    `id_computer` BINARY(16) NOT NULL,
    `id_hardware` BINARY(16) NOT NULL,
    CONSTRAINT FOREIGN KEY (`id_computer`) REFERENCES `computer` (`id_computer`)  ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_hardware`) REFERENCES `hardware` (`id_hardware`)  ON DELETE CASCADE
);