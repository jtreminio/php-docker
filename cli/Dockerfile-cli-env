FROM ubuntu:18.04

ENV PHP.allow_url_fopen=1 \
    PHP.allow_url_include= \
    PHP.always_populate_raw_post_data= \
    PHP.asp_tags= \
    PHP.auto_append_file= \
    PHP.auto_detect_line_endings=0 \
    PHP.auto_globals_jit=1 \
    PHP.auto_prepend_file= \
    PHP.browscap= \
    PHP.child_terminate= \
    PHP.default_charset=UTF-8 \
    PHP.default_mimetype=text/html \
    PHP.default_socket_timeout=60 \
    PHP.disable_classes= \
    PHP.disable_functions= \
    PHP.display_errors=Off \
    PHP.display_startup_errors= \
    PHP.docref_ext= \
    PHP.docref_root= \
    PHP.doc_root= \
    PHP.error_append_string= \
    PHP.error_log= \
    PHP.error_prepend_string= \
    PHP.error_reporting=0 \
    PHP.exit_on_timeout= \
    PHP.expose_php=1 \
    PHP.file_uploads=1 \
    PHP.html_errors=0 \
    PHP.ignore_repeated_errors= \
    PHP.ignore_repeated_source= \
    PHP.ignore_user_abort=0 \
    PHP.implicit_flush=1 \
    PHP.include_path=.:/usr/share/php \
    PHP.last_modified= \
    PHP.log_errors=1 \
    PHP.log_errors_max_len=1024 \
    PHP.max_execution_time=0 \
    PHP.max_input_nesting_level=64 \
    PHP.max_input_vars=1000 \
    PHP.max_input_time=-1 \
    PHP.memory_limit=-1 \
    PHP.open_basedir= \
    PHP.output_buffering=0 \
    PHP.output_handler= \
    PHP.enable_post_data_reading=1 \
    PHP.post_max_size=8M \
    PHP.precision=14 \
    PHP.realpath_cache_size=4096K \
    PHP.realpath_cache_ttl=120 \
    PHP.register_argc_argv=1 \
    PHP.report_memleaks=1 \
    PHP.report_zend_debug=0 \
    PHP.request_order=GP \
    PHP.sendmail_from= \
    PHP.sendmail_path="/usr/sbin/sendmail -t -i" \
    PHP.serialize_precision=-1 \
    PHP.short_open_tag= \
    PHP.SMTP=localhost \
    PHP.smtp_port=25 \
    PHP.track_errors=0 \
    PHP.unserialize_callback_func= \
    PHP.upload_max_filesize=2M \
    PHP.max_file_uploads=20 \
    PHP.upload_tmp_dir= \
    PHP.user_agent= \
    PHP.user_dir= \
    PHP.variables_order=GPCS \
    PHP.windows_show_crt_warning= \
    PHP.xbithack= \
    PHP.xmlrpc_errors=0 \
    PHP.xmlrpc_error_number=0 \
    \
    PHP.apc.cache_by_default= \
    PHP.apc.enabled= \
    PHP.apc.enable_cli= \
    PHP.apc.file_update_protection= \
    PHP.apc.filters= \
    PHP.apc.gc_ttl= \
    PHP.apc.include_once_override= \
    PHP.apc.localcache= \
    PHP.apc.localcache.size= \
    PHP.apc.max_file_size= \
    PHP.apc.mmap_file_mask= \
    PHP.apc.num_files_hint= \
    PHP.apc.report_autofilter= \
    PHP.apc.rfc1867= \
    PHP.apc.rfc1867_freq=0 \
    PHP.apc.rfc1867_name= \
    PHP.apc.rfc1867_prefix= \
    PHP.apc.shm_segments=1 \
    PHP.apc.shm_size= \
    PHP.apc.slam_defense= \
    PHP.apc.stat= \
    PHP.apc.stat_ctime= \
    PHP.apc.ttl= \
    PHP.apc.user_entries_hint= \
    PHP.apc.user_ttl= \
    PHP.apc.write_lock= \
    \
    PHP.apd.dumpdir= \
    PHP.apd.statement_tracing= \
    \
    PHP.arg_separator.input=& \
    PHP.arg_separator.output=& \
    \
    PHP.assert.active=1 \
    PHP.assert.bail=0 \
    PHP.assert.callback= \
    PHP.assert.quiet_eval=0 \
    PHP.assert.warning=1 \
    \
    PHP.axis2.client_home= \
    PHP.axis2.enable_exception= \
    PHP.axis2.enable_trace= \
    PHP.axis2.log_path= \
    \
    PHP.bcmath.scale=0 \
    \
    PHP.bcompiler.enabled= \
    \
    PHP.birdstep.max_links= \
    \
    PHP.blenc.key_file= \
    \
    PHP.cgi.check_shebang_line= \
    PHP.cgi.discard_path= \
    PHP.cgi.fix_pathinfo= \
    PHP.cgi.force_redirect= \
    PHP.cgi.nph= \
    PHP.cgi.redirect_status_env= \
    PHP.cgi.rfc2616_headers= \
    \
    PHP.cli.pager= \
    PHP.cli.prompt="\b \>" \
    PHP.cli_server.color= \
    \
    PHP.coin_acceptor.auto_initialize= \
    PHP.coin_acceptor.auto_reset= \
    PHP.coin_acceptor.command_function= \
    PHP.coin_acceptor.delay_coins= \
    PHP.coin_acceptor.delay_prom= \
    PHP.coin_acceptor.lock_on_close= \
    PHP.coin_acceptor.start_unlocked= \
    \
    PHP.com.allow_dcom= \
    PHP.com.autoregister_casesensitive= \
    PHP.com.autoregister_typelib= \
    PHP.com.autoregister_verbose= \
    PHP.com.code_page= \
    PHP.com.typelib_file= \
    \
    PHP.curl.cainfo= \
    \
    PHP.daffodildb.default_host= \
    PHP.daffodildb.default_password= \
    PHP.daffodildb.default_socket= \
    PHP.daffodildb.default_user= \
    PHP.daffodildb.port= \
    \
    PHP.date.default_latitude=31.7667 \
    PHP.date.default_longitude=35.2333 \
    PHP.date.sunrise_zenith=90.583333 \
    PHP.date.sunset_zenith=90.583333 \
    PHP.date.timezone=UTC \
    \
    PHP.dba.default_handler= \
    \
    PHP.etpan.default.charset= \
    PHP.etpan.default.protocol= \
    \
    PHP.exif.decode_jis_intel=JIS \
    PHP.exif.decode_jis_motorola=JIS \
    PHP.exif.decode_unicode_intel=UCS-2LE \
    PHP.exif.decode_unicode_motorola=UCS-2BE \
    PHP.exif.encode_jis= \
    PHP.exif.encode_unicode=ISO-8859-15 \
    \
    PHP.expect.logfile= \
    PHP.expect.loguser= \
    PHP.expect.timeout= \
    \
    PHP.fastcgi.impersonate= \
    PHP.fastcgi.logging= \
    \
    PHP.fbsql.allow_persistent= \
    PHP.fbsql.autocommit= \
    PHP.fbsql.batchsize= \
    PHP.fbsql.default_database= \
    PHP.fbsql.default_database_password= \
    PHP.fbsql.default_host= \
    PHP.fbsql.default_password= \
    PHP.fbsql.default_user= \
    PHP.fbsql.generate_warnings= \
    PHP.fbsql.max_connections= \
    PHP.fbsql.max_links= \
    PHP.fbsql.max_persistent= \
    PHP.fbsql.max_results= \
    PHP.fbsql.show_timestamp_decimals= \
    \
    PHP.filter.default=unsafe_raw \
    PHP.filter.default_flags= \
    \
    PHP.gd.jpeg_ignore_warning= \
    \
    PHP.geoip.custom_directory= \
    \
    PHP.hidef.ini_path= \
    \
    PHP.highlight.comment="#FF8000" \
    PHP.highlight.default="#0000BB" \
    PHP.highlight.html="#000000" \
    PHP.highlight.keyword="#007700" \
    PHP.highlight.string="#DD0000" \
    \
    PHP.htscanner.config_file= \
    PHP.htscanner.default_docroot= \
    PHP.htscanner.default_ttl= \
    PHP.htscanner.stop_on_error= \
    \
    PHP.http.etag.mode= \
    PHP.http.force_exit= \
    PHP.http.log.allowed_methods= \
    PHP.http.log.cache= \
    PHP.http.log.composite= \
    PHP.http.log.not_found= \
    PHP.http.log.redirect= \
    PHP.http.only_exceptions= \
    PHP.http.persistent.handles.ident= \
    PHP.http.persistent.handles.limit= \
    PHP.http.request.datashare.connect= \
    PHP.http.request.datashare.cookie= \
    PHP.http.request.datashare.dns= \
    PHP.http.request.datashare.ssl= \
    PHP.http.request.methods.allowed= \
    PHP.http.request.methods.custom= \
    PHP.http.send.deflate.start_auto= \
    PHP.http.send.deflate.start_flags= \
    PHP.http.send.inflate.start_auto= \
    PHP.http.send.inflate.start_flags= \
    PHP.http.send.not_found_404= \
    \
    PHP.ibase.allow_persistent= \
    PHP.ibase.dateformat= \
    PHP.ibase.default_charset= \
    PHP.ibase.default_db= \
    PHP.ibase.default_password= \
    PHP.ibase.default_user= \
    PHP.ibase.max_links= \
    PHP.ibase.max_persistent= \
    PHP.ibase.timeformat= \
    PHP.ibase.timestampformat= \
    \
    PHP.ibm_db2.binmode= \
    PHP.ibm_db2.i5_all_pconnect= \
    PHP.ibm_db2.i5_allow_commit= \
    PHP.ibm_db2.i5_dbcs_alloc= \
    PHP.ibm_db2.instance_name= \
    PHP.ibm_db2.i5_ignore_userid= \
    \
    PHP.iconv.input_encoding= \
    PHP.iconv.internal_encoding= \
    PHP.iconv.output_encoding= \
    \
    PHP.imlib2.font_cache_max_size= \
    PHP.imlib2.font_path= \
    \
    PHP.ingres.allow_persistent= \
    PHP.ingres.array_index_start= \
    PHP.ingres.auto= \
    PHP.ingres.blob_segment_length= \
    PHP.ingres.cursor_mode= \
    PHP.ingres.default_database= \
    PHP.ingres.default_password= \
    PHP.ingres.default_user= \
    PHP.ingres.describe= \
    PHP.ingres.fetch_buffer_size= \
    PHP.ingres.max_links= \
    PHP.ingres.max_persistent= \
    PHP.ingres.reuse_connection= \
    PHP.ingres.scrollable= \
    PHP.ingres.trace= \
    PHP.ingres.trace_connect= \
    PHP.ingres.utf8= \
    \
    PHP.ldap.max_links= \
    \
    PHP.mail.add_x_header= \
    PHP.mail.force_extra_parameters= \
    PHP.mail.log= \
    \
    PHP.maxdb.default_db= \
    PHP.maxdb.default_host= \
    PHP.maxdb.default_pw= \
    PHP.maxdb.default_user= \
    PHP.maxdb.long_readlen= \
    \
    PHP.mbstring.detect_order= \
    PHP.mbstring.encoding_translation=0 \
    PHP.mbstring.func_overload=0 \
    PHP.mbstring.http_input= \
    PHP.mbstring.http_output= \
    PHP.mbstring.internal_encoding= \
    PHP.mbstring.language=neutral \
    PHP.mbstring.script_encoding= \
    PHP.mbstring.strict_detection=0 \
    PHP.mbstring.substitute_character= \
    \
    PHP.mcrypt.algorithms_dir= \
    PHP.mcrypt.modes_dir= \
    \
    PHP.memcache.allow_failover= \
    PHP.memcache.chunk_size= \
    PHP.memcache.default_port= \
    PHP.memcache.hash_function= \
    PHP.memcache.hash_strategy= \
    PHP.memcache.max_failover_attempts= \
    \
    PHP.mime_magic.debug= \
    PHP.mime_magic.magicfile= \
    \
    PHP.mongo.allow_empty_keys= \
    PHP.mongo.chunk_size= \
    PHP.mongo.cmd= \
    PHP.mongo.default_host= \
    PHP.mongo.default_port= \
    PHP.mongo.is_master_interval= \
    PHP.mongo.long_as_object= \
    PHP.mongo.native_long= \
    PHP.mongo.ping_interval= \
    PHP.mongo.utf8= \
    \
    PHP.msql.allow_persistent= \
    PHP.msql.max_links= \
    PHP.msql.max_persistent= \
    \
    PHP.mssql.allow_persistent= \
    PHP.mssql.batchsize= \
    PHP.mssql.charset= \
    PHP.mssql.compatability_mode= \
    PHP.mssql.connect_timeout= \
    PHP.mssql.datetimeconvert= \
    PHP.mssql.max_links= \
    PHP.mssql.max_persistent= \
    PHP.mssql.max_procs= \
    PHP.mssql.min_error_severity= \
    PHP.mssql.min_message_severity= \
    PHP.mssql.secure_connection= \
    PHP.mssql.textlimit= \
    PHP.mssql.textsize= \
    PHP.mssql.timeout= \
    \
    PHP.mysql.allow_local_infile= \
    PHP.mysql.allow_persistent= \
    PHP.mysql.max_persistent= \
    PHP.mysql.max_links= \
    PHP.mysql.trace_mode= \
    PHP.mysql.default_port= \
    PHP.mysql.default_socket= \
    PHP.mysql.default_host= \
    PHP.mysql.default_user= \
    PHP.mysql.default_password= \
    PHP.mysql.connect_timeout= \
    \
    PHP.mysqli.allow_local_infile=1 \
    PHP.mysqli.allow_persistent=1 \
    PHP.mysqli.max_persistent=-1 \
    PHP.mysqli.max_links=-1 \
    PHP.mysqli.default_port=3306 \
    PHP.mysqli.default_socket= \
    PHP.mysqli.default_host= \
    PHP.mysqli.default_user= \
    PHP.mysqli.default_pw= \
    PHP.mysqli.reconnect= \
    PHP.mysqli.cache_size= \
    \
    PHP.mysqlnd_memcache.enable= \
    PHP.mysqlnd_ms.enable= \
    PHP.mysqlnd_ms.force_config_usage= \
    PHP.mysqlnd_ms.ini_file= \
    PHP.mysqlnd_ms.config_file= \
    PHP.mysqlnd_ms.collect_statistics= \
    PHP.mysqlnd_ms.multi_master= \
    PHP.mysqlnd_ms.disable_rw_split= \
    PHP.mysqlnd_mux.enable= \
    PHP.mysqlnd_qc.enable_qc= \
    PHP.mysqlnd_qc.ttl= \
    PHP.mysqlnd_qc.cache_by_default= \
    PHP.mysqlnd_qc.cache_no_table= \
    PHP.mysqlnd_qc.use_request_time= \
    PHP.mysqlnd_qc.time_statistics= \
    PHP.mysqlnd_qc.collect_statistics= \
    PHP.mysqlnd_qc.collect_statistics_log_file= \
    PHP.mysqlnd_qc.collect_query_trace= \
    PHP.mysqlnd_qc.query_trace_bt_depth= \
    PHP.mysqlnd_qc.collect_normalized_query_trace= \
    PHP.mysqlnd_qc.ignore_sql_comments= \
    PHP.mysqlnd_qc.slam_defense= \
    PHP.mysqlnd_qc.slam_defense_ttl= \
    PHP.mysqlnd_qc.std_data_copy= \
    PHP.mysqlnd_qc.apc_prefix= \
    PHP.mysqlnd_qc.memc_server= \
    PHP.mysqlnd_qc.memc_port= \
    PHP.mysqlnd_qc.sqlite_data_file= \
    PHP.mysqlnd_uh.enable= \
    PHP.mysqlnd_uh.report_wrong_types= \
    \
    PHP.nsapi.read_timeout= \
    \
    PHP.oci8.connection_class= \
    PHP.oci8.default_prefetch= \
    PHP.oci8.events= \
    PHP.oci8.max_persistent= \
    PHP.oci8.old_oci_close_semantics= \
    PHP.oci8.persistent_timeout= \
    PHP.oci8.ping_interval= \
    PHP.oci8.privileged_connect= \
    PHP.oci8.statement_cache_size= \
    \
    PHP.odbc.allow_persistent= \
    PHP.odbc.check_persistent= \
    PHP.odbc.defaultbinmode= \
    PHP.odbc.defaultlrl= \
    PHP.odbc.default_db= \
    PHP.odbc.default_pw= \
    PHP.odbc.default_user= \
    PHP.odbc.max_links= \
    PHP.odbc.max_persistent= \
    \
    PHP.odbtp.datetime_format= \
    PHP.odbtp.detach_default_queries= \
    PHP.odbtp.guid_format= \
    PHP.odbtp.interface_file= \
    PHP.odbtp.truncation_errors= \
    \
    PHP.opcache.blacklist_filename= \
    PHP.opcache.consistency_checks=0 \
    PHP.opcache.dups_fix=0 \
    PHP.opcache.enable=1 \
    PHP.opcache.enable_cli=1 \
    PHP.opcache.enable_file_override=0 \
    PHP.opcache.error_log= \
    PHP.opcache.fast_shutdown= \
    PHP.opcache.file_update_protection=2 \
    PHP.opcache.force_restart_timeout=180 \
    PHP.opcache.inherited_hack=1 \
    PHP.opcache.interned_strings_buffer=16 \
    PHP.opcache.load_comments= \
    PHP.opcache.log_verbosity_level=1 \
    PHP.opcache.max_accelerated_files=40000 \
    PHP.opcache.max_file_size=0 \
    PHP.opcache.max_wasted_percentage=5 \
    PHP.opcache.memory_consumption=256 \
    PHP.opcache.mmap_base= \
    PHP.opcache.optimization_level=0x7FFFBFFF \
    PHP.opcache.preferred_memory_model= \
    PHP.opcache.protect_memory=0 \
    PHP.opcache.revalidate_freq=0 \
    PHP.opcache.revalidate_path=0 \
    PHP.opcache.save_comments=1 \
    PHP.opcache.use_cwd=1 \
    PHP.opcache.validate_timestamps=1 \
    \
    PHP.opendirectory.max_refs= \
    PHP.opendirectory.separator= \
    \
    PHP.pam.servicename= \
    \
    PHP.pcre.backtrack_limit=1000000 \
    PHP.pcre.recursion_limit=100000 \
    \
    PHP.pdo.dsn.*= \
    \
    PHP.pdo_odbc.connection_pooling= \
    \
    PHP.pgsql.allow_persistent= \
    PHP.pgsql.auto_reset_persistent= \
    PHP.pgsql.ignore_notice= \
    PHP.pgsql.log_notice= \
    PHP.pgsql.max_links= \
    PHP.pgsql.max_persistent= \
    \
    PHP.phar.extract_list= \
    PHP.phar.readonly=1 \
    PHP.phar.require_hash=1 \
    \
    PHP.python.append_path= \
    PHP.python.prepend_path= \
    \
    PHP.runkit.internal_override= \
    PHP.runkit.superglobal= \
    \
    PHP.session.auto_start=0 \
    PHP.session.cache_expire=180 \
    PHP.session.cache_limiter=nocache \
    PHP.session.cookie_domain= \
    PHP.session.cookie_httponly= \
    PHP.session.cookie_lifetime=0 \
    PHP.session.cookie_path=/ \
    PHP.session.cookie_secure=0 \
    PHP.session.entropy_file= \
    PHP.session.entropy_length= \
    PHP.session.gc_divisor=1000 \
    PHP.session.gc_maxlifetime=1440 \
    PHP.session.gc_probability=0 \
    PHP.session.hash_bits_per_character=6 \
    PHP.session.hash_function= \
    PHP.session.name=PHPSESSID \
    PHP.session.referer_check= \
    PHP.session.save_handler=files \
    PHP.session.save_path=/var/lib/php/sessions \
    PHP.session.serialize_handler=php \
    PHP.session.use_cookies=1 \
    PHP.session.use_only_cookies=1 \
    PHP.session.use_trans_sid=0 \
    \
    PHP.session_pgsql.create_table= \
    PHP.session_pgsql.db= \
    PHP.session_pgsql.disable= \
    PHP.session_pgsql.failover_mode= \
    PHP.session_pgsql.gc_interval= \
    PHP.session_pgsql.keep_expired= \
    PHP.session_pgsql.sem_file_name= \
    PHP.session_pgsql.serializable= \
    PHP.session_pgsql.short_circuit= \
    PHP.session_pgsql.use_app_vars= \
    PHP.session_pgsql.vacuum_interval= \
    \
    PHP.simple_cvs.authMethod= \
    PHP.simple_cvs.compressionLevel= \
    PHP.simple_cvs.cvsRoot= \
    PHP.simple_cvs.host= \
    PHP.simple_cvs.moduleName= \
    PHP.simple_cvs.userName= \
    PHP.simple_cvs.workingDir= \
    \
    PHP.soap.wsdl_cache=1 \
    PHP.soap.wsdl_cache_dir=/tmp \
    PHP.soap.wsdl_cache_enabled=1 \
    PHP.soap.wsdl_cache_limit=86400 \
    PHP.soap.wsdl_cache_ttl=5 \
    \
    PHP.sql.safe_mode= \
    \
    PHP.sqlite.assoc_case= \
    \
    PHP.sybase.allow_persistent= \
    PHP.sybase.interface_file= \
    PHP.sybase.max_links= \
    PHP.sybase.max_persistent= \
    PHP.sybase.min_error_severity= \
    PHP.sybase.min_message_severity= \
    \
    PHP.sybct.deadlock_retry_count= \
    PHP.sybct.login_timeout= \
    PHP.sybct.packet_size= \
    PHP.sybct.timeout= \
    \
    PHP.sysvshm.init_mem= \
    \
    PHP.tidy.clean_output= \
    PHP.tidy.default_config= \
    \
    PHP.uploadprogress.file.filename_template= \
    \
    PHP.url_rewriter.tags="form=" \
    \
    PHP.user_ini.cache_ttl=300 \
    PHP.user_ini.filename=.user.ini \
    \
    PHP.valkyrie.auto_validate= \
    PHP.valkyrie.config_path= \
    \
    PHP.vld.active= \
    PHP.vld.execute= \
    PHP.vld.skip_append= \
    PHP.vld.skip_prepend= \
    \
    PHP.xmms.path= \
    PHP.xmms.session= \
    \
    PHP.yami.response.timeout= \
    \
    PHP.yaz.keepalive= \
    PHP.yaz.log_mask= \
    \
    PHP.zend.enable_gc=1 \
    PHP.zend.multibyte=0 \
    PHP.zend.script_encoding= \
    PHP.zend.signal_check=0 \
    \
    PHP.zlib.output_compression= \
    PHP.zlib.output_compression_level=-1 \
    PHP.zlib.output_handler= \
    \
    PHP.xdebug.auto_trace=Off \
    PHP.xdebug.cli_color=0 \
    PHP.xdebug.collect_assignments=Off \
    PHP.xdebug.collect_includes=On \
    PHP.xdebug.collect_params=0 \
    PHP.xdebug.collect_return=Off \
    PHP.xdebug.collect_vars=Off \
    PHP.xdebug.coverage_enable=On \
    PHP.xdebug.default_enable=On \
    PHP.xdebug.dump.COOKIE= \
    PHP.xdebug.dump.ENV= \
    PHP.xdebug.dump.FILES= \
    PHP.xdebug.dump.GET= \
    PHP.xdebug.dump.POST= \
    PHP.xdebug.dump.REQUEST= \
    PHP.xdebug.dump.SERVER= \
    PHP.xdebug.dump.SESSION= \
    PHP.xdebug.dump_globals=On \
    PHP.xdebug.dump_once=On \
    PHP.xdebug.dump_undefined=Off \
    PHP.xdebug.extended_info=On \
    PHP.xdebug.file_link_format= \
    PHP.xdebug.filename_format= \
    PHP.xdebug.force_display_errors=Off \
    PHP.xdebug.force_error_reporting=0 \
    PHP.xdebug.gc_stats_enable=Off \
    PHP.xdebug.gc_stats_output_dir=/tmp \
    PHP.xdebug.gc_stats_output_name=gcstats.%p \
    PHP.xdebug.halt_level=0 \
    PHP.xdebug.idekey= \
    PHP.xdebug.max_nesting_level=256 \
    PHP.xdebug.max_stack_frames=-1 \
    PHP.xdebug.overload_var_dump=2 \
    PHP.xdebug.profiler_aggregate=Off \
    PHP.xdebug.profiler_append=Off \
    PHP.xdebug.profiler_enable=Off \
    PHP.xdebug.profiler_enable_trigger=Off \
    PHP.xdebug.profiler_enable_trigger_value= \
    PHP.xdebug.profiler_output_dir=/tmp \
    PHP.xdebug.profiler_output_name=cachegrind.out.%p \
    PHP.xdebug.remote_addr_header= \
    PHP.xdebug.remote_autostart=On \
    PHP.xdebug.remote_connect_back=Off \
    PHP.xdebug.remote_cookie_expire_time=3600 \
    PHP.xdebug.remote_enable=On \
    PHP.xdebug.remote_handler=dbgp \
    PHP.xdebug.remote_host=host.docker.internal \
    PHP.xdebug.remote_log= \
    PHP.xdebug.remote_mode=req \
    PHP.xdebug.remote_port=9000 \
    PHP.xdebug.remote_timeout=200 \
    PHP.xdebug.scream=Off \
    PHP.xdebug.show_error_trace=Off \
    PHP.xdebug.show_exception_trace=Off \
    PHP.xdebug.show_local_vars=Off \
    PHP.xdebug.show_mem_delta=Off \
    PHP.xdebug.trace_enable_trigger=Off \
    PHP.xdebug.trace_enable_trigger_value= \
    PHP.xdebug.trace_format=0 \
    PHP.xdebug.trace_options=0 \
    PHP.xdebug.trace_output_dir=/tmp \
    PHP.xdebug.trace_output_name=trace.%c \
    PHP.xdebug.var_display_max_children=128 \
    PHP.xdebug.var_display_max_data=512 \
    PHP.xdebug.var_display_max_depth=3 \
