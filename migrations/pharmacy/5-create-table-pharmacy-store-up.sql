USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `pharmacy_store` (
    `id_store` BINARY(16) PRIMARY KEY NOT NULL,
    `id_pharmacy` BINARY(16) NOT NULL,
    CONSTRAINT FOREIGN KEY (`id_pharmacy`) REFERENCES `pharmacy` (`id_pharmacy`) ON DELETE CASCADE
);