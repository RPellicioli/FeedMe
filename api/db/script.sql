DROP TABLE IF EXISTS `match`;
DROP TABLE IF EXISTS `food`;
DROP TABLE IF EXISTS `schedule`;
DROP TABLE IF EXISTS `restaurant`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `restaurant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cnpj` bigint(11) NOT NULL,
  `cep` bigint(11) NOT NULL,
  `number` int(11) NOT NULL,
  `street` varchar(255) NOT NULL,
  `complement` varchar(255) NOT NULL,
  `neighborhood` varchar(255) NOT NULL,
  `latitude` float(10,6) NOT NULL,
  `longitude` float(10,6) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`),
   UNIQUE KEY `userId` (`userId`),
   CONSTRAINT `fk_r_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurantId` int(11) NOT NULL,
  `day` int(11),
  `initialHour` TIME NOT NULL,
  `finalHour` TIME NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_s_restaurant` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurantId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `price` float(10,2) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `active` tinyint(1) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_d_restaurant` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `foodId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `foodId` (`foodId`),
  CONSTRAINT `fk_u_match` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_f_match` FOREIGN KEY (`foodId`) REFERENCES `food` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user(`name`, `email`, `password`, `admin`, `created`, `updated`)
       VALUES ('Ricardo Pellicioli', 'pellicioli_r@hotmail.com', '12345', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `admin`, `created`, `updated`)
       VALUES ('Teste', 'teste@teste.com', 'teste', 0, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `admin`, `created`, `updated`)
       VALUES ('Mafacioli', 'mafacioli@teste.com', 'teste', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `admin`, `created`, `updated`)
       VALUES ('Pernambuco', 'pernambuco@teste.com', 'teste', 1, CURRENT_TIME(), CURRENT_TIME());
   
INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (1, 'Di paollo', 032526552000102, 95110022, 11, 'Luiz Cavion', 'Casa', 'Desvio Rizzo', -29.1957253, -51.2361348, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());   

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (3, 'Mafacioli', 032526552000102, 95110160, 515, 'Bom Princípio', 'Casa', 'Desvio Rizzo', -29.1975933, -51.2409512, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME()); 

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (4, 'Pernambuco', 032526552000102, 95110160, 515, 'Bom Princípio', 'Casa', 'Desvio Rizzo', -8.0848541, -34.9157048, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME()); 

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (1, 'Camarão à milanesa', 'https://img-global.cpcdn.com/recipes/dcfc63b78d267dbf/751x532cq70/foto-principal-da-receita-camarao-a-milanesa.jpg', 66.00, 'Prato bem bom feito com camarão', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (1, 'Vatapá', 'https://cdn.panelinha.com.br/receita/1399345200000-Vatapa-baiano.jpg', 66.00, 'Prato bem bom feito com camarão', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO `match`(`userId`, `foodId`)
       VALUES (2, 1);

INSERT INTO `match`(`userId`, `foodId`)
       VALUES (2, 2);