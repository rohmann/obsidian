<?php
/* Development */
use Roots\WPConfig\Config;

Config::define('SAVEQUERIES', true);
Config::define('WP_DEBUG', true);
Config::define('WP_DEBUG_LOG', true);
Config::define('WP_DEBUG_DISPLAY', true);
Config::define('SCRIPT_DEBUG', true);

// Enable plugin and theme updates and installation from the admin
Config::define('DISALLOW_FILE_MODS', false);

define('FS_METHOD', 'direct');
ini_set('xdebug.var_display_max_depth', '10');
ini_set('xdebug.var_display_max_children', '256');
ini_set('xdebug.var_display_max_data', '1024');
