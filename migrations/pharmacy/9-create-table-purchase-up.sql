USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `purchase` (
    `id_purchase` BINARY(16) PRIMARY KEY NOT NULL,
    `id_client` BINARY(16) NOT NULL,
    `id_employee` BINARY(16) NOT NULL,
    CONSTRAINT FOREIGN KEY (`id_client`) REFERENCES client (`id_client`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_employee`) REFERENCES employee (`id_employee`) ON DELETE CASCADE
);