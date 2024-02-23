-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2022-05-05T13:33:18.407Z

CREATE TYPE "t_source_type" AS ENUM (
  'vehicle',
  'infrastructure'
);

CREATE TYPE "t_dataflow_direction" AS ENUM (
  'download',
  'upload'
);

CREATE TYPE "t_license_geo_type" AS ENUM (
  'local',
  'edge',
  'country',
  'europe',
  'world'
);

CREATE TYPE "t_pipeline_type" AS ENUM (
  'byDefault',
  'onDemand'
);

CREATE TYPE "t_pipeline_protocol" AS ENUM (
  'amqp',
  'mqtt',
  'udp'
);

CREATE TABLE "dataflows" (
  "dataflowId" SERIAL PRIMARY KEY,
  "sourceId" varchar,
  "sourceType" t_source_type DEFAULT 'vehicle',
  "dataflowDirection" t_dataflow_direction DEFAULT 'upload',
  "dataType" varchar NOT NULL,
  "dataSubType" varchar NOT NULL,
  "dataFormat" varchar NOT NULL,
  "dataSampleRate" double DEFAULT 0,
  "licenseGeolimit" t_license_geo_type,
  "licenseType" varchar,
  "locationQuadkey" varchar(20),
  "locationLatitude" double,
  "locationLongitude" double,
  "locationCountry" varchar(3),
  "timeRegistration" bigint,
  "timeLastUpdate" bigint,
  "timeZone" tinyint,
  "timeStratumLevel" tinyint,
  "extraAttributes" JSON,
  "processingId" int
);

CREATE TABLE "aggregatedFlows" (
  "aggregatedFlowId" varchar PRIMARY KEY,
  "supportedDataflowDirection" t_dataflow_direction DEFAULT 'upload',
  "supportedDataType" varchar NOT NULL,
  "supportedDataSubType" varchar NOT NULL,
  "outputDataformat" varchar
);

CREATE TABLE "dataflowProcessing" (
  "processingId" int PRIMARY KEY,
  "aggregatedFlowId" varchar,
  "pipelineId" int,
  "servingEdgeId" int
);

CREATE TABLE "servingEdges" (
  "edgeId" int PRIMARY KEY,
  "edgeName" varchar(50) UNIQUE NOT NULL,
  "edgeOwner" varchar,
  "aboutEdge" varchar(255)
);

CREATE TABLE "pipeServiceOwners" (
  "ownerId" varchar PRIMARY KEY,
  "ownerName" varchar(50) UNIQUE NOT NULL,
  "aboutOwner" varchar(255)
);

CREATE TABLE "pipeServices" (
  "serviceId" varchar PRIMARY KEY,
  "serviceName" varchar(50) UNIQUE NOT NULL,
  "serviceType" varchar,
  "serviceBaseImage" varchar,
  "serviceAttributes" JSON,
  "ownerId" varchar NOT NULL,
  "isAnExternalService" bool,
  "aboutService" varchar(255)
);

CREATE TABLE "ccamApps" (
  "ccamId" varchar PRIMARY KEY,
  "topics" varchar,
  "portData" int,
  "portManagement" int,
  "processingId" int
);

CREATE TABLE "pipelines" (
  "pipelineId" int PRIMARY KEY,
  "pipelineType" t_pipeline_type DEFAULT 'byDefault',
  "pipelineIsActive" boolean,
  "timeLastUpdate" bigint,
  "inactivityTimer" int,
  "pipelineAttributes" JSON,
  "internalProtocol" t_pipeline_protocol DEFAULT 'amqp',
  "internalProtocolPort" int,
  "internalProtocolAttributes" JSON,
  "pipelineRules" JSON,
  "nbrModules" int,
  "module0" varchar,
  "module1" varchar,
  "module2" varchar,
  "module3" varchar,
  "module4" varchar,
  "module5" varchar,
  "module6" varchar,
  "module7" varchar,
  "module8" varchar,
  "module9" varchar,
  "slaId" int
);

CREATE TABLE "sla" (
  "slaId" int PRIMARY KEY,
  "samplerate" double,
  "framerate" double,
  "resolution" varchar,
  "bitrate" double,
  "bitrate_unit" varchar
);

COMMENT ON COLUMN "dataflows"."sourceId" IS 'Identifier of the producing S&D';

