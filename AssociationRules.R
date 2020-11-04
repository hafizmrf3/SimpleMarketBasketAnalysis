## Mengidentifikasi Bahan Makanan yang Sering Dibeli Konsumen ----
## Step 1: Explorasi dan mempersiapkan data ----

# load grocery data 
library(arules)
groceries <- read.transactions("H:/MEDIUM/Market Basket Analysis/groceries.csv", sep = ",")
summary(groceries)

# menampilkan 10 data teratas
inspect(groceries[1:10])

# mengecek frekuensi item
itemFrequency(groceries[, 1:3])

# plot frekuensi item
itemFrequencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, topN = 20)

# visualisasi matriks renggang untuk lima transaksi pertama
image(groceries[1:5])

# visualisasi sampel acak dari 100 transaksi
image(sample(groceries, 100))

## Step 2: Training model pada data ----
library(arules)

# secara default masih belum memiliki rules yang dipelajari
apriori(groceries)

# setting support and confidence levels untuk dapat lebih banyak rules yang dipelajari
groceryrules <- apriori(groceries, parameter = list(support =
                                                      0.006, confidence = 0.25, minlen = 2))
groceryrules

## Step 3: Evaluasi Performa Model ----
# Ringkasan dari Association Rules pada groecery data
summary(groceryrules)

# Menampilkan 3 rules teratas
inspect(groceryrules[1:3])

## Step 4: Meningkatkan performa model ----

# mengurutkan 5 grocery rules teratas berdasarkan lift value
inspect(sort(groceryrules, by = "lift")[1:5])

# menemukan subset dari rules yang berisi item cream cheese
creamcheeserules <- subset(groceryrules, items %in% "cream cheese")
inspect(creamcheeserules)

# menyimpan rules ke dalam CSV File
write(groceryrules, file = "H:/MEDIUM/Market Basket Analysis/groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# mengkonversi rules set ke dalam data frame
groceryrules_df <- as(groceryrules, "data.frame")
str(groceryrules_df)
