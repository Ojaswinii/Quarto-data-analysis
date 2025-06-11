
# Quarto Data Analysis Assignment

This project demonstrates an end-to-end data analysis workflow using R and Quarto. It covers data cleaning, merging multiple datasets, statistical modeling (GLM and linear regression), sentiment analysis, and interactive visualizations with Plotly.

## 📦 Packages Used

- `dplyr` – for data manipulation
- `plotly` – for interactive plots
- `sentimentr` – for sentiment analysis
- `DiagrammeR` – for flowchart visualization
- `quarto` – for rendering integrated documents

## 🧠 Key Concepts

- **Merging Datasets**: Combined 4 datasets on `Age` and `Location`.
- **Data Cleaning**: Removed duplicate entries and cleaned reviews.
- **Modeling**:
  - Logistic regression predicting `loan` by `Category`
  - Linear regression predicting `Purchase Amount` by `Category`
- **Sentiment Analysis**: Applied `sentimentr` to customer reviews.
- **Visualizations**:
  - Scatter plot by Age and Purchase Amount
  - Correlation heatmap
  - Bar chart of average purchase by payment method
  - Flowchart of process using Mermaid

## 📂 Files

- `assignment.R` – All R code
- `merged_data.csv` – Exported merged dataset
- `README.md` – Project documentation

## 📸 Outputs

- HTML report generated via Quarto
- Interactive Plotly graphs embedded

## 📌 How to Run

```R
# Run this script in RStudio
source("assignment.R")
```

Make sure all CSV files (`bank.csv`, `shopping_trends.csv`, `test.csv`, `States.csv`) are in your working directory.

## 👨‍🎓 Author

Created for academic purposes by [Your Name].
