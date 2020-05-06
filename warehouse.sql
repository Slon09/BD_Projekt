DROP TABLE "Employees" CASCADE CONSTRAINTS;
DROP TABLE "Ordered_products" CASCADE CONSTRAINTS;
DROP TABLE "Orders" CASCADE CONSTRAINTS;
DROP TABLE "Products" CASCADE CONSTRAINTS;
DROP TABLE "Shops" CASCADE CONSTRAINTS;

create table "Employees"
(
    "Employee_id"      NUMBER       not null
        constraint EMPLOYEES_PK
            primary key,
    "First_name"       VARCHAR2(32),
    "Last_name"        VARCHAR2(32) not null,
    "Completed_orders" NUMBER default 0,
    "Salary"           NUMBER(6, 2) not null
);

create table "Shops"
(
    "Shop_id" NUMBER       not null
        constraint SHOPS_PK
            primary key,
    "Address" VARCHAR2(64) not null,
    "Name"    VARCHAR2(64) not null
);

create table "Orders"
(
    "Order_id"    NUMBER                         not null
        constraint ORDERS_PK
            primary key,
    "Shop_id"     NUMBER                         not null
        constraint ORDERS_SHOPS_SHOP_ID_FK
            references "Shops",
    "Employee_id" NUMBER       default NULL
        constraint ORDERS_EMPLOYEES_EMPLOYEE_ID_FK
            references "Employees",
    "Status"      VARCHAR2(11) default 'Waiting' not null
        check ( "Status" IN ('Waiting', 'In progress', 'Completed', 'Cancelled') )
);

create table "Products"
(
    "Product_id" NUMBER       not null
        constraint PRODUCTS_PK
            primary key,
    "Name"       VARCHAR2(64) not null,
    "Count"      NUMBER       not null
);

create table "Ordered_products"
(
    "Ordered_product_id" NUMBER not null
        constraint ORDERED_PRODUCTS_PK
            primary key,
    "Order_id"           NUMBER not null
        constraint ORDERED_PRODUCTS_ORDERS_ORDER_ID_FK
            references "Orders"
                on delete cascade,
    "Product_id"         NUMBER not null
        constraint ORDERED_PRODUCTS_PRODUCTS_PRODUCT_ID_FK
            references "Products"
                on delete cascade,
    "Count"              NUMBER not null
);



INSERT INTO "Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (1, 'Sebastian', 'Słoniewski', 1000);
INSERT INTO "Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (2, 'Dominik','Bartkowski', 5000);
INSERT INTO "Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (3, 'Szymon','Porzeziński', 3000);
COMMIT;

INSERT INTO "Shops"
VALUES (1, 'Wybrzeże Wyspiańskiego 27, Wrocław', 'Politechnika Wrocławska');
INSERT INTO "Shops"
VALUES (2, 'Dworcowa 32, Wrocław', 'McDonalds');
INSERT INTO "Shops"
VALUES (3, 'Bierutowska 4, Wrocław', 'Lidl');
INSERT INTO "Shops"
VALUES (4, 'Krzywoustego 322, Wrocław', 'Poczta Polska UP 14');
INSERT INTO "Shops"
VALUES (5, 'Skłodowskiej-Curie 23, Wrocław', 'Panda Ramen');
COMMIT;

INSERT INTO "Orders"
VALUES (1, 1, 1, 'In progress');
INSERT INTO "Orders"
VALUES( 2, 3, NULL, 'Waiting');
INSERT INTO "Orders"
VALUES (3, 5, 2, 'Completed');
INSERT INTO "Orders"
VALUES (4, 4, 3, 'Cancelled');

INSERT INTO "Products"
VALUES (1, 'Mąka "Stary młyn" 1kg', 2000);
INSERT INTO "Products"
VALUES (2, 'Sól "Wieliczka" 1kg', 1000);
INSERT INTO "Products"
VALUES (3, '"Polska Konstytucja" wyd. Helion, 2019', 200);

INSERT INTO "Ordered_products"
VALUES (1, 1, 1, 100);
INSERT INTO "Ordered_products"
VALUES (2, 1, 2, 50);
INSERT INTO "Ordered_products"
VALUES (3, 2, 3, 4);
INSERT INTO "Ordered_products"
VALUES (4, 2, 1, 100);
INSERT INTO "Ordered_products"
VALUES (5, 2, 2, 200);
INSERT INTO "Ordered_products"
VALUES (6, 3, 1, 1000);
INSERT INTO "Ordered_products"
VALUES (7, 3, 2, 500);
INSERT INTO "Ordered_products"
VALUES (8, 3, 3, 100);
INSERT INTO "Ordered_products"
VALUES (9, 1, 3, 20);
/*
SELECT p."Name", op."Count", s."Name" FROM
"Orders" o JOIN "Ordered_products" op ON o."Order_id" = op."Order_id"
JOIN "Products" p ON op."Product_id" = p."Product_id"
JOIN "Shops" s ON o."Shop_id" = s."Shop_id"
WHERE o."Order_id" = 1;
*/
commit;