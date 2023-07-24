Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F675F7E0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvI1-0004fp-NO; Mon, 24 Jul 2023 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHS-00049T-Mr
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHP-0002bu-O3
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjSRZQf+LUSGc2iLBTOUuJI1YKlBI5q/qZZ0Y90Bs4I=;
 b=LUiFuJFZFTgNSUobkykccDh+4kxgIfT8mxe2cxO/sfamZmAQpNeqDs36CqlEWS5BKgbQw4
 uK4DS8BBpbL+C34l1qzZFbf3Ygz1acr24NqBCfkfEFUI6ViGsQoXXGJlqPYYE+v8/h1huv
 nfxgHsgHQGfvHRxu1dVazKevm3+lzus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-AvbS5J6lMWKLf8gsYl8nOQ-1; Mon, 24 Jul 2023 09:07:09 -0400
X-MC-Unique: AvbS5J6lMWKLf8gsYl8nOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11514835170;
 Mon, 24 Jul 2023 13:07:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D56CF782D;
 Mon, 24 Jul 2023 13:07:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PATCH 10/26] migration: Extend query-migrate to provide dirty page
 limit info
Date: Mon, 24 Jul 2023 15:06:23 +0200
Message-Id: <20230724130639.93135-11-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

Extend query-migrate to provide throttle time and estimated
ring full time with dirty-limit capability enabled, through which
we can observe if dirty limit take effect during live migration.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-ID: <168733225273.5845.15871826788879741674-8@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json            | 16 +++++++++++++-
 include/sysemu/dirtylimit.h    |  2 ++
 migration/migration-hmp-cmds.c | 10 +++++++++
 migration/migration.c          | 10 +++++++++
 softmmu/dirtylimit.c           | 39 ++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index cc51835cdd..ebc15e2782 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -250,6 +250,18 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
+# @dirty-limit-throttle-time-per-round: Maximum throttle time (in microseconds) of virtual
+#                                       CPUs each dirty ring full round, which shows how
+#                                       MigrationCapability dirty-limit affects the guest
+#                                       during live migration. (since 8.1)
+#
+# @dirty-limit-ring-full-time: Estimated average dirty ring full time (in microseconds)
+#                              each dirty ring full round, note that the value equals
+#                              dirty ring memory size divided by average dirty page rate
+#                              of virtual CPU, which can be used to observe the average
+#                              memory load of virtual CPU indirectly. Note that zero
+#                              means guest doesn't dirty memory (since 8.1)
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
@@ -267,7 +279,9 @@
            '*postcopy-blocktime' : 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*compression': 'CompressionStats',
-           '*socket-address': ['SocketAddress'] } }
+           '*socket-address': ['SocketAddress'],
+           '*dirty-limit-throttle-time-per-round': 'uint64',
+           '*dirty-limit-ring-full-time': 'uint64'} }
 
 ##
 # @query-migrate:
diff --git a/include/sysemu/dirtylimit.h b/include/sysemu/dirtylimit.h
index 8d2c1f3a6b..d11ebbbbdb 100644
--- a/include/sysemu/dirtylimit.h
+++ b/include/sysemu/dirtylimit.h
@@ -34,4 +34,6 @@ void dirtylimit_set_vcpu(int cpu_index,
 void dirtylimit_set_all(uint64_t quota,
                         bool enable);
 void dirtylimit_vcpu_execute(CPUState *cpu);
+uint64_t dirtylimit_throttle_time_per_round(void);
+uint64_t dirtylimit_ring_full_time(void);
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 35e8020bbf..c115ef2d23 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -190,6 +190,16 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->cpu_throttle_percentage);
     }
 
+    if (info->has_dirty_limit_throttle_time_per_round) {
+        monitor_printf(mon, "dirty-limit throttle time: %" PRIu64 " us\n",
+                       info->dirty_limit_throttle_time_per_round);
+    }
+
+    if (info->has_dirty_limit_ring_full_time) {
+        monitor_printf(mon, "dirty-limit ring full time: %" PRIu64 " us\n",
+                       info->dirty_limit_ring_full_time);
+    }
+
     if (info->has_postcopy_blocktime) {
         monitor_printf(mon, "postcopy blocktime: %u\n",
                        info->postcopy_blocktime);
diff --git a/migration/migration.c b/migration/migration.c
index 49332251e8..1ea7512291 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "sysemu/dirtylimit.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -974,6 +975,15 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->ram->dirty_pages_rate =
            stat64_get(&mig_stats.dirty_pages_rate);
     }
+
+    if (migrate_dirty_limit() && dirtylimit_in_service()) {
+        info->has_dirty_limit_throttle_time_per_round = true;
+        info->dirty_limit_throttle_time_per_round =
+                            dirtylimit_throttle_time_per_round();
+
+        info->has_dirty_limit_ring_full_time = true;
+        info->dirty_limit_ring_full_time = dirtylimit_ring_full_time();
+    }
 }
 
 static void populate_disk_info(MigrationInfo *info)
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index a6d854d161..3c275ee55b 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -565,6 +565,45 @@ out:
     hmp_handle_error(mon, err);
 }
 
+/* Return the max throttle time of each virtual CPU */
+uint64_t dirtylimit_throttle_time_per_round(void)
+{
+    CPUState *cpu;
+    int64_t max = 0;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->throttle_us_per_full > max) {
+            max = cpu->throttle_us_per_full;
+        }
+    }
+
+    return max;
+}
+
+/*
+ * Estimate average dirty ring full time of each virtaul CPU.
+ * Return 0 if guest doesn't dirty memory.
+ */
+uint64_t dirtylimit_ring_full_time(void)
+{
+    CPUState *cpu;
+    uint64_t curr_rate = 0;
+    int nvcpus = 0;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->running) {
+            nvcpus++;
+            curr_rate += vcpu_dirty_rate_get(cpu->cpu_index);
+        }
+    }
+
+    if (!curr_rate || !nvcpus) {
+        return 0;
+    }
+
+    return dirtylimit_dirty_ring_full_time(curr_rate / nvcpus);
+}
+
 static struct DirtyLimitInfo *dirtylimit_query_vcpu(int cpu_index)
 {
     DirtyLimitInfo *info = NULL;
-- 
2.40.1


