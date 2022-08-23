<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
 <head>
 {%META%}
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" href="{%THEME%}/assest/images/favicon.png">
  <script src="{%THEME%}/assest/js/script.js"></script>
  <link href="{%THEME%}/assest/css/style.css" media="all" type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="{%THEME%}/assest/css/engine.css" type="text/css" media="all">
  <link rel="stylesheet" href="{%THEME%}/assest/lightbox/css/lightbox.css" type="text/css" media="all">
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
 
$(window).scroll(function(){
if ($(this).scrollTop() > 10) {
$('.up').fadeIn();
} else {
$('.up').fadeOut();
}
});
 
$('.up').click(function(){
$("html, body").animate({ scrollTop: 0 }, 600);
return false;
});
 
});
</script>
 </head>
 <body>
<div class="main">

<div class="up" title="Вверх"><a></a></div>

<div class="head">

{%TPL:fan_menu%}

{%TPL:fan_logo%}


<a href="#" title="Перейти на страницу покупки"><div class="buy">КУПИТЬ ИГРУ В STEAM</div></a>

{%TPL:fan_soc_panel%}

</div>

<div class="content">
<div class="left_content">

{%MODULE%} 

<!-- <div class="page_changer"></div> -->
</div>

{%TPL:fan_right_content%}

</div>

{%TPL:fan_footer%}

</div>
<div class="bgbg">
<img src="{%THEME%}/assest/images/bgbg_left.png" style="position: absolute;left: -190px;bottom: 0px;">
<img src="{%THEME%}/assest/images/bgbg_right.png" style="position: absolute; right: -190px; bottom: 0px;">
</div>
<script src="{%THEME%}/assest/lightbox/js/lightbox.js"></script>
 </body>
</html>