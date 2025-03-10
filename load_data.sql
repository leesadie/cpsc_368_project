--Create table for GDHI data
CREATE TABLE GDHI_EXT(
    region VARCHAR(100) NOT NULL,
    gdhi NUMBER NOT NULL,
    PRIMARY KEY (region)
)
--Creating external tables to read directly from CSV files instead of using individual INSERT statements
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY csv_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS (
            region VARCHAR(100) NOT NULL,
            gdhi NUMBER NOT NULL
        )
        MISSING FIELD VALUES ARE NULL
    )
    LOCATION ('GDHI_2021_clean.csv')
);

--Create table for modality wait times
CREATE TABLE Modality_EXT(
    region VARCHAR(3) NOT NULL,
    org_code VARCHAR(20) NOT NULL,
    provider_name VARCHAR(255) NOT NULL,
    modality VARCHAR(255) NOT NULL,
    apr NUMBER NULL,
    may NUMBER NUll,
    jun NUMBER NULL,
    jul NUMBER NULL,
    aug NUMBER NULL,
    sep NUMBER NULL,
    oct NUMBER NULL,
    nov NUMBER NULL,
    dec NUMBER NULL,
    jan NUMBER NULL,
    feb NUMBER NULL,
    mar NUMBER NULL,
    year NUMBER NULL,
    PRIMARY KEY (region, org_code, provider_name, modality)
)
--Creating external tables to read directly from CSV files instead of using individual INSERT statements
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY csv_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS (
            region VARCHAR(3) NOT NULL,
            org_code VARCHAR(20) NOT NULL,
            provider_name VARCHAR(255) NOT NULL,
            modality VARCHAR(255) NOT NULL,
            apr NUMBER NULL,
            may NUMBER NUll,
            jun NUMBER NULL,
            jul NUMBER NULL,
            aug NUMBER NULL,
            sep NUMBER NULL,
            oct NUMBER NULL,
            nov NUMBER NULL,
            dec NUMBER NULL,
            jan NUMBER NULL,
            feb NUMBER NULL,
            mar NUMBER NULL,
            year NUMBER NULL
        )
        MISSING FIELD VALUES ARE NULL
    )
    LOCATION ('Modality_WaitTimes_2020_2021_clean.csv')
);

--Create table for workforce stats
CREATE TABLE Workforce_EXT(
    region_num VARCHAR(3) NOT NULL,
    region_name VARCHAR(100) NULL,
    org_name VARCHAR(255) NOT NULL,
    org_code VARCHAR(5) NOT NULL,
    apr_2020 NUMBER NULL,
    may_2020 NUMBER NULL,
    jun_2020 NUMBER NULL,
    jul_2020 NUMBER NULL,
    aug_2020 NUMBER NULL,
    sep_2020 NUMBER NULL,
    oct_2020 NUMBER NULL,
    nov_2020 NUMBER NULL,
    dec_2020 NUMBER NULL,
    jan_2021 NUMBER NULL,
    feb_2021 NUMBER NULL,
    mar_2021 NUMBER NULL,
    PRIMARY KEY (region_num, org_code)
    FOREIGN KEY (region_num) REFERENCES Modality ON DELETE SET NULL,
    FOREIGN KEY (region_name) REFERENCES GDHI ON DELETE SET NULL
)
--Creating external tables to read directly from CSV files instead of using individual INSERT statements
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY csv_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS (
            region_num VARCHAR(3) NOT NULL,
            region_name VARCHAR(100) NULL,
            org_name VARCHAR(255) NOT NULL,
            org_code VARCHAR(5) NOT NULL,
            apr_2020 NUMBER NULL,
            may_2020 NUMBER NULL,
            jun_2020 NUMBER NULL,
            jul_2020 NUMBER NULL,
            aug_2020 NUMBER NULL,
            sep_2020 NUMBER NULL,
            oct_2020 NUMBER NULL,
            nov_2020 NUMBER NULL,
            dec_2020 NUMBER NULL,
            jan_2021 NUMBER NULL,
            feb_2021 NUMBER NULL,
            mar_2021 NUMBER NULL
        )
        MISSING FIELD VALUES ARE NULL
    )
    LOCATION ('Workforce_Stats_clean.csv')
);

--Insert data from external tables
INSERT INTO GDHI (region, gdhi)
SELECT region, gdhi FROM GDHI_EXT;

INSERT INTO Modality (region, org_code, provider_name, modality, apr, may, jun, jul, aug, sep, oct, nov, dec, jan, feb, mar, year)
SELECT region, org_code, provider_name, modality, apr, may, jun, jul, aug, sep, oct, nov, dec, jan, feb, mar, year FROM Modality_EXT;

INSERT INTO Workforce (region_num, region_name, org_name, org_code, apr_2020, may_2020, jun_2020, jul_2020, aug_2020, sep_2020, oct_2020, nov_2020, dec_2020, jan_2021, feb_2021, mar_2021)
SELECT region_num, region_name, org_name, org_code, apr_2020, may_2020, jun_2020, jul_2020, aug_2020, sep_2020, oct_2020, nov_2020, dec_2020, jan_2021, feb_2021, mar_2021 FROM Workforce_EXT;