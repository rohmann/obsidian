<?php

function print_json( $data ) {
	echo json_encode( $data, JSON_PRETTY_PRINT );
}

function dd( $data ) {
	var_dump( $data );
	die();
}

function jsond( $data ) {
	print_json( $data );
	die();
}