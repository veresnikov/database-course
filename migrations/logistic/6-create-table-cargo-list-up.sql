USE `logistic`;
CREATE TABLE IF NOT EXISTS `cargo_list`
(
    `id_waybill` BINARY(16) NOT NULL,
    `id_cargo`   BINARY(16) NOT NULL,
    `count`      INT DEFAULT NULL,
    CONSTRAINT FOREIGN KEY (`id_waybill`) REFERENCES `waybill` (`id_waybill`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id_cargo`) ON DELETE CASCADE
)
    CHARACTER SET = utf8mb4
    COLLATE utf8mb4_unicode_ci
;