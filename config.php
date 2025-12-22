<?php
unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '89.116.51.59';
$CFG->dbname    = 'moodle';
$CFG->dbuser    = 'moodle';          // o el que uses
$CFG->dbpass    = 'moodle';
$CFG->prefix    = 'mdl_';

$CFG->dboptions = [
    'dbpersist' => false,
    'dbport' => 3308,                 // 🔴 IMPORTANTE
    'dbsocket' => '',
    'dbcollation' => 'utf8mb4_unicode_ci',
];

$CFG->wwwroot   = 'https://alumnos.felipe-villa-nueva-teotitlan.site';
$CFG->dataroot  = '/var/www/moodledata';

$CFG->directorypermissions = 02777;

require_once(__DIR__ . '/lib/setup.php');
