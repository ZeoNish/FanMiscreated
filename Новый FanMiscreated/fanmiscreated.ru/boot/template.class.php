<?php

/**
* @name        JMY CMS
* @link        http://jmy.su/
* @copyright   Copyright (C) 2012-2015 JMY LTD
* @license     LICENSE.txt (see attached file)
* @version     VERSION.txt (see attached file)
* @author      Komarov Ivan
* @revision	   31.03.2015
*/

if (!defined('ACCESS')) 
{
	header('Location: /');
	exit;
}
 
class template
{

	var $ext = '.tpl';
	var $sep = '%';
	var $sources = false;
	var $vars = array();
	var $vars_block = array();
	var $vars_tpl = array();
	var $file_dir = '';
	var $file = false;
	var $tplDir = false;
	var $filesTpl = false;
	var $cahceTpl = array();
	var $open_file = 'table';	
	var $headerIncludes = array();
	var $bodyIncludes = '';
	var $keywords = false;
	var $title = false;
	var $admin_title = false;
	var $feed_link = '';
	var $uniqTag = '';
	var $fullAjaxBody = '';
	var $adminTheme = false;	
	var $time_compile = false;
	var $startCompile = '';
	var $starWidth = 19;
	var $blocks = array();
	var $modules = array();
	var $moduleArray = '';
	var $adminBar = '';
	var $endJs = '';
	var $players = '';
	
	function __construct()
	{
	global $db, $config, $url;
        if($url[0] == ADMIN)
        {
            $this->adminTheme = true;
            $this->file_dir = 'usr/tpl/admin/';
            $this->sep = '';
        }
        
		if(!isset($_COOKIE['smartphone']))
		{
			setcookie('smartphone', 1);		
		}
		
		if(empty($this->file_dir))
		{
			if (($config['smartphone']=='1')&&($this->check_phone()==true)&&$_COOKIE['smartphone'] == 1)
			{
				$this->file_dir = 'usr/tpl/smartphone/';
			}
			else
			{
				$this->file_dir = 'usr/tpl/'.$config['tpl'].'/';
			}
		}
		
		$this->filesTpl = getcache('tplFiles');
		
		if(empty($this->filesTpl) || $this->filesTpl['theme'] != $this->file_dir || ($config['tpl_change'] == '0' && 'usr/tpl/'.$config['tpl'].'/' != $this->file_dir))
		{
			$this->filesTpl = listFiles($this->file_dir, $this->ext);
			$this->filesTpl['theme'] = $this->file_dir;
			setcache('tplFiles', $this->filesTpl);
		}


		$modArr = getcache('plugins');
		
		if (empty($modArr)) 
		{
			$query = $db->query("SELECT * FROM `".DB_PREFIX."_plugins` WHERE `active` = '1' ORDER BY priority ASC");
			while ($result = $db->getRow($query)) 
			{
				if($result['service'] == 'blocks')
				{
					$this->blocks[$result['id']] = $result;
				}
				else
				{
					$this->modules[$result['title']] = $result;
				}
			}
			setcache('plugins', array($this->blocks, $this->modules));
		}
		else
		{
			$this->blocks = $modArr[0];
			$this->modules = $modArr[1];
		}
	}
    
    function __destruct()
    {
        die();
    }	

