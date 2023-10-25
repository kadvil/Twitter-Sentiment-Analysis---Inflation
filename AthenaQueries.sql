/*

                     Big Data Project - Athena Queries

        ########################################################################

 */



/*
Create Database for holding all tables
 */

CREATE DATABASE twitterpred;

/*
Create Tables for Pre Prediction data to make Preliminary Dashboard
 */

CREATE EXTERNAL TABLE IF NOT EXISTS `twitterpred`.`prepred` (
  `id` bigint,
  `name` string,
  `username` string,
  `tweet` string,
  `followers_count` bigint,
  `location` string,
  `retweetcheck` string,
  `retweetat` string,
  `datetime` timestamp,
  `hour` int,
  `minute` int,
  `sentiment` string,
  `wordcount` int,
  `wordcloudfilter` string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim' = '\t',
  'collection.delim' = '\u0002',
  'mapkey.delim' = '\u0003',
  'skip.header.line.count' = '1'
)
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://kadvil/TPrePred/';


/*
Create Table for WordCloud from data from prepred table
 */

CREATE TABLE wordclouddata AS
SELECT DISTINCT word, username
FROM prepred,
     UNNEST(SPLIT(wordcloudfilter, ' ')) AS t(word)


/*
Create Tables for Prediction data to make Sentiment Dashboard
 */

CREATE EXTERNAL TABLE IF NOT EXISTS `twitterpred`.`tpred` (
  `username` string,
  `tweet` string,
  `followers_count` bigint,
  `location` string,
  `retweetcheck` string,
  `retweetat` string,
  `datetime` timestamp,
  `hour` int,
  `minute` int,
  `wordcount` int,
  `sentiment` string,
  `label` int,
  `prediction` int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim' = '\t',
  'collection.delim' = '\u0002',
  'mapkey.delim' = '\u0003',
  'skip.header.line.count' = '1'
)
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://kadvil/TPrediction/';


/*

 End of Queries Used
 #######################################################################
 */


