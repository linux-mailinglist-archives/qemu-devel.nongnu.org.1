Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B1715E15
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xx9-00061g-Sy; Tue, 30 May 2023 07:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwK-0005Jf-3R
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwI-0000DQ-9x
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3COZ0BARqMVhPm/JFHKioiR3HeLEi0KRIOAOdGoo4n8=;
 b=LJc9AS8Hm/eGHCCJFxXYId44rPonOJdNOW4P2OzyIIQmvf94as0w1h0l8yFFJCdD7gNsEY
 g5l2g2TAzaafFS8k3uS5uSwQjZX1KZ93NT+8NP5jOrx0iX+2G+V0N2LwCWC0Tm/ajqdajk
 PHimAassKLAZDqltmKn5cQDJ3d1bSrk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-0dvjL2Z3PyG9c6ivFxfyAg-1; Tue, 30 May 2023 07:54:56 -0400
X-MC-Unique: 0dvjL2Z3PyG9c6ivFxfyAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A01381D1E8
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:56 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04E8040C6EC4;
 Tue, 30 May 2023 11:54:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 17/21] migration/rdma: Create rdma_control_save_page()
Date: Tue, 30 May 2023 13:54:25 +0200
Message-Id: <20230530115429.1998-18-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The only user of ram_control_save_page() and save_page() hook was
rdma. Just move the function to rdma.c, rename it to
rdma_control_save_page().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230509120700.78359-7-quintela@redhat.com>
---
 migration/qemu-file.h | 12 ------------
 migration/rdma.h      |  6 ++++++
 migration/qemu-file.c | 20 --------------------
 migration/ram.c       |  4 ++--
 migration/rdma.c      | 20 +++++++++++++++++++-
 5 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 6791db6b08..c43c410168 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -36,17 +36,7 @@
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-/*
- * This function allows override of where the RAM page
- * is saved (such as RDMA, for example.)
- */
-typedef int (QEMURamSaveFunc)(QEMUFile *f,
-                              ram_addr_t block_offset,
-                              ram_addr_t offset,
-                              size_t size);
-
 typedef struct QEMUFileHooks {
-    QEMURamSaveFunc *save_page;
 } QEMUFileHooks;
 
 QEMUFile *qemu_file_new_input(QIOChannel *ioc);
@@ -129,8 +119,6 @@ int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 #define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
-int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                          ram_addr_t offset, size_t size);
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
 #endif
diff --git a/migration/rdma.h b/migration/rdma.h
index 1266a90e07..4674dceb4a 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -17,6 +17,8 @@
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
 
+#include "exec/memory.h"
+
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
 
@@ -28,10 +30,14 @@ int qemu_rdma_registration_handle(QEMUFile *f);
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
 int rdma_block_notification_handle(QEMUFile *f, const char *name);
+int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                           ram_addr_t offset, size_t size);
 #else
 int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
 int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
+int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                           ram_addr_t offset, size_t size) { return false; }
 #endif
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 08bbc29e64..a222daeaab 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -303,26 +303,6 @@ void qemu_fflush(QEMUFile *f)
     f->iovcnt = 0;
 }
 
-int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                          ram_addr_t offset, size_t size)
-{
-    if (f->hooks && f->hooks->save_page) {
-        int ret = f->hooks->save_page(f, block_offset, offset, size);
-        /*
-         * RAM_SAVE_CONTROL_* are negative values
-         */
-        if (ret != RAM_SAVE_CONTROL_DELAYED &&
-            ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-            if (ret < 0) {
-                qemu_file_set_error(f, ret);
-            }
-        }
-        return ret;
-    }
-
-    return RAM_SAVE_CONTROL_NOT_SUPP;
-}
-
 /*
  * Attempt to fill the buffer from the underlying file
  * Returns the number of bytes read, or negative value for an error.
diff --git a/migration/ram.c b/migration/ram.c
index 67d0f20368..19e5e93de8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1147,8 +1147,8 @@ static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
 {
     int ret;
 
-    ret = ram_control_save_page(pss->pss_channel, block->offset, offset,
-                                TARGET_PAGE_SIZE);
+    ret = rdma_control_save_page(pss->pss_channel, block->offset, offset,
+                                 TARGET_PAGE_SIZE);
     if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
         return false;
     }
diff --git a/migration/rdma.c b/migration/rdma.c
index 948e93256d..b506b86b47 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3319,6 +3319,25 @@ err:
     return ret;
 }
 
+int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                           ram_addr_t offset, size_t size)
+{
+    if (!migrate_rdma()) {
+        return RAM_SAVE_CONTROL_NOT_SUPP;
+    }
+
+    int ret = qemu_rdma_save_page(f, block_offset, offset, size);
+
+    if (ret != RAM_SAVE_CONTROL_DELAYED &&
+        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+        }
+    }
+    return ret;
+}
+
+
 static void rdma_accept_incoming_migration(void *opaque);
 
 static void rdma_cm_poll_handler(void *opaque)
@@ -3995,7 +4014,6 @@ static const QEMUFileHooks rdma_read_hooks = {
 };
 
 static const QEMUFileHooks rdma_write_hooks = {
-    .save_page          = qemu_rdma_save_page,
 };
 
 
-- 
2.40.1


