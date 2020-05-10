DROP TABLE "Employees" CASCADE CONSTRAINTS;
DROP TABLE "Ordered_products" CASCADE CONSTRAINTS;
DROP TABLE "Orders" CASCADE CONSTRAINTS;
DROP TABLE "Products" CASCADE CONSTRAINTS;
DROP TABLE "Shops" CASCADE CONSTRAINTS;
DROP VIEW OrderView;

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

CREATE VIEW OrderView AS
    SELECT s."Shop_id", s."Name" "Shop Name", COUNT( o."Shop_id") "Orders"
FROM "Orders" o JOIN "Shops" s ON o."Shop_id" = s."Shop_id"
GROUP BY s."Shop_id", s."Name";