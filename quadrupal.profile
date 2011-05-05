<?php
// $Id$
DEFINE('QUADRUPAL_VERSION','1.6');

/**
* @file
*   This file contains an example Drupal 6 Install Profile. It is based on the default installation profile and comments
*   found at http://api.drupal.org/api/drupal/developer--example.profile/6.
*/

/**
* Return a description of the profile for the initial installation screen.
*
* @return
*   An array with keys 'name' and 'description' describing this profile,
*   and optional 'language' to override the language selection for
*   language-specific profiles.
*/
function quadrupal_profile_details() {
  return array(	
    'name' => 'QuaDrupal',
    'description' => 'Version 6.x-'.QUADRUPAL_VERSION.'. Should be used together with the QuaDrupal package.',
  );	
}

/**
* Return an array of the modules to be enabled when this profile is installed.
*
* @return
*   An array of modules to enable.
*/
function quadrupal_profile_modules() {
  return array(
	'admin_menu',
	'dblog',
	'help',
	'menu',
	'path',
	'taxonomy',
	'search',
	'locale',
	'syslog',
	'update',
	'libraries',
	'adminrole',
	'better_formats',
	'content',
	'content_copy',
	'fieldgroup',
	'nodereference',
	'number',
	'optionwidgets',
	'text',
	'context',
	'context_ui',
	'context_layouts',
	'css_gzip',
	'ctm',
	'bulk_export',
	'ctools',
	'date_api',
	'date',
	'date_popup',
	'date_timezone',
	'ds', 'ds_ui', 'nd', 'nd_cck', 'nd_search', 'ud',
	'dul',
	'disablepwstrength',
	'token',
	'transliteration',
  'emvideo',
	'emfield',
	'eminline',
	'features',
	'filefield',
	'filefield_paths',
	'filefield_sources',
	'globalredirect',
	'image_resize_filter',
	'imagefield',
	'imageapi',
	'imageapi_gd',
	'imagecache',
	'imagecache_ui',
	'imagecache_coloractions',
	'imce',
	'imce_wysiwyg',
	'insert',
  'jquery_ui',
  'jquery_update',
	'javascript_aggregator',
	'link',
	'media_youtube',
	'nodeformcols',
	'nodeformsettings',
	'cckformsettings',
	'nodewords',
	'nodewords_basic',
	'page_title',
	'path_redirect',
	'pathauto',
	'save_edit',
	'simple_menu_settings',
	'site_info_lite',
	'search404',
	'semanticviews',
	'strongarm',
	'tinymce_node_picker',
	'token',
	'transliteration',
	'update_advanced',
	'views',
	'views_clone_display',
	'views_ui',
	'views_ui_basic',
	'views_bulk_operations',
	'wysiwyg',
	'wysiwyg_spellcheck'
	);
}


/**
* Return a list of tasks that this profile supports.
*
* @return
*   A keyed array of tasks the profile will perform during
*   the final stage. The keys of the array will be used internally,
*   while the values will be displayed to the user in the installer
*   task list.
*/
function quadrupal_profile_task_list() {
    // Here we define names of the custom tasks we're about to perform,
    // so that these will be shown in the tasks list on the
    // installer UI. The keys may be anything (internal use only),
    // excepting the reserved tasks (as listed in install_reserved_tasks()
    // inside install.php). The strings may be translated with the st()
    // wrapper (translations provided in the install profile's .po file),
    // but sometimes there's no point in doing that, if the profile is
    // only focused to a single language. We only need to list tasks,
    // for which a page will be displayed; internally, unlisted keys
    // may be well used too. It's also possible to return dynamic data
    // here, adding/removing tasks on-the-fly depending on previous
    // steps.
    //'task1' => st('Task 1'),
    //'task2' => st('Task 2'),
}

/**
* Perform any final installation tasks for this profile.
*
* @param $task
*   The current $task of the install system. When hook_profile_tasks()
*   is first called, this is 'profile'.
* @param $url
*   Complete URL to be used for a link or form action on a custom page,
*   if providing any, to allow the user to proceed with the installation.
*
* @return
*   An optional HTML string to display to the user. Only used if you
*   modify the $task, otherwise discarded.
*/

