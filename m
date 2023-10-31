Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E84957DC8F1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:03:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdy-0000az-RE; Tue, 31 Oct 2023 05:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdv-0000PE-C3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdt-0006td-4q
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCKjJA4W78PJZMYf4U2CLeARXWY7OhYhyDrkh0cEZKU=;
 b=LATHGQ44q3YiMFC+DjS6pu/0oYDsHPV+EU+MgsaYrhQwBVL1/SmwK7g5RMpHEMvJpk5M15
 0ca9wJEgRD3bHcS5M+nbtVexfxlu1mAuIYgKt+eyJgjMqpecU4Z9XCGpCvAamiKyXMrt1p
 mFNF1b2N/kYkEHnPrBG/KDDd1+1773I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-8Y7GJ8ECMMWu3A4bayNxJg-1; Tue, 31 Oct 2023 05:02:29 -0400
X-MC-Unique: 8Y7GJ8ECMMWu3A4bayNxJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1A9185A782;
 Tue, 31 Oct 2023 09:02:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 028301C060B0;
 Tue, 31 Oct 2023 09:02:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 15/38] migration: Move ram_flush_compressed_data() to
 ram-compress.c
Date: Tue, 31 Oct 2023 10:01:19 +0100
Message-ID: <20231031090142.13122-16-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As we export it, rename it compress_flush_data().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019110724.15324-10-quintela@redhat.com>
---
 migration/ram-compress.h |  1 +
 migration/ram-compress.c |  9 +++++++++
 migration/ram.c          | 17 ++++-------------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 636281ed97..7ba01e2882 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -73,5 +73,6 @@ uint64_t ram_compressed_pages(void);
 void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
 void compress_update_rates(uint64_t page_count);
 int compress_send_queued_data(CompressParam *param);
+void compress_flush_data(void);
 
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index af42cab0fe..1443a1cb45 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -558,3 +558,12 @@ void compress_update_rates(uint64_t page_count)
             compression_counters.compressed_size;
     }
 }
+
+void compress_flush_data(void)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+
+    flush_compressed_data(compress_send_queued_data);
+}
diff --git a/migration/ram.c b/migration/ram.c
index b6d485358e..849752ef29 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1300,15 +1300,6 @@ int compress_send_queued_data(CompressParam *param)
     return len;
 }
 
-static void ram_flush_compressed_data(void)
-{
-    if (!migrate_compress()) {
-        return;
-    }
-
-    flush_compressed_data(compress_send_queued_data);
-}
-
 #define PAGE_ALL_CLEAN 0
 #define PAGE_TRY_AGAIN 1
 #define PAGE_DIRTY_FOUND 2
@@ -1364,7 +1355,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
              * Also If xbzrle is on, stop using the data compression at this
              * point. In theory, xbzrle can do better than compression.
              */
-            ram_flush_compressed_data();
+            compress_flush_data();
 
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
@@ -2036,7 +2027,7 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * much CPU resource.
      */
     if (pss->block != pss->last_sent_block) {
-        ram_flush_compressed_data();
+        compress_flush_data();
         return false;
     }
 
@@ -3083,7 +3074,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
              * page is sent in one chunk.
              */
             if (migrate_postcopy_ram()) {
-                ram_flush_compressed_data();
+                compress_flush_data();
             }
 
             /*
@@ -3184,7 +3175,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
-        ram_flush_compressed_data();
+        compress_flush_data();
 
         int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
-- 
2.41.0


