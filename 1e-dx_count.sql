/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--count diagnoses for each visit

CREATE TABLE dx_count 
SELECT visit_occurrence_id,
 person_id, 
 count(condition_occurrence_id) as dx_count,
 min(condition_start_date) as min_dx_date,
 max(condition_start_date) as max_dx_date
FROM omop.condition_occurrence
group by visit_occurrence_id, person_id

