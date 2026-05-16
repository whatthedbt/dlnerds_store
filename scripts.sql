-- To create yaml file for the models. Note: Make sure you have codegen package install inside packages.yml file
dbt run-operation generate_model_yaml --args '{"model_names": ["country_cleaned"]}'