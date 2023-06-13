Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414C72E67F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TW-0006ES-TB; Tue, 13 Jun 2023 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TN-0006AB-D1
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TJ-0007Xr-JL
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbjXMEFHjLeeCQ+bgtWRo9/HwYhqwSaOT2Sv9lsS9+k=;
 b=Nxpns0Qijl2yPpc1qStudlyn4IGOUvXWmPTjzoyhlSc31dVfnR9Hffc1F5F+mpYUo0CREp
 hiVxrz0A//rD8AnVikaM7uTcCj712aZ3OylCYN4YZvdBi3S7IC46JC6IUMZJNfpKn8FBq5
 8zpwog6WRom5FcKf5r4Oq/X0CWGFgpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-304l-uf1NI-l6Z9Hqb7qVA-1; Tue, 13 Jun 2023 10:58:11 -0400
X-MC-Unique: 304l-uf1NI-l6Z9Hqb7qVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3BB9101A598;
 Tue, 13 Jun 2023 14:58:09 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B479840C6F5E;
 Tue, 13 Jun 2023 14:58:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 08/18] migration: Move update_compress_threads_counts() to
 ram-compress.c
Date: Tue, 13 Jun 2023 16:57:47 +0200
Message-Id: <20230613145757.10131-9-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
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
index c48d5c53f6..47b600d62b 100644
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
 
@@ -508,3 +511,17 @@ uint64_t ram_compressed_pages(void)
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
index 13c518f81a..53dec4d305 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1259,21 +1259,6 @@ static int ram_save_multifd_page(QEMUFile *file, RAMBlock *block,
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
 static int send_queued_data(CompressParam *param)
 {
     PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_PRECOPY];
-- 
2.40.1


