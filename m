Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87FA22133
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 17:06:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXh-0006go-7a; Wed, 29 Jan 2025 11:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVi-0003JN-1f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVf-0005Je-IG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E63921109;
 Wed, 29 Jan 2025 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwk6HvYuaZQPaRXwoYW+41oqdJE6a4AJI2X8HRrE9ig=;
 b=Ow7iMfM9IZL7Dy4c0nVSWQaae2PVfxBc3w9nUieupxoFEOUThsxepxT2c06zPIGmFt7BWo
 3EM3LTTemND0Wk+tI1dAc3+tmRV8NXaql+LSBme7AGa4NeUb5xobXQUnMezUDJgaNykdYq
 EhlTgkBzzVkTUmrXzz/+uOO+vylpx9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwk6HvYuaZQPaRXwoYW+41oqdJE6a4AJI2X8HRrE9ig=;
 b=gsXBbEGQnZT3FPYO/KzknD4qKLzYf8Lu/tbro/FrGF+WqeVi17aE6FlaW3PImLimZRUaNF
 Ukpm2ZOV8RuGWWAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ow7iMfM9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gsXBbEGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwk6HvYuaZQPaRXwoYW+41oqdJE6a4AJI2X8HRrE9ig=;
 b=Ow7iMfM9IZL7Dy4c0nVSWQaae2PVfxBc3w9nUieupxoFEOUThsxepxT2c06zPIGmFt7BWo
 3EM3LTTemND0Wk+tI1dAc3+tmRV8NXaql+LSBme7AGa4NeUb5xobXQUnMezUDJgaNykdYq
 EhlTgkBzzVkTUmrXzz/+uOO+vylpx9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwk6HvYuaZQPaRXwoYW+41oqdJE6a4AJI2X8HRrE9ig=;
 b=gsXBbEGQnZT3FPYO/KzknD4qKLzYf8Lu/tbro/FrGF+WqeVi17aE6FlaW3PImLimZRUaNF
 Ukpm2ZOV8RuGWWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8834137DB;
 Wed, 29 Jan 2025 16:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iMfgKehQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 20/42] tests/qtest: defer connection
Date: Wed, 29 Jan 2025 13:00:37 -0300
Message-Id: <20250129160059.6987-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E63921109
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Add an option to defer making the connecting to the monitor and qtest
sockets when calling qtest_init_with_env.  The client makes the connection
later by calling qtest_connect and qtest_qmp_handshake.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-20-git-send-email-steven.sistare@oracle.com
[plumb capabilities list into qtest_qmp_handshake]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c            | 99 ++++++++++++++++++++-----------
 tests/qtest/libqtest.h            | 24 +++++++-
 tests/qtest/migration/framework.c |  7 ++-
 3 files changed, 90 insertions(+), 40 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index a1e105f27f..fbb51e3e55 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -75,6 +75,8 @@ struct QTestState
 {
     int fd;
     int qmp_fd;
+    int sock;
+    int qmpsock;
     pid_t qemu_pid;  /* our child QEMU process */
     int wstatus;
 #ifdef _WIN32
@@ -458,18 +460,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
     return s;
 }
 
+static char *qtest_socket_path(const char *suffix)
+{
+    return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
+}
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
-                                       const char *extra_args)
+                                       const char *extra_args,
+                                       bool do_connect)
 {
     QTestState *s;
     int sock, qmpsock, i;
-    gchar *socket_path;
-    gchar *qmp_socket_path;
-
-    socket_path = g_strdup_printf("%s/qtest-%d.sock",
-                                  g_get_tmp_dir(), getpid());
-    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
-                                      g_get_tmp_dir(), getpid());
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
 
     /*
      * It's possible that if an earlier test run crashed it might
@@ -501,22 +504,19 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
 
-    s->fd = socket_accept(sock);
-    if (s->fd >= 0) {
-        s->qmp_fd = socket_accept(qmpsock);
-    }
-    unlink(socket_path);
-    unlink(qmp_socket_path);
-    g_free(socket_path);
-    g_free(qmp_socket_path);
-
-    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
-
     s->rx = g_string_new("");
     for (i = 0; i < MAX_IRQ; i++) {
         s->irq_level[i] = false;
     }
 
+    s->fd = -1;
+    s->qmp_fd = -1;
+    s->sock = sock;
+    s->qmpsock = qmpsock;
+    if (do_connect) {
+        qtest_connect(s);
+    }
+
     /*
      * Stopping QEMU for debugging is not supported on Windows.
      *
@@ -531,28 +531,38 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     }
 #endif
 
+   return s;
+}
+
+void qtest_connect(QTestState *s)
+{
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+
+    g_assert(s->sock >= 0 && s->qmpsock >= 0);
+    s->fd = socket_accept(s->sock);
+    if (s->fd >= 0) {
+        s->qmp_fd = socket_accept(s->qmpsock);
+    }
+    unlink(socket_path);
+    unlink(qmp_socket_path);
+    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
+    s->sock = s->qmpsock = -1;
     /* ask endianness of the target */
