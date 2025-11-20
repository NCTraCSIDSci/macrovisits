/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--counts of drugs on each visit
CREATE TABLE drug_count 
SELECT visit_occurrence_id, 
person_id,
 count(drug_exposure_id) as drug_count,
  min(drug_exposure_start_date) as min_drug_date,
   max(drug_exposure_start_date) as max_drug_date
FROM omop.drug_exposure
group by visit_occurrence_id, person_id