	private function getThemeFile($file)
	{
	global $url;
		$file = $this->file_dir.$file;
		$loadFile = '';
		if(!empty($this->uniqTag))
		{
			if(!is_array($this->uniqTag))
			{
				$this->uniqTag = array($this->uniqTag);
			}
			
			if(INDEX == true) $this->uniqTag[] = 'index';

			foreach($this->uniqTag as $uniq)
			{
				if(in_array($file . '-' . $url[0]  . '-' . $uniq . $this->ext, $this->filesTpl))
				{
					$loadFile = $file . '-' . $url[0]  . '-' . $uniq . $this->ext;
					break;
				}
				elseif(in_array($file . '_' . $uniq . $this->ext, $this->filesTpl))
				{
					$loadFile = $file . '_' . $uniq . $this->ext;
					break;
				}	
				elseif(in_array($file . '--' . $uniq . $this->ext, $this->filesTpl))
				{
					$loadFile = $file . '--' . $uniq . $this->ext;
					break;
				}			
			}
		}
		
		if(empty($loadFile))
		{
			if(in_array($file . '-' . $url[0] . $this->ext, $this->filesTpl))
			{
				$loadFile = $file . '-' . $url[0] . $this->ext;
			}
			elseif(in_array($file . $this->ext, $this->filesTpl))
			{
				$loadFile = $file . $this->ext;
			}	
		}
		
	
		return $loadFile;
	}

	
	public function loadFileADM($file, $check = false) 
	{
		$loadDefault = 'usr/tpl/admin/' . $file . $this->ext;
	
		$loadUrl = $loadDefault;
	
		if(!isset($this->cacheTpl[$loadUrl]))
		{
			if(is_file(ROOT . $loadUrl))
			{
				$this->cacheTpl[$loadUrl] = file_get_contents(ROOT . $loadUrl);
			}
			elseif(is_file(ROOT . $loadDefault))
			{
				$this->cacheTpl[$loadDefault] = file_get_contents(ROOT . $loadDefault);
				$loadUrl = $loadDefault;
			}
			else
			{
				if($check == false)
				{
					delcache('tplFiles');
					$this->filesTpl = listFiles($this->file_dir, $this->ext);
					$this->loadFile($file, true);
				}
				else
				{
					fatal_error(_ERROR, str_replace('[file]', $file . $this->ext, _FILE_NOT_FOUND));
				}
			}
		}
		
		$this->file = $loadUrl;		
		$lo = explode('/', $loadUrl);
		$this->tplDir = $lo[2];
		$this->startCompile = microtime(1);
		$this->sources = $this->cacheTpl[$loadUrl];
	}
	
	function check_phone() 
	{ 
		$agent_now = strtolower( $_SERVER['HTTP_USER_AGENT'] );
		$agent_array = array('opera mini', 'ipad', 'android', 'pocket', 'palm', 'windows ce', 'windowsce', 'cellphone', 'opera mobi', 'ipod', 'small', 'sharp', 'sonyericsson', 'symbian', 'iphone', 'nokia', 'htc_', 'samsung', 'motorola', 'smartphone', 'blackberry', 'playstation portable', 'tablet browser'); 
		foreach ($agent_array as $agent) 
		{ 
			if ( strpos($agent_now, $agent) !== false )
			{
				return true;
			}
 
		}
		return false; 
	}
	
	
	public function loadFile($file, $check = false) 
	{
		global $config, $url, $db, $core;
		
		
		$loadDefault = 'usr/tpl/default/' . $file . $this->ext;
	
		if($this->adminTheme == false)
		{
			$loadUrl = $this->getThemeFile($file);
		}
		else if ($config['tpl_change'] == '0')
		{
			$loadUrl = 'usr/tpl/'.$config['tpl'].'/' . $file . $this->ext;
		}
		else
		{
			$loadUrl = $this->file_dir . $file . $this->ext;
			if(isset($this->cacheTpl[$loadDefault])) $loadUrl = $loadDefault;
		}

		if(!isset($this->cacheTpl[$loadUrl]))
		{
			if(is_file(ROOT . $loadUrl))
			{
				$this->cacheTpl[$loadUrl] = file_get_contents(ROOT . $loadUrl);
			}
			elseif(is_file(ROOT . $loadDefault))
			{
				$this->cacheTpl[$loadDefault] = file_get_contents(ROOT . $loadDefault);
				$loadUrl = $loadDefault;
			}
			else
			{
				if($check == false)
				{
					delcache('tplFiles');
					$this->filesTpl = listFiles($this->file_dir, $this->ext);
					$this->loadFile($file, true);
				}
				else
				{
					fatal_error(_ERROR, str_replace('[file]', $file . $this->ext, _FILE_NOT_FOUND));
				}
			}
		}
		
		include(ROOT.'boot/vars.class.php');
		$this->file = $loadUrl;		
		$lo = explode('/', $loadUrl);
		$this->tplDir = $lo[2];
		$this->startCompile = microtime(1);
		$this->sources = $this->cacheTpl[$loadUrl];
	}

	public function setVar($k, $v) 
	{
		$this->vars[$k] = $v;
	}	
	
	public function setVarBlock($k, $v) 
	{
		$this->vars_block[$k] = $v;
	}
	
	public function setVarTPL($k, $v) 
	{
		$this->vars_tpl[$k] = $v;
	}

