Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49FAEE7E1
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Jun 2025 22:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgF-00050d-0o; Mon, 30 Jun 2025 16:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg5-0004rH-Ir
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKg3-0007lO-6L
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8FFB1F444;
 Mon, 30 Jun 2025 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AArHDdOU4SGXTjlPnMQuCQL+xBnKy8uwPROE+r/f8o=;
 b=IGY7to+lfvDcRo+UucCXBlIG2LqeD3J+UzpUTKHiaqQzf3JogtyXeJRtSZA8ZjC6MO9le7
 le6BT8rWNEdfji7gsj3Nmu4NLm6VTKCpLfbvwJgBppxs6qIpC7pb49SGwafv5R2lQAxdmT
 rJ9iC7I1m8STwp6eh+vV8vH+G8egjN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AArHDdOU4SGXTjlPnMQuCQL+xBnKy8uwPROE+r/f8o=;
 b=mwLKOyrFauLfaUaLfiG0ASZbozyCXhklylVhgP+4TgmNAFis8wR/DD0rVwdC9sFmqQdFow
 1CzGnPaDIRLxx5AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fSv6Ozoc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JEKp3kB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AArHDdOU4SGXTjlPnMQuCQL+xBnKy8uwPROE+r/f8o=;
 b=fSv6OzoclTT3syFyyCPEfptD0Ou1AxDcnRvgtH2BHkKTgGl1dLxbXiTkriPhxL9bUbmAtM
 TNwfbqCqVg5IQKanBWsHC4DpC8JRELrYgoVraSScPZl1081Q6+jLRLXvcZNQmpLhZNJJ8N
 iO/dJCfde3y4qjVq6arcgBr6cNa2wFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0AArHDdOU4SGXTjlPnMQuCQL+xBnKy8uwPROE+r/f8o=;
 b=JEKp3kB5F1dwS09lT6ZMMBB54/32TuqpiLyqi8bPJ1q72MZ2VzvNhArnalIo29bbCWWR/+
 VVrM0haXiA4FCeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E1D1399F;
 Mon, 30 Jun 2025 19:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADx9KL/sYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 19:59:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 20/24] migration: Allow migrate commands to provide the
 migration config
Date: Mon, 30 Jun 2025 16:59:09 -0300
Message-Id: <20250630195913.28033-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: E8FFB1F444
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Allow the migrate and migrate_incoming commands to pass the migration
configuration options all at once, dispensing the use of
migrate-set-parameters and migrate-set-capabilities.

The motivation of this is to simplify the interface with the
management layer and avoid the usage of several command invocations to
configure a migration. It also avoids stale parameters from a previous
migration to influence the current migration.

The options that are changed during the migration can still be set
with the existing commands.

The order of precedence is:

'config' argument > -global migration cmdline > migrate-set-parameters
> defaults (migration_properties)

I.e. the config takes precedence over all, values not present in the
config assume the default values. The -global migration command line
option allows the defaults to be overridden for debug.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |  5 +++--
 migration/migration.c          | 28 +++++++++++++++++++++++++---
 migration/options.c            | 19 +++++++++++++++++++
 migration/options.h            |  4 +++-
 qapi/migration.json            | 16 ++++++++++++++++
 system/vl.c                    |  3 ++-
 6 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7f234d5aa8..2075d6c6e5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -583,7 +583,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
+    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
@@ -960,7 +960,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
+                &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 13b70dbb94..42a2a6e8f2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1917,13 +1917,24 @@ void migrate_del_blocker(Error **reasonp)
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
                           MigrationChannelList *channels,
-                          bool has_exit_on_error, bool exit_on_error,
-                          Error **errp)
+                          MigrationParameters *config, bool has_exit_on_error,
+                          bool exit_on_error, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (config) {
+        /*
+         * If a config was provided, all options set previously by
+         * migrate-set-parameters get ignored.
+         */
+        if (!migrate_params_override(s, config, errp)) {
+            return;
+        }
+    }
+
     if (!once) {
         error_setg(errp, "The incoming migration has already been started");
         return;
@@ -2183,7 +2194,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
 }
 
 void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_detach, bool detach,
+                 MigrationChannelList *channels,
+                 bool has_detach, bool detach, MigrationParameters *config,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
@@ -2194,6 +2206,16 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
     MigrationChannel *cpr_channel = NULL;
 
+    if (config) {
+        /*
+         * If a config was provided, all options set previously by
+         * migrate-set-parameters get ignored.
+         */
+        if (!migrate_params_override(s, config, errp)) {
+            return;
+        }
+    }
+
     /*
      * Having preliminary checks for uri and channel
      */
diff --git a/migration/options.c b/migration/options.c
index 2f6ccefa21..0f6d021093 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1398,6 +1398,25 @@ void migrate_params_store_defaults(MigrationState *s)
     s->initial_params = QAPI_CLONE(MigrationParameters, &s->parameters);
 }
 
+bool migrate_params_override(MigrationState *s, MigrationParameters *new,
+                             Error **errp)
+{
+    ERRP_GUARD();
+
+    assert(bql_locked());
+
+    /* reset to initial parameters */
+    migrate_params_apply(s->initial_params);
+
+    /* apply the new ones on top */
+    qmp_migrate_set_parameters(new, errp);
+    if (*errp) {
+        return false;
+    }
+
+    return true;
+}
+
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 91154c4322..fa56c977a6 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -83,6 +83,8 @@ void migrate_capability_set_compat(MigrationParameters *params, int i,
                                    bool val);
 void migrate_capabilities_set_compat(MigrationParameters *params,
                                      MigrationCapabilityStatusList *caps);
-bool migrate_caps_check(const MigrationParameters *const new, Error **errp);
+bool migrate_caps_check(const MigrationParameters *new, Error **errp);
 void migrate_params_store_defaults(MigrationState *s);
+bool migrate_params_override(MigrationState *s, MigrationParameters *new,
+                             Error **errp);
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index c5e6ea1a2d..11b7d7ebec 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1456,6 +1456,13 @@
 #
 # @resume: resume one paused migration, default "off".  (since 3.0)
 #
+# @config: migration configuration options, previously set via
+#     @migrate-set-parameters and @migrate-set-capabilities.  Setting
+#     this argument causes all migration configuration options
+#     previously set via @migrate-set-parameters to be ignored.
+#     Configuration options not set will assume their default
+#     values. (since 10.1)
+#
 # Features:
 #
 # @deprecated: Argument @detach is deprecated.
@@ -1520,6 +1527,7 @@
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
+           '*config': 'MigrationParameters',
            '*resume': 'bool' } }
 
 ##
@@ -1539,6 +1547,13 @@
 #     error details could be retrieved with query-migrate.
 #     (since 9.1)
 #
+# @config: migration configuration options, previously set via
+#     @migrate-set-parameters and @migrate-set-capabilities.  Setting
+#     this argument causes all migration configuration options
+#     previously set via @migrate-set-parameters to be ignored.
+#     Configuration options not set will assume their default
+#     values. (since 10.1)
+#
 # Since: 2.3
 #
 # .. admonition:: Notes
@@ -1592,6 +1607,7 @@
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
                       '*channels': [ 'MigrationChannel' ],
+                      '*config': 'MigrationParameters',
                       '*exit-on-error': 'bool' } }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..b29fd24d08 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2823,7 +2823,8 @@ void qmp_x_exit_preconfig(Error **errp)
                 g_new0(MigrationChannelList, 1);
 
             channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
-            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
+            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
+                                 &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.35.3


