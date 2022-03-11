USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `purchase_list` (
    `id_purchase` BINARY(16) NOT NULL,
    `id_medicament` BINARY(16) NOT NULL,
    `count` INT NOT NULL,
    `price` DECIMAL(16,2) DEFAULT NULL,
    `discount` TINYINT DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_purchase`) REFERENCES purchase (`id_purchase`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_medicament`) REFERENCES medicament (`id_medicament`) ON DELETE CASCADE
);