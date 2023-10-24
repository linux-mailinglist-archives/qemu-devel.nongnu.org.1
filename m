Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA47D5134
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHFi-0006uZ-DM; Tue, 24 Oct 2023 09:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHFB-0005Nm-Kb
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHF8-0001IX-6M
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uW1Z+v64y+umSQ32w8EgxYbosCFqhn1os2yU1vJh/YQ=;
 b=I5K4TAcqUdOOAq6GKaH/pvz6aSZg0h0p2352bEG3213wH4bRAtzSggJXzULt2/UMawXT3K
 6mPHGheHhHGNeEURCGqNFDj8EqWha7XgK0eOpUMNaSC9dF2fDXYNar4MtlTZskVrTuAs2L
 OGelnPEDasI/x6KrZf0JWd8LJ7g13I4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-XKS5-EocNheYexz_jy6nnA-1; Tue, 24 Oct 2023 09:14:43 -0400
X-MC-Unique: XKS5-EocNheYexz_jy6nnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 759BA857D04;
 Tue, 24 Oct 2023 13:14:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9C91C060AE;
 Tue, 24 Oct 2023 13:14:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 13/39] migration: Create compress_update_rates()
Date: Tue, 24 Oct 2023 15:12:39 +0200
Message-ID: <20231024131305.87468-14-quintela@redhat.com>
In-Reply-To: <20231024131305.87468-1-quintela@redhat.com>
References: <20231024131305.87468-1-quintela@redhat.com>
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

So we can move more compression_counters stuff to ram-compress.c.
Create compression_counters struct to add the stuff that was on
MigrationState.

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-8-quintela@redhat.com>
---
 migration/ram-compress.h |  1 +
 migration/ram.h          |  1 -
 migration/ram-compress.c | 42 +++++++++++++++++++++++++++++++++++++++-
 migration/ram.c          | 29 +--------------------------
 4 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index b228640092..76dacd3ec7 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -71,5 +71,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 void populate_compress(MigrationInfo *info);
 uint64_t ram_compressed_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
+void compress_update_rates(uint64_t page_count);
 
 #endif
diff --git a/migration/ram.h b/migration/ram.h
index 3f724b2f02..9f3ad1ee81 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -34,7 +34,6 @@
 #include "io/channel.h"
 
 extern XBZRLECacheStats xbzrle_counters;
-extern CompressionStats compression_counters;
 
 /* Should be holding either ram_list.mutex, or the RCU lock. */
 #define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index f56e1f8e69..af42cab0fe 100644
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
@@ -518,3 +531,30 @@ void update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
     compression_counters.pages++;
 }
 
+void compress_update_rates(uint64_t page_count)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+    compression_counters.busy_rate = (double)(compression_counters.busy -
+            compression_counters.compress_thread_busy_prev) / page_count;
+    compression_counters.compress_thread_busy_prev =
+            compression_counters.busy;
+
+    double compressed_size = compression_counters.compressed_size -
+        compression_counters.compressed_size_prev;
+    if (compressed_size) {
+        double uncompressed_size = (compression_counters.pages -
+                                    compression_counters.compress_pages_prev) *
+            qemu_target_page_size();
+
+        /* Compression-Ratio = Uncompressed-size / Compressed-size */
+        compression_counters.compression_rate =
+            uncompressed_size / compressed_size;
+
+        compression_counters.compress_pages_prev =
+            compression_counters.pages;
+        compression_counters.compressed_size_prev =
+            compression_counters.compressed_size;
+    }
+}
diff --git a/migration/ram.c b/migration/ram.c
index 46209388ec..f7daf2226e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -369,13 +369,6 @@ struct RAMState {
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
@@ -945,7 +938,6 @@ uint64_t ram_get_total_transferred_pages(void)
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
-    double compressed_size;
 
     /* calculate period counters */
     stat64_set(&mig_stats.dirty_pages_rate,
@@ -973,26 +965,7 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
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
+    compress_update_rates(page_count);
 }
 
 /*
-- 
2.41.0


