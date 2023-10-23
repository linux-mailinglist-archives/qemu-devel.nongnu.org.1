Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FB7D3F28
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzYj-0004va-Al; Mon, 23 Oct 2023 14:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYh-0004qA-Hz
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:47 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYf-0001En-Ex
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC9A1FE1C;
 Mon, 23 Oct 2023 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMuF9EByigxxFjxYvHmUtxXTUZVDYlwFVzhIL0T9vI0=;
 b=wqCBu6KTNTUi5W5NPsXj9P48Uiz4luxrGeRJhU/BuzkLnnZwMQS2GcVYrKsHUt8Mklh0ob
 04YzADkQ+z7PZfBd5ZFa66Uz+oFHbs4QyovvEggKqu6LKLY9GMXoCTHMxvnSHZERuhcmWT
 +wA4/76mpSVITeG8/SRiqpAxOYfvm8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMuF9EByigxxFjxYvHmUtxXTUZVDYlwFVzhIL0T9vI0=;
 b=Ra69ySVGZv+5ky0SLB4ot7o14oB6XlxhoePfrNdToL0MKjlp3R6YT6pVGXW3A6Aq9PWaqD
 kiNhVX/gOwyWSLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F154E13A82;
 Mon, 23 Oct 2023 18:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kDItLrS5NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:21:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 12/14] migration: Implement MigrateChannelList to qmp
 migration flow.
Date: Mon, 23 Oct 2023 15:20:51 -0300
Message-Id: <20231023182053.8711-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 101 +++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 192b7a97be..c4c2f3a266 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -433,9 +433,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = NULL;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -480,7 +481,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = g_steal_pointer(&addr);
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = g_steal_pointer(&addr);
+    *channel = g_steal_pointer(&val);
     return true;
 }
 
@@ -488,44 +491,47 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -534,7 +540,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         if (migrate_compress()) {
             error_setg(errp, "RDMA and compression can't be used together");
             return;
@@ -547,12 +553,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             error_setg(errp, "RDMA and multifd can't be used together");
             return;
         }
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_start_incoming_migration(&channel->u.file, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_incoming_migration(&addr->u.file, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1792,35 +1798,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1837,8 +1846,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1847,13 +1856,13 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_start_outgoing_migration(s, &channel->u.file, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_start_outgoing_migration(s, &addr->u.file, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-- 
2.35.3


