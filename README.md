# Macrovisits: Resolving Clinical Encounter Heterogeneity in OMOP Data  

## Overview  

This repository contains code for constructing **macrovisits** and **high-confidence hospitalizations** from heterogeneous clinical encounter data in OMOP (Observational Medical Outcomes Partnership) format clinical data (this algorithm was specifically built using EHR data). The methods address fundamental challenges in working with multi-site networked EHR data, where local encounter definitions and recording practices vary significantly across organizations.

The code was developed and validated using data from the National COVID Cohort Collaborative (N3C), which networked data from >90 partner sites. While designed to be generalizable, site-specific tuning may be necessary for other OMOP-based systems.

## More Information on N3C
https://covid.cd2h.org/  
http://ncats.nih.gov/research/research-activities/n3c/overview  
https://n3c.ncats.nih.gov/  

## Citation for Leese, et al.
https://doi.org/10.1093/jamia/ocad057  

> Leese P, Anand A, Girvin A, et al. Clinical encounter heterogeneity and methods for resolving in networked EHR data: a study from N3C and RECOVER programs. *Journal of the American Medical Informatics Association*. 2023;30(6):1125-1136.  


## The Problem

Clinical encounter data in EHRs are inherently heterogeneous. Different organizations maintain their own encounter definitions, and when data are harmonized to a common data model, these local variations persist. This is particularly problematic for hospitalizations, which often span multiple days and involve many discrete service encounters (imaging, pharmacy, surgery, etc.). Different sites may represent the same hospitalization completely differently—some as a single encounter, others as many fragmented encounters—making reliable analysis very challenging.

## The Solution

**Macrovisits** are composite clinical care experiences constructed by aggregating related atomic OMOP encounter records ("microvisits") post-hoc into a single longitudinal analytical unit.

### Step 1: Macrovisit Aggregation

The algorithm identifies and merges overlapping microvisits based on temporal overlap and encounter type, creating a single macrovisit record that spans from the earliest start date to the latest end date of all merged components. Only inpatient-type and certain longitudinal outpatient encounters qualify for aggregation.

### Step 2: High-Confidence Hospitalization Classification

An ensemble approach classifies macrovisits as high-confidence hospitalizations if they contain any of:

- Diagnosis-Related Group (DRG) codes
- CMS-indicated inpatient-only CPT codes
- Inpatient or critical care (ICU) evaluation and management HCPCS codes
- Inpatient or ICU SNOMED CT procedure concepts
- ≥50 total resources (diagnoses + procedures + medications + measurements + observations)

This multi-criteria approach is robust to unreliable visit type assignments at the source.

## Outputs

- **Macrovisit records**: Aggregated encounters with composite metadata
- **Microvisit-to-macrovisit mapping**: Links component encounters to parent macrovisits
- **Hospitalization flags**: High-confidence hospitalization indicators with supporting evidence
- **Encounter metadata**: Inpatient-focused metrics and data quality indicators


### Code Source Environment Notes

This code was created and first implemented in the N3C enclave on a Palantir Foundry platform created through funding from the NIH. The macrovisit scaffold code and subsequent high-confidence hospitalization code was developed as SQL to allow both for utilization of SPARK-based distributed processing in Foundry and also to allow for easier implementation in other, non-SPARK based systems in future implementations.  

## Important Notes

This code was developed on N3C OMOP data from approximately 75 sites over 2022 and 2023.  **Performance in other OMOP systems is not guaranteed.** When applying to new data we suggest:

- Compare microvisit and macrovisit statistics to assess reasonable distributions
- Review sample macrovisits across sites for plausibility
- Examine LOS and resource density patterns for unexpected outliers
- Assess data quality through measurement frequency and completeness

## Code Authors
Macrovisit scaffold code:  Andrew Girvin, Emily Pfaff, Amin Manna, Peter Leese

High-Confidence Hospitalization code:  Peter Leese  

## Support  

This work was funded by the RECOVER Initiative (OT2HL161847–01). The analyses were conducted with data or tools accessed through the NCATS N3C Data Enclave (https://covid.cd2h.org) and N3C Attribution & Publication Policy v 1.2-2020-08-25b supported by NCATS U24 TR002306, Axle Informatics Subcontract: NCATS-P00438-B, and by the RECOVER Initiative (OT2HL161847–01). This content is solely the responsibility of the authors and does not necessarily represent the official views of the RECOVER Program, the NIH, or other funders.

The project described was supported by the National Center for Advancing Translational Sciences (NCATS), National Institutes of Health, through Grant Award Number UM1TR004406. The content is solely the responsibility of the authors and does not necessarily represent the official views of the NIH.




