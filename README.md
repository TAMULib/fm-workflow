# fw-registry

Start mod-workflow and mod-camunda.

```
cd mod-workflow
mvn clean install
cd service
mvn clean spring-boot:run
```

```
cd mod-camunda
mvn clean spring-boot:run
```

## patron

DivIT patron workflow. (Scheduled)

> Can use fw-cli mock okapi service to test. `yarn okapi`

```
fw config set divit-url ***
fw config set divit-user ***
fw config set divit-password ***
```

```
fw build patron
fw activate patron
```

## orcid

Extract for ORCID workflow.

```
fw config set divit-url ***
fw config set divit-user ***
fw config set divit-password ***
fw config set orcid-mail-from ***
fw config set orcid-mail-to ***
```

```
fw build orcid
fw activate orcid
```

```
curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/orcid/start' \
--header 'Content-Type: application/json' \
--header 'X-Okapi-Tenant: diku' \
--data-raw '{"emailTo": "you@example.com"}'
```

## gobi

ISBN report to GOBI workflow. (Scheduled)

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
fw config set gobi-mail-from ***
fw config set gobi-mail-to ***
```

```
fw build gobi
fw activate gobi
```

## e-resource

E-resource Workflow.

```
fw config set e-resource-view LIBRARY_ERESOURCES
fw config set divit-url ***
fw config set divit-user ***
fw config set divit-password ***
```

```
fw build e-resource
fw activate e-resource
```

```
fw run e-resource

or

curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/e-resource/start' \
--header 'Content-Type: application/json' \
--header 'X-Okapi-Tenant: diku' \
--data-raw '{}'
```

## purchase-orders

Purchase Orders Workflow.

```
fw build purchase-orders
fw activate purchase-orders

curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/purchase-orders/start' \
--header 'Content-Type: multipart/form-data' \
--header 'X-Okapi-Tenant: tern' \
--form 'logLevel="INFO"' \
--form 'file=@"/GOBI Print (1).mrc"' \
--form 'path="/mnt/po"' \
--form 'statisticalCode="ybppapp"' \
--form 'okapiUrl="https://folio-okapi-test.library.tamu.edu"' \
--form 'username="***"' \
--form 'password="***"' \
--form 'permLocation="Evans stk"' \
--form 'tempLocation="Evans nbs"' \
--form 'fiscalYearCode="FY2021"' \
--form 'permLoanType="normal"' \
--form 'tempLoanType="newbook"' \
--form 'noteType="General note"' \
--form 'materialType="unmediated -- volume"' \
--form 'permELocation="www_evans"' \
--form 'eMaterialType="computer -- online resource"' \
--form 'eHoldingsType="Unknown"' \
--form 'emailFrom="me@example.com"' \
--form 'emailTo="you@example.com"'
```

## circ-fines

Circulation Fees/Fines Daily Report. (Scheduled)

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
fw config set circ-fines-mail-from ***
fw config set circ-fines-mail-to ***
```

```
fw build circ-fines
fw activate circ-fines
```

## rapid-print-serials

Rapid ILS Print Serials Monthly Report. (Scheduled)

This utilizes LDP, which must have table `mis.tamu_sfx_extract` manually created.

SFX TSV file mapping. Following https://knowledge.exlibrisgroup.com/SFX/Knowledge_Articles/What_are_the_column_descriptions_for_advanced_tab_delimited_text_exports_using_the_export_tool.

```
 A TITLE_SORTABLE
 B TITLE
 C TITLE_NON_FILING_CHARACTER
 D ISSN
 E OBJECT_ID
 F TARGET_PUBLIC_NAME
 G THRESHOLD
 H EISSN
 I ABBREVIATED_TITLE
 J TARGET_SERVICE_TYPE
 K LCCN
 L OBJECT_PORTFOLIO_ID
 M Mu
 N Ny
 O Oa
 P Ph
 Q LOCAL_THRESHOLD
 R GLOBAL_THRESHOLD
 S TARGET_ID
 T TAGET_SERVICE_ID
 U OBJECT_PORTFOLIO_ID
 V CATEGORIES
 W LOCAL_ATTRIBUTE
 X ISBN
 Y EISBN
 Z PUBLISHER
AA PLACE_OF_PUBLICATION
AB DATE_OF_PUBLICATION
AC OBJECT_TYPE
AD ACTIVIATION_STATUS_FOR_THE_DEFAULT_INSTITUTE
AE INSTITUTE_ID
AF INSTITUTE_NAME
AG INSTITUTE_AVAILABILITY
AH LANGUAGE
AI MAIN_TITLE
AJ FULL_ORIGINAL_TITLE
AK ADDITIONAL_ISBNS
AL ADDITIONAL_EISBNS
AM AUTHOR
AN OWNER
AO THRESHOLD_LOCAL
AP PARSE_PARAM
AQ IS_FREE
AR
AS
AT
AU
AV
AW
AX
```