	public function parse() 
	{ 
	global $config, $url, $core;
		if($url[0] != ADMIN)
		{	
			$in["#\\{%NOWDATE:(.*?)%\\}#ies"] = "date('\\1', '" . time() . "')";
			$in["#\\[group=(.+?)](.*?)\\[/group]#ies"] = "Group('\\1', '\\2')";
			$in["#\\[nogroup=(.+?)](.*?)\\[/nogroup]#ies"] = "noGroup('\\1', '\\2')";			
			$in["#\\[index:(.+?)\\](.*?)\\[/index\\]#ies"] = "indexShow('\\1', '\\2')";
			$in["#\\[modules:(.+?):(.+?)](.*?)\\[/modules]#ies"] = "modulesShow('\\1', '\\2', '\\3')";
			$in["#\\[category:(.+?):(.+?)](.*?)\\[/category]#ies"] = "categoryShow('\\1', '\\2', '\\3')";
			$in["#\\[news:(.+?):(.+?)](.*?)\\[/news]#ies"] = "newsShow('\\1', '\\2', '\\3')";
			$in["#\\[addnews:(.+?)\\](.*?)\\[/addnews\\]#ies"] = "addnewsShow('\\1', '\\2')";
			$in["#\\[full:(.+?)\\](.*?)\\[/full\\]#ies"] = "fullnewsShow('\\1', '\\2')";
			$in["#\\[content:(.+?):(.+?)](.*?)\\[/content]#ies"] = "contentShow('\\1', '\\2', '\\3')";
			$in["#\\[lang:(.+?)]#ies"] =  "constant('\\1')";
			$in["#\\[guest](.*?)\\[/guest]#ies"] =  "checkGuest('\\1')";
			$in["#\\[user](.*?)\\[/user]#ies"] =  "checkUser('\\1')";
			$in["#\\[admin](.*?)\\[/admin]#ies"] =  "checkAdmin('\\1')";
			$in["#\\[captcha](.*?)\\[/captcha]#ies"] =  "checkCaptcha('\\1')";
			$in["#\\[social](.*?)\\[/social]#ies"] =  "checkSocial('\\1')";
			$in["#\\[recaptcha:(.+?)\\](.*?)\\[/recaptcha]#ies"] =  "checkReCaptcha('\\1', '\\2')";
			$in["#\\[title:(.*?)]#ies"] =  "\$this->preTitle('\\1');";
			$in["#\\[open](.*?)\\[/open]#ies"] =  "\$this->preOpen('\\1');";
			$in["#\\[userinfo:(.*?)]#ies"] =  "\$this->ustinf('\\1')";
			$in["#\\[custom category=\"(.*?)\" template=\"(.*?)\" aviable=\"(.*?)\" limit=\"(.*?)\" module=\"(.*?)\" order=\"(.*?)\" short=\"(.*?)\" notin=\"(.*?)\"]#ieus"] =  "buildCustom('\\1', '\\2', '\\3', '\\4', '\\5', '\\6', '\\7', '\\8')";
			$in["#\\[custom category=\"(.*?)\" template=\"(.*?)\" aviable=\"(.*?)\" limit=\"(.*?)\" module=\"(.*?)\" order=\"(.*?)\" short=\"(.*?)\"]#ieus"] =  "buildCustom('\\1', '\\2', '\\3', '\\4', '\\5', '\\6', '\\7')";			
		}
		else
		{
			$this->sources = preg_replace( "#\\[alang:(.+?)]#ies", "constant('\\1')", $this->sources);
		}
		
		
		foreach ($this->vars as $k => $v) 
		{
			$in['#{' . $this->sep . $k . $this->sep . '}#i'] = $v;
		}
		
		if (count($this->vars_block)) 
		{
			foreach ($this->vars_block as $key => $val) 
			{
				$in["#\\{" . $this->sep . $key . $this->sep . "}#ies"] = $val;
			}
		}

		if (count($this->vars_tpl)) 
		{
			foreach ($this->vars_tpl as $key => $val) 
			{
				$in["#\\{" . $this->sep . $key . $this->sep . "}#ies"] = $val;
			}
		}
		
		if(!empty($in))
		{
			$this->sources = preg_replace(array_keys($in), array_values($in), $this->sources);
		}
		
		
	}
	
