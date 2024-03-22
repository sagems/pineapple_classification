# File for plotting raster data of the plantation location predictions in a visually--appealing manner

library(raster)
library(RColorBrewer)
library(ggplot2)
library(dplyr)

# Code for combining the separate raster geographic areas into one raster per year
{
  predictions1 <- raster('/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/rf_predicted_output_30m_2020_3.tif')
  predictions2 <- raster('/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/rf_predicted_output_30m_2020_2.tif')
  predictions3 <- raster('/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/rf_predicted_output_30m_2020_0.tif')
  
  combined_raster <- merge(predictions1, predictions2, predictions3)
  
  # Save the combined raster
  writeRaster(combined_raster, filename = '/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/rf_predicted_output_30m_2020_combined.tif', format = "GTiff")
  
  
}

# Load the raster data
predictions <- raster('/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/rf_predicted_output_30m_2023_combined.tif')
predictions <- na.omit(predictions)

# Define colors and graph title
colors2 <- c('#516EB0', '#FBF682')
graph_title <- '2023 Prediction Map'

# Set the size of the plot window
png('/Users/sagemcginley-smith/Desktop/Final_Pineapple_Predictions_131/2023_map.png', width = 1500, height = 1500) 

par(mar = c(12, 12, 10, 12))  # c(bottom, left, top, right)

# Plot the raster
plot(predictions, main = graph_title, 
     axes = FALSE, box = FALSE, legend = FALSE,
     col = colors2,
     cex.main = 3.5, cex.lab = 2,
     legend.width = 0.5,  # Adjust legend width
     legend.shrink = 0.8  # Adjust legend shrink
)

# Add legend
legend_labels <- c('No Plantation', 'Plantation')
legend_colors <- colors2
legend('topright', legend = legend_labels, cex = 1.5, fill = legend_colors, bty = "n")

# Save the plot
dev.off()
