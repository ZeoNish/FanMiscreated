-- phpMyAdmin SQL Dump
-- version 4.0.10.6
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 02 2016 г., 15:10
-- Версия сервера: 5.5.41-log
-- Версия PHP: 5.4.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `fanmiscreated`
--

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_attach`
--

CREATE TABLE IF NOT EXISTS `JMY_attach` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `url` varchar(255) NOT NULL,
  `pub_id` varchar(255) DEFAULT NULL,
  `mod` varchar(55) NOT NULL,
  `downloads` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pub_id` (`pub_id`),
  KEY `url` (`url`),
  KEY `pub_id_2` (`pub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_blocks_types`
--

CREATE TABLE IF NOT EXISTS `JMY_blocks_types` (
  `title` varchar(55) DEFAULT NULL,
  `type` varchar(55) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `JMY_blocks_types`
--

INSERT INTO `JMY_blocks_types` (`title`, `type`) VALUES
('Левые блоки', 'left'),
('Правые блоки', 'right'),
('Баннер сверху', 'bannertop');

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_blogs`
--

CREATE TABLE IF NOT EXISTS `JMY_blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `altname` varchar(55) NOT NULL,
  `description` text NOT NULL,
  `avatar` varchar(200) NOT NULL,
  `posts` int(11) NOT NULL,
  `readersNum` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `lastUpdate` int(11) NOT NULL,
  `admins` varchar(255) NOT NULL,
  `readers` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_blog_posts`
--

CREATE TABLE IF NOT EXISTS `JMY_blog_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `comments` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `ratingUsers` text NOT NULL,
  `tags` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_blog_readers`
--

CREATE TABLE IF NOT EXISTS `JMY_blog_readers` (
  `bid` int(11) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_board_forums`
--

CREATE TABLE IF NOT EXISTS `JMY_board_forums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(55) NOT NULL,
  `description` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL,
  `type` varchar(3) NOT NULL,
  `active` smallint(1) NOT NULL,
  `open` smallint(1) NOT NULL,
  `threads` int(11) NOT NULL,
  `posts` int(11) NOT NULL,
  `lastPost` varchar(55) NOT NULL,
  `lastPoster` varchar(255) NOT NULL,
  `lastTid` int(11) NOT NULL,
  `lastSubject` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rulestitle` varchar(255) NOT NULL,
  `rules` text NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_board_permissions`
--

CREATE TABLE IF NOT EXISTS `JMY_board_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `allowView` int(1) NOT NULL,
  `allowRead` int(1) NOT NULL,
  `allowCreate` int(1) NOT NULL,
  `allowReply` int(1) NOT NULL,
  `allowEdit` int(1) NOT NULL,
  `allowModer` int(1) NOT NULL,
  `allowAttach` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_board_posts`
--

CREATE TABLE IF NOT EXISTS `JMY_board_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `message` text NOT NULL,
  `uid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  `files` text NOT NULL,
  `visible` varchar(1) NOT NULL,
  `editUser` varchar(55) NOT NULL,
  `editReason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_board_threads`
--

CREATE TABLE IF NOT EXISTS `JMY_board_threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum` int(11) NOT NULL,
  `title` varchar(55) NOT NULL,
  `poster` int(11) NOT NULL,
  `startTime` varchar(55) NOT NULL,
  `lastTime` varchar(55) NOT NULL,
  `lastPoster` varchar(55) NOT NULL,
  `views` int(11) NOT NULL,
  `replies` int(11) NOT NULL,
  `important` int(1) NOT NULL DEFAULT '0',
  `closed` int(1) NOT NULL DEFAULT '0',
  `score` float(6,3) NOT NULL,
  `votes` smallint(5) NOT NULL,
  `icon` varchar(44) NOT NULL,
  `closetime` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_board_users`
--

CREATE TABLE IF NOT EXISTS `JMY_board_users` (
  `uid` int(11) NOT NULL,
  `thanks` int(11) NOT NULL,
  `messages` int(11) NOT NULL,
  `specStatus` varchar(255) DEFAULT ' ',
  `lastUpdate` int(11) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `JMY_board_users`
--

INSERT INTO `JMY_board_users` (`uid`, `thanks`, `messages`, `specStatus`, `lastUpdate`) VALUES
(1, 0, 0, ' ', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_categories`
--

CREATE TABLE IF NOT EXISTS `JMY_categories` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `altname` varchar(55) NOT NULL,
  `description` varchar(200) NOT NULL,
  `keywords` varchar(255) NOT NULL,
  `module` varchar(55) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `position` smallint(5) NOT NULL,
  `parent_id` smallint(5) NOT NULL,
  PRIMARY KEY (`id`,`altname`),
  KEY `altname` (`altname`),
  KEY `parent_id` (`parent_id`),
  KEY `module` (`module`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `JMY_categories`
--

INSERT INTO `JMY_categories` (`id`, `name`, `altname`, `description`, `keywords`, `module`, `icon`, `position`, `parent_id`) VALUES
(1, 'Тестовая категория', 'testovaja_kategorija', 'Тестовая', 'Тест', 'news', '', 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_comments`
--

CREATE TABLE IF NOT EXISTS `JMY_comments` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `uid` smallint(5) NOT NULL,
  `post_id` smallint(5) NOT NULL,
  `module` varchar(55) NOT NULL,
  `text` text,
  `date` varchar(44) NOT NULL,
  `gemail` varchar(55) NOT NULL,
  `gname` varchar(55) NOT NULL,
  `gurl` varchar(55) NOT NULL,
  `parent` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module` (`module`),
  KEY `post_id` (`post_id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `JMY_comments`
--

INSERT INTO `JMY_comments` (`id`, `uid`, `post_id`, `module`, `text`, `date`, `gemail`, `gname`, `gurl`, `parent`, `status`) VALUES
(1, 1, 1, 'news', '123123123', '1472816405', '', '', '', 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_com_subscribe`
--

CREATE TABLE IF NOT EXISTS `JMY_com_subscribe` (
  `id` int(11) NOT NULL,
  `module` varchar(55) NOT NULL,
  `uid` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`,`module`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_content`
--

CREATE TABLE IF NOT EXISTS `JMY_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `translate` varchar(255) NOT NULL,
  `cat` varchar(200) NOT NULL,
  `keywords` varchar(55) NOT NULL,
  `active` int(1) NOT NULL,
  `date` varchar(55) DEFAULT NULL,
  `comments` int(11) NOT NULL,
  `theme` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_gallery_albums`
--

CREATE TABLE IF NOT EXISTS `JMY_gallery_albums` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `trans` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `views` int(11) NOT NULL,
  `nums` int(11) NOT NULL,
  `last_update` varchar(250) NOT NULL,
  `last_author` varchar(250) NOT NULL,
  `last_image` varchar(250) NOT NULL,
  `watermark` int(1) DEFAULT NULL,
  `sizes` text NOT NULL,
  `gropups_allow` int(11) NOT NULL,
  `dir` varchar(255) NOT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_gallery_photos`
--

CREATE TABLE IF NOT EXISTS `JMY_gallery_photos` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` varchar(250) NOT NULL,
  `author` varchar(250) NOT NULL,
  `add_date` varchar(250) NOT NULL,
  `photo_date` varchar(250) NOT NULL,
  `photos` text NOT NULL,
  `tech` text NOT NULL,
  `views` int(11) NOT NULL,
  `gets` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `ratings` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `groups_allow` int(11) NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_groups`
--

CREATE TABLE IF NOT EXISTS `JMY_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guest` int(1) NOT NULL,
  `user` int(1) NOT NULL,
  `moderator` int(1) NOT NULL,
  `admin` int(1) NOT NULL,
  `banned` int(1) NOT NULL,
  `showHide` int(1) NOT NULL,
  `showAttach` int(1) NOT NULL,
  `loadAttach` int(1) NOT NULL,
  `addPost` int(1) NOT NULL,
  `addComment` int(1) NOT NULL,
  `allowRating` int(1) NOT NULL,
  `maxWidth` int(11) NOT NULL,
  `maxPms` int(11) NOT NULL,
  `control` text NOT NULL,
  `icon` varchar(255) NOT NULL,
  `color` varchar(55) NOT NULL,
  `points` int(11) NOT NULL,
  `protect` int(1) NOT NULL,
  `special` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `JMY_groups`
--

INSERT INTO `JMY_groups` (`id`, `name`, `guest`, `user`, `moderator`, `admin`, `banned`, `showHide`, `showAttach`, `loadAttach`, `addPost`, `addComment`, `allowRating`, `maxWidth`, `maxPms`, `control`, `icon`, `color`, `points`, `protect`, `special`) VALUES
(1, 'Администраторы', 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 100, 50, '', 'media/groups/administrator.png', 'red', 0, 1, 0),
(3, 'Гости', 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 100, 50, '', 'media/groups/3.png', '', 0, 0, 0),
(4, 'Боты', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'media/groups/4.png', '', 0, 1, 0),
(2, 'Пользователи', 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 100, 50, '', 'media/groups/user.png', 'blue', 0, 1, 0),
(5, 'Забаненые', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_guestbook`
--

CREATE TABLE IF NOT EXISTS `JMY_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `date` varchar(55) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(75) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `comment` text NOT NULL,
  `reply` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_langs`
--

CREATE TABLE IF NOT EXISTS `JMY_langs` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `postId` varchar(255) DEFAULT NULL,
  `module` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `short` text,
  `full` text,
  `lang` varchar(255) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `JMY_langs`
--

INSERT INTO `JMY_langs` (`_id`, `postId`, `module`, `title`, `short`, `full`, `lang`) VALUES
(1, '1', 'news', 'Тестовая новость', '<p><strong>Игра</strong></p>\r\n<ul>\r\n<li>После смерти игроки будут бросать их активное оружие / предмет - исправляет баг при грабеже трупов.</li>\r\n<li>Увеличение максимального количества трупов игроков, которые могут быть в мире одновременно.</li>\r\n<li>Увеличено время исчезновения трупов игроков.</li>\r\n<li>Добавлена эмоция свиста (клавиша F11 по умолчанию).</li>\r\n<li>Игроки больше не будут видны, как только автомобиль покинет соответствующий диапазон. (Из далека игроки не видны в автомобиле).</li>\r\n<li>Доработана система синхронизации между игроками. Теперь игроки всегда там где они должны быть.</li>\r\n<li>Исправлено потенциальное зависание игры при поднятии предметов.</li>\r\n<li>Пища и вода теперь ставнится на 80% для всех вновь появившихся.</li>\r\n</ul>', '<p><strong>Игра</strong></p>\r\n<ul style="list-style-type: square;">\r\n<li>После смерти игроки будут бросать их активное оружие / предмет - исправляет баг при грабеже трупов.</li>\r\n<li>Увеличение максимального количества трупов игроков, которые могут быть в мире одновременно.</li>\r\n<li>Увеличено время исчезновения трупов игроков.</li>\r\n<li>Добавлена эмоция свиста (клавиша F11 по умолчанию).</li>\r\n<li>Игроки больше не будут видны, как только автомобиль покинет соответствующий диапазон. (Из далека игроки не видны в автомобиле).</li>\r\n<li>Доработана система синхронизации между игроками. Теперь игроки всегда там где они должны быть.</li>\r\n<li>Исправлено потенциальное зависание игры при поднятии предметов.</li>\r\n<li>Пища и вода теперь ставнится на 80% для всех вновь появившихся.&nbsp;</li>\r\n</ul>\r\n<p><strong>Мир</strong></p>\r\n<p>Для дизель-генераторов теперь нужна одна батарея для работы(Было нужно две).<br />Введен актуальный список деталей для работы дизельного генератора.<br />Hemlock(Кустарники с белыми цветами) заменены на более эффектные кустарники.<br />Подъезды к Hayward долине были скорректированы и расширены.<br />Больше открытых многоквартирных домов в Hayward долине.<br />Новый интерьер магазина одежды добавлен в Hayward долине.<br />В новом отеле Hayward долины начал работать лифт.<br />Добавлена функция для открытия и закрытия тюремных камер в полицейском участке (не может заблокировать другого игрока внутри).<br />Заменено много текстур тротуарной плитки на более крупные комбинированные для повышения производительности.<br />Исправлен баг когда игрок мог застрять в сарае.<br />Пункты спавна и звуковые зоны реверберации добавлены в таунхаусы.<br />&nbsp;</p>\r\n<p>ИИ</p>\r\n<p>Теперь мутанты будут бросать в вас камнями если вы не можете быть атакованы в ближнем бою.<br />Грубая масса существенно возросла (Кол-во мутантов увеличено).<br />Мутанты разворачиваются и отступают вместо того что бы просто исчезнуть.<br />&nbsp;</p>\r\n<p>VoIP</p>\r\n<p>Добавлен шепот - активен когда игрок в режиме ходьбы - диапазон звука 7м.<br />Индикатор VoIP обновлен.<br />Исправлен режим "Нажми и говори" (Теперь не будет треска).<br />&nbsp;</p>\r\n<p>UI</p>\r\n<p>Обновлен значок AT-15.<br />Обновлены иконки джинс.<br />Исправлено пропадание значка использования про наведении.<br />Поднимая пакет предметов, количество элементов в пакете отображается в строке.<br />Режим огня - некоторые виды оружия имеют альтернативный режим огня.<br />&nbsp;</p>\r\n<p>Транспорт</p>\r\n<p>Исправления связанные с отключением водителя при движении транспортного средства - инвентаризация жидкостей и повреждений.<br />Снижен урон наносимый крупным мутантам.<br />&nbsp;</p>\r\n<p>Предметы</p>\r\n<p>Предметы теперь будут автоматически складываться когда вы их будете собирать или крафтить.<br />Заготовленные элементы добавляются непосредственно в свой инвентарь.<br />Топоры теперь имеют 100% шанс добывания древесины, топорики 75%.<br />Подобрав груды боеприпасов теперь они будут автоматически складываться в инвентаре.<br />Разорванные предметы автоматически складываются к груды тряпок в инвентаре.<br />Увеличена физика прокси что бы некоторые кучи патронов не проваливались под текстуры.<br />&nbsp;</p>\r\n<p>Анимация</p>\r\n<p>Исправлен звук Renegade 700 rifle который было слышно при анимации на серверах.<br />&nbsp;</p>\r\n<p>Звуки</p>\r\n<p>Звук "Свиста" пуль скорректирован в зависимости от расстояния.<br />Грубые звуки были обновлены.<br />Исправлены или скорректированы звуки которые слышат игроки при еде, питье или использовании фонарика.<br />Уникальные звуки добавлены для седана.<br />Петухи имеют звуковые эффекты.<br />&nbsp;</p>\r\n<p>Модели</p>\r\n<p>Многие модели обновлены, чтобы работать лучше - LODs.<br />&nbsp;</p>\r\n<p>Текстуры/Материалы</p>\r\n<p>Добавлены новые и обновлены текстуры местности.<br />Исправлен материал стекла на багажном вагоне.</p>', 'ru');

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_logs`
--

CREATE TABLE IF NOT EXISTS `JMY_logs` (
  `time` int(5) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `uid` int(5) NOT NULL,
  `history` varchar(255) NOT NULL,
  `level` smallint(1) NOT NULL,
  PRIMARY KEY (`time`),
  KEY `level` (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `JMY_logs`
--

INSERT INTO `JMY_logs` (`time`, `ip`, `uid`, `history`, `level`) VALUES
(1472797747, '127.0.0.1', 0, 'Вход admin в панель управления.', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_news`
--

CREATE TABLE IF NOT EXISTS `JMY_news` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `author` varchar(55) NOT NULL,
  `date` int(11) DEFAULT NULL,
  `tags` varchar(255) NOT NULL,
  `cat` varchar(200) DEFAULT NULL,
  `altname` varchar(55) NOT NULL,
  `keywords` text,
  `description` text,
  `allow_comments` int(1) NOT NULL,
  `allow_rating` int(1) NOT NULL,
  `allow_index` int(1) NOT NULL,
  `score` float(6,3) DEFAULT NULL,
  `votes` smallint(5) NOT NULL,
  `views` smallint(5) NOT NULL,
  `comments` smallint(5) NOT NULL,
  `fields` text NOT NULL,
  `groups` varchar(55) NOT NULL,
  `fixed` int(1) NOT NULL,
  `active` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `altname` (`altname`),
  KEY `active` (`active`),
  KEY `date` (`date`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `JMY_news`
--

INSERT INTO `JMY_news` (`id`, `author`, `date`, `tags`, `cat`, `altname`, `keywords`, `description`, `allow_comments`, `allow_rating`, `allow_index`, `score`, `votes`, `views`, `comments`, `fields`, `groups`, `fixed`, `active`) VALUES
(1, 'admin', 1472800560, 'тест', ',0,1,', 'testovaja_novost', 'новость, полная', 'Полная новость', 1, 1, 1, 0.000, 0, 71, 1, '', ',0,', 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_online`
--

CREATE TABLE IF NOT EXISTS `JMY_online` (
  `uid` int(11) NOT NULL,
  `time` int(10) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `group` int(11) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `JMY_online`
--

INSERT INTO `JMY_online` (`uid`, `time`, `ip`, `group`, `url`) VALUES
(1, 1472818146, '127.0.0.1', 1, '/news');

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_plugins`
--

CREATE TABLE IF NOT EXISTS `JMY_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(55) NOT NULL,
  `content` text NOT NULL,
  `file` varchar(55) NOT NULL,
  `priority` tinyint(2) unsigned NOT NULL,
  `type` varchar(55) DEFAULT NULL,
  `service` varchar(44) NOT NULL,
  `showin` varchar(255) NOT NULL,
  `unshow` varchar(255) NOT NULL,
  `groups` varchar(255) NOT NULL,
  `free` tinyint(1) unsigned NOT NULL,
  `template` text,
  `active` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active` (`active`),
  KEY `priority` (`priority`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `JMY_plugins`
--

INSERT INTO `JMY_plugins` (`id`, `title`, `content`, `file`, `priority`, `type`, `service`, `showin`, `unshow`, `groups`, `free`, `template`, `active`) VALUES
(1, 'blog', 'Блог', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(2, 'board', 'Форум', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(3, 'content', 'Страницы', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(5, 'feedback', 'Обратная связь', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(6, 'gallery', 'Галерея', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(7, 'news', 'Новости', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(8, 'pm', 'Личные сообщения', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(9, 'profile', 'Профиль', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(10, 'search', 'Поиск', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(11, 'guestbook', 'Гостевая книга', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(12, 'sitemap', 'Карта сайта', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1),
(13, 'feed', 'Лента нововстей', '', 0, NULL, 'modules', '', '', '', 0, NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_pm`
--

CREATE TABLE IF NOT EXISTS `JMY_pm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toid` int(11) NOT NULL,
  `fromid` int(11) NOT NULL,
  `message` text,
  `time` varchar(55) NOT NULL,
  `status` smallint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_polls`
--

CREATE TABLE IF NOT EXISTS `JMY_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `votes` int(5) NOT NULL,
  `max` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_poll_questions`
--

CREATE TABLE IF NOT EXISTS `JMY_poll_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `variant` varchar(55) NOT NULL,
  `position` smallint(5) NOT NULL,
  `vote` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_poll_voting`
--

CREATE TABLE IF NOT EXISTS `JMY_poll_voting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `ip` varchar(55) NOT NULL,
  `time` varchar(55) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_ratings`
--

CREATE TABLE IF NOT EXISTS `JMY_ratings` (
  `_` int(11) NOT NULL AUTO_INCREMENT,
  `id` smallint(5) NOT NULL,
  `uid` smallint(5) NOT NULL,
  `mod` varchar(55) NOT NULL,
  `time` int(11) NOT NULL,
  `ip` varchar(55) NOT NULL,
  PRIMARY KEY (`_`),
  KEY `mod` (`mod`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_sitemap`
--

CREATE TABLE IF NOT EXISTS `JMY_sitemap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_tags`
--

CREATE TABLE IF NOT EXISTS `JMY_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(55) NOT NULL,
  `module` varchar(55) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `JMY_tags`
--

INSERT INTO `JMY_tags` (`id`, `tag`, `module`) VALUES
(8, 'тест', 'news');

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_users`
--

CREATE TABLE IF NOT EXISTS `JMY_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `tail` varchar(55) NOT NULL,
  `email` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `social_id` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `icq` varchar(55) NOT NULL,
  `skype` varchar(55) NOT NULL,
  `surname` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `ochestvo` varchar(55) NOT NULL,
  `place` varchar(255) NOT NULL,
  `age` int(3) NOT NULL,
  `sex` int(1) NOT NULL,
  `birthday` varchar(55) NOT NULL,
  `hobby` varchar(255) NOT NULL,
  `signature` text,
  `points` int(11) DEFAULT '0',
  `carma` int(11) NOT NULL,
  `user_comments` int(11) NOT NULL,
  `user_news` int(11) NOT NULL,
  `group` int(11) NOT NULL,
  `exgroup` int(3) NOT NULL,
  `last_visit` int(11) NOT NULL,
  `regdate` int(11) NOT NULL,
  `active` int(1) NOT NULL,
  `ip` varchar(55) NOT NULL,
  `fields` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick_2` (`nick`),
  KEY `nick` (`nick`),
  KEY `ip` (`ip`),
  KEY `active` (`active`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `JMY_users`
--

INSERT INTO `JMY_users` (`id`, `nick`, `password`, `tail`, `email`, `provider`, `social_id`, `status`, `icq`, `skype`, `surname`, `name`, `ochestvo`, `place`, `age`, `sex`, `birthday`, `hobby`, `signature`, `points`, `carma`, `user_comments`, `user_news`, `group`, `exgroup`, `last_visit`, `regdate`, `active`, `ip`, `fields`) VALUES
(1, 'admin', 'ed4ae1f6065b1a6f28faf430ea734400', 'jzrg9mnmvb', '', '', '', NULL, '', '', '', '', '', '', 0, 0, '', '', NULL, 20, 0, 1, 1, 1, 0, 0, 0, 1, '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_user_carma`
--

CREATE TABLE IF NOT EXISTS `JMY_user_carma` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `from` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `do` varchar(5) DEFAULT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_user_friends`
--

CREATE TABLE IF NOT EXISTS `JMY_user_friends` (
  `who_invite` int(9) NOT NULL,
  `whom_invite` int(9) NOT NULL,
  `confirmed` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_user_visitors`
--

CREATE TABLE IF NOT EXISTS `JMY_user_visitors` (
  `id` int(9) NOT NULL,
  `visitor` int(9) NOT NULL,
  `time` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `JMY_xfields`
--

CREATE TABLE IF NOT EXISTS `JMY_xfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` smallint(1) NOT NULL,
  `content` text NOT NULL,
  `to_user` int(1) NOT NULL,
  `module` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
