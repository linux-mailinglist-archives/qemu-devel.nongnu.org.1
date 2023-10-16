Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 907937CA503
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:15:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKW8-0001oU-KA; Mon, 16 Oct 2023 06:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKW3-0001ho-56
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKW1-0007WW-6Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZdM+LhQbIEFIfbq5d8pev/I0xt9A8BfbXRQwG9dPFM=;
 b=dEIPW23y7OHM9SAHukFV7S5+VOsyRV88hrT1+xQH0N907Ru4pwMc5oHAFjJlD3ZaHJebVE
 24vuOOPQ93jPr8fq/dEpcyRucQicWYeSV+U+W/Hodk/2XH6cY8dp4KHsy+SNpzNTlP61Z/
 N8w/HmUOYt7mWYxZ4aKMHUkl5pYk0rU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-xNC3lV13PtyaF21Dqc7eCg-1; Mon, 16 Oct 2023 06:07:56 -0400
X-MC-Unique: xNC3lV13PtyaF21Dqc7eCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73FDD185A790;
 Mon, 16 Oct 2023 10:07:56 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B378C63F21;
 Mon, 16 Oct 2023 10:07:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 15/38] migration/rdma: Unfold ram_control_before_iterate()
Date: Mon, 16 Oct 2023 12:06:43 +0200
Message-ID: <20231016100706.2551-16-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Once there:
- Remove unused data parameter
- unfold it in its callers.
- change all callers to call qemu_rdma_registration_start()
- We need to call QIO_CHANNEL_RDMA() after we check for migrate_rdma()

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011203527.9061-3-quintela@redhat.com>
---
 migration/qemu-file.h |  2 --
 migration/rdma.h      |  7 +++++++
 migration/qemu-file.c | 13 +------------
 migration/ram.c       | 16 +++++++++++++---
 migration/rdma.c      | 12 ++++--------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 03e718c264..d6a370c569 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -55,7 +55,6 @@ typedef int (QEMURamSaveFunc)(QEMUFile *f,
                               size_t size);
 
 typedef struct QEMUFileHooks {
-    QEMURamHookFunc *before_ram_iterate;
     QEMURamHookFunc *after_ram_iterate;
     QEMURamHookFunc *hook_ram_load;
     QEMURamSaveFunc *save_page;
@@ -127,7 +126,6 @@ void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 
-void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
 
diff --git a/migration/rdma.h b/migration/rdma.h
index de2ba09dc5..670c67a8cb 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -22,4 +22,11 @@ void rdma_start_outgoing_migration(void *opaque, const char *host_port,
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp);
 
+
+#ifdef CONFIG_RDMA
+int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
+#else
+static inline
+int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
+#endif
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7fb659296f..5e2d73fd68 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "options.h"
 #include "qapi/error.h"
+#include "rdma.h"
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
@@ -297,18 +298,6 @@ void qemu_fflush(QEMUFile *f)
     f->iovcnt = 0;
 }
 
-void ram_control_before_iterate(QEMUFile *f, uint64_t flags)
-{
-    int ret = 0;
-
-    if (f->hooks && f->hooks->before_ram_iterate) {
-        ret = f->hooks->before_ram_iterate(f, flags, NULL);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-        }
-    }
-}
-
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags)
 {
     int ret = 0;
diff --git a/migration/ram.c b/migration/ram.c
index acb8f95f00..6592431a4e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -59,6 +59,7 @@
 #include "qemu/iov.h"
 #include "multifd.h"
 #include "sysemu/runstate.h"
+#include "rdma.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"
 #include "sysemu/kvm.h"
@@ -3060,7 +3061,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         }
     }
 
-    ram_control_before_iterate(f, RAM_CONTROL_SETUP);
+    ret = qemu_rdma_registration_start(f, RAM_CONTROL_SETUP);
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
@@ -3123,7 +3127,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         /* Read version before ram_list.blocks */
         smp_rmb();
 
-        ram_control_before_iterate(f, RAM_CONTROL_ROUND);
+        ret = qemu_rdma_registration_start(f, RAM_CONTROL_ROUND);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+        }
 
         t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
         i = 0;
@@ -3228,7 +3235,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             migration_bitmap_sync_precopy(rs, true);
         }
 
-        ram_control_before_iterate(f, RAM_CONTROL_FINISH);
+        ret = qemu_rdma_registration_start(f, RAM_CONTROL_FINISH);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+        }
 
         /* try transferring iterative blocks of memory */
 
diff --git a/migration/rdma.c b/migration/rdma.c
index f155f3e1c8..3d74ad6db0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3850,18 +3850,15 @@ static int rdma_load_hook(QEMUFile *f, uint64_t flags, void *data)
     }
 }
 
-static int qemu_rdma_registration_start(QEMUFile *f,
-                                        uint64_t flags, void *data)
+int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
-    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
-    RDMAContext *rdma;
-
-    if (migration_in_postcopy()) {
+    if (!migrate_rdma() || migration_in_postcopy()) {
         return 0;
     }
 
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RCU_READ_LOCK_GUARD();
-    rdma = qatomic_rcu_read(&rioc->rdmaout);
+    RDMAContext *rdma = qatomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
         return -1;
     }
@@ -4002,7 +3999,6 @@ static const QEMUFileHooks rdma_read_hooks = {
 };
 
 static const QEMUFileHooks rdma_write_hooks = {
-    .before_ram_iterate = qemu_rdma_registration_start,
     .after_ram_iterate  = qemu_rdma_registration_stop,
     .save_page          = qemu_rdma_save_page,
 };
-- 
2.41.0


