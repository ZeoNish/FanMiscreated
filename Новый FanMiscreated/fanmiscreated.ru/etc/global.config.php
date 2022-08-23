<?php
if (!defined('ACCESS')) 
{
    header('Location: /');
    exit;
}


global $config;
$config = array();
$config['url'] = "http://fanmiscreated.ru";
$config['name'] = "FanMiscreated";
$config['description'] = "Первый сайт фанатов игры Miscreated в России";
$config['slogan'] = "Первый сайт фанатов игры Miscreated в России";
$config['keywords'] = "ключевые, слова, сайта";
$config['divider'] = " - ";
$config['charset'] = "utf-8";
$config['mainModule'] = "news";
$config['lang'] = "ru";
$config['uniqKey'] = "3w2tamjn";
$config['timezone'] = "Europe/Kaliningrad";
$config['tpl'] = "JMY_FanMiscreated";
$config['tpl_change'] = "0";
$config['smartphone'] = "1";
$config['dbType'] = "mysql";
$config['imageEffect'] = "shadowbox";
$config['support_mail'] = "admin@fanmiscreated.ru";
$config['gzip'] = "1";
$config['off'] = "0";
$config['off_text'] = "Сайт закрыт.<br /> Ведутся профилактические работы.";
$config['cache'] = "1";
$config['dbCache'] = "0";
$config['mod_rewrite'] = "1";
$config['comments'] = "1";
$config['plugin'] = "0";

