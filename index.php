<?php

declare(strict_types=1);

spl_autoload_register(function ($class) {
    require __DIR__ . "/src/$class.php";
});
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, PUT, GET, OPTIONS");
header("Content-type: application/json; charset=UTF-8");

$parts = explode("/api/v1/", strtok($_SERVER["REQUEST_URI"], "?"));

if(!isset($parts[1])) {
    http_response_code(501);
    exit;
}

// var_dump($parts[1]);

$database = new Database("localhost", "chestionar", "root", "");

$controller = new TestController($database);

$controller->processRequest($_SERVER["REQUEST_METHOD"], "/$parts[1]");

// $bytes = random_bytes(4);
// var_dump(bin2hex($bytes));