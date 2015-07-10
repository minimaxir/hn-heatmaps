# hn-heatmaps
Code and data necessary to reproduce heatmaps relating HN Submission time to submission score.

![](http://i.imgur.com/MdUvMB9.png)

![](http://i.imgur.com/SN5BuAJ.png)

Data was retrieved using this SQL query in my PostgreSQL database filled using the code in [this repository](https://github.com/minimaxir/get-all-hacker-news-submissions-comments):

	SELECT date_part('dow', created_at)  AS dow,
		date_part('hour', created_at) As hour,
		COUNT(created_at) AS num_submissions,
		AVG(num_points) as avg_score,
		MEDIAN(num_points) as med_score,
		CAST(SUM(CASE WHEN num_points >= 10 THEN 1 ELSE 0 END) AS numeric) / COUNT(num_points) as perc_greater_10
	FROM hn_submissions
	GROUP BY dow, hour
	ORDER BY dow, hour

Requires packages declared at beginning of *Rstart.R*. Fonts will only render if code is run on OS X.