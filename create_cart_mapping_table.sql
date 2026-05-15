CREATE TABLE IF NOT EXISTS `fast_customeradmin_cart_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_customer_id` int(11) NOT NULL,
  `target_customer_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `store_id` smallint(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_FAST_CUSTOMERADMIN_CART_MAPPING_ADMIN_CUSTOMER_ID` (`admin_customer_id`),
  KEY `IDX_FAST_CUSTOMERADMIN_CART_MAPPING_TARGET_CUSTOMER_ID` (`target_customer_id`),
  KEY `IDX_FAST_CUSTOMERADMIN_CART_MAPPING_QUOTE_ID` (`quote_id`),
  UNIQUE KEY `UNQ_FAST_CUSTOMERADMIN_CART_MAPPING_ADMIN_TARGET` (`admin_customer_id`, `target_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