	function preOpen($content)
	{
		$this->open();
		echo stripslashes($content);
		return $this->close(true);
	}	
	
	function preTitle($content)
	{
		return $this->title(stripslashes($content), true);
	}
	
	function enUrl($urlGo, $lang)
	{
	global $config;
		if(!eregStrt('http', $urlGo) && !eregStrt('css', $urlGo) && !eregStrt('ico', $urlGo) && !eregStrt('javascript', $urlGo) && !eregStrt($lang.'/', $urlGo) && !empty($urlGo) && $urlGo != '/' && $lang != $config['lang'])
		{
			$urlGo = $lang.'/' . $urlGo;
		}

		if($config['mod_rewrite'] == 1)
		{
			return 'href="'.$urlGo.'"';
		}
		else
		{
			return 'href="index.php?url='.$urlGo.'"';
		}
	}
	
	function ustinf($tag)
	{
	global $core;
		if(isset($core->auth->user_info[$tag]))
		{
			return stripslashes($core->auth->user_info[$tag]);
		}
	}

	private function compile() 
	{
		echo $this->sources;
	}

	private function clear() 
	{
		$this->sources = false;
		$this->vars = array();
		$this->file = false;
		$this->startCompile = '';
	}
	
	public function return_end()
	{
		$this->time_compile += microtime(1)-$this->startCompile;
		$this->parse();
		return $this->sources;
		$this->clear();
	}
		
	public function end() 
	{
		if(DEBUG) 
		{
			$this->listTemplates[($this->file ? $this->file : 'main')] = MicroTime(1)-$this->startCompile;
		}

		$this->time_compile += microtime(1)-$this->startCompile;
		$this->parse();
		$this->compile();
		$this->clear();
	}
		
	public function head() 
	{
		ob_start();
	}
	

	
		
	public function foot($subContent = false) 
	{
	global $config, $url, $db, $core;
	
		$content = ob_get_contents();
		ob_end_clean();		
		$cat_keyword = (isset($this->keywords) ? ', ' .$this->keywords : false);		
		$desc = (isset($this->description) ? $this->description : $config['description']);
		$title_now = html_entity_decode((!empty($this->title) && !empty($_REQUEST['url']) ? $this->title . $config['name'] : $config['name'] . $config['divider'] . $config['slogan']), ENT_QUOTES);
		$meta  =  "<title>" . $title_now . "</title>" . "\n";
		$meta .= "<meta http-equiv=\"content-type\" content=\"text/html; charset=" . $config['charset'] . "\" />" . "\n";
		$meta .= "<meta name=\"keywords\" content=\"" . $config['keywords'] . $cat_keyword . "\" />" . "\n";
		$meta .= "<meta name=\"description\" content=\"" . $desc . "\" />" . "\n";
		$meta .= "<meta name=\"author\" content=\"JMY CMS\" />" . "\n";
		$meta .= "<base href=\"" . $config['url'] . "/\" />" . "\n";
		$meta .= "<meta name=\"robots\" content=\"index, follow\" />" . "\n";
		$meta .= "<meta name=\"generator\" content=\"JMY CMS\" />" . "\n";		
		$meta .= "<link rel=\"alternate\" href=\"" . $config['url'] . "/feed/rss/" . $this->feed_link . "\" type=\"application/rss+xml\" title=\"Rss 2.0\" />" . "\n";
		$meta .= "<link rel=\"search\" type=\"application/opensearchdescription+xml\" href=\"" . $config['url'] . "/feed/opensearch/\"  title=\"" . $config['name'] . "\" />" . "\n";	
		$meta .= "<script src=\"usr/plugins/js/JMY_Ajax.js\" type=\"text/javascript\"></script>" . "\n";
		$meta .= "<script src=\"usr/plugins/js/engine.js\" type=\"text/javascript\"></script>" . "\n";
		$meta .= "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js\"></script>" . "\n";
		if(!empty($this->players))
		{
			$meta .= $this->players;
		}
		array_unique($this->headerIncludes);
		
		foreach($this->headerIncludes as $metas)
		{
			if($metas)
			{
				$meta .= $metas;
			}		
		}
		if (strpos($this->sources, "<body") !== false) 
		{
			$this->sources = preg_replace('#<body(.*)[^>]#i', '<body\\1<div id="loading" class="loading" style="display:none;top:0;"><img src="media/showloading.gif" alt="????????????????..." /><br />????????????????...</div>'.$this->bodyIncludes, $this->sources);
		}
		else
		{
			$meta .= '<div id="loading" class="loading" style="display:none;top:0;"><img src="media/showloading.gif" alt="????????????????..." /><br />????????????????...</div>' . "\n";
		}		
		$this->loadFile('index');
		if(!empty($this->endJs))
		{
			$this->sources = preg_replace('#</body(.*)[^>]#i', $this->endJs.'</body\\1', $this->sources);
		}
		
				
		if (strpos($this->sources, "{%FULL_AJAX:") !== false && $config['fullajax']) 
		{
			if(preg_match("#({%FULL_AJAX:start%}(.+){%FULL_AJAX:end%})#si", $this->sources, $fullAjax) && $subContent)
			{
				$this->sources = $fullAjax[1];
			}
		}
	
		
		$this->setVar('META', $meta);
		$this->setVar('MODULE', $content);			
		$this->end();
        unset($this->cacheTpl);
	}
	
