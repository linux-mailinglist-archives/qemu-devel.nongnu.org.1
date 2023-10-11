Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48E7C5E80
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvo-0005Ed-PV; Wed, 11 Oct 2023 16:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvl-0005ED-M9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvj-00033b-UU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNvGit9SfVOejyYVgNK2Rq8RuJMTvMvnwpSWOheA1iw=;
 b=ZrhiXYl5zfcD3nu+Z8XnPNfYWd+BtTQ0+ZVWik1HAuKGddnjcOpRch5knmLy7+++S2Rx88
 Vu14073ZvzSUkkZwoMRr3VwqKlndzpyJ6w30KhCue/mtgqqvOg2sCCLiob6ew5qJpEcHZb
 yzvgjJcUc+pQtNepcrcqSjlGo3E8nII=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-vSXdMWypOzCUtUkTWSeTAw-1; Wed, 11 Oct 2023 16:35:39 -0400
X-MC-Unique: vSXdMWypOzCUtUkTWSeTAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A90A42825EB3;
 Wed, 11 Oct 2023 20:35:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0124E492B06;
 Wed, 11 Oct 2023 20:35:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 06/13] migration/rdma: Create rdma_control_save_page()
Date: Wed, 11 Oct 2023 22:35:20 +0200
Message-ID: <20231011203527.9061-7-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

The only user of ram_control_save_page() and save_page() hook was
rdma. Just move the function to rdma.c, rename it to
rdma_control_save_page().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 12 ------------
 migration/rdma.h      | 10 ++++++++++
 migration/qemu-file.c | 20 --------------------
 migration/ram.c       |  4 ++--
 migration/rdma.c      | 20 +++++++++++++++++++-
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 80c30631dc..60510a2819 100644
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
@@ -125,8 +115,6 @@ int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 #define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
-int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
-                          ram_addr_t offset, size_t size);
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
 #endif
diff --git a/migration/rdma.h b/migration/rdma.h
index 8df8b4089a..09a16c1e3c 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -17,6 +17,8 @@
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
 
+#include "exec/memory.h"
+
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
 
@@ -28,6 +30,8 @@ int qemu_rdma_registration_handle(QEMUFile *f);
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
 int rdma_block_notification_handle(QEMUFile *f, const char *name);
+int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                           ram_addr_t offset, size_t size);
 #else
 static inline
 int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
@@ -37,5 +41,11 @@ static inline
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
 static inline
 int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
+static inline
+int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
+                           ram_addr_t offset, size_t size)
+{
+    return RAM_SAVE_CONTROL_NOT_SUPP;
+}
 #endif
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 4a414b8976..745eaf7a5b 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -298,26 +298,6 @@ void qemu_fflush(QEMUFile *f)
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
index d6a9f90b94..fd5c61c739 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1197,8 +1197,8 @@ static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
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
index 6bca9e8f19..bf16990f91 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3314,6 +3314,25 @@ err:
     return -1;
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
@@ -3989,7 +4008,6 @@ static const QEMUFileHooks rdma_read_hooks = {
 };
 
 static const QEMUFileHooks rdma_write_hooks = {
-    .save_page          = qemu_rdma_save_page,
 };
 
 
-- 
2.41.0


