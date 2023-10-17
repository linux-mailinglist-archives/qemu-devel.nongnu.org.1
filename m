Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799B47CBDB4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfU3-0005Xb-6X; Tue, 17 Oct 2023 04:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTq-00054u-Uf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTo-0005NL-SY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MB1MGnPWcbpo4P/Wqdn2Ie+pJlNrU7njLFVv1GvSuus=;
 b=OfqkZoQIMe+qL2/grFp9Sf38kRSfvHvg/L1M1rNEj1sixI6IEaEHnn+OKRbBwJuucrK25n
 ceDzS6jGWw7Wugk4ku769RfcxMTAumn5FEFOMVRP6pT60mXBu6dgGzolWkLTXEM8jrkbvp
 Qk1XnoVrAMaeEE/wbaplmux66u2avXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-OG1h5ecpMgSuaP7Lynx70A-1; Tue, 17 Oct 2023 04:31:03 -0400
X-MC-Unique: OG1h5ecpMgSuaP7Lynx70A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 906961029F46;
 Tue, 17 Oct 2023 08:31:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44C501C060AE;
 Tue, 17 Oct 2023 08:30:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 18/38] migration/rdma: Unfold hook_ram_load()
Date: Tue, 17 Oct 2023 10:29:43 +0200
Message-ID: <20231017083003.15951-19-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is only one flag called with: RAM_CONTROL_BLOCK_REG.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011203527.9061-6-quintela@redhat.com>
---
 migration/qemu-file.h | 11 -----------
 migration/rdma.h      |  3 +++
 migration/qemu-file.c | 10 ----------
 migration/ram.c       |  6 ++++--
 migration/rdma.c      | 34 +++++++++++-----------------------
 5 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 14ff0d9cc4..80c30631dc 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -29,20 +29,12 @@
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
-/*
- * This function provides hooks around different
- * stages of RAM migration.
- * 'data' is call specific data associated with the 'flags' value
- */
-typedef int (QEMURamHookFunc)(QEMUFile *f, uint64_t flags, void *data);
-
 /*
  * Constants used by ram_control_* hooks
  */
 #define RAM_CONTROL_SETUP     0
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
-#define RAM_CONTROL_BLOCK_REG 4
 
 /*
  * This function allows override of where the RAM page
@@ -54,7 +46,6 @@ typedef int (QEMURamSaveFunc)(QEMUFile *f,
                               size_t size);
 
 typedef struct QEMUFileHooks {
-    QEMURamHookFunc *hook_ram_load;
     QEMURamSaveFunc *save_page;
 } QEMUFileHooks;
 
@@ -124,8 +115,6 @@ void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 
-void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
-
 /* Whenever this is found in the data stream, the flags
  * will be passed to ram_control_load_hook in the incoming-migration
  * side. This lets before_ram_iterate/after_ram_iterate add
diff --git a/migration/rdma.h b/migration/rdma.h
index 8bd277efb9..8df8b4089a 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -27,6 +27,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
 int qemu_rdma_registration_handle(QEMUFile *f);
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
+int rdma_block_notification_handle(QEMUFile *f, const char *name);
 #else
 static inline
 int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
@@ -34,5 +35,7 @@ static inline
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
 static inline
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
+static inline
+int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
 #endif
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e7dba2a849..4a414b8976 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -298,16 +298,6 @@ void qemu_fflush(QEMUFile *f)
     f->iovcnt = 0;
 }
 
-void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data)
-{
-    if (f->hooks && f->hooks->hook_ram_load) {
-        int ret = f->hooks->hook_ram_load(f, flags, data);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-        }
-    }
-}
-
 int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                           ram_addr_t offset, size_t size)
 {
diff --git a/migration/ram.c b/migration/ram.c
index f6ea1831b5..8c462276cd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4025,8 +4025,10 @@ static int ram_load_precopy(QEMUFile *f)
                             ret = -EINVAL;
                         }
                     }
-                    ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
-                                          block->idstr);
+                    ret = rdma_block_notification_handle(f, block->idstr);
+                    if (ret < 0) {
+                        qemu_file_set_error(f, ret);
+                    }
                 } else {
                     error_report("Unknown ramblock \"%s\", cannot "
                                  "accept migration", id);
diff --git a/migration/rdma.c b/migration/rdma.c
index 5c20f425a9..0b1cb03b2b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3799,22 +3799,23 @@ err:
 }
 
 /* Destination:
- * Called via a ram_control_load_hook during the initial RAM load section which
- * lists the RAMBlocks by name.  This lets us know the order of the RAMBlocks
- * on the source.
- * We've already built our local RAMBlock list, but not yet sent the list to
- * the source.
+ * Called during the initial RAM load section which lists the
+ * RAMBlocks by name.  This lets us know the order of the RAMBlocks on
+ * the source.  We've already built our local RAMBlock list, but not
+ * yet sent the list to the source.
  */
-static int
-rdma_block_notification_handle(QEMUFile *f, const char *name)
+int rdma_block_notification_handle(QEMUFile *f, const char *name)
 {
-    RDMAContext *rdma;
-    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     int curr;
     int found = -1;
 
+    if (!migrate_rdma()) {
+        return 0;
+    }
+
     RCU_READ_LOCK_GUARD();
-    rdma = qatomic_rcu_read(&rioc->rdmain);
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    RDMAContext *rdma = qatomic_rcu_read(&rioc->rdmain);
 
     if (!rdma) {
         return -1;
@@ -3840,18 +3841,6 @@ rdma_block_notification_handle(QEMUFile *f, const char *name)
     return 0;
 }
 
-static int rdma_load_hook(QEMUFile *f, uint64_t flags, void *data)
-{
-    switch (flags) {
-    case RAM_CONTROL_BLOCK_REG:
-        return rdma_block_notification_handle(f, data);
-
-    default:
-        /* Shouldn't be called with any other values */
-        abort();
-    }
-}
-
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
     if (!migrate_rdma() || migration_in_postcopy()) {
@@ -3997,7 +3986,6 @@ err:
 }
 
 static const QEMUFileHooks rdma_read_hooks = {
-    .hook_ram_load = rdma_load_hook,
 };
 
 static const QEMUFileHooks rdma_write_hooks = {
-- 
2.41.0


