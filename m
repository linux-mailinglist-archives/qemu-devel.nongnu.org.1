Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5EB938992
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jul 2024 09:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn4D-0003Ce-1Q; Mon, 22 Jul 2024 03:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn4A-00032H-Dm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn48-0006kB-1E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwnXjUJHncRGisRIB2U9TuNZDkR7QfHj3L26Hb4fyUU=;
 b=QLoYgka8G/oO8KI86R+WX9oFM/O5cfV5cGENOrDT7esULosNsKThJb0hEC59s0w1JQFhcQ
 ml/ZZbh1tqqo+uCgvPITrESR4vDAKQtMUdCzOstUqPaNqjcOvEwnEGQZRJXeT+7hL929BY
 QA4VzdC7X1cyzIvzzm/P3b3WkNzJcRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-qpuqrK_vO3qtNL1Zm31I7A-1; Mon,
 22 Jul 2024 03:02:28 -0400
X-MC-Unique: qpuqrK_vO3qtNL1Zm31I7A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CA601915316; Mon, 22 Jul 2024 07:02:28 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 896131955D52; Mon, 22 Jul 2024 07:02:26 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 22/25] qga: centralize logic for disabling/enabling commands
Date: Mon, 22 Jul 2024 10:01:19 +0300
Message-ID: <20240722070122.27615-23-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

It is confusing having many different pieces of code enabling and
disabling commands, and it is not clear that they all have the same
semantics, especially wrt prioritization of the block/allow lists.
The code attempted to prevent the user from setting both the block
and allow lists concurrently, however, the logic was flawed as it
checked settings in the configuration file  separately from the
command line arguments. Thus it was possible to set a block list
in the config file and an allow list via a command line argument.
The --dump-conf option also creates a configuration file with both
keys present, even if unset, which means it is creating a config
that cannot actually be loaded again.

Centralizing the code in a single method "ga_apply_command_filters"
will provide a strong guarantee of consistency and clarify the
intended behaviour. With this there is no compelling technical
reason to prevent concurrent setting of both the allow and block
lists, so this flawed restriction is removed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20240712132459.3974109-23-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 docs/interop/qemu-ga.rst |  14 +++++
 qga/commands-posix.c     |   6 --
 qga/commands-win32.c     |   6 --
 qga/main.c               | 128 +++++++++++++++++----------------------
 4 files changed, 70 insertions(+), 84 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index e42b370319..fb75cfd8d4 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -28,6 +28,20 @@ configuration options on the command line. For the same key, the last
 option wins, but the lists accumulate (see below for configuration
 file format).
 
+If an allowed RPCs list is defined in the configuration, then all
+RPCs will be blocked by default, except for the allowed list.
+
+If a blocked RPCs list is defined in the configuration, then all
+RPCs will be allowed by default, except for the blocked list.
+
+If both allowed and blocked RPCs lists are defined in the configuration,
+then all RPCs will be blocked by default, then the allowed list will
+be applied, followed by the blocked list.
+
+While filesystems are frozen, all except for a designated safe set
+of RPCs will blocked, regardless of what the general configuration
+declares.
+
 Options
 -------
 
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index f4104f2760..578d29f228 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1136,12 +1136,6 @@ error:
 
 #endif /* HAVE_GETIFADDRS */
 
-/* add unsupported commands to the list of blocked RPCs */
-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
-{
-    return blockedrpcs;
-}
-
 /* register init/cleanup routines for stateful command groups */
 void ga_command_state_init(GAState *s, GACommandState *cs)
 {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5866cc2e3c..61b36da469 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1958,12 +1958,6 @@ done:
     g_free(rawpasswddata);
 }
 
-/* add unsupported commands to the list of blocked RPCs */
-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
-{
-    return blockedrpcs;
-}
-
 /* register init/cleanup routines for stateful command groups */
 void ga_command_state_init(GAState *s, GACommandState *cs)
 {
diff --git a/qga/main.c b/qga/main.c
index 6ae911eb15..b8f7b1e4a3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -423,60 +423,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
     return strcmp(str1, str2);
 }
 
-/* disable commands that aren't safe for fsfreeze */
-static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
+static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
 {
-    bool allowed = false;
     int i = 0;
+    GAConfig *config = state->config;
     const char *name = qmp_command_name(cmd);
+    /* Fallback policy is allow everything */
+    bool allowed = true;
 
-    while (ga_freeze_allowlist[i] != NULL) {
-        if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
+    if (config->allowedrpcs) {
+        /*
+         * If an allow-list is given, this changes the fallback
+         * policy to deny everything
+         */
+        allowed = false;
+
+        if (g_list_find_custom(config->allowedrpcs, name, ga_strcmp) != NULL) {
             allowed = true;
         }
-        i++;
     }
-    if (!allowed) {
-        g_debug("disabling command: %s", name);
-        qmp_disable_command(&ga_commands, name, "the agent is in frozen state");
-    }
-}
 
-/* [re-]enable all commands, except those explicitly blocked by user */
-static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
-{
-    GAState *s = opaque;
-    GList *blockedrpcs = s->blockedrpcs;
-    GList *allowedrpcs = s->allowedrpcs;
-    const char *name = qmp_command_name(cmd);
-
-    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) == NULL) {
-        if (qmp_command_is_enabled(cmd)) {
-            return;
+    /*
+     * If both allowedrpcs and blockedrpcs are set, the blocked
+     * list will take priority
+     */
+    if (config->blockedrpcs) {
+        if (g_list_find_custom(config->blockedrpcs, name, ga_strcmp) != NULL) {
+            allowed = false;
         }
+    }
 
-        if (allowedrpcs &&
-            g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
-            return;
-        }
+    /*
+     * If frozen, this filtering must take priority over
+     * absolutely everything
+     */
+    if (state->frozen) {
+        allowed = false;
 
-        g_debug("enabling command: %s", name);
-        qmp_enable_command(&ga_commands, name);
+        while (ga_freeze_allowlist[i] != NULL) {
+            if (strcmp(name, ga_freeze_allowlist[i]) == 0) {
+                allowed = true;
+            }
+            i++;
+        }
     }
+
+    return allowed;
 }
 
-/* disable commands that aren't allowed */
-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
+static void ga_apply_command_filters_iter(const QmpCommand *cmd, void *opaque)
 {
-    GList *allowedrpcs = opaque;
+    GAState *state = opaque;
+    bool want = ga_command_is_allowed(cmd, state);
+    bool have = qmp_command_is_enabled(cmd);
     const char *name = qmp_command_name(cmd);
 
-    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) == NULL) {
+    if (want == have) {
+        return;
+    }
+
+    if (have) {
         g_debug("disabling command: %s", name);
         qmp_disable_command(&ga_commands, name, "the command is not allowed");
+    } else {
+        g_debug("enabling command: %s", name);
+        qmp_enable_command(&ga_commands, name);
     }
 }
 