	public function loadTPL($file) 
	{
		global $config, $url, $db, $core;
		$this->loadFile($file);
		include(ROOT.'boot/vars.class.php');	
		return $this->return_end();
	}
		
	public function open($file = null) 
	{
	global $config, $url;
		if($file)
		{
			$this->uniqTag[] = $file;
		}
		
		ob_start();
	}

	public function close($return = false) 
	{
		$content = ob_get_contents();
		ob_end_clean();
		$this->loadFile('table');
		$this->setVar('CONTENT', $content);
		if($return == false)
			$this->end();
		else
			return $this->return_end();
	}
	
	public function title($text, $return = false) 
	{
		$this->loadFile('title');
		$this->setVar('TITLE', $text);
		if($return == false)
			$this->end();
		else
			return $this->return_end();
	}
	
	public function info($text, $type = 'info', $redicret = null, $time = null, $url = null) 
	{
	global $config;
		$this->loadFile($type);
		$this->setVar('TEXT', $text);
		$this->end();
	}
	
	public function redicret($message, $url = 'news', $text = '??????????????') 
	{
	global $config;
	$full_url = $url;
	include(ROOT . 'usr/tpl/redirect.tpl');	
	}
	
	
	public function blockParse($file = null, $type = null) 
	{
	global $db, $config, $core, $url;
		switch($type) 
		{
			case 'file':
				$block_path = ROOT . "usr/blocks/{$file}.block.php";
				if (!empty($file) && file_exists($block_path)) 
				{
					ob_start();
					include_once($block_path);
					$contetn_block = ob_get_contents();
					ob_end_clean();
					return $contetn_block;
				} 
				else 
				{
					return _BLOCK_EMPTY;
				}
				break;
				
			case 'type':
				if (empty($file)) return false;
				$block_content = null;
				

				$sideDe = !empty($this->modules[$url[0]]) ? explode(',', $this->modules[$url[0]]['unshow']) : '';				
				$sideDe = !empty($this->modules[$url[0]]) ? explode(',', $this->modules[$url[0]]['unshow']) : '';				

				foreach ($this->blocks as $array) 
				{
					if($this->blockShow($array['showin'], $array['unshow'], $array['groups']))
					{
						if ($array['type'] == $file && (empty($sideDe) || !in_array($file, $sideDe))) 
						{
							$block_path = ROOT . "usr/blocks/" . $array['file'];
							if (!empty($array['file']) && file_exists($block_path)) 
							{
								ob_start();
								require($block_path);
								$contetn_block = ob_get_contents();
								ob_end_clean();
								$this->uniqTag = array($array['id'], $array['file'], $array['type']);
							} 
							elseif (empty($array['file']) && !empty($array['content'])) 
							{
								$contetn_block = $core->bbDecode($array['content']);
								$this->uniqTag = array($array['id'], $array['type']);
							}
							else $contetn_block = '<center><b>' . _EMPTY_CONTENT . '</b></center>';						
							ob_start();
							$this->loadFile('block');
							$this->setVar('TITLE', $array['title']);
							$this->setVar('EDIT', $edit);
							$this->setVar('CONTENT', $contetn_block);
							$this->end();
							$block_content .= ob_get_contents();
							ob_end_clean();
							unset($contetn_block);
						}
					}
				}
				return $block_content;
				
				break;
				
			case 'id':
				if (empty($file)) return false;
				$block_content = null;
				
				if(isset($this->blocks[$file]))
				{
					$array = $this->blocks[$file];
					
					$block_path = ROOT . "usr/blocks/" . $array['file'];
					
					if (!empty($array['file']) && empty($array['content']) && file_exists($block_path)) 
					{
						ob_start();
						require($block_path);
						$contetn_block = ob_get_contents();
						ob_end_clean();
					} 
					elseif (empty($array['file']) && !empty($array['content'])) 
					{
						$contetn_block = $core->bbDecode($array['content']);
					} 
					else $contetn_block = '<center><b>?????? ????????????????????!</b></center>';
					
					return $contetn_block;
					unset($contetn_block);
				}
				break;
			
			default:

				break;
		}
	}
	
