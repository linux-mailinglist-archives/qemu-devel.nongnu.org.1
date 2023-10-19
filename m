Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5107D7D0287
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYdK-00074n-2t; Thu, 19 Oct 2023 15:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYdH-00071H-39
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:35 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtYdE-0004wP-WF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:24:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0BAC1FD84;
 Thu, 19 Oct 2023 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697743471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbaGiwIOD035f3spcJTHm9ivTteqPd6thsP8XNXabPs=;
 b=MA3FciQAgNoW/BxHxr3KwxcN+UgIFLkGBG2tRtH0kaFC6IBgFXlZBrXsXT/vfC2wtO7lA6
 bQIV0hyM3cL0j61bz0clNYq/0RJ6J2U76m5i39d6QBxFv09ohHnTCVrKgWPOpFewB/bwNY
 /lfyKCYSTNHWhmP62m7Az3FVcuzjgB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697743471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbaGiwIOD035f3spcJTHm9ivTteqPd6thsP8XNXabPs=;
 b=+VRx22rUhbnzqPR5+foQElCl14VUf+DWhLtedgO1Soq5GtP0W0uJEPOWcsKYRniwfA9ZMu
 XFpAC7+X/ufb+NBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93C931357F;
 Thu, 19 Oct 2023 19:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EEmUF2yCMWWWEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:24:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v14 09/14] migration: New migrate and migrate-incoming
 argument 'channels'
Date: Thu, 19 Oct 2023 16:23:48 -0300
Message-Id: <20231019192353.31500-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019192353.31500-1-farosas@suse.de>
References: <20231019192353.31500-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Het Gala <het.gala@nutanix.com>

MigrateChannelList allows to connect accross multiple interfaces.
Add MigrateChannelList struct as argument to migration QAPIs.

We plan to include multiple channels in future, to connnect
multiple interfaces. Hence, we choose 'MigrateChannelList'
as the new argument over 'MigrateChannel' to make migration
QAPIs future proof.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |   6 +-
 migration/migration.c          |  56 +++++++++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 system/vl.c                    |   2 +-
 4 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index d206700a43..efd2c268b2 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -446,7 +446,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
-    qmp_migrate_incoming(uri, &err);
+    qmp_migrate_incoming(uri, false, NULL, &err);
 
     hmp_handle_error(mon, err);
 }
@@ -745,8 +745,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 9531aec8d3..f5bad11777 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -480,11 +480,34 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
     g_autoptr(MigrationAddress) channel = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1554,7 +1577,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1572,7 +1596,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1608,7 +1632,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1739,7 +1763,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1748,6 +1773,27 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = NULL;
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 602cb706e3..85ad5f2601 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1565,6 +1565,34 @@
     'rdma': 'InetSocketAddress',
     'file': 'FileMigrationArgs' } }
 
+##
+# @MigrationChannelType:
+#
+# The migration channel-type request options.
+#
+# @main: Main outbound migration channel.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrationChannel:
+#
+# Migration stream channel parameters.
+#
+# @channel-type: Channel type for transfering packet information.
+#
+# @addr: Migration endpoint configuration on destination interface.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationChannel',
+  'data': {
+      'channel-type': 'MigrationChannelType',
+      'addr': 'MigrationAddress' } }
+
 ##
 # @migrate:
 #
@@ -1572,6 +1600,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1596,14 +1627,50 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of
+#    default destination VM. This connection will be bound to default
+#    network.
+#
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 6. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
+           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1614,6 +1681,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1629,13 +1699,46 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 4. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrationChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/system/vl.c b/system/vl.c
index 3100ac01ed..69a8cffe81 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2696,7 +2696,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.35.3


