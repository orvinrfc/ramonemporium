DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,
    shipmentDesc        VARCHAR(100),
    warehouseId         INT,
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory (
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),
    PRIMARY KEY (productId, warehouseId),
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Religious');
INSERT INTO category(categoryName) VALUES ('Hero/Villain');
INSERT INTO category(categoryName) VALUES ('Fantasy');
INSERT INTO category(categoryName) VALUES ('Sci-Fi');
INSERT INTO category(categoryName) VALUES ('Pop Culture');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Holy Ramon', 1, 'The Messiah, Ramon',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Super Ramon',2,'UBC''s Resident Superhero',34.90);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Evil Ramon',2,'When A Hero Goes Bad',24.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shramonek',3,'GET OUT OF MAH BREAKOUT ROOM',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pepe Ramon',5,'A Very Rare Ramon',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Santa Ramon',5,'A Very Merry Prof',36.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bob Ramon',5,'A Happy Little Database',33.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Yoda Ramon',4,'This Is The Way',25.80);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Teletubby Ramon',5,'A Magical Event',28.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Undead Ramon',4,'Sometimes, A Good Prof Doesn''t Die',36.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('WINSTON',5,'A Good Boy!',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mecha Ramon',4,'Ready To Save The World!',42.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Solid Ramon',4,'Kept you waiting, huh?',36.80);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Senator Ramonstrong',4,'Databases, Son.',69.42);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Data Slayer',5,'Slice and Delete.',66.66);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('The Databorn',5,'Fus Ro Dah-tabase',29.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Database Souls 3',5,'And so it is that Database seeketh Data...',69.42);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Holy Ramon - Bobblehead',1,'Bobblehead Version of Holy Ramon Poster',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Super Ramon - Bobblehead',2,'Bobblehead Version of Super Ramon Poster',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Evil Ramon - Bobblehead',2,'Bobblehead Version of Evil Ramon Poster',12.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shramonek - Bobblehead',3,'Bobblehead Version of Shramonek Poster',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pepe Ramon - Bobblehead',5,'Bobblehead Version of Pepe Ramon Poster',9.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Santa Ramon - Bobblehead',5,'Bobblehead Version of Santa Ramon Poster',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bob Ramon - Bobblehead',5,'Bobblehead Version of Bob Ramon Poster',16.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Yoda Ramon - Bobblehead',4,'Bobblehead Version of Yoda Ramon Poster',12.90);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Teletubby Ramon - Bobblehead',5,'Bobblehead Version of Teletubby Ramon Poster',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Undead Ramon - Bobblehead',4,'Bobblehead Version of Undead Ramon Poster',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mecha Ramon - Bobblehead',4,'Bobblehead Version of Mecha Ramon Poster',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Solid Ramon - Bobblehead',4,'Bobblehead Version of Solid Ramon Poster',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Senator Ramonstrong - Bobblehead',4,'Bobblehead Version of Senator Ramonstrong Poster',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Data Slayer - Bobblehead',5,'Bobblehead Version of Data Slayer Poster',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('The Databorn - Bobblehead',5,'Bobblehead Version of The Databorn Poster',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Database Souls 3 - Bobblehead',5,'Bobblehead Version of Database Souls 3 Poster',18.40);


INSERT INTO warehouse(warehouseName) VALUES ('Main Warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 34.90);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 24);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 18.40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 36);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 33);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 25.80);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 28);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 36);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 103.80)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 31)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 18.40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 36);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 92)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 18.40);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 171)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 36)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 33);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 283.80)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 24)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 25.80)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 36.80);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 159.10)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 18.40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 16.50);

UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.jpg' WHERE ProductId = 17;

DECLARE @reviewId int
INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (5, '2019-08-12', 2, 3, 'This product has helped me through some hard times. Digging into the deeper meaning of the product, I think it represents that even role models and important figures in our day to day lives can turn to the dark side even momentarily. This is a very humbling product, and it has helped me feel like my personal and career goals are more attainable. Thank you Ramon Emporium, for all that you do.');
INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (5, '2020-10-20', 1, 8, 'Code Databases I must. Hmmm... be very successful you will');
INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (5, '2020-11-21', 4, 20, 'Look around. Look at what we have. Databases are everywhere — you only have to look to see it. - Bob Ramon');
