DROP TABLE "Employees" CASCADE CONSTRAINTS;
DROP TABLE "Ordered_products" CASCADE CONSTRAINTS;
DROP TABLE "Orders" CASCADE CONSTRAINTS;
DROP TABLE "Products" CASCADE CONSTRAINTS;
DROP TABLE "Shops" CASCADE CONSTRAINTS;
DROP VIEW OrderView;
DROP TABLE "Logs";

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

create table "Logs"
(
	"Date" date not null,
	"User_name" varchar(64) not null,
	"Table_name" varchar(64) not null,
	"Action" varchar(64) not null,
    "Row_id" NUMBER not null
);

CREATE VIEW OrderView AS
    SELECT s."Shop_id", s."Name" "Shop Name", COUNT( o."Shop_id") "Orders"
FROM "Orders" o JOIN "Shops" s ON o."Shop_id" = s."Shop_id"
GROUP BY s."Shop_id", s."Name";

create or replace trigger employees_log
    after insert or update or delete on "Employees"
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

    insert into "Logs"
        values (SYSDATE,USER, 'Employees', action, row_id);
end;

create or replace trigger orders_log
    after insert or update or delete on "Orders"
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

    insert into "Logs"
        values (SYSDATE,USER, 'Orders', action, row_id);
end;

create or replace trigger shops_log
    after insert or update or delete on "Shops"
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

    insert into "Logs"
        values (SYSDATE,USER, 'Shops', action, row_id);
end;

create or replace trigger products_log
    after insert or update or delete on "Products"
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

    insert into "Logs"
        values (SYSDATE,USER, 'Products', action, row_id);
end;

create or replace trigger ordered_products_log
    after insert or update or delete on "Ordered_products"
    for each row
declare
    action varchar(64);
    row_id number(10);
begin
    if updating then
        action := 'Update';
        row_id := :OLD."Ordered_product_id";
    elsif inserting then
        action := 'Insert';
        row_id := :NEW."Ordered_product_id";
    elsif deleting then
        action := 'Delete';
        row_id := :OLD."Ordered_product_id";
    end if;

    insert into "Logs"
        values (SYSDATE,USER, 'Ordered_products', action, row_id);
end;
