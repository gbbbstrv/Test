<?php

/*
 * Editor server script for DB table test
 * Created by http://editor.datatables.net/generator
 */

// DataTables PHP library and database connection
include( "lib/DataTables.php" );

// Alias Editor classes so they are easy to use
use
	DataTables\Editor,
	DataTables\Editor\Field,
	DataTables\Editor\Format,
	DataTables\Editor\Mjoin,
	DataTables\Editor\Upload,
	DataTables\Editor\Validate;

//// The following statement can be removed after the first run (i.e. the database
//// table has been created). It is a good idea to do this to help improve
//// performance.
//$db->sql( "CREATE TABLE IF NOT EXISTS `test` (
//	`id` int(10) NOT NULL auto_increment,
//	`sdas` varchar(255),
//	`name` varchar(255),
//	`user` varchar(255),
//	PRIMARY KEY( `id` )
//);" );
//
//// Build our Editor instance and process the data coming from _POST
//Editor::inst( $db, 'test', 'id' )
//	->fields(
//		Field::inst( 'sdas' ),
//		Field::inst( 'name' ),
//		Field::inst( 'user' )
//	)
//	->process( $_POST )
//	->json();

// Build our Editor instance and process the data coming from _POST
Editor::inst( $db, 'datatables_demo' )
	->fields(
		Field::inst( 'first_name' )->validator( 'Validate::notEmpty' ),
		Field::inst( 'last_name' )->validator( 'Validate::notEmpty' ),
		Field::inst( 'position' ),
		Field::inst( 'email' ),
		Field::inst( 'office' ),
		Field::inst( 'extn' ),
		Field::inst( 'age' )
			->validator( 'Validate::numeric' )
			->setFormatter( 'Format::ifEmpty', null ),
		Field::inst( 'salary' )
			->validator( 'Validate::numeric' )
			->setFormatter( 'Format::ifEmpty', null ),
		Field::inst( 'start_date' )
			->validator( 'Validate::dateFormat', array(
				"empty"   => true,
				"format"  => Format::DATE_ISO_8601,
				"message" => "Please enter a date in the format yyyy-mm-dd"
			) )
			->getFormatter( 'Format::date_sql_to_format', Format::DATE_ISO_8601 )
			->setFormatter( 'Format::date_format_to_sql', Format::DATE_ISO_8601 )
	)
	->process( $_POST )
	->json();
    echo json();
