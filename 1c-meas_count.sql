/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

    --count measures for each visit


CREATE TABLE meas_count
SELECT visit_occurrence_id, count(measurement_id) as meas_count
FROM omop.measurements
where visit_occurrence_id is not null
group by visit_occurrence_id