```sql
CREATE TABLE mis.tamu_sfx_extract (
 TITLE_SORTABLE varchar(400) NULL,
 TITLE varchar(400) NULL,
 TITLE_NON_FILING_CHARACTER numeric(2, 0) NULL,
 ISSN varchar(20) NULL,
 OBJECT_ID numeric(20, 0) NOT NULL,
 TARGET_PUBLIC_NAME varchar(256) NULL,
 THRESHOLD varchar(1000) NULL,
 EISSN varchar(20) NULL,
 ABBREVIATED_TITLE varchar(1000) NULL,
 TARGET_SERVICE_TYPE varchar(20) NULL,
 LCCN varchar(40) NULL,
 OBJECT_PORTFOLIO_ID numeric(20, 0) NULL,
 Mu varchar(856) NULL,
 Ny varchar(856) NULL,
 Oa varchar(856) NULL,
 Ph varchar(245) NULL,
 LOCAL_THRESHOLD varchar(1000) NULL,
 GLOBAL_THRESHOLD varchar(1000) NULL,
 TARGET_ID numeric(20, 0) NULL,
 TAGET_SERVICE_ID numeric(20, 0) NULL,
 OBJECT_PORTFOLIO_ID_2 numeric(40, 0) NULL,
 CATEGORIES varchar(400) NULL,
 LOCAL_ATTRIBUTE varchar(1) NULL,
 ISBN varchar(17) NULL,
 EISBN varchar(17) NULL,
 PUBLISHER varchar(255) NULL,
 PLACE_OF_PUBLICATION varchar(255) NULL,
 DATE_OF_PUBLICATION numeric(4, 0) NULL,
 OBJECT_TYPE varchar(20) NULL,
 ACTIVIATION_STATUS_FOR_THE_DEFAULT_INSTITUTE varchar(8) NULL,
 INSTITUTE_ID numeric(1, 0) NULL,
 INSTITUTE_NAME varchar(50) NULL,
 INSTITUTE_AVAILABILITY varchar(8) NULL,
 LANGUAGE varchar(3) NULL,
 MAIN_TITLE varchar(400) NULL,
 FULL_ORIGINAL_TITLE varchar(400) NULL,
 ADDITIONAL_ISBNS varchar(35) NULL,
 ADDITIONAL_EISBNS varchar(35) NULL,
 AUTHOR varchar(1000) NULL,
 OWNER varchar(3) NULL,
 THRESHOLD_LOCAL varchar(1000) NULL,
 PARSE_PARAM varchar(256) NULL,
 IS_FREE numeric(1, 0) NULL
);
```

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build rapid-print-serials
fw activate rapid-print-serials
```

## rapid-print-monos

Rapid ILS Print Monos Monthly Report. (Scheduled)

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build rapid-print-monos
fw activate rapid-print-monos
```

## rapid-electronic-serials

Rapid ILS Electronic Serials Monthly Report. (Scheduled)

```
fw build rapid-electronic-serials
fw activate rapid-electronic-serials
```

## coral-extract

Extract Coral Data and Import it into Folio (Scheduled).

This utilizes LDP, which must have tables `mis.coral_extract` and `mis.coral_instances` manually created.
Each execution of this workflow clears the LDP table `mis.coral_extract` near the start of the process.

