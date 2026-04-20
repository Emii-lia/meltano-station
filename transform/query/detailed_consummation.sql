SELECT ct.id_consommation, d.mois, d.annee, c.carburant_type, p.nom, ct.quantite
  FROM analytics.consommation as ct
  JOIN analytics.date as d ON d.id_date = ct.id_date
  JOIN analytics.carburant as c ON c.id_carburant = ct.id_carburant
  JOIN analytics.province p ON p.id_province = ct.id_province
  ORDER BY p.nom, d.id_date, c.carburant_type;