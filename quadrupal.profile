<?php
// $Id$
DEFINE('QUADRUPAL_VERSION','1.5');

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
	'date_timezone',
	'ds', 'ds_ui', 'nd', 'nd_cck', 'nd_search', 'ud',
	'dul',
	'disablepwstrength',
	'token',
	'transliteration',
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
 		$mods = array('htmlpurifier','toolbar');
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
	
	  // Default page to not be promoted and have comments disabled.
	  //variable_set('node_options_page', array('status', 'revision'));
	  //variable_set('comment_page', COMMENT_NODE_DISABLED);
	
	  // Don't display date and author information for page nodes by default.
	  //$theme_settings = variable_get('theme_settings', array());
	  //$theme_settings['toggle_node_info_page'] = FALSE;
	  //variable_set('theme_settings', $theme_settings);
	
	  // Set the preferred theme.
    /*
	  $themes = system_theme_data();
	  $preferred_themes = array('mytheme1', 'mytheme2', 'garland');
	  foreach ($preferred_themes as $theme) {
	    if (array_key_exists($theme, $themes)) {
	      system_initialize_theme_blocks($theme);
	      db_query("UPDATE {system} SET status = 1 WHERE type = 'theme' and name = ('%s')", $theme);
	      variable_set('theme_default', $theme);
	      break;
	    }
	  }
		*/
    
	  // Default input filter allowed HTML tags.
	  //variable_set('allowed_html_1', '<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd> <ins> <del> <p> <br> <h2> <h3> <h4> ');
		
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
    
    // set the administration theme to rubik
 	  variable_set('admin_theme', 'rubik');
 	  variable_set('node_admin_theme', '1');
    // disable all blocks for rubik
    db_query("UPDATE {blocks} SET status = 0 where theme = '%s'", 'rubik');
		// default theme = oeleboele
		variable_set('theme_default', 'oeleboele');
    
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
    $theme = 'merge';
    
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
	
    // create plain-text format
    db_query("INSERT INTO {filter_formats} (format, name, roles, cache) VALUES (3, 'Plain text', ',,', 1)");
    variable_set('filter_default_format', '3'); // default maken
    // config this filter
    db_query("DELETE FROM {filters} WHERE format = '3'");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 3, 10)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 0, 1)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 1, 2)");
    db_query("INSERT INTO {filters} (fid, format, module, delta, weight) VALUES (NULL, 3, 'filter', 2, 10)");
   
  
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
	
  
  
	  //db_query("UPDATE {permission} SET perm = 'access content, search content' WHERE rid = 1");
	  #db_query("INSERT INTO {permission} (rid, perm, tid) VALUES(3, 'upload files', 0)");
	  #db_query("INSERT INTO {permission} (rid, perm, tid) VALUES(4, 'perform backup, administer blocks, administer menu, administer nodes, create url aliases, access statistics, access administration pages, access site reports', 0)");
	
	  // Create Home Page.
	
	  $node = new StdClass();
	  $node->type = 'page';
	  $node->status = 1;
	  $node->promote = 0;
	  $node->uid = 1;
	  $node->name = 'admin';
	  $node->path = 'home';
	  $node->title = 'Welcome';
	  $node->body = st('Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt.');
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
