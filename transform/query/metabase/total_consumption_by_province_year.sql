-- Total Fuel Consumption per Province and Year
-- Chart type: Map or Bar Chart
-- Useful for high-level geographic and temporal analysis
SELECT 
    p.nom AS province,
    d.annee,
    SUM(ct.quantite) AS total_quantite
FROM analytics.consommation AS ct
JOIN analytics.date AS d ON d.id_date = ct.id_date
JOIN analytics.province AS p ON p.id_province = ct.id_province
GROUP BY p.nom, d.annee
ORDER BY d.annee DESC, total_quantite DESC;
