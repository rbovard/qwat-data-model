/*
	qWat - QGIS Water Module
	
	SQL file :: draw lines from subscriber to their pipe

*/



CREATE OR REPLACE VIEW qwat_od.subscriber_pipe_relation AS
	SELECT
		a.id as id,
		a.identification,
		ST_MakeLine(a.geometry,ST_Line_Interpolate_Point(b.geometry,.5))::geometry(LineString,:SRID) AS geometry
	FROM 
		qwat_od.vw_element_subscriber a
	INNER JOIN 
		qwat_od.pipe b ON a.fk_pipe = b.id
	WHERE 
		a.fk_pipe IS NOT NULL;	
