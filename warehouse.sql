DROP TABLE "WH_Employees" CASCADE CONSTRAINTS;
DROP TABLE "WH_Ordered_products" CASCADE CONSTRAINTS;
DROP TABLE "WH_Orders" CASCADE CONSTRAINTS;
DROP TABLE "WH_Products" CASCADE CONSTRAINTS;
DROP TABLE "WH_Shops" CASCADE CONSTRAINTS;
DROP VIEW WH_OrderView;
DROP TABLE "WH_Logs";
create table "WH_Employees"
(
    "Employee_id"      NUMBER       not null
        constraint WH_EMPLOYEES_PK
            primary key,
    "First_name"       VARCHAR2(32),
    "Last_name"        VARCHAR2(32) not null,
    "Completed_orders" NUMBER default 0,
    "Salary"           NUMBER(6, 2) not null
);

create table "WH_Shops"
(
    "Shop_id" NUMBER       not null
        constraint WH_SHOPS_PK
            primary key,
    "Address" VARCHAR2(64) not null,
    "Name"    VARCHAR2(64) not null
);

create table "WH_Orders"
(
    "Order_id"    NUMBER                         not null
        constraint WH_ORDERS_PK
            primary key,
    "Shop_id"     NUMBER                         not null
        constraint WH_ORDERS_SHOP_ID_FK
            references "WH_Shops",
    "Employee_id" NUMBER       default NULL
        constraint WH_ORDERS_EMPLOYEE_ID_FK
            references "WH_Employees",
    "Status"      VARCHAR2(11) default 'Waiting' not null
        check ( "Status" IN ('Waiting', 'In progress', 'Completed', 'Cancelled') )
);

create table "WH_Products"
(
    "Product_id" NUMBER       not null
        constraint WH_PRODUCTS_PK
            primary key,
    "Name"       VARCHAR2(64) not null,
    "Count"      NUMBER       not null
);

create table "WH_Ordered_products"
(
    "WH_Ordered_product_id" NUMBER not null
        constraint WH_ORDERED_PRODUCTS_PK
            primary key,
    "Order_id"           NUMBER not null
        constraint WH_ORD_PROD_ORDER_ID_FK
            references "WH_Orders"
                on delete cascade,
    "Product_id"         NUMBER not null
        constraint WH_ORD_PROD_PRODUCT_ID_FK
            references "WH_Products"
                on delete cascade,
    "Count"              NUMBER not null
);

create table "WH_Logs"
(
	"Date" date not null,
	"User_name" varchar(64) not null,
	"Table_name" varchar(64) not null,
	"Action" varchar(64) not null,
    "Row_id" NUMBER not null
);

CREATE VIEW WH_OrderView AS
    SELECT s."Shop_id", s."Name" "Shop Name", COUNT( o."Shop_id") "WH_Orders"
FROM "WH_Orders" o JOIN "WH_Shops" s ON o."Shop_id" = s."Shop_id"
GROUP BY s."Shop_id", s."Name";

create or replace trigger employees_log
    after insert or update or delete on "WH_Employees"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."Employee_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."Employee_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."Employee_id";
    end if;

    insert into "WH_Logs"
        values (SYSDATE,USER, 'Employees', action, row_id);
end;

create or replace trigger orders_log
    after insert or update or delete on "WH_Orders"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."Order_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."Order_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."Order_id";
    end if;

    insert into "WH_Logs"
        values (SYSDATE,USER, 'Orders', action, row_id);
end;

create or replace trigger shops_log
    after insert or update or delete on "WH_Shops"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."Shop_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."Shop_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."Shop_id";
    end if;

    insert into "WH_Logs"
        values (SYSDATE,USER, 'Shops', action, row_id);
end;

create or replace trigger products_log
    after insert or update or delete on "WH_Products"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."Product_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."Product_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."Product_id";
    end if;

    insert into "WH_Logs"
        values (SYSDATE,USER, 'Products', action, row_id);
end;

create or replace trigger ordered_products_log
    after insert or update or delete on "WH_Ordered_products"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."WH_Ordered_product_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."WH_Ordered_product_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."WH_Ordered_product_id";
    end if;

    insert into "WH_Logs"
        values (SYSDATE,USER, 'Ordered_products', action, row_id);
end;
COMMIT;
INSERT INTO "WH_Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (1, 'Sebastian', 'S³oniewski', 1000);
INSERT INTO "WH_Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (2, 'Dominik','Bartkowski', 5000);
INSERT INTO "WH_Employees" ("Employee_id", "First_name", "Last_name", "Salary")
VALUES (3, 'Szymon','Porzeziñski', 3000);
COMMIT;

INSERT INTO "WH_Shops"
VALUES (1, 'Wybrze¿e Wyspiañskiego 27, Wroc³aw', 'Politechnika Wroc³awska');
INSERT INTO "WH_Shops"
VALUES (2, 'Dworcowa 32, Wroc³aw', 'McDonalds');
INSERT INTO "WH_Shops"
VALUES (3, 'Bierutowska 4, Wroc³aw', 'Lidl');
INSERT INTO "WH_Shops"
VALUES (4, 'Krzywoustego 322, Wroc³aw', 'Poczta Polska UP 14');
INSERT INTO "WH_Shops"
VALUES (5, 'Sk³odowskiej-Curie 23, Wroc³aw', 'Panda Ramen');
COMMIT;

INSERT INTO "WH_Orders"
VALUES (1, 1, 1, 'In progress');
INSERT INTO "WH_Orders"
VALUES( 2, 3, NULL, 'Waiting');
INSERT INTO "WH_Orders"
VALUES (3, 5, 2, 'Completed');
INSERT INTO "WH_Orders"
VALUES (4, 4, 3, 'Cancelled');

INSERT INTO "WH_Products"
VALUES (1, 'M¹ka "Stary m³yn" 1kg', 2000);
INSERT INTO "WH_Products"
VALUES (2, 'Sól "Wieliczka" 1kg', 1000);
INSERT INTO "WH_Products"
VALUES (3, '"Polska Konstytucja" wyd. Helion, 2019', 200);

INSERT INTO "WH_Ordered_products"
VALUES (1, 1, 1, 100);
INSERT INTO "WH_Ordered_products"
VALUES (2, 1, 2, 50);
INSERT INTO "WH_Ordered_products"
VALUES (3, 2, 3, 4);
INSERT INTO "WH_Ordered_products"
VALUES (4, 2, 1, 100);
INSERT INTO "WH_Ordered_products"
VALUES (5, 2, 2, 200);
INSERT INTO "WH_Ordered_products"
VALUES (6, 3, 1, 1000);
INSERT INTO "WH_Ordered_products"
VALUES (7, 3, 2, 500);
INSERT INTO "WH_Ordered_products"
VALUES (8, 3, 3, 100);
INSERT INTO "WH_Ordered_products"
VALUES (9, 1, 3, 20);
COMMIT;