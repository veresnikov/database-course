USE `pharmacy`;
CREATE TABLE IF NOT EXISTS `employee` (
    `id_employee` BINARY(16) PRIMARY KEY NOT NULL,
    `id_pharmacy` BINARY(16) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(16) DEFAULT NULL,
    `job_title` VARCHAR(255) DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_pharmacy`) REFERENCES `pharmacy` (`id_pharmacy`) ON DELETE CASCADE
);