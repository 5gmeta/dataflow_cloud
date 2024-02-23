# Docker file for using the dbml_cli tool which allows conversion from dbml to sql formats.
# More information on: https://www.dbml.org/cli/
FROM node:alpine AS base
RUN yarn install && yarn global add @dbml/cli
