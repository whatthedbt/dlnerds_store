-- To create yaml file for the models. Note: Make sure you have codegen package install inside packages.yml file
dbt run-operation generate_model_yaml --args '{"model_names": ["country_cleaned"]}'

Step 1: Generate private key (choose one option)
-- Option A – Encrypted private key (requires passphrase, more secure):

openssl genrsa 2048 | openssl pkcs8 -topk8 -v2 des3 -out rsa_private_key.p8
-- Option B – Unencrypted private key (no passphrase):

openssl genrsa 2048 | openssl pkcs8 -topk8 -nocrypt -out rsa_private_key.p8
-- Step 2: Generate public key (always unencrypted)
openssl rsa -in rsa_private_key.p8 -pubout -out rsa_public_key.pub
-- Run in Snowflake CLI or Snowsight
-- Step 3: Configure Snowflake User Account
ALTER USER <username> SET RSA_PUBLIC_KEY='<public_key_string>';
