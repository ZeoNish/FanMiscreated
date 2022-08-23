<?php
if (!defined('ACCESS')) {
    header('Location: /');
    exit;
}


$url_gallery_general = 'http://api.vk.com/method/photos.get?gid=70429896&aid=217510347'; 
//делаем запрос к API, забираем  из GET запроса ID нашего альбома, который мы получили благодаря предыдущему скрипту.  
$content_general = file_get_contents($url_gallery_general);
$json_general = json_decode($content_general, true);
 
array_splice($json_general['response'], 0, -20);

foreach( array_reverse ($json_general['response']) as $item) {
$img_general = '<a class="src_img" href=' . $item['src_xxbig'] . ' data-lightbox="example-set" data-title="Используйте стрелки для того что бы листать изображения"><img src=' . $item['src'] . ' alt=""/></a>'; //находим все наши src_xxbig и делаем из них картинку, с помощью всеми любимого тега <img></img>
    
	print $img_general;
	
}
