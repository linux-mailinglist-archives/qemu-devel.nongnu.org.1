Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7D7496E5
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJrE-0002In-SK; Thu, 06 Jul 2023 03:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJr5-0002GV-By
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJr3-0007Mb-NZ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S4fG1HfYZ8d2GMLFeaQRWbJnKmRMzY6VpgFTszcce8=;
 b=i5E0jA0sQZUShCKGsRkzVog86IC/WIWUb9FlgzM0xMtTakSsezjLd8U4hspEqOb9nrABuM
 QaX7KJRRiLEUHx6APoOGDnAlfzmIi1dW3i8BbMUKO4nglo0H0uTyyRZfM1tiG29bFkLLAF
 rsYoqHJAj7Tt1+xwLfKtrj05XGoASnM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-pL5vzOKyMsiEeaSDwq6CGg-1; Thu, 06 Jul 2023 03:56:40 -0400
X-MC-Unique: pL5vzOKyMsiEeaSDwq6CGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61075800B35;
 Thu,  6 Jul 2023 07:56:40 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.193.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0330AF640E;
 Thu,  6 Jul 2023 07:56:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 3/4] migration/ram: Expose ramblock_is_ignored() as
 migrate_ram_is_ignored()
Date: Thu,  6 Jul 2023 09:56:08 +0200
Message-ID: <20230706075612.67404-4-david@redhat.com>
In-Reply-To: <20230706075612.67404-1-david@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

virtio-mem wants to know whether it should not mess with the RAMBlock
content (e.g., discard RAM, preallocate memory) on incoming migration.

So let's expose that function as migrate_ram_is_ignored() in
migration/misc.h

Acked-by: Peter Xu <peterx@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/postcopy-ram.c |  2 +-
 migration/ram.c          | 14 +++++++-------
 migration/ram.h          |  3 +--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 5ebe13b4b9..7dcc0b5c2c 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -40,6 +40,7 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp);
 
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
+bool migrate_ram_is_ignored(RAMBlock *block);
 
 /* migration/block.c */
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5615ec29eb..29aea9456d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -408,7 +408,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
     /*
      * We don't support postcopy with some type of ramblocks.
      *
-     * NOTE: we explicitly ignored ramblock_is_ignored() instead we checked
+     * NOTE: we explicitly ignored migrate_ram_is_ignored() instead we checked
      * all possible ramblocks.  This is because this function can be called
      * when creating the migration object, during the phase RAM_MIGRATABLE
      * is not even properly set for all the ramblocks.
diff --git a/migration/ram.c b/migration/ram.c
index 5283a75f02..0ada6477e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -194,7 +194,7 @@ static bool postcopy_preempt_active(void)
     return migrate_postcopy_preempt() && migration_in_postcopy();
 }
 
-bool ramblock_is_ignored(RAMBlock *block)
+bool migrate_ram_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
            (migrate_ignore_shared() && qemu_ram_is_shared(block)
@@ -696,7 +696,7 @@ static void pss_find_next_dirty(PageSearchStatus *pss)
     unsigned long size = rb->used_length >> TARGET_PAGE_BITS;
     unsigned long *bitmap = rb->bmap;
 
-    if (ramblock_is_ignored(rb)) {
+    if (migrate_ram_is_ignored(rb)) {
         /* Points directly to the end, so we know no dirty page */
         pss->page = size;
         return;
@@ -780,7 +780,7 @@ unsigned long colo_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
 
     *num = 0;
 
-    if (ramblock_is_ignored(rb)) {
+    if (migrate_ram_is_ignored(rb)) {
         return size;
     }
 
@@ -2260,7 +2260,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
     unsigned long start_page = pss->page;
     int res;
 
-    if (ramblock_is_ignored(pss->block)) {
+    if (migrate_ram_is_ignored(pss->block)) {
         error_report("block %s should not be migrated !", pss->block->idstr);
         return 0;
     }
@@ -3347,7 +3347,7 @@ static inline RAMBlock *ram_block_from_stream(MigrationIncomingState *mis,
         return NULL;
     }
 
-    if (ramblock_is_ignored(block)) {
+    if (migrate_ram_is_ignored(block)) {
         error_report("block %s should not be migrated !", id);
         return NULL;
     }
@@ -3958,7 +3958,7 @@ static int ram_load_precopy(QEMUFile *f)
                     }
                     if (migrate_ignore_shared()) {
                         hwaddr addr = qemu_get_be64(f);
-                        if (ramblock_is_ignored(block) &&
+                        if (migrate_ram_is_ignored(block) &&
                             block->mr->addr != addr) {
                             error_report("Mismatched GPAs for block %s "
                                          "%" PRId64 "!= %" PRId64,
@@ -4254,7 +4254,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
     RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
     Error *err = NULL;
 
-    if (ramblock_is_ignored(rb)) {
+    if (migrate_ram_is_ignored(rb)) {
         return;
     }
 
diff --git a/migration/ram.h b/migration/ram.h
index ea1f3c25b5..145c915ca7 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -36,11 +36,10 @@
 extern XBZRLECacheStats xbzrle_counters;
 extern CompressionStats compression_counters;
 
-bool ramblock_is_ignored(RAMBlock *block);
 /* Should be holding either ram_list.mutex, or the RCU lock. */
 #define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
-        if (ramblock_is_ignored(block)) {} else
+        if (migrate_ram_is_ignored(block)) {} else
 
 #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
-- 
2.41.0


