Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87B749786
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKOF-0007zp-RK; Thu, 06 Jul 2023 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKO1-0007yV-7n
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKNy-0001TK-0s
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixPf2fvJntUSWMXJHbBR5RRkxfXVuOgFILnb2kzSWds=;
 b=dT/wkAMn/wuCWT8020vlcx0J1GRXbZSZCHgEPpmA5HKg7ae3wS59njrdOaoFd90h9DVqmc
 1NsGK6th/+peZgvDYuR221iZyqR1ZCgg5Nr5/V+hKkYYVqcRK37J+YEAFiN49M9NtsrGDP
 yWUCRH3ZNxhP2RNnk+nQXhDpZm2cHX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-A-1cCDvVNsaMkMfXjbeUog-1; Thu, 06 Jul 2023 04:30:41 -0400
X-MC-Unique: A-1cCDvVNsaMkMfXjbeUog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5059101A528;
 Thu,  6 Jul 2023 08:30:40 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A47F52166B25;
 Thu,  6 Jul 2023 08:30:39 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 2/3] qga: Add new option --allow-rpcs
Date: Thu,  6 Jul 2023 11:30:34 +0300
Message-Id: <20230706083035.623802-3-kkostiuk@redhat.com>
In-Reply-To: <20230706083035.623802-1-kkostiuk@redhat.com>
References: <20230706083035.623802-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The allow-rpcs option accepts a comma-separated list of RPCs to
enable. This option is opposite to --block-rpcs. Using --block-rpcs
and --allow-rpcs at the same time is not allowed.

resolves: https://gitlab.com/qemu-project/qemu/-/issues/1505

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 docs/interop/qemu-ga.rst |  5 +++
 qga/main.c               | 85 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index a9183802d1..461c5a35ee 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -84,6 +84,11 @@ Options
   Comma-separated list of RPCs to disable (no spaces, use ``help`` to
   list available RPCs).
 
+.. option:: -a, --allow-rpcs=LIST
+
+  Comma-separated list of RPCs to enable (no spaces, use ``help`` to
+  list available RPCs).
+
 .. option:: -D, --dump-conf
 
   Dump the configuration in a format compatible with ``qemu-ga.conf``
diff --git a/qga/main.c b/qga/main.c
index 121ff7a748..0f95fa87c0 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -87,6 +87,7 @@ struct GAState {
     bool delimit_response;
     bool frozen;
     GList *blockedrpcs;
+    GList *allowedrpcs;
     char *state_filepath_isfrozen;
     struct {
         const char *log_filepath;
@@ -261,6 +262,8 @@ QEMU_COPYRIGHT "\n"
 #endif
 "  -b, --block-rpcs  comma-separated list of RPCs to disable (no spaces,\n"
 "                    use \"help\" to list available RPCs)\n"
+"  -a, --allow-rpcs  comma-separated list of RPCs to enable (no spaces,\n"
+"                    use \"help\" to list available RPCs)\n"
 "  -D, --dump-conf   dump a qemu-ga config file based on current config\n"
 "                    options / command-line parameters to stdout\n"
 "  -r, --retry-path  attempt re-opening path if it's unavailable or closed\n"
@@ -416,16 +419,38 @@ static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
 /* [re-]enable all commands, except those explicitly blocked by user */
 static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
 {
-    GList *blockedrpcs = opaque;
+    GAState *s = opaque;
+    GList *blockedrpcs = s->blockedrpcs;
+    GList *allowedrpcs = s->allowedrpcs;
     const char *name = qmp_command_name(cmd);
 
-    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL &&
-        !qmp_command_is_enabled(cmd)) {
+    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL) {
+        if (qmp_command_is_enabled(cmd)) {
+            return;
+        }
+
+        if (allowedrpcs &&
+            g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
+            return;
+        }
+
         g_debug("enabling command: %s", name);
         qmp_enable_command(&ga_commands, name);
     }
 }
 
+/* disable commands that aren't allowed */
+static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
+{
+    GList *allowedrpcs = opaque;
+    const char *name = qmp_command_name(cmd);
+
+    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
+        g_debug("disabling command: %s", name);
+        qmp_disable_command(&ga_commands, name, "the command is not allowed");
+    }
+}
+
 static bool ga_create_file(const char *path)
 {
     int fd = open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
@@ -497,8 +522,8 @@ void ga_unset_frozen(GAState *s)
         s->deferred_options.pid_filepath = NULL;
     }
 
