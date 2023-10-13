# Mod AlbertHeijn FA

Het DDL script kan je [hier](https://github.com/fckLatif/mod-albertheijn-fa/blob/main/mod-fa.sql) downloaden.

## De insert statements:

```sql
INSERT INTO public.aankoop (transactiebonuskaartnummer, productproductnummer, aantal) VALUES (2, 1, 2);
INSERT INTO public.aankoop (transactiebonuskaartnummer, productproductnummer, aantal) VALUES (2, 2, 1);
INSERT INTO public.aankoop (transactiebonuskaartnummer, productproductnummer, aantal) VALUES (2, 3, 1);
INSERT INTO public.aankoop (transactiebonuskaartnummer, productproductnummer, aantal) VALUES (3, 1, 1);
INSERT INTO public.aankoop (transactiebonuskaartnummer, productproductnummer, aantal) VALUES (4, 1, 2);

INSERT INTO public.bonuskaart (bonuskaartnummer, naam, adres, woonplaats) VALUES (65472335, NULL, NULL, NULL);
INSERT INTO public.bonuskaart (bonuskaartnummer, naam, adres, woonplaats) VALUES (12345678, 'Anette', 'Vredenburg 12', 'Utrecht');
INSERT INTO public.bonuskaart (bonuskaartnummer, naam, adres, woonplaats) VALUES (98765, 'Jazim', 'Trekkerspad 5', 'Houten');

INSERT INTO public.filiaal (filiaalnummer, plaats, adres) VALUES (35, 'Utrecht', 'Stationsplein 1');
INSERT INTO public.filiaal (filiaalnummer, plaats, adres) VALUES (48, 'Utrecht', 'Roelantdreef 41');
INSERT INTO public.filiaal (filiaalnummer, plaats, adres) VALUES (50, 'Utrecht', 'Biltstraat 90');

INSERT INTO public.product (productnummer, omschrijving, prijs) VALUES (1, 'pak AH halfvolle melk', 0.99);
INSERT INTO public.product (productnummer, omschrijving, prijs) VALUES (2, 'pot AH pindakaas', 2.39);
INSERT INTO public.product (productnummer, omschrijving, prijs) VALUES (3, 'tandenborstel', 1.35);
INSERT INTO public.product (productnummer, omschrijving, prijs) VALUES (4, 'zak Lays ribbelchips paprika', 1.19);
INSERT INTO public.product (productnummer, omschrijving, prijs) VALUES (5, '2 kg handsinaasappels', 3.45);

INSERT INTO public.transactie (transactienummer, datum, tijd, bonuskaartbonuskaartnummer, filiaalfiliaalnummer) VALUES (2, '2019-12-01', '17:35:00', 65472335, 35);
INSERT INTO public.transactie (transactienummer, datum, tijd, bonuskaartbonuskaartnummer, filiaalfiliaalnummer) VALUES (3, '2020-01-03', '12:25:00', 65472335, 48);
INSERT INTO public.transactie (transactienummer, datum, tijd, bonuskaartbonuskaartnummer, filiaalfiliaalnummer) VALUES (4, '2019-12-10', '08:30:00', 12345678, 35);
```

## De 3 gevraagde SQL Statements:

Toon de verschillende filialen (toon filiaalnummer, adres en plaats) waar een klant met bonuskaartnummer `65472335` boodschappen heeft gedaan en op welke datum.

```sql
SELECT f.filiaalnummer, f.adres, f.plaats, t.datum
FROM
    public.transactie t
    JOIN public.filiaal f ON t.filiaalfiliaalnummer = f.filiaalnummer
    JOIN public.bonuskaart b ON t.bonuskaartbonuskaartnummer = b.bonuskaartnummer
WHERE
    b.bonuskaartnummer = 65472335;
```

Toon het totaalbedrag dat de klant met bonuskaartnummer `65472335` heeft besteed aan boodschappen. Je hoeft dus alleen het totaalbedrag (1 waarde) te tonen, niet wat of wie of wanneer.

```sql
SELECT
    SUM(p.prijs * a.aantal) AS "Totaal Bedrag"
FROM
    public.aankoop a
    JOIN public.product p ON a.productproductnummer = p.productnummer
    JOIN public.transactie t ON a.transactiebonuskaartnummer = t.transactienummer
WHERE
    t.bonuskaartbonuskaartnummer = 65472335;
```

Toon het aantal maal dat de `AH halfvolle melk` is verkocht in de maand december 2019 bij een filiaal in Utrecht. Toon dus ook weer 1 waarde (niet in welk filiaal dat was of welk product etc.).

```sql
SELECT SUM(a.aantal) AS "Aantal Verkocht"
FROM public.aankoop AS a
JOIN public.product AS p ON a.productproductnummer = p.productnummer
JOIN public.transactie AS t ON a.transactiebonuskaartnummer = t.transactienummer
JOIN public.filiaal AS f ON t.filiaalfiliaalnummer = f.filiaalnummer
WHERE p.omschrijving = 'pak AH halfvolle melk'
    AND f.filiaalnummer = 35
    AND t.datum >= '2019-12-01' AND t.datum <= '2019-12-31';
```
