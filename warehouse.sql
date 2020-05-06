DROP TABLE "Employees";
DROP TABLE "Ordered_products";
DROP TABLE "Orders";
DROP TABLE "Products";
DROP TABLE "Shops";

create table "Employees"
(
    "Employee_id"      NUMBER       not null
        constraint EMPLOYEES_PK
            primary key,
    "First_name"       VARCHAR2(32),
    "Last_name"        VARCHAR2(32) not null,
    "Completed_orders" NUMBER,
    "Salary"           NUMBER(6, 2) not null
)
/

create table "Shops"
(
    "Shop_id" NUMBER       not null
        constraint SHOPS_PK
            primary key,
    "Address" VARCHAR2(64) not null,
    "Name"    VARCHAR2(64) not null
)
/

create table "Orders"
(
    "Order_id"    NUMBER       not null
        constraint ORDERS_PK
            primary key,
    "Shop_id"     NUMBER       not null
        constraint ORDERS_SHOPS_SHOP_ID_FK
            references "Shops",
    "Employee_id" NUMBER
        constraint ORDERS_EMPLOYEES_EMPLOYEE_ID_FK
            references "Employees",
    "Status"      VARCHAR2(11) not null
)
/

create table "Products"
(
    "Product_id" NUMBER       not null
        constraint PRODUCTS_PK
            primary key,
    "Name"       VARCHAR2(64) not null,
    "Count"      NUMBER       not null
)
/

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
                on delete cascade
)
/