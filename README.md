# README

## Ruby
- v 2.7.1

## Database
- Postgres v 14.0

## Dependencies
- Nokogiri v 1.12.5

## About
- This repository contains an XML_Parser service that parses IRS 990 public grant data to store Filer, Award, and Receiver attributes for said grants.

## Run locally
- `Rails s`

## Endpoints
- `/filers` returns serialized filers with associated awards
- `/awards` returns serialized awards
- `/receivers` returns serialized receivers of awards
- `/receivers?state={state_code}` (ex: `/receivers?state=co`) returns serialized receivers for the queried state parameter

## Notes
- Given more time to work on this project, I would do the following:
  - Write tests
  - Refactor the XML_Parser to use inherited classes to reduce redundancy and increase efficiency
  - Improve upon routing and redirection handling
- The `Grant Amount Key: CashGrantAmt` path did not work for all included XML files. I was able to use alternative keywords to find the relevant data for all files.
