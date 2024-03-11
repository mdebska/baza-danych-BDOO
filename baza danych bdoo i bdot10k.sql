CREATE EXTENSION postgis;

-- tabele typów podstawowych
CREATE TABLE bt_cyklzyciainfo (
    id serial PRIMARY KEY,
    koniecWersjiObiektu timestamp,
    poczatekWersjiObiektu timestamp not null
);

CREATE TABLE bt_idmaterialu (
    id serial PRIMARY KEY,
    pierwszyCzlon text REFERENCES bt_oznaczeniezasobu(id) not null,
    drugiCzlon text not null,
    trzeciCzlon integer not null,
    czwartyCzlon integer not null
);

-- tabele słownikowe
CREATE TABLE bdz_zrodlo (
	id text PRIMARY KEY,
	nazwa text
);

CREATE TABLE bt_oznaczeniezasobu (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE bdz_rodzajobprzyrodn (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE bdz_rodzajoborient (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE ot_rodzajobszaruwody (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE ot_katdokladnosci (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE ot_zrodlodanych (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE pt_rodzajreprgeom (
	id text PRIMARY KEY,
	nazwa text 
);

CREATE TABLE bdz_rodzajmokradla (
	id text PRIMARY KEY,
	nazwa text 
);

-- reszta tabel
CREATE TABLE bdz_obiektbdot500 (
	idllP text PRIMARY KEY,
    startObiekt date not null,
    cyklZyciaObiektu integer REFERENCES bt_cyklzyciainfo(id) not null,
    koniecObiekt date,
    zrodlo text REFERENCES bdz_zrodlo(id) not null,
    idMaterialu integer REFERENCES bt_idmaterialu(id),
    dokument text,
    informacja text
);

CREATE TABLE bdz_mokradlo (
	idllP text PRIMARY KEY,
    startObiekt date not null,
    cyklZyciaObiektu integer REFERENCES bt_cyklzyciainfo(id) not null,
    koniecObiekt date,
    zrodlo text REFERENCES bdz_zrodlo(id) not null,
    idMaterialu integer REFERENCES bt_idmaterialu(id),
    dokument text,
    informacja text,
	geometria geometry(POLYGON, 2180) not null,
	rodzajMokradla text REFERENCES bdz_rodzajmokradla(id) not null	
);

CREATE TABLE bdz_szuwary (
	idllP text PRIMARY KEY,
    startObiekt date not null,
    cyklZyciaObiektu integer REFERENCES bt_cyklzyciainfo(id) not null,
    koniecObiekt date,
    zrodlo text REFERENCES bdz_zrodlo(id) not null,
    idMaterialu integer REFERENCES bt_idmaterialu(id),
    dokument text,
    informacja text,
	geometria geometry(POLYGON, 2180) not null
);

CREATE TABLE bdz_obiektprzyrodniczy (
    idllP text PRIMARY KEY,
    startObiekt date not null,
    cyklZyciaObiektu integer REFERENCES bt_cyklzyciainfo(id) not null,
    koniecObiekt date,
    zrodlo text REFERENCES bdz_zrodlo(id) not null,
    idMaterialu integer REFERENCES bt_idmaterialu(id),
    dokument text,
    informacja text,
    geometria geometry(POINT, 2180) not null,
    pomnikPrzyrody boolean,
    rodzajOBPrzyr text REFERENCES bdz_rodzajobprzyrodn(id) not null
);

CREATE TABLE bdz_obiektoznaczeniuorientacyjnymwterenie (
	idllP text PRIMARY KEY,
    startObiekt date not null,
    cyklZyciaObiektu integer REFERENCES bt_cyklzyciainfo(id) not null,
    koniecObiekt date,
    zrodlo text REFERENCES bdz_zrodlo(id) not null,
    idMaterialu integer REFERENCES bt_idmaterialu(id),
    dokument text,
    informacja text,
	geometria geometry(POINT, 2180) not null,
	rodzajObOrient text REFERENCES bdz_rodzajoborient(id) not null
);

-- CREATE TABLE ot_obiekttopograficzny (
-- 	idllP text PRIMARY KEY,
-- 	czyObiektBDOO boolean not null,
-- 	x_kod text not null,
-- 	x_katDoklGeom text REFERENCES OT_KatDokladnosci(id) not null,
-- 	x_dklGeom real,
-- 	x_zrodloDanychG text REFERENCES OT_ZrodloDanych(id) not null,
-- 	x_zrodloDanychA text REFERENCES OT_ZrodloDanych(id) not null,
-- 	x_rodzajReprGeom text REFERENCES OT_RodzajReprGeom(id) not null,
-- 	x_uwagi text,
-- 	x_aktualnoscG date not null,
-- 	x_aktualnoscA date not null,
-- 	x_uzytkownik text not null,
-- 	x_cyklZycia integer REFERENCES BT_CyklZyciaInfo(id) not null,
-- 	x_dataUtworzenia date not null,
-- 	x_informDodatkowa text
-- );

-- CREATE TABLE OT_PokrycieTerenu (
-- 	idllP text PRIMARY KEY,
-- 	czyObiektBDOO boolean not null,
-- 	x_kod text not null,
-- 	x_katDoklGeom text REFERENCES OT_KatDokladnosci(id) not null,
-- 	x_dklGeom real,
-- 	x_zrodloDanychG text REFERENCES OT_ZrodloDanych(id) not null,
-- 	x_zrodloDanychA text REFERENCES OT_ZrodloDanych(id) not null,
-- 	x_rodzajReprGeom text REFERENCES OT_RodzajReprGeom(id) not null,
-- 	x_uwagi text,
-- 	x_aktualnoscG date not null,
-- 	x_aktualnoscA date not null,
-- 	x_uzytkownik text not null,
-- 	x_cyklZycia integer REFERENCES BT_CyklZyciaInfo(id) not null,
-- 	x_dataUtworzenia date not null,
-- 	x_informDodatkowa text,
-- 	geometria geometry(POLYGON, 2180) not null
-- ); 

CREATE TABLE ot_zbiornikwodny (
	idllP text PRIMARY KEY,
	idPRNG text not null,
	nazwa text not null,
	x_informDodatkowa text,
	x_aktualnoscA date not null
);

CREATE TABLE ot_ptwp_a (
	idllP text PRIMARY KEY,
	idMPHP text,
	poziomWody real,
	rodzaj text REFERENCES ot_rodzajobszaruwody(id) not null,
	czyObiektBDOO boolean not null,
	x_kod text not null,
	x_katDoklGeom text REFERENCES ot_katdokladnosci(id) not null,
	x_dklGeom real,
	x_zrodloDanychG text REFERENCES ot_zrodlodanych(id) not null,
	x_zrodloDanychA text REFERENCES ot_zrodlodanych(id) not null,
	x_rodzajReprGeom text REFERENCES ot_rodzajreprgeom(id) not null,
	x_uwagi text,
	x_aktualnoscG date not null,
	x_aktualnoscA date not null,
	x_uzytkownik text not null,
	x_cyklZycia integer REFERENCES bt_cyklzyciainfo(id) not null,
	x_dataUtworzenia date not null,
	x_informDodatkowa text,
	geometria geometry(POLYGON, 2180) not null,
	id_zbWodny text REFERENCES ot_zbiornikwodny(idllP),
	id_ciek text REFERENCES ot_ciek(idPRNG)
);

CREATE TABLE ot_ciek (
	idPRNG text PRIMARY KEY,
	nazwa text not null,
	dlugosc real not null
);

-- widoki zmaterializowane
CREATE MATERIALIZED VIEW mv_ptwp_a as
SELECT a.idllP, a.idMPHP, a.czyObiektBDOO, a.geometria
FROM ot_ptwp_a as a
LEFT JOIN ot_rodzajobszaruwody as w on w.id = a.rodzaj
LEFT JOIN ot_katdokladnosci as d on d.id = a.x_katDoklGeom
LEFT JOIN ot_zrodlodanych as z on z.id = a.x_zrodloDanychG
LEFT JOIN ot_zrodlodanych as zd on zd.id = a.x_zrodloDanychA
LEFT JOIN ot_rodzajreprgeom as r on r.id = a.x_rodzajReprGeom
WITH DATA;

CREATE UNIQUE INDEX mv_ptwp_a_idx on mv_ptwp_a using btree(idllP);
CREATE INDEX mv_ptwp_a_sdx on mv_ptwp_a using gist(geometria);

CREATE MATERIALIZED VIEW mv_obprzyr as
SELECT p.idllP, p.pomnikPrzyrody, p.geometria
FROM bdz_obiektprzyrodniczy as p
LEFT JOIN bdz_zrodlo as z on z.id = p.zrodlo
LEFT JOIN bdz_rodzajobprzyrodn as o on o.id = p.rodzajOBPrzyr
WITH DATA;

CREATE UNIQUE INDEX mv_obprzyr_idx on mv_obprzyr using btree(idllP);
CREATE INDEX mv_obprzyr_sdx on mv_obprzyr using gist(geometria);

CREATE MATERIALIZED VIEW mv_obort as
SELECT t.idllP, t.geometria
FROM bdz_obiektoznaczeniuorientacyjnymwterenie as t
LEFT JOIN bdz_zrodlo as z on z.id = t.zrodlo
LEFT JOIN bdz_rodzajoborient as o on o.id = t.rodzajObOrient  
WITH DATA;

CREATE UNIQUE INDEX mv_obort_idx on mv_obort using btree(idllP);
CREATE INDEX mv_obort_sdx on mv_obort using gist(geometria);

-- indeksy
-- CREATE INDEX idx_a_idllP on OT_PTWP_A using btree(idllP);
CREATE INDEX idx_a_rodzaj on ot_ptwp_a(rodzaj);
CREATE INDEX idx_a_x_katDoklGeom on ot_ptwp_a(x_katDoklGeom );
CREATE INDEX idx_a_Ex_zrodloDanychG on ot_ptwp_a(x_zrodloDanychG);
CREATE INDEX idx_a_Ex_zrodloDanychA on ot_ptwp_a(x_zrodloDanychA);
CREATE INDEX idx_a_x_rodzajReprGeom on ot_ptwp_a(x_rodzajReprGeom);
CREATE INDEX idx_a_x_cyklZycia on ot_ptwp_a(x_cyklZycia);
CREATE INDEX sdx_a_geometria on ot_ptwp_a using gist(geometria);

-- CREATE INDEX idx_p_idllP on BDZ_ObiektPrzyrodniczy using btree(idllP);
CREATE INDEX idx_p_cyklZyciaObiektu on bdz_obiektprzyrodniczy(cyklZyciaObiektu);
CREATE INDEX idx_p_zrodlo on bdz_obiektprzyrodniczy(zrodlo);
CREATE INDEX idx_p_idMaterialu on bdz_obiektprzyrodniczy(idMaterialu);
CREATE INDEX idx_p_rodzajOBPrzyr on bdz_obiektprzyrodniczy(rodzajOBPrzyr);
CREATE INDEX sdx_p_geometria on bdz_obiektprzyrodniczy using gist(geometria);

-- CREATE INDEX idx_t_idllP on BDZ_ObiektOZnaczeniuOrientacyjnymWTerenie using btree(idllP);
CREATE INDEX idx_t_cyklZyciaObiektu on bdz_obiektoznaczeniuorientacyjnymwterenie(cyklZyciaObiektu);
CREATE INDEX idx_t_zrodlo on bdz_obiektoznaczeniuorientacyjnymwterenie(zrodlo);
CREATE INDEX idx_t_idMaterialu on bdz_obiektoznaczeniuorientacyjnymwterenie(idMaterialu);
CREATE INDEX idx_t_rodzajObOrient on bdz_obiektoznaczeniuorientacyjnymwterenie(rodzajObOrient);
CREATE INDEX sdx_t_geometria on bdz_obiektoznaczeniuorientacyjnymwterenie using gist(geometria);

-- WEDŁUG DOKUMENTACJI POSTGISa INDEKSY NA KLUCZACH GŁÓWNYCH TWORZĄ SIĘ AUTOMATYCZNIE

-- trigger
CREATE FUNCTION fun_divide()
	RETURNS trigger as
	$$
		DECLARE
			new_idllP text;
		BEGIN
			IF ST_GeometryType(NEW.geometria) = 'MULTIPOLYGON' THEN
				FOR i IN 1..ST_NumGeometries(NEW.geometria) LOOP
					new_idllP := NEW.idllP||'_'||i::text; 
      				INSERT INTO bdz_mokradlo(idllP, startObiekt, cyklZyciaObiektu, koniecObiekt, koniecObiekt, zrodlo, idMaterialu, dokument, informacja, rodzajMokradla) 
      				VALUES (new_idllP, NEW.startObiekt, NEW.cyklZyciaObiektu, NEW.koniecObiekt, NEW.zrodlo, NEW.idMaterialu, NEW.dokument, NEW.informacja, ST_GeometryN(NEW.geometria, i), NEW.rodzajMokradla);
    			END LOOP;
			ELSEIF ST_GeometryType(NEW.geometria) = 'POLYGON' THEN
				INSERT INTO bdz_mokradlo(idllP, startObiekt, cyklZyciaObiektu, koniecObiekt, koniecObiekt, zrodlo, idMaterialu, dokument, informacja, rodzajMokradla) 
      			VALUES (NEW.idllP, NEW.startObiekt, NEW.cyklZyciaObiektu, NEW.koniecObiekt, NEW.zrodlo, NEW.idMaterialu, NEW.dokument, NEW.informacja, ST_GeometryN(NEW.geometria, i), NEW.rodzajMokradla);
    		ELSE
				RAISE EXCEPTION 'Geometry type must be either MULTIPOLYGON or POLYGON';
			END IF;
		END;
	$$ language plpgsql volatile cost 100;
 
CREATE TRIGGER trg_divide
BEFORE INSERT ON bdz_mokradlo FOR EACH ROW EXECUTE FUNCTION fun_divide();  	

-- function
CREATE OR REPLACE FUNCTION gwiazdozbior (mid_x numeric, mid_y numeric, rad numeric, dist numeric)
	RETURNS void as 
	$$
	DECLARE 
    gwiazda geometry(MULTILINESTRING, 2180);
	ot_ptwp_a RECORD;
	bdz_obiektprzyrodniczy RECORD;
	BEGIN
		DROP TABLE IF EXISTS jeziora_obiekty_p;
			CREATE TABLE jeziora_obiekty_p(
				id serial PRIMARY KEY,
				geom geometry(MULTILINESTRING, 2180),
				id_jez integer,
				liczba integer
			);
		FOR ot_ptwp_a IN (SELECT * 
						 FROM ot_ptwp_a
						 WHERE ST_Within(ot_ptwp_a.geometria, ST_Buffer(ST_SetSRID(ST_MakePoint(mid_x, mid_y), 2180), rad))
						) LOOP
			gwiazda := NULL;
			FOR bdz_obiektprzyrodniczy IN (SELECT *
										   FROM bdz_obiektprzyrodniczy
										   WHERE ST_Within(bdz_obiektprzyrodniczy.geometria, ST_Buffer(ot_ptwp_a.geometria, dist))
										  ) LOOP
				gwiazda := ST_Collect(gwiazda, ST_MakeLine(ST_Centroid(ot_ptwp_a.geometria), bdz_obiektprzyrodniczy.geometria));
			END LOOP;
			IF gwiazda IS NOT NULL THEN
				INSERT INTO jeziora_obiekty_p (geom, id_jez, liczba) VALUES (gwiazda, ot_ptwp_a.idllP, ST_NumGeometries(gwiazda)); 
			END IF;
		END LOOP;
	END;
	$$ language plpgsql volatile cost 1000;
	
-- wartości słownikowe
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('figuraKapliczkaKrzyzPrzydrozny', 'fgk');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('fontanna', 'ftn');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('murHistoryczny', 'mhi');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('pomnik', 'pmn');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('pomostLubMolo', 'pom');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('ruinaZabytkowa', 'rzb');
INSERT INTO bdz_rodzajoborient(nazwa, id) VALUES ('inny', 'i');

INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('pomiarNaOsnowe', 'O');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('digitalizacjaWektoryzacja', 'D');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('fotogrametria', 'F');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('pomiarWOparciuOElementyMapy', 'M');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('inne', 'I');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('nieokreslone', 'X');
INSERT INTO bdz_zrodlo(nazwa, id) VALUES ('niepoprawne', 'N');

INSERT INTO bt_oznaczeniezasobu(nazwa, id) VALUES ('centralny', 'C');
INSERT INTO bt_oznaczeniezasobu(nazwa, id) VALUES ('wojewodzki', 'W');
INSERT INTO bt_oznaczeniezasobu(nazwa, id) VALUES ('powiatowy', 'P');

INSERT INTO bdz_rodzajobprzyrodn(nazwa, id) VALUES ('drzewoiglaste', 'di');
INSERT INTO bdz_rodzajobprzyrodn(nazwa, id) VALUES ('drzewoLisciaste', 'dl');
INSERT INTO bdz_rodzajobprzyrodn(nazwa, id) VALUES ('wodospad', 'wds');
INSERT INTO bdz_rodzajobprzyrodn(nazwa, id) VALUES ('zrodlo', 'zrd');
INSERT INTO bdz_rodzajobprzyrodn(nazwa, id) VALUES ('inny', 'i');

INSERT INTO ot_rodzajobszaruwody(nazwa, id) VALUES ('wodyMorskie', 'Pm');
INSERT INTO ot_rodzajobszaruwody(nazwa, id) VALUES ('wodyPlynace', 'Pp');
INSERT INTO ot_rodzajobszaruwody(nazwa, id) VALUES ('wodyStojace', 'Ps');

INSERT INTO ot_katdokladnosci(nazwa, id) VALUES ('dokladny', 'Dok');
INSERT INTO ot_katdokladnosci(nazwa, id) VALUES ('przyblizony', 'Prz');
INSERT INTO ot_katdokladnosci(nazwa, id) VALUES ('niepewny', 'Npw');

INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychGeodezyjnychGrawimetrycznych', 'GEOS');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('ewidencjaGruntowIBudynkow', 'EGiB');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('geodezyjnaEwidencjaSieciUzbrojeniaTerenu', 'GESUT');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychPanstwowegoRejestruGranic', 'PRG');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('panstwowyRejestrNazwGeograficznych', 'PRNG');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('ewidencjaMiejscowosciUlicIAdresow', 'EMUiA');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('rejestrCenWartosciNieruchomosci', 'RCiWN');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychOgolnogeograficznych', 'BDO');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('ortofotomapa', 'Ort');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('mapaZasadnicza', 'Mz');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('mapaTopograficzna10k', 'Mtp10');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('mapaTopograficzna50k', 'Mtp50');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('vmapLevel2PierwszejEdycji', 'VMAPL2_v1');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('vmapLevel2DrugiejEdycji', 'VMAPL2_v2');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychTopograficznych', 'TBD');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychCLC', 'CORINE');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('centralnyRejestrFormOchronyPrzyrody', 'CRFOP');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bankDanychDrogowych', 'BDD');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazaDanychWglnstrk1', 'BDOT5000');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('krajowySystemObszarowChronionych', 'KSOCH');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('lesnaMapaNumeryczna', 'LMN');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('mapaPodzialuHydrograficznegoPolski', 'MPHP');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('bazyDanychPKP', 'PKP');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('rejestrZabytkow', 'RZAB');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('krajowyRejestrUrzedowyPodzialuTerytorialnegoKraju', 'TERYT');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('pomiarStereoskopowy', 'Str');
INSERT INTO ot_zrodlodanych(nazwa, id) VALUES ('pomiarTerenowy', 'Tm');

INSERT INTO ot_rodzajreprgeom(nazwa, id) VALUES ('liniaUmowna', 'Lm');
INSERT INTO ot_rodzajreprgeom(nazwa, id) VALUES ('sztucznyLacznik', 'Sl');

INSERT INTO bdz_rodzajmokradla(nazwa, id) VALUES ('bagno', 'b');
INSERT INTO bdz_rodzajmokradla(nazwa, id) VALUES ('terenPodmokly', 'tp');


