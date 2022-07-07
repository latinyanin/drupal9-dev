<?php

/**
 * @file
 * Drupal site-specific configuration file.
 */

$databases = [
  "default" => [
    "default" => [
      "database" => $_ENV['MYSQL_DATABASE'],
      "username" => $_ENV['MYSQL_USER'],
      "password" => $_ENV['MYSQL_PASSWORD'],
      "host" => "db",
      "port" => "3306",
      "driver" => "mysql",
      "prefix" => "",
    ],
  ],
];

$settings["file_temp_path"] = '/tmp';
$settings['config_sync_directory'] = dirname(DRUPAL_ROOT) . '/configs';
$settings['file_public_path'] = 'sites/default/files';
$settings['file_private_path'] = __DIR__ . '/files/private';
$settings['trusted_host_patterns'] = ['^localhost$'];
$settings["hash_salt"] = 'sgaftdghyrtwhybfdazfdsagtrehyrth';
$config['smtp.settings']['smtp_on'] = TRUE;
$config['smtp.settings']['smtp_host'] = 'mailhog';
$config['smtp.settings']['smtp_port'] = '1025';
$config['smtp.settings']['smtp_username'] = '';
$config['smtp.settings']['smtp_password'] = '';
$config['smtp.settings']['smtp_protocol'] = 'standard';
$config['smtp.settings']['smtp_autotls'] = false;
$config['smtp.settings']['smtp_timeout'] = 30;
$config['smtp.settings']['smtp_allowhtml'] = 1;
