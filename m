Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F67DF1C8
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:55:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWBj-0003XK-HN; Thu, 02 Nov 2023 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW9Z-0000AG-Hc
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW9R-0006wq-7B
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAy4VBc66QoZq5KeEa71dSNGlXnXaidLjsRTcJA5+f0=;
 b=cHYkEbqzQNKNvvWRmfrF/XFNcxM0m2LQdDGitC3Pbsv6zC4uJpQPhPCG+EIiWSWGnwi6Eu
 8c78x3MrD1dj1oJf8kgTAYk75kAoGZaLQfDfIEZPLmDxxYBh9qiDL+Mysyrl/CVt9JRKaH
 wo1hTB8i66uevdHhuKvsF0VC76MPqWk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-iLWaQKg-OgiAJrmmH1wRfg-1; Thu,
 02 Nov 2023 07:46:07 -0400
X-MC-Unique: iLWaQKg-OgiAJrmmH1wRfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7A9B2808FCD;
 Thu,  2 Nov 2023 11:46:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52B3F2026D4C;
 Thu,  2 Nov 2023 11:45:58 +0000 (UTC)
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
Subject: [PULL 39/40] migration: Implement MigrateChannelList to hmp migration
 flow.
Date: Thu,  2 Nov 2023 12:40:53 +0100
Message-ID: <20231102114054.44360-40-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20231023182053.8711-14-farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h          |  3 ++-
 migration/migration-hmp-cmds.c | 23 +++++++++++++++++++++--
 migration/migration.c          |  5 ++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index af8c965b7f..cf2c9c88e0 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -520,7 +520,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 6ec778a990..86ae832176 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -451,9 +451,18 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        goto end;
+    }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
+
+end:
     hmp_handle_error(mon, err);
 }
 
@@ -753,6 +762,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
     if (inc) {
         warn_report("option '-i' is deprecated;"
@@ -764,12 +775,20 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
                     " use blockdev-mirror with NBD instead");
     }
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
 
+    qapi_free_MigrationChannelList(caps);
+
     if (!detach) {
         HMPMigrationStatus *status;
 
diff --git a/migration/migration.c b/migration/migration.c
index 10a6f2fb12..28a34c9068 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -457,9 +457,8 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri,
-                              MigrationChannel **channel,
-                              Error **errp)
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
-- 
2.41.0


