mysql> select titreform, nomsess, datedebut, datefin from formation
    -> join session
    -> on formation.codeform = session.codeform;
+-------------------+--------------+------------+------------+
| titreform         | nomsess      | datedebut  | datefin    |
+-------------------+--------------+------------+------------+
| Programming Java  | Session 1101 | 2022-01-02 | 2022-01-14 |
| Programming Java  | Session 1102 | 2022-02-03 | 2022-02-15 |
| web developpment  | Session 1201 | 2022-03-04 | 2022-03-18 |
| web developpment  | Session 1202 | 2022-04-05 | 2022-04-19 |
| Anglais technique | Session 1301 | 2022-01-06 | 2022-01-21 |
| Anglais technique | Session 1302 | 2022-05-07 | 2022-05-22 |
| Anglais technique | Session 1303 | 2022-06-08 | 2022-06-23 |
| Communication     | Session 1401 | 2022-09-01 | 2022-09-11 |
+-------------------+--------------+------------+------------+
8 rows in set (0.00 sec)

mysql> select titreform, nometu, prenometu from inscription
    -> join session on session.codesess = inscription.codesess
    -> join formation on session.codeform = formation.codeform
    -> join etudiant on etudiant.numCINEtu = inscription.numCINEtu
    -> order by titreform;
+------------------+---------------+-----------+
| titreform        | nometu        | prenometu |
+------------------+---------------+-----------+
| Programming Java | Alami         | Ahmad     |
| Programming Java | Souni         | Sanaa     |
| Programming Java | Idrissi Alami | Mohammed  |
| Programming Java | Toumi         | Aicha     |
| Programming Java | Ben Omar      | Abd Allah |
| Programming Java | Ouled thami   | Ali       |
| web developpment | Alami         | Ahmad     |
| web developpment | Souni         | Sanaa     |
| web developpment | Idrissi Alami | Mohammed  |
| web developpment | Toumi         | Aicha     |
| web developpment | Ben Omar      | Abd Allah |
| web developpment | Ouled thami   | Ali       |
+------------------+---------------+-----------+
12 rows in set (0.00 sec)

mysql> select count(titreform) from inscription
    -> join session on session.codesess = inscription.codesess
    -> join formation on session.codeform = formation.codeform
    -> where titreform = 'web developpment';
+------------------+
| count(titreform) |
+------------------+
|                6 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT formation.titreform, COUNT(inscription.numCINEtu)
    -> FROM formation
    -> JOIN session ON formation.codeform = session.codeform
    ->  JOIN inscription ON session.codesess = inscription.codesess
    -> WHERE inscription.typecours = 'Distanciel'
    -> GROUP BY formation.titreform
    -> HAVING COUNT(inscription.numCINEtu) >= 3;
+------------------+------------------------------+
| titreform        | COUNT(inscription.numCINEtu) |
+------------------+------------------------------+
| Programming Java |                            6 |
+------------------+------------------------------+
1 row in set (0.00 sec)

mysql> select nomspec, titreform, dureeform, prixform from catalogue
    -> join specialite on catalogue.codespec = specialite.codespec
    -> join formation on catalogue.codeform = formation.codeform
    -> where Active = 1
    -> order by nomspec desc;
+---------------+-------------------------+-----------+----------+
| nomspec       | titreform               | dureeform | prixform |
+---------------+-------------------------+-----------+----------+
| Langues       | Anglais technique       |        15 |     3750 |
| GL            | Programming Java        |        12 |     3600 |
| GL            | web developpment        |        14 |     4200 |
| GL            | Base de données Oracle  |        20 |     6000 |
| Data          | Base de données Oracle  |        20 |     6000 |
| Communication | Anglais technique       |        15 |     3750 |
| Communication | Communication           |        10 |     2500 |
| Communication | Soft skills             |        12 |     3000 |
+---------------+-------------------------+-----------+----------+
8 rows in set (0.00 sec)

mysql> SELECT YEAR(session.datedebut) AS Annee, MONTH(session.datedebut) AS Mois, SUM(formation.prixform) AS Total_Prix
    -> FROM formation
    -> JOIN session ON formation.codeform = session.codeform
    -> GROUP BY Annee, Mois;
+-------+------+------------+
| Annee | Mois | Total_Prix |
+-------+------+------------+
|  2022 |    1 |       7350 |
|  2022 |    2 |       3600 |
|  2022 |    3 |       4200 |
|  2022 |    4 |       4200 |
|  2022 |    5 |       3750 |
|  2022 |    6 |       3750 |
|  2022 |    9 |       2500 |
+-------+------+------------+
7 rows in set (0.01 sec)