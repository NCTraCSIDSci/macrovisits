/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

CREATE TABLE inpt_hcpc_list AS
SELECT distinct visit_occurrence_id, cms_inpt
FROM cms_inpt_hcpcs

