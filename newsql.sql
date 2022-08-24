CREATE TABLE IF NOT EXISTS ecommerce.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE IF NOT EXISTS ecommerce.discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecommerce.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `ecommerce`.`product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE IF NOT EXISTS ecommerce.product_info
(
    product_id character varying(255)  NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    product_description character varying(255) ,
    product_icon character varying(255) ,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE IF NOT EXISTS ecommerce.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `ecommerce`.`users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `ecommerce`.`order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES ecommerce.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES ecommerce.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE IF NOT EXISTS ecommerce.wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES ecommerce.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES ecommerce.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `ecommerce`.`discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `ecommerce`.`discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `ecommerce`.`users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `ecommerce`.`discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `ecommerce`.`discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `ecommerce`.`discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



INSERT INTO ecommerce.product_category VALUES (2147483641, 'Furnitures', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483642, 'Garden & Outdoor', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483643, 'Wall Decorations', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483644, 'Lightings', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');



INSERT INTO ecommerce.users VALUES (2147483645, true, 'KukatPally Phase 19, Hyderabad', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




