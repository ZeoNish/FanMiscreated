<div class="panel">
	[user]
	<!-- Если вошел -->
	<a href="{%URL_PROFIL%}" title="{%USER_NAME%}"><img class="ava_img" src="{%USER_AVATAR%}" /></a>
	<a href="{%URL_PROFIL%}" title="{%USER_NAME%}"><span class="nick_name">{%USER_NAME%}</span></a>
	<a href="{%URL_PM%}" title="Личные сообщения : {%NEW_PM%}"><span class="PM">ЛС : {%NEW_PM%}</span></a>
	[admin]
	<a href="{%URL_ADMIN%}" title="Админ панель"><span class="AD">Админка</span></a>
	[/admin]
	<a href="{%URL_LOGOUT%}" title="Выход"><span class="logout"></span></a>
	[/user]
	[guest]
	<!-- Если не вошел -->
	<a href="#" title="Войти"><span class="login"></span></a>
	<!-- Если не вошел -->
	[/guest]
</div>