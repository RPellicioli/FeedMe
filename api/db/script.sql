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
  `km` float(10,2) NOT NULL,
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

/* USUÁRIOS.*/

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Ricardo Pellicioli', 'pellicioli_r@hotmail.com', '12345', 6, 0, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Di Paollo', 'dipaollo@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Mafacioli', 'mafacioli@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Bargaço', 'bargaco@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Andréa', 'andrea@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Milano', 'milano@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Lunelli', 'lunelli@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Imperador', 'imperador@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Bode', 'bode@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());


INSERT INTO user(`name`, `email`, `password`, `km`, `admin`, `created`, `updated`)
       VALUES ('Parraxaxá', 'parraxaxa@teste.com', 'teste', 10, 1, CURRENT_TIME(), CURRENT_TIME());


/* RESTAURANTES.*/
   
INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (2, 'Di paollo', 032526552000102, 95020472, 454, 'R. Os Dezoito do Forte', '', 'Nossa Sra. de Lourdes', -29.1705152, -51.1677946, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());   

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (3, 'Mafacioli', 032526552000102, 95110160, 515, 'Bom Princípio', '', 'Desvio Rizzo', -29.1975933, -51.2409512, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME()); 

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (4, 'Bargaço', 032526552000102, 51011000, 62, 'Av. Antônio de Goes', '', 'Pina', -8.0911981, -34.8842011, 'Recife', 'PE', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (5, 'Restaurante Andréa', 032526552000102, 95034120, 85, 'Marcos Moreschi', '', 'Pio X', -29.160839, -51.1874057, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (6, 'Restaurante Milano', 032526552000102, 95010000, 3135, 'Av. Júlio de Castilhos', '', 'São Pelegrino', -29.1678941, -51.1964756, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (7, 'Cantina Lunelli', 032526552000102, 95010000, 115, 'BR-116, KM 156', '', 'São Pelegrino', -29.2079859, -51.1802385, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (8, 'Churrascaria Imperador', 032526552000102, 95010000, 3107, 'Av. Júlio de Castilhos', '', 'São Pelegrino', -29.1679518, -51.195891, 'Caxias do Sul', 'RS', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (9, 'Bode do Nô', 032526552000102, 51021090, 3107, 'Dr. João Guilherme Pontes Sobrinho', '', 'Boa Viagem', -8.1244461, -34.906538, 'Recefi', 'PE', CURRENT_TIME(), CURRENT_TIME());

INSERT INTO restaurant(`userId`, `name`, `cnpj`, `cep`, `number`, `street`, `complement`, `neighborhood`, `latitude`, `longitude`, `city`, `state`, `created`, `updated`)
       VALUES (10, 'Parraxaxá', 032526552000102, 51021060, 1200, 'Av. Fernando Simões Barbosa', '', 'Boa Viagem', -8.128052, -34.9043876, 'Recefi', 'PE', CURRENT_TIME(), CURRENT_TIME());


/* PRATOS.*/

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (3, 'Camarão à milanesa', 'https://img-global.cpcdn.com/recipes/dcfc63b78d267dbf/751x532cq70/foto-principal-da-receita-camarao-a-milanesa.jpg', 36.00, 'Camarão banhado na farinha de rosca temperada.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (3, 'Vatapá', 'https://cdn.panelinha.com.br/receita/1399345200000-Vatapa-baiano.jpg', 66.00, 'Vatapá é um prato típico da culinária afro-brasileira. O seu preparo inclui farinha de rosca, fubá, gengibre, pimenta-malagueta, amendoim, cravo, castanha de caju, leite desnatado, azeite de oliva, cebola, alho e tomate. Com camarões frescos inteiros.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (2, 'Pizza Nona Itália', 'https://s2.glbimg.com/uBheAzFpL2wQDN89HUgI1fyv-cg=/696x390/smart/filters:cover():strip_icc()/s.glbimg.com/po/rc/media/2012/06/13/15/30/58/110/ppp.jpg', 45.00, 'A melhor pizza de Caxias do Sul feita com presunto, tomate, cebola, azeitona preta, mussarela e manjeiricão.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (1, 'Massa tomate seco', 'https://i.ytimg.com/vi/ZDEp_wQuZzk/maxresdefault.jpg', 45.00, 'O molho da massa é feito com os melhores tomates da região Pomarola com um leve sabor de pimenta preta.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (1, 'Sopa de Agnolini', 'https://2.bp.blogspot.com/-Z64VcQ6K22g/WOlwpFrkgeI/AAAAAAAAWTw/Icna9pkmO4AhwqlKQTdkNqaXCA3GtZT9QCEw/s1600/Garibaldi-59.jpg', 22.00, 'A tradicional sopa da serra gaúcha. Com um sabor irrestível.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (2, 'Tortéi', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwTq_WWTPQ5XRjp215MEW--cBwG8nVZb9QnQ&usqp=CAU', 18.00, 'Típico da culinária italiana, o Tortei de Moranga Papito surgiu na região da Lombardia e apresenta forma semelhante a um pequeno pastel. Com recheio abundante e sabor inconfundível, é ideal para ser servido com molho vermelho e queijo mussarela e, é claro, sempre acompanhado de um bom vinho.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (1, 'Massa ao pesto', 'https://www.comidaereceitas.com.br/wp-content/uploads/2019/02/espaguete_abobrinha.jpg', 25.00, 'Pesto é um molho italiano, originário de Gênova, na Ligúria, norte da Itália. É composto tradicionalmente de folhas de manjericão moídas com pinhões (pinoli) de Pinus pinea, alho e sal, queijo parmesão ou pecorino ralados e no fim misturados com azeite extra virgem e temperado com pimenta preta.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (4, 'Bife à Felipão', 'https://www.rbsdirect.com.br/imagesrc/25683653.jpg?w=700', 95.00, 'Bife autentico. Vêm acompanhado de polenta mole, batata frita, spaghetti com molho, tortéi e radicci com bacon.', 1, CURRENT_TIME(), CURRENT_TIME());  

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (4, 'File com molho da casa', 'https://static-images.ifood.com.br/image/upload/t_high/pratos/473cb364-d989-4b67-bb0a-d2bbab61d864/202004081625_7PES_2.jpg', 105.00, 'File com molho da casa, palmito, aspargos e queijo. O Filé acompanha massa, polenta mole, radicci e tortei.', 1, CURRENT_TIME(), CURRENT_TIME());  

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (5, 'Bife à Parmegiana', 'https://amp.receitadevovo.com.br/wp-content/uploads/2020/10/bife-a-parmegiana.jpg', 38.00, 'Um prato brasileiro, composto por um pedaço de carne fatiado, empanado com farinha de trigo e ovos (clara de ovo), coberto com queijo do tipo parmesão, presunto e bastante molho de tomate e condimentos como orégano e coentro.', 1, CURRENT_TIME(), CURRENT_TIME());  

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (6, 'Carbonara', 'https://static-images.ifood.com.br/image/upload/t_high/pratos/bf37ce34-907d-4cf3-a16f-723a2fc82789/202003071549_1W4B_c.jpg', 33.00, 'é uma receita tradicional italiana de massa. O seu nome é derivado da palavra italiana carbone, que significa carvão. É preparada com ovos, queijo parmesão, queijo pecorino romano, toucinho, pimenta preta e banha, azeite.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (6, 'Omelete com Salame', 'https://static-images.ifood.com.br/image/upload/t_high/pratos/bf37ce34-907d-4cf3-a16f-723a2fc82789/202003071350_Uz1L_.jpeg', 29.00, 'Omelete com salame, acompanhado de polenta brustolada e salada de radite com bacon.', 1, CURRENT_TIME(), CURRENT_TIME());   

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (7, 'Espeto corrido', 'https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000i2EBoMAM/5b31184de4b0d69d2105eafb.jpg&w=710&h=462 ', 89.00, 'Espeto corrido com as mais conceituadas carnes.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (8, 'Filé de peixe com camarão', 'https://www.comidaereceitas.com.br/wp-content/uploads/2010/05/file_peixe_camarao.jpg', 130.00, 'Filé de peixe com camarão ao molho branco.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (8, 'Tambaqui na folha de bananeira', 'https://media-cdn.tripadvisor.com/media/photo-s/0d/a8/37/31/tambaqui-assado-na-folha.jpg', 99.00, 'Tambaqui assado na folha de bananeira, acompanhado de legumes.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (9, 'Escondidinho de Charque', 'https://img.itdg.com.br/tdg/images/recipes/000/141/866/324056/324056_original.jpg?mode=crop&width=710&height=400', 37.50, 'Escondidinho de batata recheado com charque.', 1, CURRENT_TIME(), CURRENT_TIME());

INSERT INTO food(`restaurantId`, `name`, `image`, `price`, `description`, `active`, `created`, `updated`)
       VALUES (9, 'Carne de Sol', 'https://cdn.panelinha.com.br/receita/1554131690755-CP-2019-01-03_11389.jpg', 54.00, 'Ela é curtida com esse tempero no sol por alguns dias e com isso não precisa de mais nada além de ser frita numa frigideria, assada numa chapa ou até numa churrasqueira.', 1, CURRENT_TIME(), CURRENT_TIME());

/* MATCHS.*/

INSERT INTO `match`(`userId`, `foodId`)
       VALUES (1, 3);

INSERT INTO `match`(`userId`, `foodId`)
       VALUES (1, 4);