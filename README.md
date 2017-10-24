==================================================================
HCRData Analysis for Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Hawking Liu
Shanghai
lzhhawking@126.come
==================================================================

This project mainly cleans the HCR data in the dataset directory.
Detailed explanation of the HCR data could be found in the README.txt
inside the dataset directory.

The 'run_analysis.R' file contains the R script to carry out the cleaning
and analyzing steps. The two output datasets are "HCRData.txt" and
"Avg_HCRData_for_Act_Sub.txt"

The dataset includes the following files:
=========================================
- 'README.md':

- 'CodeBook.txt': describe variables in both HCRData dataset and
  Avg_HCRData_for_Act_Sub dataset.

- 'run_analysis.R':
    step1: read and combine test and training datasets
    step2: assign measurements names and extract only mean() and std() measurements
    step3: combine subject index, label index and extracted Data together
    step4: match descriptive activity label name based on label index
    step5：create a dataset with the average of each variable for each activity and each subject.
    step6: write output datasets into separate txt files.

- 'HCRData.txt': a complete dataset contains both training and test data,
    also has descriptive variable names and activity label names.

- 'Avg_HCRData_for_Act_Sub.txt': average of each variable for each activity and each subject in HCRData
