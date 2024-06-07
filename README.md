# SAS Data Analysis Project

This project aims to prepare and analyze TSA claims data using SAS programming language. The requirements for this project are provided by the course instructor and are tailored specifically for this case study. It's important to note that these requirements are not an accurate representation of TSA requirements.

## Data Requirements

- **Raw Data File:** The raw data file `TSAClaims2002_2017.csv` must be imported into SAS and stored in a file named `claims_cleaned` in the `tsa` library.
- **Data Cleaning:** Remove entirely duplicated records. Replace missing and '-' values in columns `Claim_Type`, `Claim_Site`, and `Disposition` with 'Unknown'.
- **Valid Values:** Ensure that values in `Claim_Type`, `Claim_Site`, and `Disposition` columns adhere to predefined lists.
- **Data Transformation:** Convert `StateName` values to proper case and `State` values to uppercase. Add a new column `Date_Issues` to indicate rows with date issues.
- **Output Table:** Exclude `County` and `City` columns. Format currency and dates. Assign permanent labels by replacing underscores with spaces.
- **Sorting:** Sort the final data in ascending order by `Incident_Date`.

## Report Requirements

The final report, compiled into a single PDF, must answer the following questions:

1. **Date Issues:** Determine the number of date issues in the overall data.
2. **Claims per Year:** Count the number of claims per year of `Incident_Date` and include a plot.
3. **Dynamic Input:** Allow the user to input a specific state value and answer the following:
   - Frequency values for `Claim_Type`.
   - Frequency values for `Claim_Site`.
   - Frequency values for `Disposition`.
   - Mean, minimum, maximum, and sum of `Close_Amount`, rounded to the nearest integer.

## Usage

To run the analysis:

1. Ensure SAS software is installed.
2. Clone or download the repository.
3. Import the `TSAClaims2002_2017.csv` file into SAS.
4. Execute the SAS code provided in the project.
5. Generate the final report in PDF format.

## Note

This project is for educational and illustrative purposes only. The provided requirements are specific to this case study and do not represent actual TSA requirements.

Copyright © 2018, SAS Institute Inc., Cary, North Carolina, USA. ALL RIGHTS RESERVED.