```sql
CREATE SCHEMA mis AUTHORIZATION ldpadmin;

GRANT USAGE ON SCHEMA mis TO ldp;
GRANT USAGE ON SCHEMA mis TO ldpadmin;

ALTER DEFAULT PRIVILEGES IN SCHEMA mis GRANT ALL PRIVILEGES ON TABLES TO ldp;
ALTER DEFAULT PRIVILEGES IN SCHEMA mis GRANT ALL PRIVILEGES ON TABLES TO ldpadmin;

CREATE TABLE mis.coral_extract (
coralid int2 NOT NULL,
contributor varchar(256) NULL,
title varchar(256) NULL,
publisher varchar(256) NULL,
summary varchar(4000) NULL,
natureofcontentterm varchar(200) NULL,
electronicaccess varchar(2000) NULL,
status varchar(8) NULL,
CONSTRAINT coral_extract_pkey PRIMARY KEY (coralid)
);

CREATE TABLE mis.coral_instances (
coralid int2 NOT NULL,
instanceid varchar(36) NULL,
CONSTRAINT coral_instances_pkey PRIMARY KEY (coralid)
);
```

```
fw config set coral-url ***
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build coral-extract
fw activate coral-extract
```

```
fw run coral-extract

or

Wait for the cron job to execute.
```

## medsci-gps-zone

MedSci GPS Zone

For the `medsci-gps-zone-file` setting, the file name (without the path part) should likely be `grad_access.txt`.

```
fw config set divit-url ***
fw config set divit-user ***
fw config set divit-password ***
fw config set medsci-gps-zone-from ***
fw config set medsci-gps-zone-to ***
```

```
fw build medsci-gps-zone
fw activate medsci-gps-zone
```

```
fw run medsci-gps-zone
```

## hathitrust

HathiTrust Export

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build hathitrust
fw activate hathitrust
```

```
fw run hathitrust
```

## create-tags

Create Tags Workflow.

```
fw build create-tags
fw activate create-tags

curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/create-tags/start' \
--header 'Content-Type: multipart/form-data' \
--header 'X-Okapi-Tenant: tamu' \
--form 'logLevel="DEBUG"' \
--form 'file=@"FOLIOTags.csv"' \
--form 'path="/mnt/workflows/create-tags"' \
--form 'username="***"' \
--form 'password="***"'
```

## shelflist-holdings

Shelflist (holdings level) Report Workflow.

```
fw config set mis-catalog-reports-url https://localhost/catalog_reports/site
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build shelflist-holdings
fw activate shelflist-holdings

curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/shelflist-holdings/start' \
--header 'Content-Type: multipart/form-data' \
--header 'X-Okapi-Tenant: tern' \
--form 'logLevel="INFO"' \
--form 'emailFrom="folio@k1000.library.tamu.edu"' \
--form 'emailTo="wwelling@library.tamu.edu"' \
--form 'libraryName="[\"Texas A&M University Qatar Library\"]"' \
--form 'locationDiscoveryDisplayName'="[]"' \
--form 'locationName'="[]"' \
--form 'language'="[]"' \
--form 'resourceType'="[]"' \
--form 'format'="[]"' \
--form 'batchId'=""' \
--form 'issuance'=""' \
--form 'suppressInstance'=false' \
--form 'suppressHoldings'=false' \
--form 'createdDateStart'=""' \
--form 'createdDateEnd'=""' \
--form 'updatedDateStart'=""' \
--form 'updatedDateEnd'=""'
```

## shelflist-items

Shelflist (items level) Report Workflow.

```
fw config set mis-catalog-reports-url https://localhost/catalog_reports/site
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build shelflist-holdings
fw activate shelflist-holdings

curl --location --request POST 'http://localhost:9001/mod-workflow/events/workflow/shelflist-items/start' \
--header 'Content-Type: multipart/form-data' \
--header 'X-Okapi-Tenant: tern' \
--form 'logLevel="INFO"' \
--form 'emailFrom="folio@k1000.library.tamu.edu"' \
--form 'emailTo="wwelling@library.tamu.edu"' \
--form 'libraryName="[\"Texas A&M University Qatar Library\"]"' \
--form 'locationDiscoveryDisplayName'="[]"' \
--form 'locationName'="[]"' \
--form 'loanType'="[]"' \
--form 'materialType'="[]"' \
--form 'itemStatus'="[]"' \
--form 'createdDateStart'=""' \
--form 'createdDateEnd'=""' \
--form 'updatedDateStart'=""' \
--form 'updatedDateEnd'=""'
```

## item-history-update

Item History Update Workflow.

```
fw config set ldp-url ***
fw config set ldp-user ***
fw config set ldp-password ***
```

```
fw build item-history-update
fw activate item-history-update
fw run item-history-update
```
