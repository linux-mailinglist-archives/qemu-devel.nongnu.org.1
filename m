Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3E7C4E7F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRB-0008Od-Dh; Wed, 11 Oct 2023 05:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR7-00087i-Dw
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQw-00050T-Es
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7fslpI+dX1ojdIlQPOK+gy83IxxlkK1Y8sFsRgg9sw=;
 b=MNo5I9sPL9fouWBI+//rY4siK3T3PEiCSkRM2RnFExuedhHt7fJSwuYIbPciCW/L9X2ZNS
 7SPWSa1sue/Ag+ZXhYBJgybmmL0DSmaCmopYu1eyIAm9r5OprVf3YGw1nLsnq4zRU2I53m
 AuLy7zYTtRqDixhRAkGLCb5y1MnvTQU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-1NV6pbMZPwq3kgWumjVyzw-1; Wed, 11 Oct 2023 05:22:59 -0400
X-MC-Unique: 1NV6pbMZPwq3kgWumjVyzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BFA13814583;
 Wed, 11 Oct 2023 09:22:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D10A1C060AE;
 Wed, 11 Oct 2023 09:22:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 26/65] migration/rdma: Replace dangerous macro
 CHECK_ERROR_STATE()
Date: Wed, 11 Oct 2023 11:21:24 +0200
Message-ID: <20231011092203.1266-27-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

Hiding return statements in macros is a bad idea.  Use a function
instead, and open code the return part.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-20-armbru@redhat.com>
---
 migration/rdma.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 18be228e3b..30e2c817f2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -85,18 +85,6 @@
  */
 static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
 
-#define CHECK_ERROR_STATE() \
-    do { \
-        if (rdma->error_state) { \
-            if (!rdma->error_reported) { \
-                error_report("RDMA is in an error state waiting migration" \
-                                " to abort!"); \
-                rdma->error_reported = true; \
-            } \
-            return rdma->error_state; \
-        } \
-    } while (0)
-
 /*
  * A work request ID is 64-bits and we split up these bits
  * into 3 parts:
@@ -451,6 +439,16 @@ typedef struct QEMU_PACKED {
     uint64_t chunks;            /* how many sequential chunks to register */
 } RDMARegister;
 
+static int check_error_state(RDMAContext *rdma)
+{
+    if (rdma->error_state && !rdma->error_reported) {
+        error_report("RDMA is in an error state waiting migration"
+                     " to abort!");
+        rdma->error_reported = true;
+    }
+    return rdma->error_state;
+}
+
 static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
 {
     RDMALocalBlock *local_block;
@@ -3268,7 +3266,10 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     qemu_fflush(f);
 
@@ -3574,7 +3575,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     local = &rdma->local_ram_blocks;
     do {
@@ -3878,6 +3882,7 @@ static int qemu_rdma_registration_start(QEMUFile *f,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
+    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -3889,7 +3894,10 @@ static int qemu_rdma_registration_start(QEMUFile *f,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     trace_qemu_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
@@ -3920,7 +3928,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     qemu_fflush(f);
     ret = qemu_rdma_drain_cq(rdma);
-- 
2.41.0


