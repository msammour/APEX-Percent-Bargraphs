prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>21717127411908241868
,p_default_application_id=>103428
,p_default_owner=>'RD_DEV'
);
end;
/
prompt --application/shared_components/plugins/region_type/apex_perecent_bargraphs
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(54884691442646934817)
,p_plugin_type=>'REGION TYPE'
,p_name=>'APEX.PERECENT.BARGRAPHS'
,p_display_name=>'APEX Percent Bargraphs'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION F_AJAX (',
'    P_REGION   IN         APEX_PLUGIN.T_REGION,',
'    P_PLUGIN   IN         APEX_PLUGIN.T_PLUGIN',
') RETURN APEX_PLUGIN.T_REGION_AJAX_RESULT IS',
'    VR_RESULT   APEX_PLUGIN.T_REGION_AJAX_RESULT;',
'BEGIN',
'    APEX_UTIL.JSON_FROM_SQL(SQLQ   => RTRIM(',
'        P_REGION.SOURCE,',
'        '';''',
'    ));',
'    RETURN VR_RESULT;',
'END;',
'',
'FUNCTION F_RENDER (',
'    P_REGION                IN                      APEX_PLUGIN.T_REGION,',
'    P_PLUGIN                IN                      APEX_PLUGIN.T_PLUGIN,',
'    P_IS_PRINTER_FRIENDLY   IN                      BOOLEAN',
') RETURN APEX_PLUGIN.T_REGION_RENDER_RESULT IS',
'',
'    VR_RESULT         APEX_PLUGIN.T_REGION_RENDER_RESULT;',
'    VR_ITEMS2SUBMIT   APEX_APPLICATION_PAGE_REGIONS.AJAX_ITEMS_TO_SUBMIT%TYPE := APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_REGION.AJAX_ITEMS_TO_SUBMIT);',
'BEGIN',
'    APEX_CSS.ADD_FILE(',
'        P_NAME        => ''style.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''pergrcsssrc''',
'    );',
'',
'    APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''script.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''pergrjssrc''',
'    );',
'',
'    HTP.P(''<div id="'' || P_REGION.STATIC_ID || ''-p"></div>'');',
'',
'    APEX_JAVASCRIPT.ADD_ONLOAD_CODE( ''apexSkillBar.render(''',
'     || APEX_JAVASCRIPT.ADD_VALUE( P_REGION.STATIC_ID, TRUE )    ',
'     || APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN.GET_AJAX_IDENTIFIER, TRUE )',
'     || APEX_JAVASCRIPT.ADD_VALUE( P_REGION.NO_DATA_FOUND_MESSAGE, TRUE )',
'     || APEX_JAVASCRIPT.ADD_VALUE( VR_ITEMS2SUBMIT, TRUE )',
'     || APEX_JAVASCRIPT.ADD_VALUE( P_REGION.ESCAPE_OUTPUT, TRUE )',
'     || APEX_JAVASCRIPT.ADD_VALUE( P_REGION.ATTRIBUTE_01, FALSE )',
'     || '');'' );',
'',
'    RETURN VR_RESULT;',
'END;'))
,p_api_version=>1
,p_render_function=>'F_RENDER'
,p_ajax_function=>'F_AJAX'
,p_standard_attributes=>'SOURCE_LOCATION:AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE:ESCAPE_OUTPUT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'This plug-in is used to visualize percent bargraphs in APEX.'
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/RonnyWeiss/APEX-Percent-Bargraphs'
,p_files_version=>1418
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(54905435947487748190)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Refresh Time (Seconds)'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Set the refresh time of the region in seconds.'
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(54884692350725934836)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_name=>'SOURCE_LOCATION'
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    /* Required: Title that is show on skill bar */',
'    DECODE( ROWNUM, 1, ''ORACLE APEX'', 2, ''HTML5'', 3, ''CSS3'', 4, ''JavaScript'', NULL ) AS TITLE,',
'    /* Required: Percentage value as integer between 0 and 100 */',
'    ROUND( DBMS_RANDOM.VALUE( 30, 100 ) ) AS VALUE,',
'    /* Optional: background color of the title */',
'    DECODE( ROWNUM, 1, ''#0572CE'', 2, ''rgb(233,98,41)'', 3, ''rgb(38,143,201)'', 4, ''rgb(239,216,29)'', NULL ) AS TITLE_COLOR,',
'    /* Optional: background color of the bar value */',
'    NULL AS BAR_COLOR',
'FROM',
'    DUAL',
'CONNECT BY ROWNUM <= 4'))
,p_depending_on_has_to_exist=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'SELECT',
'    /* Required: Title that is show on skill bar */',
'    DECODE( ROWNUM, 1, ''ORACLE APEX'', 2, ''HTML5'', 3, ''CSS3'', 4, ''JavaScript'', NULL ) AS TITLE,',
'    /* Required: Percentage value as integer between 0 and 100 */',
'    ROUND( DBMS_RANDOM.VALUE( 30, 100 ) ) AS VALUE,',
'    /* Optional: background color of the title */',
'    DECODE( ROWNUM, 1, ''#0572CE'', 2, ''rgb(233,98,41)'', 3, ''rgb(38,143,201)'', 4, ''rgb(239,216,29)'', NULL ) AS TITLE_COLOR,',
'    /* Optional: background color of the bar value */',
'    NULL AS BAR_COLOR',
'FROM',
'    DUAL',
'CONNECT BY ROWNUM <= 4',
'</pre>'))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722061706578536B696C6C4261723D66756E6374696F6E28297B2275736520737472696374223B66756E6374696F6E206128612C722C732C74297B242861292E656D70747928292C722E726F772626722E726F772E6C656E6774683E303F66756E63';
wwv_flow_api.g_varchar2_table(2) := '74696F6E28612C722C73297B76617220743D303B242E6561636828722C66756E6374696F6E28722C6E297B6E2E56414C554526266E2E56414C55453C3D31303026266E2E56414C55453E3D30262628743D6E2E56414C5545293B766172206F3D2428223C';
wwv_flow_api.g_varchar2_table(3) := '6469763E3C2F6469763E22293B6F2E616464436C6173732822736B696C6C62617222292C6F2E616464436C6173732822636C65617266697822292C6F2E617474722822646174612D70657263656E74222C742B222522293B76617220693D2428223C6469';
wwv_flow_api.g_varchar2_table(4) := '763E3C2F6469763E22293B692E616464436C6173732822736B696C6C6261722D7469746C6522292C6E2E5449544C455F434F4C4F522626692E63737328226261636B67726F756E64222C652E65736361706548544D4C286E2E5449544C455F434F4C4F52';
wwv_flow_api.g_varchar2_table(5) := '29293B76617220633D2428223C7370616E3E3C2F7370616E3E22293B2131213D3D733F632E74657874286E2E5449544C45293A632E68746D6C286E2E5449544C45292C692E617070656E642863292C6F2E617070656E642869293B76617220643D242822';
wwv_flow_api.g_varchar2_table(6) := '3C6469763E3C2F6469763E22293B642E616464436C6173732822736B696C6C6261722D62617222292C6E2E4241525F434F4C4F522626642E63737328226261636B67726F756E64222C652E65736361706548544D4C286E2E4241525F434F4C4F5229292C';
wwv_flow_api.g_varchar2_table(7) := '6F2E617070656E642864293B76617220703D2428223C6469763E3C2F6469763E22293B702E616464436C6173732822736B696C6C2D6261722D70657263656E7422292C702E7465787428742B222522292C6F2E617070656E642870292C242861292E6170';
wwv_flow_api.g_varchar2_table(8) := '70656E64286F297D292C242861292E66696E6428222E736B696C6C62617222292E656163682866756E6374696F6E28297B242874686973292E66696E6428222E736B696C6C6261722D62617222292E616E696D617465287B77696474683A242874686973';
wwv_flow_api.g_varchar2_table(9) := '292E617474722822646174612D70657263656E7422297D2C31353030297D297D28612C722E726F772C74293A28242861292E63737328226D696E2D686569676874222C2222292C652E6E6F446174614D6573736167652E73686F7728612C7329292C652E';
wwv_flow_api.g_varchar2_table(10) := '6C6F616465722E73746F702861297D76617220653D7B76657273696F6E3A22312E302E31222C65736361706548544D4C3A66756E6374696F6E2861297B6966286E756C6C3D3D3D612972657475726E206E756C6C3B696628766F69642030213D3D61297B';
wwv_flow_api.g_varchar2_table(11) := '696628226F626A656374223D3D747970656F662061297472797B613D4A534F4E2E737472696E676966792861297D63617463682861297B7D7472797B72657475726E20617065782E7574696C2E65736361706548544D4C28537472696E67286129297D63';
wwv_flow_api.g_varchar2_table(12) := '617463682865297B72657475726E28613D537472696E67286129292E7265706C616365282F262F672C2226616D703B22292E7265706C616365282F3C2F672C22266C743B22292E7265706C616365282F3E2F672C222667743B22292E7265706C61636528';
wwv_flow_api.g_varchar2_table(13) := '2F222F672C222671756F743B22292E7265706C616365282F272F672C2226237832373B22292E7265706C616365282F5C2F2F672C2226237832463B22297D7D7D2C6C6F616465723A7B73746172743A66756E6374696F6E2861297B7472797B617065782E';
wwv_flow_api.g_varchar2_table(14) := '7574696C2E73686F775370696E6E65722824286129297D63617463682874297B76617220653D2428223C7370616E3E3C2F7370616E3E22293B652E6174747228226964222C226C6F61646572222B61292C652E616464436C617373282263742D6C6F6164';
wwv_flow_api.g_varchar2_table(15) := '65722066612D737461636B2066612D337822293B76617220723D2428223C693E3C2F693E22293B722E616464436C617373282266612066612D636972636C652066612D737461636B2D327822292C722E6373732822636F6C6F72222C2272676261283132';
wwv_flow_api.g_varchar2_table(16) := '312C3132312C3132312C302E362922293B76617220733D2428223C693E3C2F693E22293B732E616464436C617373282266612066612D726566726573682066612D7370696E2066612D696E76657273652066612D737461636B2D317822292C732E637373';
wwv_flow_api.g_varchar2_table(17) := '2822616E696D6174696F6E2D6475726174696F6E222C22312E387322292C652E617070656E642872292C652E617070656E642873292C242861292E617070656E642865297D7D2C73746F703A66756E6374696F6E2861297B2428612B22203E202E752D50';
wwv_flow_api.g_varchar2_table(18) := '726F63657373696E6722292E72656D6F766528292C2428612B22203E202E63742D6C6F6164657222292E72656D6F766528297D7D2C6E6F446174614D6573736167653A7B73686F773A66756E6374696F6E28612C65297B76617220723D2428223C646976';
wwv_flow_api.g_varchar2_table(19) := '3E3C2F6469763E22292E63737328226D617267696E222C223132707822292E6373732822746578742D616C69676E222C2263656E74657222292E637373282270616464696E67222C2236347078203022292E616464436C61737328226E6F64617461666F';
wwv_flow_api.g_varchar2_table(20) := '756E646D65737361676522292C733D2428223C6469763E3C2F6469763E22292C743D2428223C7370616E3E3C2F7370616E3E22292E616464436C6173732822666122292E616464436C617373282266612D73656172636822292E616464436C6173732822';
wwv_flow_api.g_varchar2_table(21) := '66612D327822292E6373732822686569676874222C223332707822292E63737328227769647468222C223332707822292E6373732822636F6C6F72222C222344304430443022292E63737328226D617267696E2D626F74746F6D222C223136707822293B';
wwv_flow_api.g_varchar2_table(22) := '732E617070656E642874293B766172206E3D2428223C7370616E3E3C2F7370616E3E22292E746578742865292E6373732822646973706C6179222C22626C6F636B22292E6373732822636F6C6F72222C222337303730373022292E6373732822666F6E74';
wwv_flow_api.g_varchar2_table(23) := '2D73697A65222C223132707822293B722E617070656E642873292E617070656E64286E292C242861292E617070656E642872297D2C686964653A66756E6374696F6E2861297B242861292E6368696C6472656E28222E6E6F64617461666F756E646D6573';
wwv_flow_api.g_varchar2_table(24) := '7361676522292E72656D6F766528297D7D7D3B72657475726E7B72656E6465723A66756E6374696F6E28722C732C742C6E2C6F2C692C63297B66756E6374696F6E206428297B242870292E63737328226D696E2D686569676874222C2231323070782229';
wwv_flow_api.g_varchar2_table(25) := '2C652E6C6F616465722E73746172742870293B76617220723D6E3B7472797B617065782E7365727665722E706C7567696E28732C7B706167654974656D733A727D2C7B737563636573733A66756E6374696F6E2865297B6128702C652C742C6F297D2C65';
wwv_flow_api.g_varchar2_table(26) := '72726F723A66756E6374696F6E2861297B636F6E736F6C652E6572726F7228612E726573706F6E736554657874297D2C64617461547970653A226A736F6E227D297D63617463682865297B636F6E736F6C652E6572726F7228224572726F72207768696C';
wwv_flow_api.g_varchar2_table(27) := '652074727920746F2067657420446174612066726F6D204150455822292C636F6E736F6C652E6572726F722865293B7472797B6326266128702C632C742C6F297D63617463682861297B636F6E736F6C652E6572726F7228224572726F72207768696C65';
wwv_flow_api.g_varchar2_table(28) := '2074727920746F2072756E206E6174697665206D6F646522292C636F6E736F6C652E6572726F722861297D7D7D76617220703D2223222B722B222D70223B6428293B7472797B617065782E6A5175657279282223222B72292E62696E6428226170657872';
wwv_flow_api.g_varchar2_table(29) := '656672657368222C66756E6374696F6E28297B6428297D297D63617463682861297B636F6E736F6C652E6572726F7228224572726F72207768696C652074727920746F2062696E6420415045582072656672657368206576656E7422292C636F6E736F6C';
wwv_flow_api.g_varchar2_table(30) := '652E6572726F722861297D692626693E302626736574496E74657276616C2866756E6374696F6E28297B6428297D2C3165332A69297D7D7D28293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(27455767203360510655)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_file_name=>'script.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E736B696C6C6261727B706F736974696F6E3A72656C61746976653B646973706C61793A626C6F636B3B6D617267696E2D626F74746F6D3A313570783B77696474683A313030253B6261636B67726F756E643A236565653B6865696768743A333570783B';
wwv_flow_api.g_varchar2_table(2) := '626F726465722D7261646975733A3370783B2D6D6F7A2D626F726465722D7261646975733A3370783B2D7765626B69742D626F726465722D7261646975733A3370783B2D7765626B69742D7472616E736974696F6E3A2E3473206C696E6561723B2D6D6F';
wwv_flow_api.g_varchar2_table(3) := '7A2D7472616E736974696F6E3A2E3473206C696E6561723B2D6D732D7472616E736974696F6E3A2E3473206C696E6561723B2D6F2D7472616E736974696F6E3A2E3473206C696E6561723B7472616E736974696F6E3A2E3473206C696E6561723B2D7765';
wwv_flow_api.g_varchar2_table(4) := '626B69742D7472616E736974696F6E2D70726F70657274793A77696474682C6261636B67726F756E642D636F6C6F723B2D6D6F7A2D7472616E736974696F6E2D70726F70657274793A77696474682C6261636B67726F756E642D636F6C6F723B2D6D732D';
wwv_flow_api.g_varchar2_table(5) := '7472616E736974696F6E2D70726F70657274793A77696474682C6261636B67726F756E642D636F6C6F723B2D6F2D7472616E736974696F6E2D70726F70657274793A77696474682C6261636B67726F756E642D636F6C6F723B7472616E736974696F6E2D';
wwv_flow_api.g_varchar2_table(6) := '70726F70657274793A77696474682C6261636B67726F756E642D636F6C6F727D2E736B696C6C6261722D7469746C657B706F736974696F6E3A6162736F6C7574653B746F703A303B6C6566743A303B666F6E742D7765696768743A3730303B666F6E742D';
wwv_flow_api.g_varchar2_table(7) := '73697A653A313370783B636F6C6F723A236666663B6261636B67726F756E643A236338633863383B2D7765626B69742D626F726465722D746F702D6C6566742D7261646975733A3370783B2D7765626B69742D626F726465722D626F74746F6D2D6C6566';
wwv_flow_api.g_varchar2_table(8) := '742D7261646975733A3470783B2D6D6F7A2D626F726465722D7261646975732D746F706C6566743A3370783B2D6D6F7A2D626F726465722D7261646975732D626F74746F6D6C6566743A3370783B626F726465722D746F702D6C6566742D726164697573';
wwv_flow_api.g_varchar2_table(9) := '3A3370783B626F726465722D626F74746F6D2D6C6566742D7261646975733A3370787D2E736B696C6C6261722D7469746C65207370616E7B646973706C61793A626C6F636B3B6261636B67726F756E643A7267626128302C302C302C2E31293B70616464';
wwv_flow_api.g_varchar2_table(10) := '696E673A3020323070783B6865696768743A333570783B6C696E652D6865696768743A333570783B2D7765626B69742D626F726465722D746F702D6C6566742D7261646975733A3370783B2D7765626B69742D626F726465722D626F74746F6D2D6C6566';
wwv_flow_api.g_varchar2_table(11) := '742D7261646975733A3370783B2D6D6F7A2D626F726465722D7261646975732D746F706C6566743A3370783B2D6D6F7A2D626F726465722D7261646975732D626F74746F6D6C6566743A3370783B626F726465722D746F702D6C6566742D726164697573';
wwv_flow_api.g_varchar2_table(12) := '3A3370783B626F726465722D626F74746F6D2D6C6566742D7261646975733A3370787D2E736B696C6C6261722D6261727B6865696768743A333570783B77696474683A303B6261636B67726F756E643A236338633863383B626F726465722D7261646975';
wwv_flow_api.g_varchar2_table(13) := '733A3370783B2D6D6F7A2D626F726465722D7261646975733A3370783B2D7765626B69742D626F726465722D7261646975733A3370787D2E736B696C6C2D6261722D70657263656E747B706F736974696F6E3A6162736F6C7574653B72696768743A3130';
wwv_flow_api.g_varchar2_table(14) := '70783B746F703A303B666F6E742D73697A653A313170783B6865696768743A333570783B6C696E652D6865696768743A333570783B636F6C6F723A233434343B636F6C6F723A7267626128302C302C302C31297D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(27455768789515511678)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_file_name=>'style.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '4D4954204C6963656E73650A0A436F7079726967687420286329203230313920526F6E6E792057656973730A0A5065726D697373696F6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E79207065';
wwv_flow_api.g_varchar2_table(2) := '72736F6E206F627461696E696E67206120636F70790A6F66207468697320736F66747761726520616E64206173736F63696174656420646F63756D656E746174696F6E2066696C657320287468652022536F66747761726522292C20746F206465616C0A';
wwv_flow_api.g_varchar2_table(3) := '696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E6720776974686F7574206C696D69746174696F6E20746865207269676874730A746F207573652C20636F70792C206D6F646966792C206D';
wwv_flow_api.g_varchar2_table(4) := '657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F722073656C6C0A636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F20';
wwv_flow_api.g_varchar2_table(5) := '77686F6D2074686520536F6674776172652069730A6675726E697368656420746F20646F20736F2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A0A5468652061626F766520636F70797269676874206E';
wwv_flow_api.g_varchar2_table(6) := '6F7469636520616E642074686973207065726D697373696F6E206E6F74696365207368616C6C20626520696E636C7564656420696E20616C6C0A636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674';
wwv_flow_api.g_varchar2_table(7) := '776172652E0A0A54484520534F4654574152452049532050524F564944454420224153204953222C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A494D504C4945442C20494E434C5544494E47';
wwv_flow_api.g_varchar2_table(8) := '20425554204E4F54204C494D4954454420544F205448452057415252414E54494553204F46204D45524348414E544142494C4954592C0A4649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E465249';
wwv_flow_api.g_varchar2_table(9) := '4E47454D454E542E20494E204E4F204556454E54205348414C4C205448450A415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845';
wwv_flow_api.g_varchar2_table(10) := '520A4C494142494C4954592C205748455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A4F5554204F46204F5220494E20434F4E4E454354';
wwv_flow_api.g_varchar2_table(11) := '494F4E20574954482054484520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A534F4654574152452E0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(31819835017848985518)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_file_name=>'LICENSE'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := 'EFBBBF5468616E6B7320666F72206578616D706C65206F6E20636F646570656E2E696F3A0D0A0D0A536B696C6C204261722077697468206A5175657279202620435353330D0A412050656E20427920526F737469736C617620556772796E79756B200D0A';
wwv_flow_api.g_varchar2_table(2) := '0D0A68747470733A2F2F636F646570656E2E696F2F7567726F73732F70656E2F7A416974620D0A0D0A616E64206A51756572793A0D0A0D0A68747470733A2F2F6769746875622E636F6D2F6A71756572792F6A71756572790D0A0D0A436F707972696768';
wwv_flow_api.g_varchar2_table(3) := '74204A5320466F756E646174696F6E20616E64206F7468657220636F6E7472696275746F72732C2068747470733A2F2F6A732E666F756E646174696F6E2F0D0A0D0A5065726D697373696F6E20697320686572656279206772616E7465642C2066726565';
wwv_flow_api.g_varchar2_table(4) := '206F66206368617267652C20746F20616E7920706572736F6E206F627461696E696E670D0A6120636F7079206F66207468697320736F66747761726520616E64206173736F63696174656420646F63756D656E746174696F6E2066696C65732028746865';
wwv_flow_api.g_varchar2_table(5) := '0D0A22536F66747761726522292C20746F206465616C20696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E670D0A776974686F7574206C696D69746174696F6E2074686520726967687473';
wwv_flow_api.g_varchar2_table(6) := '20746F207573652C20636F70792C206D6F646966792C206D657267652C207075626C6973682C0D0A646973747269627574652C207375626C6963656E73652C20616E642F6F722073656C6C20636F70696573206F662074686520536F6674776172652C20';
wwv_flow_api.g_varchar2_table(7) := '616E6420746F0D0A7065726D697420706572736F6E7320746F2077686F6D2074686520536F667477617265206973206675726E697368656420746F20646F20736F2C207375626A65637420746F0D0A74686520666F6C6C6F77696E6720636F6E64697469';
wwv_flow_api.g_varchar2_table(8) := '6F6E733A0D0A0D0A5468652061626F766520636F70797269676874206E6F7469636520616E642074686973207065726D697373696F6E206E6F74696365207368616C6C2062650D0A696E636C7564656420696E20616C6C20636F70696573206F72207375';
wwv_flow_api.g_varchar2_table(9) := '627374616E7469616C20706F7274696F6E73206F662074686520536F6674776172652E0D0A0D0A54484520534F4654574152452049532050524F564944454420224153204953222C20574954484F55542057415252414E5459204F4620414E59204B494E';
wwv_flow_api.g_varchar2_table(10) := '442C0D0A45585052455353204F5220494D504C4945442C20494E434C5544494E4720425554204E4F54204C494D4954454420544F205448452057415252414E54494553204F460D0A4D45524348414E544142494C4954592C204649544E45535320464F52';
wwv_flow_api.g_varchar2_table(11) := '204120504152544943554C415220505552504F534520414E440D0A4E4F4E494E4652494E47454D454E542E20494E204E4F204556454E54205348414C4C2054484520415554484F5253204F5220434F5059524947485420484F4C444552532042450D0A4C';
wwv_flow_api.g_varchar2_table(12) := '4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F54484552204C494142494C4954592C205748455448455220494E20414E20414354494F4E0D0A4F4620434F4E54524143542C20544F5254204F52204F54484552574953';
wwv_flow_api.g_varchar2_table(13) := '452C2041524953494E472046524F4D2C204F5554204F46204F5220494E20434F4E4E454354494F4E0D0A574954482054484520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E2054484520534F4654';
wwv_flow_api.g_varchar2_table(14) := '574152452E';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(31819835381966985520)
,p_plugin_id=>wwv_flow_api.id(54884691442646934817)
,p_file_name=>'LICENSE4LIBS'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
