/*
Author:  Peter Leese
© 2025, The University of North Carolina at Chapel Hill. The code is licensed under the MIT license and permission is granted to use in accordance with the MIT license.
*/

--combine extracted hcpcs data back together minus places where hcpc is null or empty

CREATE TABLE hcpcs_all AS

SELECT * FROM hcpcs
where length(hcpc)>0

UNION

select * from beg_hcpcs
where length(hcpc)>0

UNION

select * from end_hcpcs
where length(hcpc)>0

