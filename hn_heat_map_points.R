source("Rstart.R")

df <- read_csv("hn_greater_10.csv")

dow_format <- data_frame(dow = 0:6, dow_format = c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))

hour_format <- data_frame(hour = 0:23, hour_format = c(paste(c(12,1:11),"AM"), paste(c(12,1:11),"PM")))

df <- df %>% left_join(dow_format) %>% left_join(hour_format)

df$dow_format <- factor(df$dow_format, level = rev(dow_format$dow_format))
df$hour_format <- factor(df$hour_format, level = hour_format$hour_format)

###
### % > 10
###


plot <- ggplot(df, aes(x=hour_format, y=dow_format, fill=perc_greater_10)) +
	geom_tile() +
	fte_theme() +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.6), legend.title = element_blank(), legend.position="top", legend.direction="horizontal", legend.key.width=unit(1, "cm"), legend.key.height=unit(0.25, "cm"), legend.margin=unit(-0.5,"cm"), panel.margin=element_blank()) +
	labs(x = "Hour of HN Submission (Eastern Standard Time)", y = "Day of Week of HN Submission", title = "% of all Hacker News Submissions Which Receive 10+ Points, by Time of HN Submission") +
	scale_fill_gradient(low = "white", high = "#27ae60", labels=percent)
	
max_save(plot, "hn_gt10", "Hacker News Algolia API", w=6)

###
### Median
###

plot <- ggplot(df, aes(x=hour_format, y=dow_format, fill=med_score)) +
	geom_tile() +
	fte_theme() +
	theme(axis.text.x = element_text(angle = 90, vjust = 0.6), legend.title = element_blank(), legend.position="top", legend.direction="horizontal", legend.key.width=unit(1, "cm"), legend.key.height=unit(0.25, "cm"), legend.margin=unit(-0.5,"cm"), panel.margin=element_blank()) +
	labs(x = "Hour of HN Submission (Eastern Standard Time)", y = "Day of Week of HN Submission", title = "Median Score of all Hacker News Submissions, by Time of HN Submission") +
	scale_fill_gradient(low = "white", high = "#e74c3c", breaks=c(1,2), limits=c(0,2))
	
max_save(plot, "hn_median", "Hacker News Algolia API", w=6)
	