	private function blockShow($mods, $unmods, $groups, $free = false)
	{
	global $url, $core;
	
		if(eregStrt('_free', $mods) && $free == false) return false;
		
		$modNow = $url[0];
		$modsArr = explode(',', $mods);
		$unModsArr = explode(',', $unmods);
		$groupsArr = explode(',', $groups);
		$groupAccess = false;
		
		if((is_array($groupsArr) && in_array($core->auth->user_info['group'], $groupsArr)) OR $groups == '' OR $core->auth->isAdmin)
		{
			$groupAccess = true;
		}
		
		if(is_array($unModsArr) && in_array($modNow, $unModsArr))
		{
			return false;
		}
		elseif((is_array($modsArr) && in_array($modNow, $modsArr)) && INDEX == false)
		{
			return $groupAccess;
		}
		elseif(eregStrt('_index', $mods))
		{
			if(INDEX == true)
			{
				return $groupAccess;
			}
			else
			{
				return false; 
			}
		}
		elseif(eregStrt('_all', $mods))
		{
			return $groupAccess;
		}
	}

	public function pages($page, $num, $all, $link, $onClick = false) 
	{
		global $config, $nums, $url;
		if(!eregStrt('{page}', $link)) $link = $link . '/{page}';
		$numpages = ceil($all/$num);
		
		$predel = 4;
		$prevpage = $page-1;
		for ($var = 1; $var < $numpages+1; $var++) 
		{
			if ($var == $page) 
			{
				$nums .= '<span class="pages">' . $var . '</span>';
			} 
			else 
			{
				if ((($var > ($page - $predel)) && ($var < ($page + $predel))) or ($var == $numpages) || ($var == 1)) 
				{
					$nums .= ' <a href="' . str_replace('{page}', 'page/'.$var, $link) . '" ' . ($onClick ? str_replace('{num}', $var, $onClick) : '') . '><b>' . $var . '</b></a> ';
				} 
				
				if ($var < $numpages) 
				{
					if (($var > ($page - $predel-2)) && ($var < ($page + $predel))) $nums .= " ";
					if (($page > $predel+2) && ($var == 1)) $nums .= " ... ";
					if (($page < ($numpages - $predel)) && ($var == ($numpages - 2))) $nums .= "... ";
				}
			}
		}
		$nextpage = $page + 1;
		if($numpages != 1 && $numpages != 0) 
		{
			$this->loadFile('pages');
			$this->setVar('NUM', $nums);
			$this->sources = preg_replace( "#\\{" . $this->sep . "NEXT" . $this->sep . "\\}(.*?)\\{/" . $this->sep . "NEXT" . $this->sep . "\\}#ies", ($page < $var-1) ? "pageLink('".$link."', '\\1', $nextpage" . ($onClick ? ", '" . str_replace("'", "\'", $onClick) . "'" : '') . ")" : '', $this->sources);
			$this->sources = preg_replace( "#\\{" . $this->sep . "PREV" . $this->sep . "\\}(.*?)\\{/" . $this->sep . "PREV" . $this->sep . "\\}#ies", ($page != 1) ? "pageLink('".$link."', '\\1', $prevpage" . ($onClick ? ", '" . str_replace("'", "\'", $onClick) . "'" : '') . ")" : '', $this->sources);
			$this->end();
			$nums = '';
		}
	}
}