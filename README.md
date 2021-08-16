# InterviewCGDHealth

Setting Up the SQL Server:

There is a problem deploying the SQL server on my mac based on M1 chip:

-deploy the SQL server on Docker sucessfully, but restore the database failed:

>(base) karsyn@Karsyns-MacBook-Pro ~ % sudo docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=<YourStrong!Passw0rd>' \
   --name 'sql1' -p 1401:1433 \
   -v sql1data:/var/opt/mssql \
   -d mcr.microsoft.com/mssql/server:2019-latest
Unable to find image 'mcr.microsoft.com/mssql/server:2019-latest' locally
2019-latest: Pulling from mssql/server
a31c7b29f4ad: Pull complete 
a039ba299d1e: Pull complete 
1d60c867fae0: Pull complete 
b9278f283ade: Pull complete 
120d64e87cdd: Pull complete 
Digest: sha256:3a64da47fb2c8b4d730856b06930999a09bf7ed4eab2d540fae2c7063da7a4fd
Status: Downloaded newer image for mcr.microsoft.com/mssql/server:2019-latest
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
310d370562308475ed9576a8d3e555754fe4e8121b3f117d35dd7ed68581d9b2
ERRO[0137] error waiting for container: context canceled 


Then I tried:

`-d mcr.microsoft.com/azure-sql-edge`

but the connection with SQL Server failed..

SOLVED:

`docker cp myNewDatabase.mdf SQLDockerName:/var/opt/mssql/data`
`docker cp myNewDatabase_log.ldf SQLDockerName:/var/opt/mssql/data`



`sudo docker exec -ti -u root azuresqledge bash`

`root@ce8f5c03b44b:/# chmod 777 /var/opt/mssql/data/synpuf52_fixed.mdf` //make sure the permission of files in local 777 as well

`root@ce8f5c03b44b:/# chmod 777 /var/opt/mssql/data/synpuf52_fixed_log.ldf`


>CREATE DATABASE myNewDatabase
    ON (FILENAME = '/var/opt/mssql/data/myNewDatabase.mdf'),   
    (FILENAME = '/var/opt/mssql/data/myNewDatabase_log.ldf')   
    FOR ATTACH; 


####New Issue:

run `docker-compose up` then:


![issue of deploying GE](issue1.png)


There is an potential issue of the Dockerfile (deploy file). 


Next step: I will change the Dockerfile to fix the exit code 1 error.


