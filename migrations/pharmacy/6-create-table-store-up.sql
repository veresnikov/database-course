USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `store` (
    `id_store` BINARY(16) NOT NULL,
    `id_medicament` BINARY(16) NOT NULL,
    `production_date` DATE NOT NULL,
    `balance` INT DEFAULT 0,
    CONSTRAINT FOREIGN KEY (`id_store`) REFERENCES `pharmacy_store` (`id_store`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_medicament`) REFERENCES `medicament` (`id_medicament`) ON DELETE CASCADE
);