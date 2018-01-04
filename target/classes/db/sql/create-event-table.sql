CREATE TABLE EVENT (
  ID              BIGINT AUTO_INCREMENT,
  NAME       VARCHAR(50),
  BASE_PRICE DOUBLE,
  RATING     VARCHAR(30),
  IMAGE      BLOB DEFAULT NULL,
  COUNTRY    VARCHAR(50),
  YEAR       INT,
  LANGUAGE   VARCHAR(50),
  DIRECTED_BY VARCHAR(50),
  DESCRIPTION VARCHAR(1000),
  DURATION_MIN INT,
  TECHNOLOGY VARCHAR(20),
  MIN_AGE INT,
  PRIMARY KEY (ID)
);