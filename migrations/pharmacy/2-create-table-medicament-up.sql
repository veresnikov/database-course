USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `medicament` (
    `id_medicament` BINARY(16) PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `composition` TEXT DEFAULT NULL,
    `contraindications` TEXT DEFAULT NULL,
    `expiration_date` TIMESTAMP DEFAULT NULL
);