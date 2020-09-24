CREATE TABLE `users` (
`user_id` INT NOT NULL AUTO_INCREMENT,
`user_name` VARCHAR(255) NOT NULL,
`phone_number` VARCHAR(255) NOT NULL,
`email` VARCHAR(255) NOT NULL,
PRIMARY KEY (`user_id`)
)

COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;

CREATE TABLE `payments` (
`payment_id` INT NOT NULL AUTO_INCREMENT,
`user_id` INT,
`pay_date` TIMESTAMP NOT NULL,
`credit` INT NOT NULL,
PRIMARY KEY (`payment_id`),
FOREIGN KEY (`user_id`) REFERENCES users (`user_id`)
)

COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;

CREATE TABLE `servers` (
`server_id` INT NOT NULL AUTO_INCREMENT,
`bandwidth` real NOT NULL,
`disk` INT NOT NULL,
`ram` INT NOT NULL,
`cpu` INT NOT NULL,
`category` VARCHAR(255) NOT NULL,
`crashed` BOOLEAN NOT NULL DEFAULT FALSE,
PRIMARY KEY (`server_id`)
)

COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;

CREATE TABLE `orders` (
`order_id` INT NOT NULL AUTO_INCREMENT,
`user_id` INT,
`server_id` INT,
`start_date` TIMESTAMP NOT NULL,
`end_date` TIMESTAMP NOT NULL,
`cpu_requested` INT NOT NULL,
`ram_requested` INT NOT NULL,
`disk_requested` INT NOT NULL,
`bandwidth_requested` real NOT NULL,
PRIMARY KEY (`order_id`),
FOREIGN KEY (`user_id`) REFERENCES users(`user_id`),
FOREIGN KEY (`server_id`) REFERENCES servers(`server_id`)
)

COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;

CREATE TABLE `sessions` (
`user_id` INT,
`info` JSON NOT NULL,
FOREIGN KEY (`user_id`) REFERENCES users(`user_id`)
)

COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;

