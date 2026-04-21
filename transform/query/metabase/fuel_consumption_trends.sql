-- Monthly Fuel Consumption Trends by Fuel Type
-- Chart type: Line chart
-- Best for time-series visualization to see which fuels are growing in popularity
SELECT 
    d.annee,
    d.mois,
    c.carburant_type,
    SUM(ct.quantite) AS total_quantite
FROM analytics.consommation AS ct
JOIN analytics.date AS d ON d.id_date = ct.id_date
JOIN analytics.carburant AS c ON c.id_carburant = ct.id_carburant
GROUP BY d.annee, d.id_date, d.mois, d.num_mois, c.carburant_type
ORDER BY d.annee, d.num_mois, c.carburant_type;
