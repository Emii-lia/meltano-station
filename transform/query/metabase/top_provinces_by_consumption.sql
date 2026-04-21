-- Top 5 Provinces by Total Consumption
-- Chart type: Bar Chart (Leaderboard)
-- Quick leaderboard for the dashboard
SELECT 
    p.nom AS province,
    SUM(ct.quantite) AS total_historique
FROM analytics.consommation AS ct
JOIN analytics.province AS p ON p.id_province = ct.id_province
GROUP BY p.nom
ORDER BY total_historique DESC;
