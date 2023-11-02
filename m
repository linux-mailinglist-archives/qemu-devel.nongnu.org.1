Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFF7DF1C9
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:55:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWAT-0000mU-DE; Thu, 02 Nov 2023 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW8V-00070t-Nq
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW8S-0006Yc-6w
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycH7Pzd60GdSUSqN4qjd6nf1GPx4gaBxv8xhqHyn4NY=;
 b=doNClgo+FRTK6+Z3g3AJe6/1SEUatr5syB06DX45JoVKw8pbDeUzZ2Q1Ei/+e7Hqa7gzE5
 YSySlT6pOGOHbl6VPsSoxTJpG2ATLrW04CkiSkEVpvKRSgU9VDdNM+rtzMuPIvLb0zOles
 pRiDFz5qw6GBHRLCe1ifeWQxTdOE3C4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-DkTOmCTwMkqFttbCR704_Q-1; Thu, 02 Nov 2023 07:45:11 -0400
X-MC-Unique: DkTOmCTwMkqFttbCR704_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51906101A529;
 Thu,  2 Nov 2023 11:45:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1DEE2026D4C;
 Thu,  2 Nov 2023 11:45:02 +0000 (UTC)
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
Subject: [PULL 32/40] migration: convert socket backend to accept
 MigrateAddress
Date: Thu,  2 Nov 2023 12:40:46 +0100
Message-ID: <20231102114054.44360-33-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231023182053.8711-6-farosas@suse.de>
---
 migration/socket.h    |  7 ++++---
 migration/migration.c | 30 ++++++++++++++++++------------
 migration/socket.c    | 39 +++++++++------------------------------
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index a1bace259e..846877135a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -524,10 +524,15 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         if (migrate_compress()) {
@@ -546,8 +551,6 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1922,18 +1925,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -108,19 +110,19 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
@@ -135,18 +137,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +162,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +202,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
-- 
2.41.0


