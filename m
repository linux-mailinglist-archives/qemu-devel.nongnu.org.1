Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AB7DFF75
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 08:43:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyopX-0004sz-Rr; Fri, 03 Nov 2023 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyopR-0004sL-8J
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyopO-0006AM-W2
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 03:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698997370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f3xDqZqz9DnaTXWxWT/L/+Ux0N6si72bNiY/O2C+gWk=;
 b=d5dcbCZRBWhUr0s/lblH0eOs7hHAPTWX6CW+nu9cA8S3j8G2yM8DSrbxh3XUHR5tfoOm/o
 UFjmtlyxFZhxse3nAiEjviqeQxnaTmZDH4EXC5aSrL9JzRK+BXUYkCwssHdBhVr+UxAJGW
 zeZBHGrF3cgdzmisp5bI9CRZ7GqmeRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-lIKg6z29PHCEOpCth7Xm_g-1; Fri, 03 Nov 2023 03:42:48 -0400
X-MC-Unique: lIKg6z29PHCEOpCth7Xm_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0889A101A529;
 Fri,  3 Nov 2023 07:42:48 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D839440C6EBC;
 Fri,  3 Nov 2023 07:42:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v2] migration: Unlock mutex in error case
Date: Fri,  3 Nov 2023 08:42:45 +0100
Message-ID: <20231103074245.55166-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

We were not unlocking bitmap mutex on the error case.  To fix it
forever change to enclose the code with WITH_QEMU_LOCK_GUARD().
Coverity CID 1523750.

Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error paths")
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 106 ++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a0f3b86663..8c7886ab79 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3030,71 +3030,71 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      * MAX_WAIT (if curious, further see commit 4508bd9ed8053ce) below, which
      * guarantees that we'll at least released it in a regular basis.
      */
-    qemu_mutex_lock(&rs->bitmap_mutex);
-    WITH_RCU_READ_LOCK_GUARD() {
-        if (ram_list.version != rs->last_version) {
-            ram_state_reset(rs);
-        }
-
-        /* Read version before ram_list.blocks */
-        smp_rmb();
-
-        ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-            goto out;
-        }
-
-        t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-        i = 0;
-        while ((ret = migration_rate_exceeded(f)) == 0 ||
-               postcopy_has_request(rs)) {
-            int pages;
-
-            if (qemu_file_get_error(f)) {
-                break;
+    WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
+        WITH_RCU_READ_LOCK_GUARD() {
+            if (ram_list.version != rs->last_version) {
+                ram_state_reset(rs);
             }
 
-            pages = ram_find_and_save_block(rs);
-            /* no more pages to sent */
-            if (pages == 0) {
-                done = 1;
-                break;
-            }
+            /* Read version before ram_list.blocks */
+            smp_rmb();
 
-            if (pages < 0) {
-                qemu_file_set_error(f, pages);
-                break;
+            ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
+            if (ret < 0) {
+                qemu_file_set_error(f, ret);
+                goto out;
             }
 
-            rs->target_page_count += pages;
+            t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            i = 0;
+            while ((ret = migration_rate_exceeded(f)) == 0 ||
+                   postcopy_has_request(rs)) {
+                int pages;
 
-            /*
-             * During postcopy, it is necessary to make sure one whole host
-             * page is sent in one chunk.
-             */
-            if (migrate_postcopy_ram()) {
-                compress_flush_data();
-            }
+                if (qemu_file_get_error(f)) {
+                    break;
+                }
+
+                pages = ram_find_and_save_block(rs);
+                /* no more pages to sent */
+                if (pages == 0) {
+                    done = 1;
+                    break;
+                }
 
-            /*
-             * we want to check in the 1st loop, just in case it was the 1st
-             * time and we had to sync the dirty bitmap.
-             * qemu_clock_get_ns() is a bit expensive, so we only check each
-             * some iterations
-             */
-            if ((i & 63) == 0) {
-                uint64_t t1 = (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - t0) /
-                              1000000;
-                if (t1 > MAX_WAIT) {
-                    trace_ram_save_iterate_big_wait(t1, i);
+                if (pages < 0) {
+                    qemu_file_set_error(f, pages);
                     break;
                 }
+
+                rs->target_page_count += pages;
+
+                /*
+                 * During postcopy, it is necessary to make sure one whole host
+                 * page is sent in one chunk.
+                 */
+                if (migrate_postcopy_ram()) {
+                    compress_flush_data();
+                }
+
+                /*
+                 * we want to check in the 1st loop, just in case it was the 1st
+                 * time and we had to sync the dirty bitmap.
+                 * qemu_clock_get_ns() is a bit expensive, so we only check each
+                 * some iterations
+                 */
+                if ((i & 63) == 0) {
+                    uint64_t t1 = (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - t0) /
+                        1000000;
+                    if (t1 > MAX_WAIT) {
+                        trace_ram_save_iterate_big_wait(t1, i);
+                        break;
+                    }
+                }
+                i++;
             }
-            i++;
         }
     }
-    qemu_mutex_unlock(&rs->bitmap_mutex);
 
     /*
      * Must occur before EOS (or any QEMUFile operation)
-- 
2.41.0


