USE flights_audit;

SELECT *
FROM vistara_data;

WITH market_conditions AS (
SELECT
	flight,
    source_city AS origin,
    departure_time AS departure,
    stops,
    arrival_time AS arrival,
    destination_city AS destination,
    duration,
    class,
    days_left,
    sales_channel,
    booking_class,
    base_fare,
	MAX(CASE
		WHEN sales_channel = 'Direct' THEN base_fare END) OVER (
        PARTITION BY flight, stops, class, days_left, source_city, departure_time, arrival_time, destination_city,
        duration) AS direct_web_fare,
    MIN(base_fare) OVER (
            PARTITION BY flight, stops, class, days_left, source_city, departure_time, arrival_time, destination_city,
        duration) AS market_min,
    AVG(base_fare) OVER (
            PARTITION BY flight, stops, class, days_left, source_city, departure_time, arrival_time, destination_city,
        duration) AS market_avg,
    MAX(base_fare) OVER (
            PARTITION BY flight, stops, class, days_left, source_city, departure_time, arrival_time, destination_city,
        duration) AS market_max,
    tax_fees,
    total_fare
FROM vistara_data
), compliance_testing AS (
SELECT
	flight,
    origin,
    departure,
    stops,
    arrival,
    destination,
    class,
    days_left,
    booking_class,
    sales_channel,
    base_fare,
    direct_web_fare,
    ROUND(market_min, 2) AS market_min,
    ROUND(market_avg, 2) AS market_avg,
    ROUND(market_max, 2) AS market_max,
    tax_fees,
    total_fare,
    (base_fare - direct_web_fare) AS price_variance,
    CASE 
           WHEN sales_channel != 'Direct_Web'
             AND base_fare < direct_web_fare
             THEN 'Revenue Leak: GDS/OTA Audit Required'
             
        WHEN sales_channel != 'Direct_Web'
             AND base_fare > direct_web_fare
             THEN 'GDA/OTA Friction: Audit Required'
		-- ========================================
        -- Note for 7-day window for Economy class
        -- ========================================
        WHEN days_left <= 7 
			AND sales_channel != 'Direct_Web'
            AND base_fare < direct_web_fare
            THEN 'Close-In Leak: GDS/OTA Audit Required'
            
		WHEN days_left <= 7 
			AND sales_channel != 'Direct_Web'
            AND base_fare > direct_web_fare
            THEN 'Close-In Friction: GDS/OTA Audit Required' 
		ELSE 'Compliant'
    END AS audit_classification
    FROM market_conditions
    )
    SELECT
		flight,
		origin,
		departure,
		stops,
		arrival,
		destination,
		class,
		days_left,
        booking_class,
		sales_channel,
		base_fare,
        direct_web_fare,
        price_variance,
		market_min,
		market_avg,
		market_max,
		tax_fees,
		total_fare,
		audit_classification
    FROM compliance_testing;
