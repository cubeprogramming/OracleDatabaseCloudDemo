# OracleDatabaseCloudDemo

Project containing script for demoing Oracle Database Cloud integration with Oracle SOA Cloud Service trough OSB service artefact that is polling data from database and sending this data to Java SpringBoot REST micro-service

Oracle Service Bus service is using database poller to be notified on database changes. Than it reads records from database and send them to SpringBoot REST micro-service.
