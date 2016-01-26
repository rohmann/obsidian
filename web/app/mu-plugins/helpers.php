<?php

function print_json( $data ) {
	echo json_encode( $data, JSON_PRETTY_PRINT );
}

if ( ! function_exists('dd') ) :
	function dd( $data ) {
		var_dump( $data );
		die();
	}
endif;

function jsond( $data ) {
	print_json( $data );
	die();
}

function obsidian_log_clear() {
	unlink(ABSPATH . "../obsidian.log");
}

function obsidian_log( $message ) {

	ob_start();

	if ( is_scalar( $message ) ) {
		echo $message;
	} else {
		var_dump($message);
	}
	echo "\n\n";

	error_log( ob_get_clean(), 3, ABSPATH . "../obsidian.log");
}
