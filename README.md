# dataflow_Cloud
The **dataflow_cloud** repository is related to the **dataflow database Cloud** building block of the 5GMETA Platform, and to be deployed at the **5GMETA Cloud** level for storing the metadata (commonly named **dataflow** in the project) related to producted & consumed data. To that end, this repository provides the following:
*	**Main Features:**
	*   **Database definition** based on the dbml format: **dataflow_DB_CLOUD.dbml**
	*   **Database schemas** for **MySQL & PostgreSQL** dbms. (Nevertheless, ***only MySQL has been tested so far***)
	*	**Dataflow_utils**: a distinct [5GMETA repository](https://github.com/5gmeta/dataflow_utils) including utility tables (country codes, known dataflow types) that are pre-populated based on provided CSV files. The repository is included here as a **git submodule** under the **utils/** folder).
	*   **Docker-compose file** for quickly instantiating MySQL + PhpMyAdmin containers with the provided MySQL database schema.
*	**Other Features:**
	<!-- *   Examples of dataflows based on MySQL -->
	*   **dbml_cli + updateDB.sh script:** an easy way to convert from/to DBML to/from SQL using a containerized tool (check the **dbml_cli** section in the Docker-compose file in the **src** folder) and the **updateDB.sh script**.

!["Dataflow_Cloud DB"](miscelania/images/5GMETA_Cloud_Dataflow-DB.png "Dataflow_Cloud DB Model(05052022)")
<!-- # Overview
including a summary of the intended functions and scopeList item -->
# Prerequisites
**Docker** and **Docker-compose** are required for using this module.
<!-- including:
	infrastructure: assets/systems required and their features
	device: model of the sensor
	dependencies: list of packages and their versions -->
# Features
Refers to the first section
<!-- including a list of implememented functions -->
# Deployment
## Cloning the repository
The **Dataflow-CLOUD** nests the **Dataflow-Utils** repository as **a Git Submodule**, therefore cloning should be done like this:

	<!-- git clone --recurse-submodules https://github.com/5gmeta/dataflow_cloud.git -->
	git clone --recurse-submodules https://github.com/5gmeta/dataflow_cloud.git 

## Deployment & Usage 
To run the **Dataflow-CLOUD**

	cd src/
	sudo docker-compose up -d

<!-- To populate the database with the fictive example

	docker exec -it dataflow_sd_db bash

	# MySQL environments variables are listed in the docker-compose file
	# Default password: db_password
	mysql -u db_user -p -D dataflow_db
	source mysql_example.sql; -->

Then connect to the **PhpMyAdmin** instance at http://localhost:8888/ or check the examples directly on the mysql prompt 

To use the **dbml_cli** for converting from dbml to sql formats, just execute the **updateDB.sh script**
## Authors 
*	Arslane HAMZA CHERIF ([arslane.hamzacherif@unimore.it](mailto:arslane.hamzacherif@unimore.it))
*	Khaled Chikh ([khaledchikh@unimore.it](mailto:khaledchikh@unimore.it))
## License 
Copyright : Copyright 2022 VICOMTECH

License : EUPL 1.2 ([https://eupl.eu/1.2/en/](https://eupl.eu/1.2/en/))

The European Union Public Licence (EUPL) is a copyleft free/open source software license created on the initiative of and approved by the European Commission in 23 official languages of the European Union.

Licensed under the EUPL License, Version 1.2 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at [https://eupl.eu/1.2/en/](https://eupl.eu/1.2/en/)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.




