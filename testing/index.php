<?php

header_remove('X-Powered-By');
header('Content-Type: text/html');
header_remove('Content-Type');

$setting = $_GET['setting'] ?? null;

if ($setting === 'version') {
    echo phpversion();
    exit;
}

if ($setting) {
    echo ini_get($setting);
    exit;
}

phpinfo();
