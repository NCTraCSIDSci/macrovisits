/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

CREATE TABLE hospital_list AS
SELECT macrovisit_id, 
1 as likely_hospitalization
FROM macro_filter
where (drg is not null or max_cms_inpt=1 or max_resources>=50 or all_inpt=1 or all_icu=1)


