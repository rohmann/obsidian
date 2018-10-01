<?php

if ( ! function_exists('dd') ) :
	function dd( $data, $pre = true ) {
		echo '<pre>';
		var_dump( $data );
		echo '</pre>';
		die();
	}
endif;

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