function quadrupal_profile_tasks(&$task, $url) {
  // First time, this function will be called with the 'profile' task.
  // In this case, we advance the pointer to our first custom task, to
  // indicate that this profile needs more runs to complete, and we
  // also perform some initial settings.
	
	//if ($task == 'profile') {
		
		//$task = 'task1';
		
    // The following part is a verbatim from default.profile, doing some
    // basic settings, that may be easily customized here. For a simple
    // profile, with no need for custom UI screens, this will be the
    // only code inside hook_profile_tasks(); in that case there's
    // no need to modify $task, as demonstrated in default.profile:
    // If $task is not changed, this function gets only called once.

    // Insert default user-defined node types into the database. For a complete
    // list of available node type attributes, refer to the node type API
    // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
		
		/* we laten deze later draaien omdat het anders niet werkt */
 		$mods = array('htmlpurifier');
  	drupal_install_modules($mods);
		
	  $types = array(
	    array(
	      'type' => 'page',
	      'name' => st('Pagina'),
	      'module' => 'node',
	      'description' => t('Standaard pagina.'),
	      'custom' => TRUE,
	      'modified' => TRUE,
	      'locked' => FALSE,
	      'help' => '',
	      'min_word_count' => '',
	    ),
	  );
	
	  foreach ($types as $type) {
	    $type = (object) _node_type_set_defaults($type);
	    node_type_save($type);
	  }
    
    // default niet promoted    
    $node_options_page = array(0 => status);
    variable_set('node_options_page',$node_options_page);
	  // nodewords
    variable_set('nodewords_metatags_generation_method_page', 1);
    variable_set('nodewords_metatags_generation_source_page', 3);
    
    $menu_page = array
    (
    0 => 'primary-links',
    1 => 'secondary-links'
    );
    variable_set('menu_page', $menu_page);
    
    // node form settings 2.x
    $nodeformsettings_page = array(
    'nfs_submission_body_rows' => 20,
    'nfs_splitsummary' => 1,
    'nfs_inputformat' => 0,
    'nfs_revisionlog' => 2,
    'nfs_author_information' => 0,
    'nfs_path' => 0,
    'nfs_menu' => 0,
    'nfs_publishingoptions' => 0,
    'nfs_comments' => 0,
    'nfs_taxonomy' => 0,
    'nfs_preview' => 1,
    'nfs_cancel' => array(
    'nfs_cancel_status' => 0,
    'nfs_cancel_behaviour' => 0,
    ),
    'nfs_submit' => 'Opslaan',
    'nfs_hide_node_title' => 0,
    'nfs_title_create' => 'Nieuw : !node_type',
    'nfs_title_edit' => 'Bewerk !node_type : !node_title',
    );
    variable_set('nodeformsettings_page',$nodeformsettings_page);
    
    // nodeform collumns
    $nodeformscols_field_placements_page_default = array (
      'title' => 
      array (
        'region' => 'main',
        'weight' => '-5',
        'has_required' => true,
        'title' => 'Title',
      ),
      'body_field' => 
      array (
        'region' => 'main',
        'weight' => '0.008',
        'has_required' => false,
        'title' => NULL,
        'hidden' => 0,
      ),
      'menu' => 
      array (
        'region' => 'right',
        'weight' => '0',
        'has_required' => false,
        'title' => 'Menu settings',
        'collapsed' => 1,
        'hidden' => 0,
      ),
      'revision_information' => 
      array (
        'region' => 'right',
        'weight' => '3',
        'has_required' => false,
        'title' => 'Revision information',
        'collapsed' => 1,
        'hidden' => 0,
      ),
      'path' => 
      array (
        'region' => 'right',
        'weight' => '4',
        'has_required' => false,
        'title' => 'URL path settings',
        'collapsed' => 1,
        'hidden' => 0,
      ),
      'options' => 
      array (
        'region' => 'right',
        'weight' => '5',
        'has_required' => false,
        'title' => 'Publishing options',
        'collapsed' => 0,
        'hidden' => 0,
      ),
      'author' => 
      array (
        'region' => 'right',
        'weight' => '1',
        'has_required' => false,
        'title' => 'Authoring information',
        'collapsed' => 1,
        'hidden' => 0,
      ),
      'buttons' => 
      array (
        'region' => 'main',
        'weight' => '100',
        'has_required' => false,
        'title' => NULL,
        'hidden' => 0,
      ),
      'nodewords' => 
      array (
        'region' => 'right',
        'weight' => '2',
        'has_required' => false,
        'title' => 'Meta tags',
        'collapsed' => 1,
        'hidden' => 0,
      ),
    );
    variable_set('nodeformscols_field_placements_page_default', $nodeformscols_field_placements_page_default);
    
	  // Set timezone for date_timezone.module.
	  variable_set('date_default_timezone', -14400);
	  variable_set('date_default_timezone_name', 'Europe/Amsterdam');
	  variable_set('configurable_timezones', '0');
	  variable_set('date_first_day', '1');
 	  variable_set('date_format_long', 'l, j F, Y - H:i');
 	  variable_set('date_format_medium', 'D, d/m/Y - H:i');
 	  variable_set('date_format_short', 'd/m/Y - H:i');
    
	  // Set site_footer value.
	  variable_set('site_footer', st('Created by ezCompany + Merge (QuaDrupal version '.QUADRUPAL_VERSION.')'));
		
	// Configure access log for statistics module.
	variable_set('statistics_count_content_views', '0');
	variable_set('statistics_enable_access_log', '1');
	variable_set('statistics_flush_accesslog_timer', '2419200');
		
	// Configure user settings. Set user creation to administrator only.
	variable_set('user_register', '0');
    
	// default theme = oeleboele
	variable_set('theme_default', 'oeleboele');
	
    // set the administration theme to rubik
 	variable_set('admin_theme', 'rubik');
 	variable_set('node_admin_theme', '1');
    
	// disable all blocks for these themes
    db_query("UPDATE {blocks} SET status = 0 where theme = '%s'", 'rubik');
	db_query("UPDATE {blocks} SET status = 0 where theme = '%s'", 'rubik');
	
    
    // image toolkit and api jpeg quality to 90%
	variable_set('image_toolkit', 'gd');
	variable_set('image_jpeg_quality', '90');
	variable_set('imageapi_image_toolkit', 'imageapi_gd');
	variable_set('imageapi_jpeg_quality', '90');
    
    // search 404 settings
    variable_set('search404_jump', '1');
    variable_set('search404_first', '1');
    variable_set('search404_block_show', '0');
    variable_set('search404_do_google_cse', '0');
    variable_set('search404_do_search_by_page', '0');
    variable_set('search404_redirect_301', '0');
    variable_set('search404_use_or', '0');
    variable_set('search404_use_search_engine', '1');
    variable_set('search404_ignore', 'and or the in op de het een');
    variable_set('search404_ignore_extensions', 'gif jpg jpeg bmp png');
    variable_set('search404_page_title', 'Pagina niet gevonden');
    
    // post settings
    variable_set('default_nodes_main', '10');
    variable_set('teaser_length', '600');
    variable_set('node_preview', '0');
		
    // pathauto
    variable_set('pathauto_taxonomy_pattern', '[vocab-raw]/[catpath-raw]');
    variable_set('pathauto_node_pattern', '[nid]/[title-raw]');
    variable_set('pathauto_transliterate', '1');
		
    // imce
    $imce = array (
      1 => array (
        'name' => 'Editor',
        'usertab' => 1,
        'filesize' => 0,
        'quota' => 0,
        'tuquota' => 0,
        'extensions' => '*',
        'dimensions' => '1600x1200',
        'filenum' => 0,
        'directories' => array(
          0 => array(
            'name' => '.',
            'subnav' => 1,
            'browse' => 1,
            'upload' => 1,
            'thumb' => 1,
            'delete' => 1,
            'resize' => 1,
          ),
        ),
        'thumbnails' => array(
          0 => array(
            'name' => 'Thumb',
            'dimensions' => '100x100',
            'prefix' => 'thumb_',
            'suffix' => ''
          )
        )
      )
    );
    
    $imce_roles = array(
      4 => array (
        'weight' => 0,
        'pid' => 1
      ),
      3 => array(
        'weight' => 0,
        'pid' => 1
      ),
      2 => array(
        'weight' => 11,
        'pid' => 0
      ),
      1 => array(
        'weight' => 12,
        'pid' => 0
      )
    );
		
    variable_set('imce_profiles', $imce);
    variable_set('imce_roles_profiles', $imce_roles);
		
		// wysiwyg
		$wysiwyg = array (
      'default' => 1,
      'user_choose' => 0,
      'show_toggle' => 0,
      'theme' => 'advanced',
      'language' => 'en',
      'buttons' => array(
        'default' => array(
          'bold' => 1,
          'italic' => 1,
          'underline' => 1,
          'bullist' => 1,
          'numlist' => 1,
          'undo' => 1,
          'redo' => 1,
          'link' => 1,
          'unlink' => 1,
          'image' => 1,
          'cleanup' => 1,
          'sup' => 1,
          'sub' => 1,
          'code' => 1,
          'cut' => 1,
          'copy' => 1,
          'paste' => 1,
          'removeformat' => 1,
          'charmap' => 1
        ),
        'contextmenu' => array(
          'contextmenu' => 1
        ),
        'font' => array(
          'formatselect' => 1
        ),
        'paste' => array(
          'pastetext' => 1,
          'pasteword' => 1
        ),
        'imce' => array(
          'imce' => 1
        ),
        'drupal' => array(
          'nodepicker' => 1
        )
      ),
      'toolbar_loc' => 'top',
      'toolbar_align' => 'left',
      'path_loc' => 'bottom',
      'resizing' => 1,
      'verify_html' => 1,
      'preformatted' => 0,
      'convert_fonts_to_spans' => 1,
      'remove_linebreaks' => 0,
      'apply_source_formatting' => 0,
      'paste_auto_cleanup_on_paste' => 1,
      'block_formats' => 'p,h2,h3',
      'css_setting' => 'theme',
      'css_path' => '',
      'css_classes' => ''
    );

		db_query("INSERT INTO {wysiwyg} (format, editor,settings) VALUES (1, 'tinymce', '%s')", serialize($wysiwyg));
	
    // we will want to change this in the near future...
    $theme = 'oeleboele';
    
	  // Build user menu
	  $menu = array(
	    'menu_name' => 'menu-user',
	    'title' => 'Gebruikersmenu',
	    'description' => 'Het menu voor ingelogde gebruikers.'
	  );
	  drupal_write_record('menu_custom', $menu);
    
	  $link = array('menu_name' => 'menu-user', 'link_path' => 'user/%', 'link_title' => 'Mijn account', 'weight' => 5);
	  menu_link_save($link);
    
	  $link = array('menu_name' => 'menu-user', 'link_path' => 'user/login', 'link_title' => 'Inloggen', 'weight' => 15);
	  menu_link_save($link);
	
	  $link = array('menu_name' => 'menu-user', 'link_path' => 'logout', 'link_title' => 'Uitloggen', 'weight' => 25);
	  menu_link_save($link);
	  
	  // Build footer menu
	  $menu = array(
	    'menu_name' => 'menu-footer',
	    'title' => 'Footer',
	    'description' => 'Het menu dat standaard in de footer staat.'
	  );
	  drupal_write_record('menu_custom', $menu);

    $link = array('menu_name' => 'menu-footer', 'link_path' => '<front>', 'link_title' => 'Contact', 'weight' => 1);
	  menu_link_save($link);
    
	  //variable_set('menu_default_node_menu', 'menu-site');
	
	  //$link = array('menu_name' => 'menu-footer-links', 'link_path' => 'contact', 'link_title' => 'Contact Us', 'weight' => 5);
	
	  //$link = array('menu_name' => 'menu-site', 'link_path' => '<front>', 'link_title' => 'Home', 'weight' => -50);
	  //menu_link_save($link);
	


	  // Configure visible blocks.
	  // Disable all default blocks for current theme and enable the two custom menus created above.
	
	  db_query("UPDATE {blocks} SET status = 0 where theme = '%s'", $theme);
	
	  $block = array(
	    'module' => 'menu',
	    'delta' => 'menu-footer',
	    'theme' => $theme,
	    'status' => 1,
	    'region' => 'footer',
	    'title' => '<none>'
	  );
	  drupal_write_record('blocks', $block);
	
	  $block = array(
	    'module' => 'menu',
	    'delta' => 'menu-admin',
	    'theme' => $theme,
	    'status' => 1,
	    'region' => 'left',
	    'title' =>  '<none>'
	  );
	  drupal_write_record('blocks', $block);
	
    // make filtered html only available for editor and admin
    db_query("UPDATE {filter_formats} SET roles = ',3,4,' WHERE format = 1");
    // htmlpurifier has its own cache logic
    db_query("UPDATE {filter_formats} SET cache = '0' WHERE format = 1");
    
    // make full html only available for admin
    db_query("UPDATE {filter_formats} SET roles = ',3,' WHERE format = 2");

    
    // create plain-text format
    db_query("INSERT INTO {filter_formats} (format, name, roles, cache) VALUES (3, 'Plain text', ',,', 1)");

    // reset filters
    db_query("DELETE FROM {filters} WHERE format = '1'");
    db_query("DELETE FROM {filters} WHERE format = '2'");
    db_query("DELETE FROM {filters} WHERE format = '3'");
    
    // configureate filters (plain text)
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 3, 10)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 0, 1)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 1, 2)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 2, 10)");
     
    // configureate filters (filtered html)
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 1, 'image_resize_filter', 0, -10)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 1, 'eminline', 0, 9)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 1, 'htmlpurifier', 1, -8)");

     
    // set plain text as default
    variable_set('filter_default_format', '3');
    
    // Create custom roles and set initial permissions.
    $role = array('name' => 'editor');
    drupal_write_record('role', $role);
    // FIX the editor role for better_formats (be
    db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight) VALUES ('4',  'node',  '0',  '1',  '-26')");
    db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight) VALUES ('4',  'block',  '0',  '1',  '-26')");
    db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight) VALUES ('4',  'comment',  '0',  '1',  '-26')");
		db_query("UPDATE {better_formats_defaults} SET weight = '20' WHERE rid = 1"); // anon
		db_query("UPDATE {better_formats_defaults} SET weight = '15' WHERE rid = 2"); // auth
		db_query("UPDATE {better_formats_defaults} SET weight = '5' WHERE rid = 3"); // administrator
		db_query("UPDATE {better_formats_defaults} SET weight = '10' WHERE rid = 4"); // editor
    // volgordes
    db_query("UPDATE {better_formats_defaults} SET format = '3' WHERE rid = 1");
    db_query("UPDATE {better_formats_defaults} SET format = '3' WHERE rid = 2");
    db_query("UPDATE {better_formats_defaults} SET format = '1' WHERE rid = 3");
    db_query("UPDATE {better_formats_defaults} SET format = '1' WHERE rid = 4");
	  db_query("UPDATE {better_formats_defaults} SET format = '3' WHERE type = 'comment'");
      
    variable_set('format', 's:1:"1";');
    
    // embedded inline video
    variable_set('eminline_providers_1', unserialize('a:1:{s:7:"youtube";s:7:"youtube";}'));
    variable_set('eminline_video_1', unserialize('a:3:{s:11:"video_width";s:3:"425";s:12:"video_height";s:3:"350";s:14:"video_autoplay";i:0;}'));
    variable_set('eminline_preview_1', unserialize('a:3:{s:13:"preview_width";s:3:"425";s:14:"preview_height";s:3:"350";s:16:"preview_autoplay";i:0;}'));
    variable_set('eminline_tn_1', unserialize('a:4:{s:15:"thumbnail_width";s:3:"120";s:16:"thumbnail_height";s:2:"90";s:22:"thumbnail_default_path";s:0:"";s:20:"thumbnail_link_title";s:0:"";}'));
    variable_set('eminline_full_node_1', unserialize('s:11:"video_video";'));
    variable_set('eminline_1', unserialize('a:6:{s:13:"provider_list";a:1:{s:9:"providers";a:1:{s:7:"youtube";s:7:"youtube";}}s:5:"video";a:3:{s:11:"video_width";s:3:"425";s:12:"video_height";s:3:"350";s:14:"video_autoplay";i:0;}s:7:"preview";a:3:{s:13:"preview_width";s:3:"425";s:14:"preview_height";s:3:"350";s:16:"preview_autoplay";i:0;}s:2:"tn";a:4:{s:15:"thumbnail_width";s:3:"120";s:16:"thumbnail_height";s:2:"90";s:22:"thumbnail_default_path";s:0:"";s:20:"thumbnail_link_title";s:0:"";}s:9:"meta_data";a:1:{s:11:"meta_fields";a:2:{s:5:"title";i:0;s:11:"description";i:0;}}s:12:"node_display";s:11:"video_video";}'));
    
    // html purifier settings
    variable_set('htmlpurifier_help_1', 0);
    variable_set('htmlpurifier_doublecache', 0);

