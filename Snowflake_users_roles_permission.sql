-- SECURITYADMIN: The Chief Security Officer. Creates and manages all roles and users. We are using it to create a new role
use role securityadmin;
-- Creating the role as analyst_role
create or replace role analyst_role
comment = "This is test role";

-- List up all the existing roles present in Snowflake
show roles;

-- Now let's grant the created role analyst_role
grant role analyst_role to role sysadmin;

-- Give the Role Permissions. Your custom role cannot do anything yet. It needs a compute engine (Warehouse) to run queries and access to the data.
-- Here we are giving the role permission to use the warehouse called analytics_wh

grant usage on warehouse analytics_wh to role analyst_role;

-- Let the role see the database and table
grant usage on database sales_db to role analyst_role;
grant usage on schema sales_db.my_schema to role analyst_role;
-- If you want to grant all the schemas under the sales_db database
GRANT USAGE ON ALL SCHEMAS IN DATABASE sales_db TO ROLE analyst_role;
grant select on all tables in schema sales_db.my_schema to role analyst_role;

-- Step 2: Grant SELECT on all FUTURE tables in a specific schema
grant select on future tables in schema sales_db.my_schema to role analyst_role;

-- Finally, give the role to Sara.
grant role analyst_role to user sara;