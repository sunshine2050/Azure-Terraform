# Demo App

Demo App is a A Flask app which is connected to SQL server using pyodbc, the app is to be deployed on Azure using Terraform.

## Code
#### app.py
Main python file uses flask to create two routes one route is index route which only returns Hello World!\
\
The second route is /live endpoint which returns Well Done if successful connection to Azure SQL Server and Maintainace if not\
\
The code used pyodbc to make the connection and it gets the needed db configurations from db_conf.yaml file\
\
Azure DevOps is responsible in appending db_conf.yaml with db_user and db_pass

## Docker
Install needed pip packages also ODBC connector to connect to SQL Server

## Terraform
#### azurerm_container_group

Used to deploy Docker image that was pushed to Docker Hub the container instance exposes port 5000

#### azurerm_sql_server
Creates a SQL Server for the app to communicate with along side azurerm_sql_database

#### azurerm_log_analytics_workspace
Extract logs from azurerm_container_group

#### azurerm_sql_firewall_rule
Customize access rules to Azure SQL Server, which allows access from all azure services.\
\
In my opinion the DB server should be in a private subnet but I searched a lot about how to add both azurerm_container_group and azurerm_sql_server to private subnets then expose azurerm_container_group to public network but It wasn't as easy to do it in azure in comparison to AWS which allows both public subnets and private subnets to co-exist in the same VPC

> **_NOTE:_** Use value '0.0.0.0' for all Azure-internal IP addresses.

## Vagrant
I created a Self Hosted Vagrant VM and connected it as agent for Azure DevOps which uses it to run CI/CD steps as defined in README.md

## License
[MIT](https://choosealicense.com/licenses/mit/)