# Macrovisits: Resolving Clinical Encounter Heterogeneity in OMOP Data  

## Overview  

This repository contains code for constructing **macrovisits** and **high-confidence hospitalizations** from heterogeneous clinical encounter data in OMOP (Observational Medical Outcomes Partnership) format clinical data (this algorithm was specifically built using EHR data). The methods address fundamental challenges in working with multi-site networked EHR data, where local encounter definitions and recording practices vary significantly across organizations.

The code was developed and validated using data from the National COVID Cohort Collaborative (N3C), which networks data from 75 partner sites. While designed to be generalizable, site-specific tuning may be necessary for other OMOP-based systems.

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

## Getting Started

### Prerequisites

- SQL for encounter data manipulation
- R (3.5+) or Python (3.6+)
- OMOP-formatted data with visit_occurrence, diagnosis, procedure, and measurement tables
- Clinical codes mapped to OMOP standard vocabularies (DRG, CPT, HCPCS, SNOMED CT)

### Key Input Tables

- OMOP visit_occurrence and/or visit_detail depending on local OMOP implementation  
- OMOP diagnosis, procedure, medication, and measurement tables

## Important Notes

This code was developed on N3C OMOP data from 75 sites. **Performance in other OMOP systems is not guaranteed.** When applying to new data:

- Compare microvisit and macrovisit statistics to assess reasonable distributions
- Review sample macrovisits across sites for plausibility
- Examine LOS and resource density patterns for unexpected outliers
- Assess data quality through measurement frequency and completeness

## Citation
https://academic.oup.com/jamia/article-abstract/30/6/1125/7136721  

> Leese P, Anand A, Girvin A, et al. Clinical encounter heterogeneity and methods for resolving in networked EHR data: a study from N3C and RECOVER programs. *Journal of the American Medical Informatics Association*. 2023;30(6):1125-1136. https://doi.org/10.1093/jamia/ocad057

## Resources

- **RECOVER Initiative**: https://recovercovid.org
- **OMOP CDM**: https://ohdsi.org
- **N3C Data Enclave**: Foundry platform by Palantir Technologies
