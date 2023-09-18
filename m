Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71027A4B29
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFT7-0003JH-Mp; Mon, 18 Sep 2023 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002yC-FL
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bA-PI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KICyPLkmvqj/30Z29ko6BQBtIIMhvIUkvS/e3H8ki4c=;
 b=YcifMSrLTlkJL8QnLwDv91UszF3ELiABbeEBFL7eEJv+nYEQPGQ0pI+mxI02q48jgd7Luu
 Si+wOWto1QWeTSu2U0r0hj7jlm2FELU4w+1q+Nmu0qdU9oMfHFH9WFt9DEzf6BPa86VpF7
 9RN7b7CigLNwx5BqbJjP84vn2hlmEqY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158--GzE2ERKMZyDi4WHFD9RPA-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: -GzE2ERKMZyDi4WHFD9RPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 310303C00088
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F323140E950
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A75521E691B; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 17/52] migration/rdma: Replace dangerous macro
 CHECK_ERROR_STATE()
Date: Mon, 18 Sep 2023 16:41:31 +0200
Message-ID: <20230918144206.560120-18-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Hiding return statements in macros is a bad idea.  Use a function
instead, and open code the return part.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 30e6dff875..be66f53489 100644
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
@@ -3219,7 +3217,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     qemu_fflush(f);
 
@@ -3535,7 +3536,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     local = &rdma->local_ram_blocks;
     do {
@@ -3839,6 +3843,7 @@ static int qemu_rdma_registration_start(QEMUFile *f,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
+    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -3850,7 +3855,10 @@ static int qemu_rdma_registration_start(QEMUFile *f,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     trace_qemu_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
@@ -3881,7 +3889,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
         return -EIO;
     }
 
-    CHECK_ERROR_STATE();
+    ret = check_error_state(rdma);
+    if (ret) {
+        return ret;
+    }
 
     qemu_fflush(f);
     ret = qemu_rdma_drain_cq(f, rdma);
-- 
2.41.0