+static void ga_apply_command_filters(GAState *state)
+{
+    qmp_for_each_command(&ga_commands, ga_apply_command_filters_iter, state);
+}
+
 static bool ga_create_file(const char *path)
 {
     int fd = open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
@@ -509,15 +528,14 @@ void ga_set_frozen(GAState *s)
     if (ga_is_frozen(s)) {
         return;
     }
-    /* disable all forbidden (for frozen state) commands */
-    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     g_warning("disabling logging due to filesystem freeze");
-    ga_disable_logging(s);
     s->frozen = true;
     if (!ga_create_file(s->state_filepath_isfrozen)) {
         g_warning("unable to create %s, fsfreeze may not function properly",
                   s->state_filepath_isfrozen);
     }
+    ga_apply_command_filters(s);
+    ga_disable_logging(s);
 }
 
 void ga_unset_frozen(GAState *s)
@@ -549,12 +567,12 @@ void ga_unset_frozen(GAState *s)
     }
 
     /* enable all disabled, non-blocked and allowed commands */
-    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
     s->frozen = false;
     if (!ga_delete_file(s->state_filepath_isfrozen)) {
         g_warning("unable to delete %s, fsfreeze may not function properly",
                   s->state_filepath_isfrozen);
     }
+    ga_apply_command_filters(s);
 }
 
 #ifdef CONFIG_FSFREEZE
@@ -1086,13 +1104,6 @@ static void config_load(GAConfig *config, const char *confpath, bool required)
                                           split_list(config->aliststr, ","));
     }
 
-    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL) &&
-        g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
-        g_critical("wrong config, using 'block-rpcs' and 'allow-rpcs' keys at"
-                   " the same time is not allowed");
-        exit(EXIT_FAILURE);
-    }
-
 end:
     g_key_file_free(keyfile);
     if (gerr && (required ||
@@ -1172,7 +1183,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
 {
     const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
     int opt_ind = 0, ch;
-    bool block_rpcs = false, allow_rpcs = false;
     const struct option lopt[] = {
         { "help", 0, NULL, 'h' },
         { "version", 0, NULL, 'V' },
@@ -1268,7 +1278,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             }
             config->blockedrpcs = g_list_concat(config->blockedrpcs,
                                                 split_list(optarg, ","));
-            block_rpcs = true;
             break;
         }
         case 'a': {
@@ -1278,7 +1287,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             }
             config->allowedrpcs = g_list_concat(config->allowedrpcs,
                                                 split_list(optarg, ","));
-            allow_rpcs = true;
             break;
         }
 #ifdef _WIN32
@@ -1319,12 +1327,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             exit(EXIT_FAILURE);
         }
     }
-
-    if (block_rpcs && allow_rpcs) {
-        g_critical("wrong commandline, using --block-rpcs and --allow-rpcs at the"
-                   " same time is not allowed");
-        exit(EXIT_FAILURE);
-    }
 }
 
 static void config_free(GAConfig *config)
@@ -1435,7 +1437,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
             s->deferred_options.log_filepath = config->log_filepath;
         }
         ga_disable_logging(s);
-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     } else {
         if (config->daemonize) {
             become_daemon(config->pid_filepath);
@@ -1459,25 +1460,6 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
         return NULL;
     }
 
-    if (config->allowedrpcs) {
-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, config->allowedrpcs);
-        s->allowedrpcs = config->allowedrpcs;
-    }
-
-    /*
-     * Some commands can be blocked due to system limitation.
-     * Initialize blockedrpcs list even if allowedrpcs specified.
-     */
-    config->blockedrpcs = ga_command_init_blockedrpcs(config->blockedrpcs);
-    if (config->blockedrpcs) {
-        GList *l = config->blockedrpcs;
-        s->blockedrpcs = config->blockedrpcs;
-        do {
-            g_debug("disabling command: %s", (char *)l->data);
-            qmp_disable_command(&ga_commands, l->data, NULL);
-            l = g_list_next(l);
-        } while (l);
-    }
     s->command_state = ga_command_state_new();
     ga_command_state_init(s, s->command_state);
     ga_command_state_init_all(s->command_state);
@@ -1503,6 +1485,8 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
     }
 #endif
 
+    ga_apply_command_filters(s);
+
     ga_state = s;
     return s;
 }
-- 
2.45.2


