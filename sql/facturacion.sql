/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.24 : Database - facturacion
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`facturacion` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `facturacion`;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresa` tinyint(1) NOT NULL DEFAULT '0',
  `rut` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genero` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descuento_id` int(10) unsigned DEFAULT NULL,
  `plazo_factura` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `telefono` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_documento` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clientes_descuento_id_foreign` (`descuento_id`),
  KEY `clientes_mail_rut_index` (`mail`,`rut`),
  KEY `cliente_tipo_documento` (`tipo_documento`),
  KEY `clientes_documento_index` (`documento`),
  CONSTRAINT `cliente_tipo_documento` FOREIGN KEY (`tipo_documento`) REFERENCES `tipos_documento` (`id`),
  CONSTRAINT `clientes_descuento_id_foreign` FOREIGN KEY (`descuento_id`) REFERENCES `descuentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `clientes` */

/*Table structure for table `comprobantes` */

DROP TABLE IF EXISTS `comprobantes`;

CREATE TABLE `comprobantes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_comprobante_id` int(10) unsigned NOT NULL,
  `moneda_id` int(10) unsigned DEFAULT NULL,
  `cotizacion` double NOT NULL DEFAULT '1',
  `cliente_id` int(10) unsigned DEFAULT NULL,
  `serie` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `nombre_cliente` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rut` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subTotal` double NOT NULL DEFAULT '0',
  `iva` double NOT NULL DEFAULT '0',
  `total` double NOT NULL DEFAULT '0',
  `fecha_emision` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descripcion_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comprobantes_tipo_comprobante_id_foreign` (`tipo_comprobante_id`),
  KEY `comprobantes_moneda_id_foreign` (`moneda_id`),
  KEY `comprobantes_cliente_id_foreign` (`cliente_id`),
  KEY `comprobantes_fecha_emision_index` (`fecha_emision`),
  CONSTRAINT `comprobantes_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `comprobantes_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  CONSTRAINT `comprobantes_tipo_comprobante_id_foreign` FOREIGN KEY (`tipo_comprobante_id`) REFERENCES `tipo_comprobantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `comprobantes` */

/*Table structure for table `descuentos` */

DROP TABLE IF EXISTS `descuentos`;

CREATE TABLE `descuentos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `descuentos` */

/*Table structure for table `facturas` */

DROP TABLE IF EXISTS `facturas`;

CREATE TABLE `facturas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comprobante_id` int(10) unsigned NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `plazo` int(11) DEFAULT NULL,
  `deuda_original` double NOT NULL,
  `deuda_actual` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facturas_fecha_vencimiento_index` (`fecha_vencimiento`),
  KEY `facturas_comprobante_id_index` (`comprobante_id`),
  CONSTRAINT `facturas_comprobante_id_foreign` FOREIGN KEY (`comprobante_id`) REFERENCES `comprobantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `facturas` */

/*Table structure for table `familia_productos` */

DROP TABLE IF EXISTS `familia_productos`;

CREATE TABLE `familia_productos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `familia_productos_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `familia_productos` */

insert  into `familia_productos`(`id`,`nombre`,`created_at`,`updated_at`) values 
(1,'test','2021-03-15 22:54:22','2021-03-15 22:54:22');

/*Table structure for table `franja_descuentos` */

DROP TABLE IF EXISTS `franja_descuentos`;

CREATE TABLE `franja_descuentos` (
  `descuento_id` int(10) unsigned NOT NULL,
  `monto_minimo` int(11) NOT NULL,
  `valor` double NOT NULL,
  `porcentual` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`descuento_id`,`monto_minimo`),
  CONSTRAINT `franja_descuentos_descuento_id_foreign` FOREIGN KEY (`descuento_id`) REFERENCES `descuentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `franja_descuentos` */

/*Table structure for table `insumos` */

DROP TABLE IF EXISTS `insumos`;

CREATE TABLE `insumos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tasa_iva_id` int(10) unsigned NOT NULL DEFAULT '1',
  `stock` int(11) NOT NULL DEFAULT '0',
  `stock_minimo_valor` int(11) NOT NULL DEFAULT '0',
  `stock_minimo_notificar` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `insumos_codigo_unique` (`codigo`),
  KEY `insumos_tasa_iva_id_foreign` (`tasa_iva_id`),
  KEY `insumos_codigo_nombre_index` (`codigo`,`nombre`),
  CONSTRAINT `insumos_tasa_iva_id_foreign` FOREIGN KEY (`tasa_iva_id`) REFERENCES `tasas_iva` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `insumos` */

/*Table structure for table `linea_productos` */

DROP TABLE IF EXISTS `linea_productos`;

