Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628577CD8D2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3Sj-0007aw-1G; Wed, 18 Oct 2023 06:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SZ-0007PX-8t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SV-0007lG-M4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fbHzSia0VUeAnFfxv21gVLysC97kwxizm5pnnAM7Cg=;
 b=KsM81Ol8g/Z/WsUNs+ezC6DKri5QPuv8XD3UOy2NOK2JHC1VuD8k3nioBXb24BjdgIb8Ko
 vWuK1sJVunS9OoixTL0TV4noAA9ElXoa/vpHRDw0D6kCFmMXzTiJ7t4PLm30j4H8b9fslc
 FuOUN6J8Y0mhxc+TKPi0uz9fg8wBtHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-hBkqH_cAPpWfZOFP277JSw-1; Wed, 18 Oct 2023 06:06:57 -0400
X-MC-Unique: hBkqH_cAPpWfZOFP277JSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41DE187A9F5;
 Wed, 18 Oct 2023 10:06:57 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3999B2026D4C;
 Wed, 18 Oct 2023 10:06:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 03/11] migration: Create populate_compress()
Date: Wed, 18 Oct 2023 12:06:43 +0200
Message-ID: <20231018100651.32674-4-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

So we don't have to access compression_counters from outside
ram-compress.c.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20230613145757.10131-7-quintela@redhat.com>
---
 migration/ram-compress.h |  3 +++
 migration/migration.c    | 11 +----------
 migration/ram-compress.c | 13 +++++++++++++
 3 files changed, 17 insertions(+), 10 deletions(-)

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
index a808abd294..05c0b801ba 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -974,16 +974,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
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
index a0f6a56470..bbf78a02d4 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -488,3 +488,16 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
         }
     }
 }
+
+void populate_compress(MigrationInfo *info)
+{
+    if (!migrate_compress()) {
+        return;
+    }
+    info->compression = g_malloc0(sizeof(*info->compression));
+    info->compression->pages = compression_counters.pages;
+    info->compression->busy = compression_counters.busy;
+    info->compression->busy_rate = compression_counters.busy_rate;
+    info->compression->compressed_size = compression_counters.compressed_size;
+    info->compression->compression_rate = compression_counters.compression_rate;
+}
-- 
2.41.0