COMMENT ON COLUMN "dataflows"."dataType" IS 'potential values: application, audio, cits, image, text, video';

COMMENT ON COLUMN "dataflows"."dataSubType" IS 'potential values: cam, denm, webrtc, jpeg...';

COMMENT ON COLUMN "dataflows"."dataFormat" IS 'potential values: json, asn1_jer, H264, mp4 ...';

COMMENT ON COLUMN "dataflows"."licenseType" IS 'potential values: commercial, free...';

COMMENT ON COLUMN "dataflows"."locationQuadkey" IS 'min size/zoom is 14 and max up to 18';

COMMENT ON COLUMN "dataflows"."locationLatitude" IS '7 decimal places for max precision';

COMMENT ON COLUMN "dataflows"."locationLongitude" IS '7 decimal places for max precision';

COMMENT ON COLUMN "dataflows"."locationCountry" IS 'length of 3 if we want to use ISO 3166-1 alpha-3 country code';

COMMENT ON COLUMN "dataflows"."timeRegistration" IS 'UNIX timestamp in milliseconds';

COMMENT ON COLUMN "dataflows"."timeLastUpdate" IS 'UNIX timestamp in milliseconds';

COMMENT ON COLUMN "dataflows"."timeZone" IS 'UTC timzones between -12 & +12';

COMMENT ON COLUMN "dataflows"."timeStratumLevel" IS 'Stratum levels used by NTP protocol, min 1, max 15';

COMMENT ON COLUMN "aggregatedFlows"."supportedDataType" IS 'potential values: application, audio, cits, image, text, video';

COMMENT ON COLUMN "aggregatedFlows"."supportedDataSubType" IS 'potential values: cam, denm, webrtc, jpeg...';

COMMENT ON COLUMN "aggregatedFlows"."outputDataformat" IS 'In case the data format is expected to change at the pipeline output';

COMMENT ON COLUMN "pipeServiceOwners"."ownerId" IS 'possibility to generate a unique key by hashing the ownerName';

COMMENT ON TABLE "pipeServices" IS 'each service listed here is a single instance
  therefore a pipeline never shares its services';

COMMENT ON COLUMN "pipeServices"."serviceId" IS 'possibility to generate a unique key by hashing the sourceName';

COMMENT ON COLUMN "pipeServices"."serviceType" IS 'potential values: message-converter, data-sampler, video-compression';

COMMENT ON COLUMN "pipeServices"."serviceBaseImage" IS 'Name of the Image for the current service';

COMMENT ON TABLE "ccamApps" IS 'this table should be part of the Cloud_Identity-DB';

COMMENT ON COLUMN "pipelines"."pipelineIsActive" IS 'to know if this pipeline is currently active or not';

COMMENT ON COLUMN "pipelines"."timeLastUpdate" IS 'UNIX timestamp in milliseconds';

COMMENT ON COLUMN "pipelines"."inactivityTimer" IS 'Timer for disabling the pipeline';

COMMENT ON COLUMN "pipelines"."internalProtocolPort" IS 'for e.g. the broker port';

COMMENT ON COLUMN "pipelines"."nbrModules" IS 'Total number of stages composing this pipeline, currently Max 10';

ALTER TABLE "dataflows" ADD FOREIGN KEY ("processingId") REFERENCES "dataflowProcessing" ("processingId");

ALTER TABLE "dataflowProcessing" ADD FOREIGN KEY ("aggregatedFlowId") REFERENCES "aggregatedFlows" ("aggregatedFlowId");

ALTER TABLE "dataflowProcessing" ADD FOREIGN KEY ("pipelineId") REFERENCES "pipelines" ("pipelineId");

ALTER TABLE "dataflowProcessing" ADD FOREIGN KEY ("servingEdgeId") REFERENCES "servingEdges" ("edgeId");

ALTER TABLE "pipeServices" ADD FOREIGN KEY ("ownerId") REFERENCES "pipeServiceOwners" ("ownerId");

ALTER TABLE "ccamApps" ADD FOREIGN KEY ("processingId") REFERENCES "dataflowProcessing" ("processingId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module0") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module1") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module2") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module3") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module4") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module5") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module6") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module7") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module8") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("module9") REFERENCES "pipeServices" ("serviceId");

ALTER TABLE "pipelines" ADD FOREIGN KEY ("slaId") REFERENCES "sla" ("slaId");
