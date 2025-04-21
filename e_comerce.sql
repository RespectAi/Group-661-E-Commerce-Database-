CREATE DATABASE e_commerce;
USE e_commerce;

-- 1. Brand 
CREATE TABLE brand (
  brand_id           INT AUTO_INCREMENT PRIMARY KEY,
  name               VARCHAR(255) NOT NULL,
  logo_url           VARCHAR(255),
  description        TEXT
);

-- 2. Product Categories
CREATE TABLE product_category (
  category_id        INT AUTO_INCREMENT PRIMARY KEY,
  category_name      VARCHAR(255) NOT NULL,
  description        TEXT 
);

-- 3. Products
CREATE TABLE product (
  product_id         INT AUTO_INCREMENT PRIMARY KEY,
  brand_id           INT         NOT NULL,
  category_id        INT,
  product_name       VARCHAR(255) NOT NULL,
  base_price         DECIMAL(10,2) NOT NULL,
  description        TEXT,
  FOREIGN KEY (brand_id)    REFERENCES brand(brand_id),
  FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 4. Product Images
CREATE TABLE product_image (
  image_id           INT AUTO_INCREMENT PRIMARY KEY,
  product_id         INT         NOT NULL,
  image_url          VARCHAR(2048) NOT NULL,
  alt_text           VARCHAR(255),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
) ENGINE=InnoDB;

-- 5. Colors
CREATE TABLE color (
  color_id           INT AUTO_INCREMENT PRIMARY KEY,
  color_name         VARCHAR(50) NOT NULL,
  hex_code           CHAR(7) -- e.g. '#FF5733'
);

-- 6. Size Categories
CREATE TABLE size_category (
  size_category_id         INT AUTO_INCREMENT PRIMARY KEY,
  size_category_name       VARCHAR(100) NOT NULL-- e.g. 'Clothing Sizes', 'Shoe Sizes'
) ;

-- 7. Size Options
CREATE TABLE size_option (
  size_option_id     INT AUTO_INCREMENT PRIMARY KEY,
  size_category_id   INT         NOT NULL,
  label              VARCHAR(50) NOT NULL,  -- e.g. 'S', 'M', 'L',
  FOREIGN KEY (size_category_id)
  REFERENCES size_category(size_category_id)
);

-- 8. Product Variations
--    (one row per combination of product + color + size)
CREATE TABLE product_variation (
  variation_id       INT AUTO_INCREMENT PRIMARY KEY,
  product_id         INT         NOT NULL,
  color_id           INT,
  size_option_id     INT,
  FOREIGN KEY (product_id)
  REFERENCES product(product_id),
  FOREIGN KEY (color_id)
  REFERENCES color(color_id),
  FOREIGN KEY (size_option_id)
  REFERENCES size_option(size_option_id)
);

-- 9. Product Items
CREATE TABLE product_item (
  item_id            INT AUTO_INCREMENT PRIMARY KEY,
  variation_id       INT         NOT NULL,
  sku                VARCHAR(100) NOT NULL UNIQUE,
  price              DECIMAL(10,2),         -- overrides base_price if set
  stock_quantity     INT        DEFAULT 0,
  FOREIGN KEY (variation_id)
  REFERENCES product_variation(variation_id)
);

-- 10. Attribute Categories
CREATE TABLE attribute_category (
  attribute_category_id        INT AUTO_INCREMENT PRIMARY KEY,
  attribute_name               VARCHAR(100) NOT NULL,  -- e.g. 'Physical', 'Technical'
  description           TEXT
);

-- 11. Attribute Types
CREATE TABLE attribute_type (
  attribute_type_id           INT AUTO_INCREMENT PRIMARY KEY,
  attribute_type_name         VARCHAR(50) NOT NULL -- e.g. 'Text', 'Number', 'Boolean'
);

-- 12. Product Attributes
CREATE TABLE product_attribute (
  attribute_id          INT AUTO_INCREMENT PRIMARY KEY,
  product_id            INT         NOT NULL,
  attribute_category_id INT,
  attribute_type_id     INT,
  attribute_name        VARCHAR(100) NOT NULL,   -- e.g. 'Material', 'Weight'
  attribute_value       VARCHAR(255),                  
  FOREIGN KEY (product_id)
  REFERENCES product(product_id),
  FOREIGN KEY (attribute_category_id)
  REFERENCES attribute_category(attribute_category_id),
  FOREIGN KEY (attribute_type_id)
  REFERENCES attribute_type(attribute_type_id)
);
