CREATE TABLE `user` (
	`id` int NOT NULL AUTO_INCREMENT,
	`role` int NOT NULL,
	`country_id` int NOT NULL,
	`name` varchar(200) NOT NULL,
	`email` varchar(200) NOT NULL,
	`password` varchar(250) NOT NULL,
	`created` TIMESTAMP NOT NULL,
	`updated` TIMESTAMP,
	`deleted` TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `role` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(10) NOT NULL UNIQUE,
	`created` TIMESTAMP NOT NULL,
	`updated` TIMESTAMP,
	`deleted` TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `recommendation` (
	`id` int NOT NULL AUTO_INCREMENT,
	`user_id` int NOT NULL,
	`mood` varchar(50) NOT NULL,
	`song_name` varchar(200) NOT NULL,
	`song_artist` varchar(200) NOT NULL,
	`song_album` varchar(200) NOT NULL,
	`song_link` varchar(150) NOT NULL,
	`song_img` varchar(200) NOT NULL,
	`created` TIMESTAMP NOT NULL,
	`updated` TIMESTAMP,
	`deleted` TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE `country` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(150) NOT NULL UNIQUE,
	`created` TIMESTAMP NOT NULL,
	`updated` TIMESTAMP,
	`deleted` TIMESTAMP,
	PRIMARY KEY (`id`)
);

ALTER TABLE `user` ADD CONSTRAINT `user_fk0` FOREIGN KEY (`role`) REFERENCES `role`(`id`);

ALTER TABLE `user` ADD CONSTRAINT `user_fk1` FOREIGN KEY (`country_id`) REFERENCES `country`(`id`);

ALTER TABLE `recommendation` ADD CONSTRAINT `recommendation_fk0` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);