-    /* enable all disabled, non-blocked commands */
-    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s->blockedrpcs);
+    /* enable all disabled, non-blocked and allowed commands */
+    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
     s->frozen = false;
     if (!ga_delete_file(s->state_filepath_isfrozen)) {
         g_warning("unable to delete %s, fsfreeze may not function properly",
@@ -984,7 +1009,9 @@ struct GAConfig {
     const char *service;
 #endif
     gchar *bliststr; /* blockedrpcs may point to this string */
+    gchar *aliststr; /* allowedrpcs may point to this string */
     GList *blockedrpcs;
+    GList *allowedrpcs;
     int daemonize;
     GLogLevelFlags log_level;
     int dumpconf;
@@ -1055,6 +1082,19 @@ static void config_load(GAConfig *config)
         config->blockedrpcs = g_list_concat(config->blockedrpcs,
                                           split_list(config->bliststr, ","));
     }
+    if (g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
+        config->aliststr =
+            g_key_file_get_string(keyfile, "general", "allow-rpcs", &gerr);
+        config->allowedrpcs = g_list_concat(config->allowedrpcs,
+                                          split_list(config->aliststr, ","));
+    }
+
+    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL) &&
+        g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
+        g_critical("wrong config, using --block-rpcs and --allow-rpcs at the"
+                   " same time is not allowed");
+        exit(EXIT_FAILURE);
+    }
 
 end:
     g_key_file_free(keyfile);
@@ -1115,6 +1155,9 @@ static void config_dump(GAConfig *config)
     tmp = list_join(config->blockedrpcs, ',');
     g_key_file_set_string(keyfile, "general", "block-rpcs", tmp);
     g_free(tmp);
+    tmp = list_join(config->allowedrpcs, ',');
+    g_key_file_set_string(keyfile, "general", "allow-rpcs", tmp);
+    g_free(tmp);
 
     tmp = g_key_file_to_data(keyfile, NULL, &error);
     if (error) {
@@ -1130,8 +1173,9 @@ static void config_dump(GAConfig *config)
 
 static void config_parse(GAConfig *config, int argc, char **argv)
 {
-    const char *sopt = "hVvdm:p:l:f:F::b:s:t:Dr";
+    const char *sopt = "hVvdm:p:l:f:F::b:a:s:t:Dr";
     int opt_ind = 0, ch;
+    bool block_rpcs = false, allow_rpcs = false;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
         { "version", 0, NULL, 'V' },
@@ -1147,6 +1191,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "daemonize", 0, NULL, 'd' },
         { "block-rpcs", 1, NULL, 'b' },
         { "blacklist", 1, NULL, 'b' },  /* deprecated alias for 'block-rpcs' */
+        { "allow-rpcs", 1, NULL, 'a' },
 #ifdef _WIN32
         { "service", 1, NULL, 's' },
 #endif
@@ -1206,6 +1251,17 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             }
             config->blockedrpcs = g_list_concat(config->blockedrpcs,
                                                 split_list(optarg, ","));
+            block_rpcs = true;
+            break;
+        }
+        case 'a': {
+            if (is_help_option(optarg)) {
+                qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
+                exit(EXIT_SUCCESS);
+            }
+            config->allowedrpcs = g_list_concat(config->allowedrpcs,
+                                                split_list(optarg, ","));
+            allow_rpcs = true;
             break;
         }
 #ifdef _WIN32
@@ -1246,6 +1302,12 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             exit(EXIT_FAILURE);
         }
     }
+
+    if (block_rpcs && allow_rpcs) {
+        g_critical("wrong commandline, using --block-rpcs and --allow-rpcs at the"
+                   " same time is not allowed");
+        exit(EXIT_FAILURE);
+    }
 }
 
 static void config_free(GAConfig *config)
@@ -1256,10 +1318,12 @@ static void config_free(GAConfig *config)
     g_free(config->state_dir);
     g_free(config->channel_path);
     g_free(config->bliststr);
+    g_free(config->aliststr);
 #ifdef CONFIG_FSFREEZE
     g_free(config->fsfreeze_hook);
 #endif
     g_list_free_full(config->blockedrpcs, g_free);
+    g_list_free_full(config->allowedrpcs, g_free);
     g_free(config);
 }
 
@@ -1374,6 +1438,15 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
         return NULL;
     }
 
+    if (config->allowedrpcs) {
+        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, config->allowedrpcs);
+        s->allowedrpcs = config->allowedrpcs;
+    }
+
+    /*
+     * Some commands can be blocked due to system limitation.
+     * Initialize blockedrpcs list even if allowedrpcs specified.
+     */
     config->blockedrpcs = ga_command_init_blockedrpcs(config->blockedrpcs);
     if (config->blockedrpcs) {
         GList *l = config->blockedrpcs;
-- 
2.34.1


