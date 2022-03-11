USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `catalog` (
    `id_pharmacy` BINARY(16) NOT NULL,
    `id_medicament` BINARY(16) NOT NULL,
    `price` DECIMAL(16,2) NOT NULL,
    `discount` TINYINT DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_pharmacy`) REFERENCES `pharmacy` (`id_pharmacy`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_medicament`) REFERENCES `medicament` (`id_medicament`) ON DELETE CASCADE
);