Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38A7DF1B1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:51:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWBb-0002og-Cv; Thu, 02 Nov 2023 07:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW9W-00009n-Cn
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW9F-0006uQ-M1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWg3ff2B75FkDwyvGnzwjnRj3RXzTlynWc4AS7vKP7k=;
 b=O6wx5sq5XQbLVKnF2hO7mcoEHOiUdoZjeVjukxY3cHuVSWcd+VbPm1UHTGZHspdtoe/qfS
 jtsTJiybH9ZChuFjK43GdBWVuAD72o+B/shPJP+hVv10kXZ9OMkMjwe94nPVcVcMF9rjXT
 dIyjotl+YnfTtFJJ7j3PeFePnGO3VJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-0eqbtVRIN3CHcea3S7t7CQ-1; Thu, 02 Nov 2023 07:45:59 -0400
X-MC-Unique: 0eqbtVRIN3CHcea3S7t7CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 046CE185A781;
 Thu,  2 Nov 2023 11:45:58 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0887B2026D4C;
 Thu,  2 Nov 2023 11:45:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Het Gala <het.gala@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Subject: [PULL 38/40] migration: Implement MigrateChannelList to qmp migration
 flow.
Date: Thu,  2 Nov 2023 12:40:52 +0100
Message-ID: <20231102114054.44360-39-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

From: Het Gala <het.gala@nutanix.com>

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231023182053.8711-13-farosas@suse.de>
---
 migration/migration.c | 101 +++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 70725a89ab..10a6f2fb12 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -458,9 +458,10 @@ void migrate_add_address(SocketAddress *address)
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
@@ -505,7 +506,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = g_steal_pointer(&addr);
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = g_steal_pointer(&addr);
+    *channel = g_steal_pointer(&val);
     return true;
 }
 
@@ -513,44 +516,47 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
@@ -559,7 +565,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         if (migrate_compress()) {
             error_setg(errp, "RDMA and compression can't be used together");
             return;
@@ -572,12 +578,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
@@ -1927,35 +1933,38 @@ void qmp_migrate(const char *uri, bool has_channels,
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
 
@@ -1972,8 +1981,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1982,13 +1991,13 @@ void qmp_migrate(const char *uri, bool has_channels,
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
2.41.0


