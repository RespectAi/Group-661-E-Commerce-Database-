-- Creating an E-commerce Database
CREATE DATABASE e_commerce;
-- Using the e_commerce database
USE e_commerce;

-- 1. Brand 
CREATE TABLE brand (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  logo_url VARCHAR(255),
  description TEXT
);

-- 2. Product Categories
CREATE TABLE product_category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  description TEXT 
);

-- 3. Products
CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  brand_id INT NOT NULL,
  category_id INT,
  product_name VARCHAR(255) NOT NULL,
  base_price DECIMAL(10,2) NOT NULL,
  description TEXT,
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
  FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 4. Product Images
CREATE TABLE product_image (
  image_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  image_url VARCHAR(2048) NOT NULL,
  alt_text VARCHAR(255),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 5. Colors
CREATE TABLE color (
  color_id INT AUTO_INCREMENT PRIMARY KEY,
  color_name VARCHAR(50) NOT NULL,
  hex_code CHAR(7) -- e.g. '#FF5733'
);

-- 6. Size Categories
CREATE TABLE size_category (
  size_category_id INT AUTO_INCREMENT PRIMARY KEY,
  size_category_name VARCHAR(100) NOT NULL-- e.g. 'Clothing Sizes', 'Shoe Sizes'
);

-- 7. Size Options
CREATE TABLE size_option (
  size_option_id INT AUTO_INCREMENT PRIMARY KEY,
  size_category_id INT NOT NULL,
  label VARCHAR(50) NOT NULL,  -- e.g. 'S', 'M', 'L',
  FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- 8. Product Variations
--    (one row per combination of product + color + size)
CREATE TABLE product_variation (
  variation_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  color_id INT,
  size_option_id INT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (color_id) REFERENCES color(color_id),
  FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- 9. Product Items
CREATE TABLE product_item (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  variation_id INT NOT NULL,
  sku VARCHAR(100) NOT NULL UNIQUE,
  price DECIMAL(10,2),    -- overrides base_price if set
  stock_quantity INT DEFAULT 0,
  FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

-- 10. Attribute Categories
CREATE TABLE attribute_category (
  attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
  attribute_name VARCHAR(100) NOT NULL,  -- e.g. 'Physical', 'Technical'
  description  TEXT
);

-- 11. Attribute Types
CREATE TABLE attribute_type (
  attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
  attribute_type_name VARCHAR(50) NOT NULL -- e.g. 'Text', 'Number', 'Boolean'
);

-- 12. Product Attributes
CREATE TABLE product_attribute (
  attribute_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  attribute_category_id INT,
  attribute_type_id INT,
  attribute_name VARCHAR(100) NOT NULL,   -- e.g. 'Material', 'Weight'
  attribute_value VARCHAR(255),                  
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
  FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- INSERT statements
INSERT INTO brand (name, logo_url, description) VALUES
  ('Nike',    'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg',    'Sportswear and footwear'),
  ('Apple',   'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg',  'Consumer electronics and software'),
  ('Adidas',  'https://upload.wikimedia.org/wikipedia/commons/2/20/Adidas_Logo.svg',  'Athletic apparel and footwear'),
  ('Sony',    'https://upload.wikimedia.org/wikipedia/commons/2/25/Sony_Logo.svg',    'Electronics and entertainment'),
  ('Samsung', 'https://upload.wikimedia.org/wikipedia/commons/2/24/Samsung_Logo.svg', 'Electronics and home appliances'),
  ('Dell',    'https://upload.wikimedia.org/wikipedia/commons/4/48/Dell_Logo.svg',    'Computers and technology'),
  ('HP',      'https://upload.wikimedia.org/wikipedia/commons/3/3a/HP_logo_2012.svg','Personal computing and printing'),
  ('Puma',    'https://upload.wikimedia.org/wikipedia/commons/f/f7/Puma_AG.svg',     'Sport lifestyle products'),
  ('Lenovo',  'https://upload.wikimedia.org/wikipedia/commons/1/12/Lenovo_logo.svg', 'PCs and smart devices'),
  ('LG',      'https://upload.wikimedia.org/wikipedia/commons/9/95/LG_logo_%282015%29.svg', 'Electronics and appliances');


INSERT INTO product_category (category_name, description) VALUES
('Clothing', 'Fashion and apparel'),
('Electronics', 'Devices and gadgets'),
('Footwear', 'Shoes and sneakers'),
('Accessories', 'Wearable extras'),
('Home Appliances', 'Electronics for home use'),
('Computers', 'Desktops and laptops'),
('Mobile Phones', 'Smartphones and accessories'),
('Gaming', 'Consoles and games'),
('Furniture', 'Home and office furniture'),
('Kitchen', 'Cooking appliances and tools');

INSERT INTO color (color_name, hex_code) VALUES
('Red', '#FF0000'),
('Green', '#00FF00'),
('Blue', '#0000FF'),
('Black', '#000000'),
('White', '#FFFFFF'),
('Yellow', '#FFFF00'),
('Purple', '#800080'),
('Orange', '#FFA500'),
('Grey', '#808080'),
('Brown', '#A52A2A');

INSERT INTO size_category (size_category_name) VALUES
('Clothing Sizes'),
('Shoe Sizes'),
('Pant Sizes'),
('Shirt Sizes'),
('Laptop Sizes'),
('TV Sizes'),
('Phone Sizes'),
('Ring Sizes'),
('Watch Sizes'),
('Hat Sizes');

INSERT INTO size_option (size_category_id, label) VALUES
(1, 'XS'),
(2, 'S'),
(3, 'M'),
(4, 'L'),
(5, 'XL'),
(6, 'XXL');

INSERT INTO product (product_name, brand_id, category_id, base_price, description) VALUES
('Air Max Sneakers', 1, 3, 120.00, 'Comfortable and stylish running shoes'),
('iPhone 14', 2, 7, 999.99, 'Latest Apple smartphone with advanced features'),
('Ultraboost Shoes', 3, 3, 150.00, 'High-performance running shoes'),
('PlayStation 5', 4, 8, 499.99, 'Next-gen gaming console from Sony'),
('Galaxy S22', 5, 7, 899.99, 'Flagship Samsung smartphone'),
('XPS 13 Laptop', 6, 6, 1099.99, 'Compact and powerful laptop from Dell'),
('Envy Printer', 7, 6, 149.99, 'HP wireless printer'),
('Running T-Shirt', 8, 1, 29.99, 'Breathable sportswear from Puma'),
('ThinkPad X1', 9, 6, 1249.99, 'Business-class laptop from Lenovo'),
('Smart Fridge', 10, 5, 1999.99, 'Wi-Fi enabled fridge from LG');

INSERT INTO product_image (product_id, image_url, alt_text) VALUES
  (1, 'https://upload.wikimedia.org/wikipedia/commons/3/36/Nike_Air_Max_1.png', 'Air Max Sneakers'),  
  (2, 'https://upload.wikimedia.org/wikipedia/commons/6/61/IPhone_14_vector.svg', 'iPhone 14'),         
  (3, 'https://upload.wikimedia.org/wikipedia/commons/5/5a/Adidas_Ultra_Boost_4_running_shoes.jpeg', 'Ultraboost Shoes'),  
  (4, 'https://upload.wikimedia.org/wikipedia/commons/7/7a/PlayStation_5_and_DualSense.jpg', 'PlayStation 5'),         
  (5, 'https://upload.wikimedia.org/wikipedia/commons/c/c6/SamsungGalaxyS22.png', 'Galaxy S22'),                      
  (6, 'https://upload.wikimedia.org/wikipedia/commons/4/49/Dell_XPS_13_9350_and_9300.jpg', 'XPS 13 Laptop'),           
  (7, 'https://upload.wikimedia.org/wikipedia/commons/9/90/HP_ENVY_4500.png', 'Envy Printer'),                       
  (8, 'https://us.puma.com/us/en/pd/run-velocity-mens-tri-blend-running-tee/526603', 'Running T-Shirt'),              
  (9, 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Lenovo_ThinkPad_X1_Carbon_Ultrabook.jpg', 'ThinkPad X1'),  
  (10, 'https://upload.wikimedia.org/wikipedia/commons/6/6c/LG_Smart_Refrigerator_at_CES_2011.jpg', 'Smart Fridge');  


INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 1),
(8, 8, 5),
(9, 9, 3),
(10, 10, 2);

INSERT INTO product_item (variation_id, sku, price, stock_quantity) VALUES
(1, 'SKU1000', 109.00, 94),
(2, 'SKU1001', 998.99, 37),
(3, 'SKU1002', 140.00, 31),
(4, 'SKU1003', 493.99, 47),
(5, 'SKU1004', 912.99, 33),
(6, 'SKU1005', 1089.99, 93),
(7, 'SKU1006', 134.99, 38),
(8, 'SKU1007', 24.99, 46),
(9, 'SKU1008', 1256.99, 55),
(10, 'SKU1009', 1999.99, 94);

INSERT INTO attribute_category (attribute_name, description) VALUES
('Physical', 'Physical characteristics'),
('Technical', 'Technical specifications'),
('Environmental', 'Eco-friendly properties'),
('Design', 'Design elements'),
('Functional', 'Functionality attributes'),
('Performance', 'Performance metrics'),
('Material', 'Material composition'),
('Warranty', 'Warranty info'),
('Color', 'Color information'),
('Dimension', 'Size and dimensions');

INSERT INTO attribute_type (attribute_type_name) VALUES
('Text'),
('Number'),
('Boolean'),
('Date'),
('Image'),
('Video'),
('Audio'),
('File'),
('Link'),
('Code');

INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES
(1, 1, 1, 'Attribute 1', 'Value 1'),
(2, 2, 2, 'Attribute 2', 'Value 2'),
(3, 3, 3, 'Attribute 3', 'Value 3'),
(4, 4, 4, 'Attribute 4', 'Value 4'),
(5, 5, 5, 'Attribute 5', 'Value 5'),
(6, 6, 6, 'Attribute 6', 'Value 6'),
(7, 7, 7, 'Attribute 7', 'Value 7'),
(8, 8, 8, 'Attribute 8', 'Value 8'),
(9, 9, 9, 'Attribute 9', 'Value 9'),
(10, 10, 10, 'Attribute 10', 'Value 10');