CREATE TABLE `linea_productos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `comprobante_id` int(10) unsigned DEFAULT NULL,
  `descripcion` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` datetime NOT NULL DEFAULT '2021-03-15 22:53:33',
  `stock` double NOT NULL DEFAULT '0',
  `tasa_iva_id` int(10) unsigned NOT NULL DEFAULT '1',
  `precioUnitario` double DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `subTotal` double DEFAULT NULL,
  `iva` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `linea_productos_producto_id_foreign` (`producto_id`),
  KEY `linea_productos_usuario_id_foreign` (`usuario_id`),
  KEY `linea_productos_comprobante_id_foreign` (`comprobante_id`),
  KEY `linea_productos_tasa_iva_id_foreign` (`tasa_iva_id`),
  KEY `linea_productos_fecha_index` (`fecha`),
  CONSTRAINT `linea_productos_comprobante_id_foreign` FOREIGN KEY (`comprobante_id`) REFERENCES `comprobantes` (`id`),
  CONSTRAINT `linea_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `linea_productos_tasa_iva_id_foreign` FOREIGN KEY (`tasa_iva_id`) REFERENCES `tasas_iva` (`id`),
  CONSTRAINT `linea_productos_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `linea_productos` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2017_08_15_041216_create_tasa_ivas_table',1),
(4,'2017_08_16_202051_create_tipo_comprobantes_table',1),
(5,'2017_08_18_005611_create_descuentos_table',1),
(6,'2017_08_18_005625_create_franja_descuentos_table',1),
(7,'2017_08_18_011442_create_monedas_table',1),
(8,'2017_08_18_175224_create_familia_productos_table',1),
(9,'2017_08_18_225600_create_productos_table',1),
(10,'2017_08_18_225647_create_clientes_table',1),
(11,'2017_08_19_044418_create_comprobantes_table',1),
(12,'2017_08_19_225827_create_linea_productos_table',1),
(13,'2017_08_23_033640_create_producto_precio_table',1),
(14,'2017_08_24_031723_create_proveedores_table',1),
(15,'2017_08_26_010631_create_notificaciones_table',1),
(16,'2017_08_26_010644_create_notificacion_usuarios_table',1),
(17,'2017_09_20_140134_updateFacturasTable',1),
(18,'2017_10_05_200203_create_tipo_documentos_table',1),
(19,'2017_11_05_184918_moduloClientesMigration',1),
(20,'2017_12_11_234643_create_preferencias_table',1),
(21,'2018_01_28_235128_create_facturas_table',1),
(22,'2018_01_29_000325_create_recibos_table',1),
(23,'2018_02_14_140303_create_recibo_facturas_table',1),
(24,'2020_01_17_165236_create_insumos_table',1);

/*Table structure for table `monedas` */

DROP TABLE IF EXISTS `monedas`;

CREATE TABLE `monedas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `simbolo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redondeo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `monedas` */

insert  into `monedas`(`id`,`nombre`,`simbolo`,`redondeo`) values 
(1,'Pesos UY','$',0),
(2,'Dólares','U$S',2);

/*Table structure for table `notificacion_usuarios` */

DROP TABLE IF EXISTS `notificacion_usuarios`;

CREATE TABLE `notificacion_usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leido` tinyint(1) NOT NULL DEFAULT '0',
  `usuario_id` int(10) unsigned NOT NULL,
  `notificacion_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `not_usr_usr_fk` (`usuario_id`),
  KEY `not_usr_not_fk` (`notificacion_id`),
  CONSTRAINT `not_usr_not_fk` FOREIGN KEY (`notificacion_id`) REFERENCES `notificaciones` (`id`),
  CONSTRAINT `not_usr_usr_fk` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `notificacion_usuarios` */

/*Table structure for table `notificaciones` */

DROP TABLE IF EXISTS `notificaciones`;

CREATE TABLE `notificaciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `texto` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_texto` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `notificaciones` */

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `preferencias` */

DROP TABLE IF EXISTS `preferencias`;

CREATE TABLE `preferencias` (
  `usuario_id` int(10) unsigned NOT NULL,
  `estilo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'css/style_blue.css',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  CONSTRAINT `preferencias_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `preferencias` */

insert  into `preferencias`(`usuario_id`,`estilo`,`created_at`,`updated_at`) values 
(1,'css/style_blue.css',NULL,NULL);

/*Table structure for table `producto_precio` */

DROP TABLE IF EXISTS `producto_precio`;

CREATE TABLE `producto_precio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `fecha` datetime NOT NULL,
  `precio` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `producto_precio_producto_id_foreign` (`producto_id`),
  KEY `producto_precio_usuario_id_foreign` (`usuario_id`),
  CONSTRAINT `producto_precio_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `producto_precio_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `producto_precio` */

