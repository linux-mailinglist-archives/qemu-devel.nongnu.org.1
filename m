Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D682E824
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa09-0005h9-KN; Mon, 15 Jan 2024 22:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzs-0005gM-94
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzo-0002mU-DS
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IawJs/pTkatJD0nB6iYg3s1VH4CU0TF4xWkc1B3gc/k=;
 b=XCbbndPnfyFnOQUK0QBhuRMpOS1zFUHoxFkpPNp01UDOLjaNwTTdrVPHaH+TJi4m+Tsz1E
 f3WN4ItDtUojXkVKkQoMIM/Sfr5YgKVvSPN7AY8Z/0yWyolfuDuxHTW5UkWW2xo3iw7z+I
 8C7dEwtlzePQB30a+GK2l4VVZR05c1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-FLxkA_YKOP2uUqlprywDoQ-1; Mon, 15 Jan 2024 22:20:02 -0500
X-MC-Unique: FLxkA_YKOP2uUqlprywDoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AC6D85A589;
 Tue, 16 Jan 2024 03:20:02 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 004D83C25;
 Tue, 16 Jan 2024 03:19:59 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/20] migration/multifd: Remove QEMUFile from where it is not
 needed
Date: Tue, 16 Jan 2024 11:19:30 +0800
Message-ID: <20240116031947.69017-4-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

From: Fabiano Rosas <farosas@suse.de>

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240104142144.9680-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  4 ++--
 migration/multifd.c | 12 ++++++------
 migration/ram.c     | 15 +++++++--------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index b0ff610c37..35d11f103c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -21,8 +21,8 @@ void multifd_load_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(QEMUFile *f);
-int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
+int multifd_send_sync_main(void);
+int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
diff --git a/migration/multifd.c b/migration/multifd.c
index 3e650f5da0..2dbc3ba836 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -390,7 +390,7 @@ struct {
  * false.
  */
 
-static int multifd_send_pages(QEMUFile *f)
+static int multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -436,7 +436,7 @@ static int multifd_send_pages(QEMUFile *f)
     return 1;
 }
 
-int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
+int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages = multifd_send_state->pages;
     bool changed = false;
@@ -456,12 +456,12 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
         changed = true;
     }
 
-    if (multifd_send_pages(f) < 0) {
+    if (multifd_send_pages() < 0) {
         return -1;
     }
 
     if (changed) {
-        return multifd_queue_page(f, block, offset);
+        return multifd_queue_page(block, offset);
     }
 
     return 1;
@@ -583,7 +583,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(QEMUFile *f)
+int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
@@ -592,7 +592,7 @@ int multifd_send_sync_main(QEMUFile *f)
         return 0;
     }
     if (multifd_send_state->pages->num) {
-        if (multifd_send_pages(f) < 0) {
+        if (multifd_send_pages() < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
diff --git a/migration/ram.c b/migration/ram.c
index 890f31cf66..c0cdcccb75 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1250,10 +1250,9 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
     return pages;
 }
 
-static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
-                                 ram_addr_t offset)
+static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
-    if (multifd_queue_page(file, block, offset) < 0) {
+    if (multifd_queue_page(block, offset) < 0) {
         return -1;
     }
     stat64_add(&mig_stats.normal_pages, 1);
@@ -1336,7 +1335,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
             if (migrate_multifd() &&
                 !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_send_sync_main(f);
+                int ret = multifd_send_sync_main();
                 if (ret < 0) {
                     return ret;
                 }
@@ -2067,7 +2066,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
      * still see partially copied pages which is data corruption.
      */
     if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(pss->pss_channel, block, offset);
+        return ram_save_multifd_page(block, offset);
     }
 
     return ram_save_page(rs, pss);
@@ -2985,7 +2984,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     migration_ops->ram_save_target_page = ram_save_target_page_legacy;
 
     bql_unlock();
-    ret = multifd_send_sync_main(f);
+    ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
         return ret;
@@ -3109,7 +3108,7 @@ out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
-            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
+            ret = multifd_send_sync_main();
             if (ret < 0) {
                 return ret;
             }
@@ -3183,7 +3182,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
+    ret = multifd_send_sync_main();
     if (ret < 0) {
         return ret;
     }
-- 
2.43.0