$html_purifier_adv_settings = array(
    'Null_Attr.AllowedClasses' => 1,
    'Attr.AllowedFrameTargets' => '_top
_blank
_self
_parent',
    'Attr.AllowedRel' => '',
    'Attr.AllowedRev' => '',
    'Null_Attr.ClassUseCDATA' => 1,
    'Null_Attr.DefaultImageAlt' => 1,
    'Attr.DefaultInvalidImage' => '',
    'Attr.DefaultInvalidImageAlt' => 'Invalid image',
    'Attr.DefaultTextDir' => 'ltr',
    'Attr.EnableID' => 1,
    'Attr.ForbiddenClasses' => '',
    'Attr.IDBlacklist' => '',
    'Null_Attr.IDBlacklistRegexp' => 1,
    'Attr.IDPrefix' => '',
    'Attr.IDPrefixLocal' => '',
    'AutoFormat.AutoParagraph' => 1,
    'AutoFormat.Custom' => '',
    'AutoFormat.DisplayLinkURI' => 0,
    'AutoFormat.Linkify' => 0,
    'AutoFormat.PurifierLinkify.DocURL' => '#%s',
    'AutoFormat.PurifierLinkify' => 0,
    'AutoFormat.RemoveEmpty.RemoveNbsp.Exceptions' => 'td
th',
    'AutoFormat.RemoveEmpty.RemoveNbsp' => 0,
    'AutoFormat.RemoveEmpty' => 0,
    'AutoFormat.RemoveSpansWithoutAttributes' => 0,
    'CSS.AllowImportant' => 0,
    'CSS.AllowTricky' => 0,
    'Null_CSS.AllowedFonts' => 1,
    'Null_CSS.AllowedProperties' => 1,
    'CSS.ForbiddenProperties' => '',
    'CSS.MaxImgLength' => '1200px',
    'CSS.Proprietary' => 0,
    'CSS.Trusted' => 1,
    'Cache.DefinitionImpl' => 'Drupal',
    'Null_Cache.SerializerPath' => 1,
    'Cache.SerializerPermissions' => 493,
    'Core.AggressivelyFixLt' => 1,
    'Core.CollectErrors' => 0,
    'Core.ColorKeywords' => 'maroon:#800000
red:#FF0000
orange:#FFA500
yellow:#FFFF00
olive:#808000
purple:#800080
fuchsia:#FF00FF
white:#FFFFFF
lime:#00FF00
green:#008000
navy:#000080
blue:#0000FF
aqua:#00FFFF
teal:#008080
black:#000000
silver:#C0C0C0
gray:#808080',
    'Core.ConvertDocumentToFragment' => 1,
    'Core.DirectLexLineNumberSyncInterval' => 0,
    'Core.Encoding' => 'utf-8',
    'Core.EscapeInvalidChildren' => 0,
    'Core.EscapeInvalidTags' => 0,
    'Core.EscapeNonASCIICharacters' => 0,
    'Core.HiddenElements' => 'script
style',
    'Core.Language' => 'en',
    'Null_Core.LexerImpl' => 1,
    'Null_Core.MaintainLineNumbers' => 1,
    'Core.NormalizeNewlines' => 1,
    'Core.RemoveInvalidImg' => 1,
    'Core.RemoveProcessingInstructions' => 0,
    'Null_Core.RemoveScriptContents' => 1,
    'Filter.Custom' => '',
    'Filter.ExtractStyleBlocks.Escaping' => 1,
    'Null_Filter.ExtractStyleBlocks.Scope' => 1,
    'Null_Filter.ExtractStyleBlocks.TidyImpl' => 1,
    'Filter.ExtractStyleBlocks' => 0,
    'Filter.YouTube' => 1,
    'HTML.Allowed' => 'a,em,strong,cite,code,ul,ol,li,dl,dt,dd,p,br,img,br,h1,h2,h3,h4,h5,h6,table,th,tr,td,img',
    'HTML.AllowedAttributes' => 'a.target
a.href
*.value
*.name
*.src
*.title
*.class
*.style
*.alt
*.height
*.width
*.id
*.summary
*.abbr
*.codetype
*.standby
*.type
*.action
*.label',
    'Null_HTML.AllowedElements' => 1,
    'Null_HTML.AllowedModules' => 1,
    'HTML.Attr.Name.UseCDATA' => 0,
    'HTML.BlockWrapper' => 'p',
    'HTML.CoreModules' => 'Structure
Text
Hypertext
List
NonXMLCommonAttributes
XMLCommonAttributes
CommonAttributes',
    'Null_HTML.CustomDoctype' => 1,
    'HTML.Doctype' => 'XHTML 1.0 Transitional',
    'HTML.FlashAllowFullScreen' => 1,
    'HTML.ForbiddenAttributes' => '',
    'HTML.ForbiddenElements' => '',
    'HTML.MaxImgLength' => 1200,
    'HTML.Nofollow' => 0,
    'HTML.Parent' => 'div',
    'HTML.Proprietary' => 0,
    'HTML.SafeEmbed' => 0,
    'HTML.SafeObject' => 1,
    'HTML.Strict' => 0,
    'HTML.TidyAdd' => '',
    'HTML.TidyLevel' => 'medium',
    'HTML.TidyRemove' => '',
    'HTML.Trusted' => 1,
    'HTML.XHTML' => 1,
    'Output.CommentScriptContents' => 1,
    'Output.FixInnerHTML' => 1,
    'Output.FlashCompat' => 1,
    'Null_Output.Newline' => 1,
    'Output.SortAttr' => 0,
    'Output.TidyFormat' => 0,
    'Test.ForceNoIconv' => 0,
    'URI.AllowedSchemes' => 'http
https
mailto
ftp
nntp
news',
    'Null_URI.Base' => 1,
    'URI.DefaultScheme' => 'http',
    'URI.Disable' => 0,
    'URI.DisableExternal' => 0,
    'URI.DisableExternalResources' => 1,
    'URI.DisableResources' => 0,
    'Null_URI.Host' => 1,
    'URI.HostBlacklist' => '',
    'URI.MakeAbsolute' => 0,
    'Null_URI.Munge' => 1,
    'URI.MungeResources' => 0,
    'Null_URI.MungeSecretKey' => 1,
    'URI.OverrideAllowedSchemes' => 1,
);
    
    variable_set('htmlpurifier_config_1', $html_purifier_adv_settings);

  
	  //db_query("UPDATE {permission} SET perm = 'access content, search content' WHERE rid = 1");
	  #db_query("INSERT INTO {permission} (rid, perm, tid) VALUES(3, 'upload files', 0)");
	  #db_query("INSERT INTO {permission} (rid, perm, tid) VALUES(4, 'perform backup, administer blocks, administer menu, administer nodes, create url aliases, access statistics, access administration pages, access site reports', 0)");
	
	  // Create Home Page.
	
	  $node = new StdClass();
	  $node->type = 'page';
	  $node->status = 1;
	  $node->promote = 0;
    $node->format = 1;
	  $node->uid = 1;
	  $node->name = 'admin';
	  $node->path = 'home';
	  $node->title = 'Welcome';
	  $node->body = st('<p>Welkom bij versie '.QUADRUPAL_VERSION.' van QuaDrupal!</p><p>Om te testen of htmlpurifier goed geconfigureerd staat: <a href="http://www.merge.nl" target="_blank">deze link zou in een nieuw venster</a> moeten openen en <span style="color:#ff0000;">deze tekst zou rood moeten zijn</span>!</p>');
	  node_save($node);
	
	  variable_set('site_frontpage', 'node/1');
	
	  // Update the menu router information.
	  menu_rebuild();
	
	  // Run cron for the first time.
	  drupal_cron_run();
		
}

/**
* Implementation of hook_form_alter().
*
* Allows the profile to alter the site-configuration form. This is
* called through custom invocation, so $form_state is not populated.
*/
function quadrupal_form_alter(&$form, $form_state, $form_id) {
  if ($form_id == 'install_configure') {
    // Set default for site name field.
    $form['site_information']['site_name']['#default_value'] = 'QuaDrupal';
    $form['site_information']['site_mail']['#default_value'] = 'root@merge.nl';
    $form['admin_account']['account']['name']['#default_value'] = 'merge';
    $form['admin_account']['account']['mail']['#default_value'] = 'root@merge.nl';
  }
}

/**
 * Form API submit for the example form.
 */
function quadrupal_form_submit($form, &$form_state) {

  // This code is executed, while the form is submitted. There's
  // a wide range of possible operations to execute here, such as
  // process and store settings, enable extra modules, or save
  // contents to the new site (unless the operations are too
  // expensive: the Batch API is a good choice for such operations,
  // but it needs to be coded inside hook_profile_tasks(), not
  // here).

  // In this example profile, we just store the submitted text to
  // a temporary variable, to be used in further tasks.
  //variable_set('example_submitted_text', $form_state['values']['example_text']);
  

    
  
}