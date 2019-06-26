#!/bin/bash

instanceFolder=$INSTANCE_FOLDER
# Get all required properties
g8DeployName=$G8_DEPLOY_NAME
gkDeployName=$GK_DEPLOY_NAME
tomcatUrl=$TOMCAT_URL
tomcatUsername=$TOMCAT_USERNAME
tomcatPassword=$TOMCAT_PASSWORD
mysqlHost=$MYSQL_HOST
mysqlPort=$MYSQL_PORT
mysqlUsername=$MYSQL_USERNAME
mysqlPassword=$MYSQL_PASSWORD
file="/opt/germinate/$instanceFolder/config.properties"

# Convert line endings to make sure the function below works as expected
sed -i.bak 's/\r$//' $file

# Function to extract the value of a property from config.properties
function prop {
    grep "${1}" $file|cut -d'=' -f2
}

function setUpDatabase {
	RESULT=`mysql -u $mysqlUsername -p$mysqlPassword -h $mysqlHost -P $mysqlPort --skip-column-names -e "SHOW DATABASES LIKE '$1'"`

	if [ $? -eq 0 ]; then
		# Query succeeded
		setup=true
		if [ "$RESULT" == "$1" ]; then
			# Database exists, check if tables are there
			RESULT=`mysql -u $mysqlUsername -p$mysqlPassword -h $mysqlHost -P $mysqlPort --skip-column-names -e "USE $1; SHOW TABLES LIKE '$3';"`

			if [ ! $? -eq 0 ]; then
				echo "Database connection failed. Please check environment variables."
				exit 1
			fi
			
			# If $3 exists, assume the database is set up correctly
			if [ "$RESULT" == "$3" ]; then
				setup=false
			fi
		fi
		
		if [ $setup == false ]; then
			echo "Database '$1' exists, no setup required"
		else
			echo "Database '$1' not found, setting up"
			
			# Create the database
			RES_DATABASE=`mysql -u $mysqlUsername -p$mysqlPassword -h $mysqlHost -P $mysqlPort -e "CREATE DATABASE $1;"`
			if [ ! $? -eq 0 ]; then
				echo "Creating the database '$1' failed."
				exit 1
			fi
			# Use the setup script to set up the database
			RES_TABLES=`mysql -u $mysqlUsername -p$mysqlPassword -h $mysqlHost -P $mysqlPort $1 < $2`
			if [ ! $? -eq 0 ]; then
				echo "Running the Germinate/Gatekeeper database script failed."
				exit 1
			fi
		fi
	else
		echo "Database connection failed. Please check environment variables."
		exit 1
	fi
}

g8MysqlDatabase=$(prop 'Germinate.Database.Name')
gkMysqlDatabase=$(prop 'Gatekeeper.Database.Name')

if [ -z "$instanceFolder" ]; then
  	cat >&2 <<EOF
Environment variable "INSTANCE_FOLDER" not provided.
This is required to build Germinate.
EOF
  	exit 1
fi

# If database host and username are provided, take that to mean that the database should be set up
if [ ! -z "$mysqlHost" ] && [ ! -z "$mysqlUsername" ]; then
	setUpDatabase $g8MysqlDatabase "/opt/germinate/database/germinate_template.sql" "germinatebase"

	if [ ! -z "$gkDeployName" ]; then
		setUpDatabase $gkMysqlDatabase "/opt/gatekeeper/database/germinate_gatekeeper.sql" "users"
	fi
fi

# Build Germinate
if [ ! -z "$g8DeployName" ]; then
	# If both tomcat properties are empty, assume we're just supposed to build the .war
	if [ -z "$tomcatUrl" ] && [ -z "$tomcatUsername" ]; then
		/opt/apache-ant-1.10.6/bin/ant -buildfile /opt/germinate/build.xml -Dproject.name="$g8DeployName" -Dinstance.files="$instanceFolder" testbuild
		mv /opt/germinate/$DEPLOY_NAME.war /opt/germinate/$instanceFolder/
	# Else, if only one is missing, this is an error
	elif [ -z "$tomcatUrl" ] || [ -z "$tomcatUsername" ]; then
		cat >&2 <<EOF
Environment variable "TOMCAT_URL" or "TOMCAT_USERNAME" not provided.
This is required to build Germinate.
EOF
	  	exit 1
	else
		/opt/apache-ant-1.10.6/bin/ant -buildfile /opt/germinate/build.xml -Dproject.name="$g8DeployName" -Dinstance.files="$instanceFolder" -Dtomcat.manager.url="$tomcatUrl" -Dtomcat.manager.username="$tomcatUsername" -Dtomcat.manager.password="$tomcatPassword" deploy
	fi
fi

# Build Gatekeeper
if [ ! -z "$gkDeployName" ]; then
	# If both tomcat properties are empty, assume we're just supposed to build the .war
	if [ -z "$tomcatUrl" ] && [ -z "$tomcatUsername" ]; then
		/opt/apache-ant-1.10.6/bin/ant -buildfile /opt/gatekeeper/build.xml -Dproject.name="$gkDeployName" testbuild
		mv /opt/gatekeeper/$DEPLOY_NAME.war /opt/germinate/$instanceFolder/
	# Else, if only one is missing, this is an error
	elif [ -z "$tomcatUrl" ] || [ -z "$tomcatUsername" ]; then
		cat >&2 <<EOF
Environment variable "TOMCAT_URL" or "TOMCAT_USERNAME" not provided.
This is required to build Germinate.
EOF
	  	exit 1
	else
		/opt/apache-ant-1.10.6/bin/ant -buildfile /opt/gatekeeper/build.xml -Dproject.name="$gkDeployName" -Dtomcat.manager.url="$tomcatUrl" -Dtomcat.manager.username="$tomcatUsername" -Dtomcat.manager.password="$tomcatPassword" deploy
	fi
fi

exec "$@"