insert  into `producto_precio`(`id`,`producto_id`,`usuario_id`,`fecha`,`precio`) values 
(1,1,1,'2021-03-15 22:54:27',25000);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_de_barras` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `familiaProducto_id` int(10) unsigned NOT NULL DEFAULT '1',
  `tasa_iva_id` int(10) unsigned NOT NULL DEFAULT '1',
  `stock` int(11) NOT NULL DEFAULT '0',
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio` double NOT NULL DEFAULT '0',
  `stock_minimo_valor` int(11) NOT NULL DEFAULT '0',
  `stock_minimo_notificar` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productos_nombre_unique` (`nombre`),
  UNIQUE KEY `productos_codigo_unique` (`codigo`),
  KEY `productos_codigo_index` (`codigo`),
  KEY `productos_codigo_de_barras_index` (`codigo_de_barras`),
  KEY `productos_familiaproducto_id_foreign` (`familiaProducto_id`),
  KEY `productos_tasa_iva_id_foreign` (`tasa_iva_id`),
  KEY `productos_codigo_codigo_de_barras_nombre_index` (`codigo`,`codigo_de_barras`,`nombre`),
  CONSTRAINT `productos_familiaproducto_id_foreign` FOREIGN KEY (`familiaProducto_id`) REFERENCES `familia_productos` (`id`),
  CONSTRAINT `productos_tasa_iva_id_foreign` FOREIGN KEY (`tasa_iva_id`) REFERENCES `tasas_iva` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `productos` */

insert  into `productos`(`id`,`codigo`,`codigo_de_barras`,`familiaProducto_id`,`tasa_iva_id`,`stock`,`nombre`,`descripcion`,`precio`,`stock_minimo_valor`,`stock_minimo_notificar`,`deleted_at`,`created_at`,`updated_at`) values 
(1,'000',NULL,1,1,1,'test','asdasd',25000,0,0,NULL,'2021-03-15 22:54:27','2021-03-15 22:54:27');

/*Table structure for table `proveedores` */

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rut` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proveedores_rut_unique` (`rut`),
  KEY `proveedores_nombre_rut_index` (`nombre`,`rut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `proveedores` */

/*Table structure for table `recibo_facturas` */

DROP TABLE IF EXISTS `recibo_facturas`;

CREATE TABLE `recibo_facturas` (
  `factura_id` int(10) unsigned NOT NULL,
  `recibo_id` int(10) unsigned NOT NULL,
  `deuda_inicial` double NOT NULL,
  `deuda_final` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `recibo_facturas_factura_id_foreign` (`factura_id`),
  KEY `recibo_facturas_recibo_id_foreign` (`recibo_id`),
  CONSTRAINT `recibo_facturas_factura_id_foreign` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`),
  CONSTRAINT `recibo_facturas_recibo_id_foreign` FOREIGN KEY (`recibo_id`) REFERENCES `recibos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `recibo_facturas` */

/*Table structure for table `recibos` */

DROP TABLE IF EXISTS `recibos`;

CREATE TABLE `recibos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `moneda_id` int(10) unsigned DEFAULT NULL,
  `cotizacion` double NOT NULL DEFAULT '1',
  `concepto` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lugar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto` double NOT NULL,
  `cliente_id` int(10) unsigned DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recibos_usuario_id_foreign` (`usuario_id`),
  KEY `recibos_moneda_id_foreign` (`moneda_id`),
  KEY `recibos_cliente_id_foreign` (`cliente_id`),
  CONSTRAINT `recibos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `recibos_moneda_id_foreign` FOREIGN KEY (`moneda_id`) REFERENCES `monedas` (`id`),
  CONSTRAINT `recibos_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `recibos` */

/*Table structure for table `tasas_iva` */

DROP TABLE IF EXISTS `tasas_iva`;

CREATE TABLE `tasas_iva` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tasa` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tasas_iva` */

insert  into `tasas_iva`(`id`,`nombre`,`tasa`,`created_at`,`updated_at`) values 
(1,'Básica',22,NULL,NULL),
(2,'Mínimo',10,NULL,NULL),
(3,'Exento',0,NULL,NULL);

/*Table structure for table `tipo_comprobantes` */

DROP TABLE IF EXISTS `tipo_comprobantes`;

CREATE TABLE `tipo_comprobantes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tipo_comprobantes` */

insert  into `tipo_comprobantes`(`id`,`created_at`,`updated_at`,`nombre`) values 
(1,NULL,NULL,'Venta al contado'),
(2,NULL,NULL,'Devolución al contado'),
(3,NULL,NULL,'Factura de venta crédito'),
(4,NULL,NULL,'Nota de crédito de venta'),
(5,NULL,NULL,'Compra al contado'),
(6,NULL,NULL,'Recibo de cobro');

/*Table structure for table `tipos_documento` */

DROP TABLE IF EXISTS `tipos_documento`;

CREATE TABLE `tipos_documento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_documento` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `tipos_documento` */

insert  into `tipos_documento`(`id`,`tipo_documento`) values 
(1,'CI'),
(2,'Pasaporte');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`password`,`remember_token`,`created_at`,`updated_at`) values 
(1,'admin','admin','$2y$10$m0eJEnZbs7M13yH7xlY/g.VO0VR9KDv4bk4mqu5L1vXvkWW6Zha6u',NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
