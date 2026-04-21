-- Seasonal Consumption Patterns (Average by Month Name)
-- Chart type: Bar Chart
-- Identify peak seasons across years
SELECT 
    d.mois,
    AVG(total_mensuel) AS moyenne_consommation
FROM (
    SELECT 
        d.annee, 
        d.mois, 
        SUM(ct.quantite) AS total_mensuel
    FROM analytics.consommation AS ct
    JOIN analytics.date AS d ON d.id_date = ct.id_date
    GROUP BY d.annee, d.mois
) AS monthly_agg
JOIN analytics.date AS d ON d.mois = monthly_agg.mois
GROUP BY d.mois, d.num_mois
ORDER BY d.num_mois;
