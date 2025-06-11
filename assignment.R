
# Load libraries
library(dplyr)
library(sentimentr)
library(plotly)
library(DiagrammeR)

# Read datasets
df1 <- read.csv("bank.csv")
df2 <- read.csv("shopping_trends.csv")
df3 <- read.csv("test.csv")
df4 <- read.csv("States.csv")

# Remove duplicates
df1_unique <- df1 %>% distinct(Age, .keep_all = TRUE)
df2_unique <- df2 %>% distinct(Age, .keep_all = TRUE)
df3_unique <- df3 %>% distinct(Age, .keep_all = TRUE)

# Merge datasets
inner_merged_data <- Reduce(function(x, y) inner_join(x, y, by = "Age"), list(df1_unique, df2_unique, df3_unique))
merged_data <- inner_merged_data %>% left_join(df4, by = "Location")

# Convert 'loan' to binary
inner_merged_data$loan <- ifelse(inner_merged_data$loan == "Yes", 1, 0)

# Logistic Regression
glm_model <- glm(loan ~ Category, data = inner_merged_data, family = binomial)
summary(glm_model)

# Linear Regression
lm_model <- lm(Purchase.Amount..USD. ~ Category, data = inner_merged_data)
summary(lm_model)

# Likelihood ratio test
lr_test <- anova(glm_model, lm_model, test = "Chisq")
print(lr_test)

# Sentiment analysis
inner_merged_data$review <- tolower(inner_merged_data$review)
sentiment <- sentiment_by(text = inner_merged_data$review)
print(sentiment)

# Scatter plot
plot1 <- plot_ly(data = inner_merged_data, x = ~Age, y = ~Purchase.Amount..USD., color = ~Category, type = "scatter", mode = "markers")
plot1

# Heatmap
correlation_matrix <- cor(merged_data[, c('Age', 'balance', 'duration', 'campaign', 'Purchase.Amount..USD.')])
heatmap <- plot_ly(z = correlation_matrix, x = colnames(correlation_matrix), y = colnames(correlation_matrix), type = 'heatmap') %>%
  layout(title = list(text = "Correlation Heatmap"))
heatmap

# Bar chart
avg_purchase_by_payment <- aggregate(Purchase.Amount..USD. ~ Preferred.Payment.Method, data = merged_data, FUN = mean)
plot_ly(avg_purchase_by_payment, x = ~Preferred.Payment.Method, y = ~Purchase.Amount..USD., type = 'bar', marker = list(color = '#FFA15A')) %>%
  layout(title = 'Average Purchase Amount by Preferred Payment Method', xaxis = list(title = 'Preferred Payment Method'), yaxis = list(title = 'Average Purchase Amount (USD)'))

# Flowchart
mermaid("
graph TD;
    A[Bank Dataset] -->|Merge by Age| E[Merged Dataset]
    B[Shopping Trends] -->|Merge by Age| E
    C[Reviews] -->|Merge by Age| E
    D[States] -->|Merge by Location| E
    E --> F(Data Cleaning)
    F --> G(Statistical & Sentiment Analysis)
    G --> H(Visualization)
    H --> I(HTML Report via Quarto)
")
