CREATE TABLE `dataflows` (
  `dataflowId` integer PRIMARY KEY AUTO_INCREMENT,
  `sourceId` varchar(255) COMMENT 'Identifier of the producing S&D',
  `sourceType` ENUM ('vehicle', 'infrastructure') DEFAULT "vehicle",
  `dataflowDirection` ENUM ('download', 'upload') DEFAULT "upload",
  `dataType` varchar(255) NOT NULL COMMENT 'potential values: application, audio, cits, image, text, video',
  `dataSubType` varchar(255) NOT NULL COMMENT 'potential values: cam, denm, webrtc, jpeg...',
  `dataFormat` varchar(255) NOT NULL COMMENT 'potential values: json, asn1_jer, H264, mp4 ...',
  `dataSampleRate` double DEFAULT 0,
  `licenseGeolimit` ENUM ('local', 'edge', 'country', 'europe', 'world'),
  `licenseType` varchar(255) COMMENT 'potential values: commercial, free...',
  `locationQuadkey` varchar(20) COMMENT 'min size/zoom is 14 and max up to 18',
  `locationLatitude` double COMMENT '7 decimal places for max precision',
  `locationLongitude` double COMMENT '7 decimal places for max precision',
  `locationCountry` varchar(3) COMMENT 'length of 3 if we want to use ISO 3166-1 alpha-3 country code',
  `timeRegistration` bigint COMMENT 'UNIX timestamp in milliseconds',
  `timeLastUpdate` bigint COMMENT 'UNIX timestamp in milliseconds',
  `timeZone` tinyint COMMENT 'UTC timzones between -12 & +12',
  `timeStratumLevel` tinyint COMMENT 'Stratum levels used by NTP protocol, min 1, max 15',
  `extraAttributes` JSON,
  `counter` int NOT NULL DEFAULT 0,
  `quality` int NOT NULL DEFAULT 0
);

CREATE TABLE `serviceOwners` (
  `ownerId` varchar(255) PRIMARY KEY COMMENT 'possibility to generate a unique key by hashing the ownerName',
  `ownerName` varchar(50) UNIQUE NOT NULL,
  `aboutOwner` varchar(255)
);

CREATE TABLE `services` (
  `serviceId` varchar(255) PRIMARY KEY COMMENT 'possibility to generate a unique key by hashing the sourceName',
  `serviceName` varchar(50) UNIQUE NOT NULL,
  `serviceType` varchar(255) COMMENT 'potential values: message-converter, data-sampler, video-compression',
  `serviceBaseImage` varchar(255) COMMENT 'Name of the Image for the current service',
  `serviceAttributes` JSON,
  `ownerId` varchar(255) NOT NULL,
  `isAnExternalService` bool,
  `aboutService` varchar(255)
);

CREATE TABLE `ccamApps` (
  `ccamId` varchar(255) PRIMARY KEY,
  `topics` varchar(255),
  `portData` int,
  `portManagement` int,
  `processingId` int
);

CREATE TABLE `pipelines` (
  `filterDataType` varchar(255) PRIMARY KEY,
  `pipelineRules` JSON,
  `nbrModules` int COMMENT 'Total number of stages composing this pipeline, currently Max 10',
  `slaId` int
);

CREATE TABLE `pipelineServices` (
  `filterDataType` varchar(255),
  `moduleNumber` int,
  `serviceId` varchar(255),
  PRIMARY KEY (filterDataType, moduleNumber)
);

CREATE TABLE `sla` (
  `slaId` int PRIMARY KEY,
  `samplerate` double,
  `framerate` double,
  `resolution` varchar(255),
  `bitrate` double,
  `bitrate_unit` varchar(255)
);

CREATE TABLE `topics` (
  `topicName` varchar(255) NOT NULL,
  `dataType` varchar(255) NOT NULL,
  `dataSubType` varchar(255) DEFAULT null,
  `dataFormat` varchar(255) DEFAULT null,
  `sourceId` varchar(255) DEFAULT null,
  `locationQuadkey` varchar(20) DEFAULT null,
  `locationCountry` varchar(3) DEFAULT null,
  `extraAttributes` json DEFAULT null,
  `sourceType` ENUM ('vehicle', 'infrastructure') DEFAULT "vehicle",
  `licenseGeolimit` ENUM ('local', 'edge', 'country', 'europe', 'world') DEFAULT "world",
  `licenseType` varchar(255) COMMENT 'potential values: commercial, free...' DEFAULT "free"
);

ALTER TABLE `services` ADD FOREIGN KEY (`ownerId`) REFERENCES `serviceOwners` (`ownerId`);

ALTER TABLE `pipelineServices` ADD FOREIGN KEY (`filterDataType`) REFERENCES `pipelines` (`filterDataType`);

ALTER TABLE `pipelineServices` ADD FOREIGN KEY (`serviceId`) REFERENCES `services` (`serviceId`);

ALTER TABLE `pipelines` ADD FOREIGN KEY (`slaId`) REFERENCES `sla` (`slaId`);