-
     s->big_endian = qtest_query_target_endianness(s);
-
-   return s;
 }
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
 }
 
-QTestState *qtest_init_with_env_and_capabilities(const char *var,
-                                                 const char *extra_args,
-                                                 QList *capabilities)
+void qtest_qmp_handshake(QTestState *s, QList *capabilities)
 {
-    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
-    QDict *greeting;
-
     /* Read the QMP greeting and then do the handshake */
-    greeting = qtest_qmp_receive(s);
+    QDict *greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
+
     if (capabilities) {
         qtest_qmp_assert_success(s,
                                  "{ 'execute': 'qmp_capabilities', "
@@ -561,18 +571,37 @@ QTestState *qtest_init_with_env_and_capabilities(const char *var,
     } else {
         qtest_qmp_assert_success(s, "{ 'execute': 'qmp_capabilities' }");
     }
+}
 
+QTestState *qtest_init_with_env_and_capabilities(const char *var,
+                                                 const char *extra_args,
+                                                 QList *capabilities,
+                                                 bool do_connect)
+{
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
+                                        do_connect);
+
+    if (do_connect) {
+        qtest_qmp_handshake(s, capabilities);
+    } else {
+        /*
+         * If the connection is delayed, the capabilities must be set
+         * at that moment.
+         */
+        assert(!capabilities);
+    }
     return s;
 }
 
-QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+QTestState *qtest_init_with_env(const char *var, const char *extra_args,
+                                bool do_connect)
 {
-    return qtest_init_with_env_and_capabilities(var, extra_args, NULL);
+    return qtest_init_with_env_and_capabilities(var, extra_args, NULL, true);
 }
 
 QTestState *qtest_init(const char *extra_args)
 {
-    return qtest_init_with_env(NULL, extra_args);
+    return qtest_init_with_env(NULL, extra_args, true);
 }
 
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
@@ -1580,7 +1609,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(qemu_var, "-machine none");
+    qts = qtest_init_with_env(qemu_var, "-machine none", true);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1635,7 +1664,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(NULL, "-machine none");
+    qts = qtest_init_with_env(NULL, "-machine none", true);
     response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index ce88d23eae..29f123e281 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -61,13 +61,15 @@ QTestState *qtest_init(const char *extra_args);
  * @var: Environment variable from where to take the QEMU binary
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
+ * @do_connect: connect to qemu monitor and qtest socket.
  *
  * Like qtest_init(), but use a different environment variable for the
  * QEMU binary.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_with_env(const char *var, const char *extra_args);
+QTestState *qtest_init_with_env(const char *var, const char *extra_args,
+                                bool do_connect);
 
 /**
  * qtest_init_with_env_and_capabilities:
@@ -75,6 +77,7 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
  * @capabilities: list of QMP capabilities (strings) to enable
+ * @do_connect: connect to qemu monitor and qtest socket.
  *
  * Like qtest_init_with_env(), but enable specified capabilities during
  * hadshake.
@@ -83,7 +86,8 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
  */
 QTestState *qtest_init_with_env_and_capabilities(const char *var,
                                                  const char *extra_args,
-                                                 QList *capabilities);
+                                                 QList *capabilities,
+                                                 bool do_connect);
 
 /**
  * qtest_init_without_qmp_handshake:
@@ -94,6 +98,22 @@ QTestState *qtest_init_with_env_and_capabilities(const char *var,
  */
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
+/**
+ * qtest_connect
+ * @s: #QTestState instance to connect
+ * Connect to qemu monitor and qtest socket, after skipping them in
+ * qtest_init_with_env.  Does not handshake with the monitor.
+ */
+void qtest_connect(QTestState *s);
+
+/**
+ * qtest_qmp_handshake:
+ * @s: #QTestState instance to operate on.
+ * @capabilities: list of QMP capabilities (strings) to enable
+ * Perform handshake after connecting to qemu monitor.
+ */
+void qtest_qmp_handshake(QTestState *s, QList *capabilities);
+
 /**
  * qtest_init_with_serial:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 758e14abab..f7add75ed5 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -196,9 +196,10 @@ static void cleanup(const char *filename)
 
 static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
 {
-    QList *capabilities = qlist_new();
+    QList *capabilities = NULL;
 
     if (args->oob) {
+        capabilities = qlist_new();
         qlist_append_str(capabilities, "oob");
     }
     return capabilities;
@@ -333,7 +334,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  ignore_stderr);
     if (!args->only_target) {
         *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
-                                                     capabilities);
+                                                     capabilities, true);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -354,7 +355,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
-                                               capabilities);
+                                               capabilities, true);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
-- 
2.35.3


