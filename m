Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF272E682
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TZ-0006GW-Oy; Tue, 13 Jun 2023 10:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TR-0006B3-4d
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TP-0007ZY-C5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v558RLr6WgkcbOztgEE4mV8ORUZbrNghlZK35hjC7OA=;
 b=TxWdvrMPKtE3xJlDp1m/8K3eixFfAlzfie6BGcVwJycWQ//KgiYFrdRLzptbPO5/ykNIAP
 EvhcGnDzDq4ghIIMCUlnxuvVXNIBlLEGNFM+aheLoqH6czhIIMWpu+RC9YdSlemTShCRAP
 3VfunZsSc1xoUciJWZGbZaqlHqGfiCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-fO7T3T5FOAuaT5AQ-hQQ2w-1; Tue, 13 Jun 2023 10:58:16 -0400
X-MC-Unique: fO7T3T5FOAuaT5AQ-hQQ2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0BB85A5BE;
 Tue, 13 Jun 2023 14:58:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7EB40C6F5C;
 Tue, 13 Jun 2023 14:58:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 12/18] migration: Create compression_update_rates()
Date: Tue, 13 Jun 2023 16:57:51 +0200
Message-Id: <20230613145757.10131-13-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

So we can move more compression_counters stuff to ram-compress.c.
Create compression_counters struct to add the stuff that was on
MigrationState.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.h |  1 +
 migration/ram.h          |  1 -
 migration/ram-compress.c | 41 +++++++++++++++++++++++++++++++++++++++-
 migration/ram.c          | 29 +---------------------------
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index b228640092..a7eb028849 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -71,5 +71,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 void populate_compress(MigrationInfo *info);
 uint64_t ram_compressed_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
+void compression_update_rates(uint64_t page_count);
 
 #endif
diff --git a/migration/ram.h b/migration/ram.h
index ea1f3c25b5..60bc4c9e3a 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -34,7 +34,6 @@
 #include "io/channel.h"
 
 extern XBZRLECacheStats xbzrle_counters;
-extern CompressionStats compression_counters;
 
 bool ramblock_is_ignored(RAMBlock *block);
 /* Should be holding either ram_list.mutex, or the RCU lock. */
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 2652cdee8b..5e1bb82fcd 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -41,7 +41,20 @@
 #include "ram.h"
 #include "migration-stats.h"
 
-CompressionStats compression_counters;
+static struct {
+    int64_t pages;
+    int64_t busy;
+    double busy_rate;
+    int64_t compressed_size;
+    double compression_rate;
+    /* compression statistics since the beginning of the period */
+    /* amount of count that no free thread to compress data */
+    uint64_t compress_thread_busy_prev;
+    /* amount bytes after compression */
+    uint64_t compressed_size_prev;
+    /* amount of compressed pages */
+    uint64_t compress_pages_prev;
+} compression_counters;
 
 static CompressParam *comp_param;
 static QemuThread *compress_threads;
@@ -529,3 +542,29 @@ void update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
+void compression_update_rates(uint64_t page_count)
+{
+    if (migrate_compress()) {
+        compression_counters.busy_rate = (double)(compression_counters.busy -
+            compression_counters.compress_thread_busy_prev) / page_count;
+        compression_counters.compress_thread_busy_prev =
+            compression_counters.busy;
+
+        double compressed_size = compression_counters.compressed_size -
+                                 compression_counters.compressed_size_prev;
+        if (compressed_size) {
+            double uncompressed_size = (compression_counters.pages -
+                compression_counters.compress_pages_prev) *
+                qemu_target_page_size();
+
+            /* Compression-Ratio = Uncompressed-size / Compressed-size */
+            compression_counters.compression_rate =
+                                        uncompressed_size / compressed_size;
+
+            compression_counters.compress_pages_prev =
+                compression_counters.pages;
+            compression_counters.compressed_size_prev =
+                compression_counters.compressed_size;
+        }
+    }
+}
diff --git a/migration/ram.c b/migration/ram.c
index 60f24006bc..1bd586c23a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -364,13 +364,6 @@ struct RAMState {
     bool xbzrle_started;
     /* Are we on the last stage of migration */
     bool last_stage;
-    /* compression statistics since the beginning of the period */
-    /* amount of count that no free thread to compress data */
-    uint64_t compress_thread_busy_prev;
-    /* amount bytes after compression */
-    uint64_t compressed_size_prev;
-    /* amount of compressed pages */
-    uint64_t compress_pages_prev;
 
     /* total handled target pages at the beginning of period */
     uint64_t target_page_count_prev;
@@ -933,7 +926,6 @@ uint64_t ram_get_total_transferred_pages(void)
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
-    double compressed_size;
 
     /* calculate period counters */
     stat64_set(&mig_stats.dirty_pages_rate,
@@ -961,26 +953,7 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
         rs->xbzrle_pages_prev = xbzrle_counters.pages;
         rs->xbzrle_bytes_prev = xbzrle_counters.bytes;
     }
-
-    if (migrate_compress()) {
-        compression_counters.busy_rate = (double)(compression_counters.busy -
-            rs->compress_thread_busy_prev) / page_count;
-        rs->compress_thread_busy_prev = compression_counters.busy;
-
-        compressed_size = compression_counters.compressed_size -
-                          rs->compressed_size_prev;
-        if (compressed_size) {
-            double uncompressed_size = (compression_counters.pages -
-                                    rs->compress_pages_prev) * TARGET_PAGE_SIZE;
-
-            /* Compression-Ratio = Uncompressed-size / Compressed-size */
-            compression_counters.compression_rate =
-                                        uncompressed_size / compressed_size;
-
-            rs->compress_pages_prev = compression_counters.pages;
-            rs->compressed_size_prev = compression_counters.compressed_size;
-        }
-    }
+    compression_update_rates(page_count);
 }
 
 static void migration_trigger_throttle(RAMState *rs)
-- 
2.40.1


