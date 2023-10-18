Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF297CD8D9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SY-0007P8-FB; Wed, 18 Oct 2023 06:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SE-0007K7-N1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SC-0007hO-VS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/Ejx/IyJuY2+gy3F6ZdkGistopq1ZUuFEb6kSAsko0=;
 b=MatGjV8lD6Y2z/cLPeZfLWZA5jvSrZt4yJyAajhI1MTZzKm+JtaniJuVtPnoxNvsq6XSzP
 PoZWMT+eV6NEGlz8d15+k+ygV+E85FNgjO0MYDVSWqgSRUwCeqCM5Et5PQzaXTLAHlAuy/
 eEI/sSn0NUuH07xgBZgqwPQt/ZWwPfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-Yob6UCDzN8KZOWIz02ULQg-1; Wed, 18 Oct 2023 06:07:00 -0400
X-MC-Unique: Yob6UCDzN8KZOWIz02ULQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F170810201F1;
 Wed, 18 Oct 2023 10:06:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAA4D2026D4C;
 Wed, 18 Oct 2023 10:06:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 05/11] migration: Move update_compress_threads_counts() to
 ram-compress.c
Date: Wed, 18 Oct 2023 12:06:45 +0200
Message-ID: <20231018100651.32674-6-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-9-quintela@redhat.com>
---
 migration/ram-compress.h |  1 +
 migration/ram-compress.c | 17 +++++++++++++++++
 migration/ram.c          | 15 ---------------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 77465dad4b..e55d3b50bd 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -70,5 +70,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 
 void populate_compress(MigrationInfo *info);
 uint64_t ram_compressed_pages(void);
+void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
 
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index d54345d0c1..3ad5975d48 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -32,11 +32,14 @@
 #include "ram-compress.h"
 
 #include "qemu/error-report.h"
+#include "qemu/stats64.h"
 #include "migration.h"
 #include "options.h"
 #include "io/channel-null.h"
 #include "exec/target_page.h"
 #include "exec/ramblock.h"
+#include "ram.h"
+#include "migration-stats.h"
 
 CompressionStats compression_counters;
 
@@ -507,3 +510,17 @@ uint64_t ram_compressed_pages(void)
     return compression_counters.pages;
 }
 
+void update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
+{
+    ram_transferred_add(bytes_xmit);
+
+    if (param->result == RES_ZEROPAGE) {
+        stat64_add(&mig_stats.zero_pages, 1);
+        return;
+    }
+
+    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
+    compression_counters.compressed_size += bytes_xmit - 8;
+    compression_counters.pages++;
+}
+
diff --git a/migration/ram.c b/migration/ram.c
index 2a9c899cb0..5595379fa6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1292,21 +1292,6 @@ static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
     return 1;
 }
 
-static void
-update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
-{
-    ram_transferred_add(bytes_xmit);
-
-    if (param->result == RES_ZEROPAGE) {
-        stat64_add(&mig_stats.zero_pages, 1);
-        return;
-    }
-
-    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
-    compression_counters.compressed_size += bytes_xmit - 8;
-    compression_counters.pages++;
-}
-
 static bool save_page_use_compression(RAMState *rs);
 
 static int send_queued_data(CompressParam *param)
-- 
2.41.0


