Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B637DF1CB
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWAQ-0000dx-0q; Thu, 02 Nov 2023 07:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW8x-0007jI-AQ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW8l-0006ft-Qj
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cMGyWsKStTm8u7T4kN5ucVYCX/6IeMsXkxsakfjItU=;
 b=EOltrztEG/3CowIdHumMJOysWNTwjPZ8MhRMbzk6l6Y1EMxIHyrFUYpvhIsmcEN0pD5MQ0
 yjv0WqZxIuE4D42Za8yKJ+ObocFIVcoaogcUfiZvjA5vo4k+02EUHPJ3SUZYbSZvkQKpyG
 PjwcdkLmMwz60FrE4OBuz3FNASYEHPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-XiALpHG6MgKNhQgwV6yiMg-1; Thu, 02 Nov 2023 07:45:27 -0400
X-MC-Unique: XiALpHG6MgKNhQgwV6yiMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C0FC82BA81;
 Thu,  2 Nov 2023 11:45:26 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FBE52026D4C;
 Thu,  2 Nov 2023 11:45:18 +0000 (UTC)
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
Subject: [PULL 34/40] migration: convert exec backend to accept MigrateAddress.
Date: Thu,  2 Nov 2023 12:40:48 +0100
Message-ID: <20231102114054.44360-35-quintela@redhat.com>
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231023182053.8711-8-farosas@suse.de>
---
 migration/exec.h      |  4 +--
 migration/exec.c      | 73 +++++++++++++++++++++++++++++++------------
 migration/migration.c |  8 ++---
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/migration/exec.h b/migration/exec.h
index 736cd71028..3107f205e3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,8 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+void exec_start_incoming_migration(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
                                    Error **errp);
 #endif
diff --git a/migration/exec.c b/migration/exec.c
index 32f5143dfd..47d2f3b8fb 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,20 +39,51 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem->next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst->next) {
+        argv[i++] = lst->value;
+    }
+
+    argv[i] = NULL;
+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer(&argv),
+                            O_RDWR,
+                            errp));
     if (!ioc) {
         return;
     }
@@ -71,20 +102,22 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer(&argv),
+                            O_RDWR,
+                            errp));
     if (!ioc) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 8c26672630..0911fb310c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -549,8 +549,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         }
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1938,8 +1938,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
-- 
2.41.0


