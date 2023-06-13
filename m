Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D879872E6A7
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TX-0006EZ-JK; Tue, 13 Jun 2023 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TN-0006AE-DX
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TJ-0007Xj-Ch
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZ9uIFneLmm4zIFFZcUoN4vRknP1r2UoRBjOP23rXjM=;
 b=dya45858l5buj1QIj3JIfv2prm7BkYUGBJSTdJEmglwt/VxBy2JzX6+GkLQ5WC8Yc4Kiff
 nGDzfWGB9Vb2D4gn9Km1RRZm/xThsMAYuWsFvYK2Jgrez5o6EGAt5raoTFGvzJm3ncDqk9
 DFYNheC12vhnh1dnixL2Q87bnMr0XYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-5gnIECDkPliPcMsTbjINMw-1; Tue, 13 Jun 2023 10:58:08 -0400
X-MC-Unique: 5gnIECDkPliPcMsTbjINMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BB5080120A;
 Tue, 13 Jun 2023 14:58:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B3D640C6F5C;
 Tue, 13 Jun 2023 14:58:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 06/18] migration: Create populate_compress()
Date: Tue, 13 Jun 2023 16:57:45 +0200
Message-Id: <20230613145757.10131-7-quintela@redhat.com>
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

So we don't have to access compression_counters from outside
ram-compress.c.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.h |  3 +++
 migration/migration.c    | 11 +----------
 migration/ram-compress.c | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/migration/ram-compress.h b/migration/ram-compress.h
index 6f7fe2f472..43ff44c0ba 100644
--- a/migration/ram-compress.h
+++ b/migration/ram-compress.h
@@ -30,6 +30,7 @@
 #define QEMU_MIGRATION_COMPRESS_H
 
 #include "qemu-file.h"
+#include "qapi/qapi-types-migration.h"
 
 enum CompressResult {
     RES_NONE = 0,
@@ -67,4 +68,6 @@ void compress_threads_load_cleanup(void);
 int compress_threads_load_setup(QEMUFile *f);
 void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
 
+void populate_compress(MigrationInfo *info);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 5105ad6825..402bcd0d67 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -956,16 +956,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
-    if (migrate_compress()) {
-        info->compression = g_malloc0(sizeof(*info->compression));
-        info->compression->pages = compression_counters.pages;
-        info->compression->busy = compression_counters.busy;
-        info->compression->busy_rate = compression_counters.busy_rate;
-        info->compression->compressed_size =
-                                    compression_counters.compressed_size;
-        info->compression->compression_rate =
-                                    compression_counters.compression_rate;
-    }
+    populate_compress(info);
 
     if (cpu_throttle_active()) {
         info->has_cpu_throttle_percentage = true;
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index a0f6a56470..a91c32588e 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -488,3 +488,17 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
         }
     }
 }
+
+void populate_compress(MigrationInfo *info)
+{
+    if (migrate_compress()) {
+        info->compression = g_malloc0(sizeof(*info->compression));
+        info->compression->pages = compression_counters.pages;
+        info->compression->busy = compression_counters.busy;
+        info->compression->busy_rate = compression_counters.busy_rate;
+        info->compression->compressed_size =
+            compression_counters.compressed_size;
+        info->compression->compression_rate =
+            compression_counters.compression_rate;
+    }
+}
-- 
2.40.1


