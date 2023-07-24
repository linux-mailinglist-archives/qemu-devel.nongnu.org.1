Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A375F7D2
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvHM-00043m-2r; Mon, 24 Jul 2023 09:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHB-000432-Tl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvH9-0002Z4-Sl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwFy6lfN0ts+RTbUZj1aGNeIu2txPg9Sz4/q51PTYQI=;
 b=BwIg+6ObdDDHSwtgiqSo6Tbs2zOI19l6CJ6FvhGrmfT9zBBTpBrBLF3yZcburo0WCnkUyT
 4DYfmNxQEMdctdJHsB8N+bgJG2w2x8z6JytznlQMkEBLbs7pzHvpNw1IbSmRBxGE5ODFBN
 QAv8TcWo1DW6Mo249/MhoUiV7bbkvP0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-w2hWAOTHNdy4BBLEnlMk7A-1; Mon, 24 Jul 2023 09:06:57 -0400
X-MC-Unique: w2hWAOTHNdy4BBLEnlMk7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F89310504AB;
 Mon, 24 Jul 2023 13:06:56 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B963AF782D;
 Mon, 24 Jul 2023 13:06:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PATCH 06/26] migration: Introduce dirty-limit capability
Date: Mon, 24 Jul 2023 15:06:19 +0200
Message-Id: <20230724130639.93135-7-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Introduce migration dirty-limit capability, which can
be turned on before live migration and limit dirty
page rate durty live migration.

Introduce migrate_dirty_limit function to help check
if dirty-limit capability enabled during live migration.

Meanwhile, refactor vcpu_dirty_rate_stat_collect
so that period can be configured instead of hardcoded.

dirty-limit capability is kind of like auto-converge
but using dirty limit instead of traditional cpu-throttle
to throttle guest down. To enable this feature, turn on
the dirty-limit capability before live migration using
migrate-set-capabilities, and set the parameters
"x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
to speed up convergence.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <168618975839.6361.17407633874747688653-4@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json  | 13 ++++++++++++-
 migration/options.h  |  1 +
 migration/options.c  | 23 ++++++++++++++++++++++-
 softmmu/dirtylimit.c | 18 ++++++++++++++----
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index aa590dbf0e..cc51835cdd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -497,6 +497,16 @@
 #     are present.  'return-path' capability must be enabled to use
 #     it.  (since 8.1)
 #
+# @dirty-limit: If enabled, migration will use the dirty-limit algo to
+#               throttle down guest instead of auto-converge algo.
+#               Throttle algo only works when vCPU's dirtyrate greater
+#               than 'vcpu-dirty-limit', read processes in guest os
+#               aren't penalized any more, so this algo can improve
+#               performance of vCPU during live migration. This is an
+#               optional performance feature and should not affect the
+#               correctness of the existing auto-converge algo.
+#               (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -512,7 +522,8 @@
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
-           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
+           'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
+           'dirty-limit'] }
 
 ##
 # @MigrationCapabilityStatus:
diff --git a/migration/options.h b/migration/options.h
index 9aaf363322..045e2a41a2 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -29,6 +29,7 @@ bool migrate_block(void);
 bool migrate_colo(void);
 bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
+bool migrate_dirty_limit(void);
 bool migrate_events(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
diff --git a/migration/options.c b/migration/options.c
index 7d2d98830e..7d83f190d6 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -27,6 +27,7 @@
 #include "qemu-file.h"
 #include "ram.h"
 #include "options.h"
+#include "sysemu/kvm.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -196,7 +197,7 @@ Property migration_properties[] = {
 #endif
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
-
+    DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -242,6 +243,13 @@ bool migrate_dirty_bitmaps(void)
     return s->capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
 }
 
+bool migrate_dirty_limit(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_LIMIT];
+}
+
 bool migrate_events(void)
 {
     MigrationState *s = migrate_get_current();
@@ -572,6 +580,19 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
     }
+    if (new_caps[MIGRATION_CAPABILITY_DIRTY_LIMIT]) {
+        if (new_caps[MIGRATION_CAPABILITY_AUTO_CONVERGE]) {
+            error_setg(errp, "dirty-limit conflicts with auto-converge"
+                       " either of then available currently");
+            return false;
+        }
+
+        if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
+            error_setg(errp, "dirty-limit requires KVM with accelerator"
+                   " property 'dirty-ring-size' set");
+            return false;
+        }
+    }
 
     return true;
 }
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index e80201097a..942d876523 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -24,6 +24,9 @@
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
+#include "migration/misc.h"
+#include "migration/migration.h"
+#include "migration/options.h"
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -75,14 +78,21 @@ static bool dirtylimit_quit;
 
 static void vcpu_dirty_rate_stat_collect(void)
 {
+    MigrationState *s = migrate_get_current();
     VcpuStat stat;
     int i = 0;
+    int64_t period = DIRTYLIMIT_CALC_TIME_MS;
+
+    if (migrate_dirty_limit() &&
+        migration_is_active(s)) {
+        period = s->parameters.x_vcpu_dirty_limit_period;
+    }
 
     /* calculate vcpu dirtyrate */
-    vcpu_calculate_dirtyrate(DIRTYLIMIT_CALC_TIME_MS,
-                             &stat,
-                             GLOBAL_DIRTY_LIMIT,
-                             false);
+    vcpu_calculate_dirtyrate(period,
+                              &stat,
+                              GLOBAL_DIRTY_LIMIT,
+                              false);
 
     for (i = 0; i < stat.nvcpu; i++) {
         vcpu_dirty_rate_stat->stat.rates[i].id = i;
-- 
2.40.1


