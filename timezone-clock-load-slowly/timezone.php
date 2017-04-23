<?php
//header("Content-Type: application/xml; charset=utf-8");

if (!file_exists("db.json")) {
	$zones = [];
	file_put_contents("db.json", json_encode($zones));
} else {
	$zones = (array) json_decode(file_get_contents("db.json"));
}

$cord = explode("/", $_SERVER['REQUEST_URI']);
$cord = "{$cord[3]},{$cord[4]}";

if (! isset($zones[$cord])) {
	$opts = stream_context_create(array(
		'http'=> array(
			'method' => 'GET',
			'header'=> 'Host: www.saythetime.com',
		)
	));
	$content = file_get_contents('http://74.125.68.121' . $_SERVER['REQUEST_URI'], false, $opts);
	$timezone = substr($content, strpos($content, "<timezoneId>") + 12, strpos($content, "</timezoneId>") - strpos($content, "<timezoneId>") - 12);
	
	// Race conditions
	$zones = (array) json_decode(file_get_contents("db.json"));
	$zones[$cord] = $timezone;
	file_put_contents("db.json", json_encode($zones));
}

date_default_timezone_set($zones[$cord]);
$date = date('Y-m-d H:i') ;

// var_dump($cord, $cord_hash, $_SERVER);
?><?xml version="1.0" encoding="UTF-8" standalone="no"?>
<geonames>
<timezone tzversion="tzdata2016a">
<time><?= $date ?></time>
</timezone>
</geonames>


<?php
/*
Original output
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<geonames>
<timezone tzversion="tzdata2016a">
<countryCode>FR</countryCode>
<countryName>France</countryName>
<lat>48.85693</lat>
<lng>2.3412</lng>
<timezoneId>Europe/Paris</timezoneId>
<dstOffset>2.0</dstOffset>
<gmtOffset>1.0</gmtOffset>
<rawOffset>1.0</rawOffset>
<time>2016-04-28 19:13</time>
<sunrise>2016-04-28 06:34</sunrise>
<sunset>2016-04-28 21:02</sunset>
</timezone>
</geonames>
*/