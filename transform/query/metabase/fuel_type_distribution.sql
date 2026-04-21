-- Fuel Type Distribution per Province (Percentage)
--  Chart type: Stacked Bar Chart or Pie Chart
-- Shows the energy mix for each region (e.g., more GO in industrial areas)
WITH province_total AS (
    SELECT 
        p.nom AS province,
        SUM(ct.quantite) as grand_total
    FROM analytics.consommation AS ct
    JOIN analytics.province AS p ON p.id_province = ct.id_province
    GROUP BY p.nom
)
SELECT 
    p.nom AS province,
    c.carburant_type,
    SUM(ct.quantite) AS quantite_type,
    ROUND((SUM(ct.quantite) / pt.grand_total) * 100, 2) AS percentage_of_total
FROM analytics.consommation AS ct
JOIN analytics.province AS p ON p.id_province = ct.id_province
JOIN analytics.carburant AS c ON c.id_carburant = ct.id_carburant
JOIN province_total pt ON pt.province = p.nom
GROUP BY p.nom, c.carburant_type, pt.grand_total
ORDER BY p.nom, percentage_of_total DESC;
