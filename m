Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6E703DFA
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeKU-0007yH-0U; Mon, 15 May 2023 15:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKO-0007a1-U8
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKK-0005Mp-Vb
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN6XYOkkV312Bdr5yyuCmAMqH33G8DerrB7QE8xvnZs=;
 b=UBPDrKURZrpRP03N3lXXFrx12XL1qDvjy7opifMLlIzJu2q5iarReU2LaNcxxmIcCE5wGI
 GozAcXt4jsI4B6dx3y+972MBliGU3yTUJs4t51TrCF4odv94Xigy8i6usUyKVILsEYvjQt
 N/0mB/tIpkRu5C50mBVdSO4BArTenLg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-UGKygdn5NCm0d_UCwFJDiQ-1; Mon, 15 May 2023 15:57:43 -0400
X-MC-Unique: UGKygdn5NCm0d_UCwFJDiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28ED71C0A581;
 Mon, 15 May 2023 19:57:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30814492B00;
 Mon, 15 May 2023 19:57:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 05/16] migration: Move rate_limit_max and rate_limit_used
 to migration_stats
Date: Mon, 15 May 2023 21:56:58 +0200
Message-Id: <20230515195709.63843-6-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These way we can make them atomic and use this functions from any
place.  I also moved all functions that use rate_limit to
migration-stats.

Functions got renamed, they are not qemu_file anymore.

qemu_file_rate_limit -> migration_rate_exceeded
qemu_file_set_rate_limit -> migration_rate_set
qemu_file_get_rate_limit -> migration_rate_get
qemu_file_reset_rate_limit -> migration_rate_reset
qemu_file_acct_rate_limit -> migration_rate_account.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

---

s/this/these/ (harsh)
If you have any good suggestion for better names, I am all ears.
Fix missing / XFER_LIMIT_RATIO in migration_rate_set(quintela)
---
 include/migration/qemu-file-types.h | 12 ++++++-
 migration/migration-stats.h         | 47 ++++++++++++++++++++++++++
 migration/options.h                 |  7 ----
 migration/qemu-file.h               | 11 ------
 hw/ppc/spapr.c                      |  4 +--
 hw/s390x/s390-stattrib.c            |  2 +-
 migration/block-dirty-bitmap.c      |  2 +-
 migration/block.c                   |  5 +--
 migration/migration-stats.c         | 44 ++++++++++++++++++++++++
 migration/migration.c               | 14 ++++----
 migration/multifd.c                 |  2 +-
 migration/options.c                 |  7 ++--
 migration/qemu-file.c               | 52 ++---------------------------
 migration/ram.c                     |  2 +-
 migration/savevm.c                  |  2 +-
 15 files changed, 124 insertions(+), 89 deletions(-)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index 1436f9ce92..9ba163f333 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -165,6 +165,16 @@ size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256]);
 
 void qemu_put_counted_string(QEMUFile *f, const char *name);
 
-int qemu_file_rate_limit(QEMUFile *f);
+/**
+ * migration_rate_exceeded: Check if we have exceeded rate for this interval
+ *
+ * Checks if we have already transferred more data that we are allowed
+ * in the current interval.
+ *
+ * @f: QEMUFile used for main migration channel
+ *
+ * Returns if we should stop sending data for this interval.
+ */
+bool migration_rate_exceeded(QEMUFile *f);
 
 #endif
diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 21402af9e4..e39c083245 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -15,6 +15,12 @@
 
 #include "qemu/stats64.h"
 
+/*
+ * Amount of time to allocate to each "chunk" of bandwidth-throttled
+ * data.
+ */
+#define BUFFER_DELAY     100
+
 /*
  * If rate_limit_max is 0, there is special code to remove the rate
  * limit.
@@ -75,6 +81,14 @@ typedef struct {
      * Number of bytes sent during precopy stage.
      */
     Stat64 precopy_bytes;
+    /*
+     * Maximum amount of data we can send in a cycle.
+     */
+    Stat64 rate_limit_max;
+    /*
+     * Amount of data we have sent in the current cycle.
+     */
+    Stat64 rate_limit_used;
     /*
      * How long has the setup stage took.
      */
@@ -100,4 +114,37 @@ extern MigrationAtomicStats mig_stats;
  * Returns: Nothing.  The time is stored in val.
  */
 void migration_time_since(MigrationAtomicStats *stats, int64_t since);
+
+/**
+ * migration_rate_account: Increase the number of bytes transferred.
+ *
+ * Report on a number of bytes the have been transferred that need to
+ * be applied to the rate limiting calcuations.
+ *
+ * @len: amount of bytes transferred
+ */
+void migration_rate_account(uint64_t len);
+
+/**
+ * migration_rate_get: Get the maximum amount that can be transferred.
+ *
+ * Returns the maximum number of bytes that can be transferred in a cycle.
+ */
+uint64_t migration_rate_get(void);
+
+/**
+ * migration_rate_reset: Reset the rate limit counter.
+ *
+ * This is called when we know we start a new transfer cycle.
+ */
+void migration_rate_reset(void);
+
+/**
+ * migration_rate_set: Set the maximum amount that can be transferred.
+ *
+ * Sets the maximum amount of bytes that can be transferred in one cycle.
+ *
+ * @new_rate: new maximum amount
+ */
+void migration_rate_set(uint64_t new_rate);
 #endif
diff --git a/migration/options.h b/migration/options.h
index 5cca3326d6..45991af3c2 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -17,13 +17,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 
-/* constants */
-
-/* Amount of time to allocate to each "chunk" of bandwidth-throttled
- * data. */
-#define BUFFER_DELAY     100
-#define XFER_LIMIT_RATIO (1000 / BUFFER_DELAY)
-
 /* migration properties */
 
 extern Property migration_properties[];
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index bcc39081f2..e649718492 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -130,17 +130,6 @@ void qemu_file_skip(QEMUFile *f, int size);
  * accounting information tracks the total migration traffic.
  */
 void qemu_file_credit_transfer(QEMUFile *f, size_t size);
-void qemu_file_reset_rate_limit(QEMUFile *f);
-/*
- * qemu_file_acct_rate_limit:
- *
- * Report on a number of bytes the have been transferred
- * out of band from the main file object I/O methods, and
- * need to be applied to the rate limiting calcuations
- */
-void qemu_file_acct_rate_limit(QEMUFile *f, uint64_t len);
-void qemu_file_set_rate_limit(QEMUFile *f, uint64_t new_rate);
-uint64_t qemu_file_get_rate_limit(QEMUFile *f);
 int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ddc9c7b1a1..1baea16c96 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2166,7 +2166,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
                 break;
             }
         }
-    } while ((index < htabslots) && !qemu_file_rate_limit(f));
+    } while ((index < htabslots) && !migration_rate_exceeded(f));
 
     if (index >= htabslots) {
         assert(index == htabslots);
@@ -2237,7 +2237,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
             assert(index == htabslots);
             index = 0;
         }
-    } while ((examined < htabslots) && (!qemu_file_rate_limit(f) || final));
+    } while ((examined < htabslots) && (!migration_rate_exceeded(f) || final));
 
     if (index >= htabslots) {
         assert(index == htabslots);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index aed919ad7d..220e845d12 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -209,7 +209,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
         return -ENOMEM;
     }
 
-    while (final ? 1 : qemu_file_rate_limit(f) == 0) {
+    while (final ? 1 : migration_rate_exceeded(f) == 0) {
         reallen = sac->get_stattr(sas, &start_gfn, buflen, buf);
         if (reallen < 0) {
             g_free(buf);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 20f36e6bd8..032fc5f405 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -706,7 +706,7 @@ static void bulk_phase(QEMUFile *f, DBMSaveState *s, bool limit)
     QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
         while (!dbms->bulk_completed) {
             bulk_phase_send_chunk(f, s, dbms);
-            if (limit && qemu_file_rate_limit(f)) {
+            if (limit && migration_rate_exceeded(f)) {
                 return;
             }
         }
diff --git a/migration/block.c b/migration/block.c
index 12617b4152..b9580a6c7e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -23,6 +23,7 @@
 #include "block/dirty-bitmap.h"
 #include "migration/misc.h"
 #include "migration.h"
+#include "migration-stats.h"
 #include "migration/register.h"
 #include "qemu-file.h"
 #include "migration/vmstate.h"
@@ -625,7 +626,7 @@ static int flush_blks(QEMUFile *f)
 
     blk_mig_lock();
     while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
-        if (qemu_file_rate_limit(f)) {
+        if (migration_rate_exceeded(f)) {
             break;
         }
         if (blk->ret < 0) {
@@ -762,7 +763,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     /* control the rate of transfer */
     blk_mig_lock();
     while (block_mig_state.read_done * BLK_MIG_BLOCK_SIZE <
-           qemu_file_get_rate_limit(f) &&
+           migration_rate_get() &&
            block_mig_state.submitted < MAX_PARALLEL_IO &&
            (block_mig_state.submitted + block_mig_state.read_done) <
            MAX_IO_BUFFERS) {
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 3431453c90..1b16edae7d 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/stats64.h"
 #include "qemu/timer.h"
+#include "qemu-file.h"
 #include "migration-stats.h"
 
 MigrationAtomicStats mig_stats;
@@ -22,3 +23,46 @@ void migration_time_since(MigrationAtomicStats *stats, int64_t since)
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     stat64_set(&stats->setup_time, now - since);
 }
+
+bool migration_rate_exceeded(QEMUFile *f)
+{
+    if (qemu_file_get_error(f)) {
+        return true;
+    }
+
+    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
+    uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
+
+    if (rate_limit_max == RATE_LIMIT_MAX) {
+        return false;
+    }
+    if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
+        return true;
+    }
+    return false;
+}
+
+uint64_t migration_rate_get(void)
+{
+    return stat64_get(&mig_stats.rate_limit_max);
+}
+
+#define XFER_LIMIT_RATIO (1000 / BUFFER_DELAY)
+
+void migration_rate_set(uint64_t limit)
+{
+    /*
+     * 'limit' is per second.  But we check it each BUFER_DELAY miliseconds.
+     */
+    stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
+}
+
+void migration_rate_reset(void)
+{
+    stat64_set(&mig_stats.rate_limit_used, 0);
+}
+
+void migration_rate_account(uint64_t len)
+{
+    stat64_add(&mig_stats.rate_limit_used, len);
+}
diff --git a/migration/migration.c b/migration/migration.c
index e9466273bb..594709dbbc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2119,7 +2119,7 @@ static int postcopy_start(MigrationState *ms)
      * will notice we're in POSTCOPY_ACTIVE and not actually
      * wrap their state up here
      */
-    qemu_file_set_rate_limit(ms->to_dst_file, bandwidth);
+    migration_rate_set(bandwidth);
     if (migrate_postcopy_ram()) {
         /* Ping just for debugging, helps line traces up */
         qemu_savevm_send_ping(ms->to_dst_file, 2);
@@ -2303,7 +2303,7 @@ static void migration_completion(MigrationState *s)
                  * them if migration fails or is cancelled.
                  */
                 s->block_inactive = !migrate_colo();
-                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
+                migration_rate_set(RATE_LIMIT_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                                          s->block_inactive);
             }
@@ -2698,7 +2698,7 @@ static void migration_update_counters(MigrationState *s,
             stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
     }
 
-    qemu_file_reset_rate_limit(s->to_dst_file);
+    migration_rate_reset();
 
     update_iteration_initial_status(s);
 
@@ -2851,7 +2851,7 @@ bool migration_rate_limit(void)
 
     bool urgent = false;
     migration_update_counters(s, now);
-    if (qemu_file_rate_limit(s->to_dst_file)) {
+    if (migration_rate_exceeded(s->to_dst_file)) {
 
         if (qemu_file_get_error(s->to_dst_file)) {
             return false;
@@ -2973,7 +2973,7 @@ static void *migration_thread(void *opaque)
     trace_migration_thread_setup_complete();
 
     while (migration_is_active(s)) {
-        if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
+        if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
             MigIterateState iter_state = migration_iteration_run(s);
             if (iter_state == MIG_ITERATE_SKIP) {
                 continue;
@@ -3047,7 +3047,7 @@ static void *bg_migration_thread(void *opaque)
     rcu_register_thread();
     object_ref(OBJECT(s));
 
-    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
+    migration_rate_set(RATE_LIMIT_MAX);
 
     setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     /*
@@ -3219,7 +3219,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         notifier_list_notify(&migration_state_notifiers, s);
     }
 
-    qemu_file_set_rate_limit(s->to_dst_file, rate_limit);
+    migration_rate_set(rate_limit);
     qemu_file_set_blocking(s->to_dst_file, true);
 
     /*
diff --git a/migration/multifd.c b/migration/multifd.c
index 5c4298eadf..5052091ce2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -431,7 +431,7 @@ static int multifd_send_pages(QEMUFile *f)
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     transferred = ((uint64_t) pages->num) * p->page_size + p->packet_len;
-    qemu_file_acct_rate_limit(f, transferred);
+    migration_rate_account(transferred);
     qemu_mutex_unlock(&p->mutex);
     stat64_add(&mig_stats.transferred, transferred);
     stat64_add(&mig_stats.multifd_bytes, transferred);
diff --git a/migration/options.c b/migration/options.c
index c2a278ee2d..b62ab30cd5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -23,6 +23,7 @@
 #include "migration/colo.h"
 #include "migration/misc.h"
 #include "migration.h"
+#include "migration-stats.h"
 #include "qemu-file.h"
 #include "ram.h"
 #include "options.h"
@@ -1242,8 +1243,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_max_bandwidth) {
         s->parameters.max_bandwidth = params->max_bandwidth;
         if (s->to_dst_file && !migration_in_postcopy()) {
-            qemu_file_set_rate_limit(s->to_dst_file,
-                                s->parameters.max_bandwidth);
+            migration_rate_set(s->parameters.max_bandwidth);
         }
     }
 
@@ -1272,8 +1272,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_max_postcopy_bandwidth) {
         s->parameters.max_postcopy_bandwidth = params->max_postcopy_bandwidth;
         if (s->to_dst_file && migration_in_postcopy()) {
-            qemu_file_set_rate_limit(s->to_dst_file,
-                    s->parameters.max_postcopy_bandwidth);
+            migration_rate_set(s->parameters.max_postcopy_bandwidth);
         }
     }
     if (params->has_max_cpu_throttle) {
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 956bd2a580..9c67b52fe0 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -41,17 +41,6 @@ struct QEMUFile {
     QIOChannel *ioc;
     bool is_writable;
 
-    /*
-     * Maximum amount of data in bytes to transfer during one
-     * rate limiting time window
-     */
-    uint64_t rate_limit_max;
-    /*
-     * Total amount of data in bytes queued for transfer
-     * during this rate limiting time window
-     */
-    uint64_t rate_limit_used;
-
     /* The sum of bytes transferred on the wire */
     uint64_t total_transferred;
 
@@ -303,7 +292,7 @@ void qemu_fflush(QEMUFile *f)
             qemu_file_set_error_obj(f, -EIO, local_error);
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
-            qemu_file_acct_rate_limit(f, size);
+            migration_rate_account(size);
             f->total_transferred += size;
         }
 
@@ -356,7 +345,7 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
         int ret = f->hooks->save_page(f, block_offset,
                                       offset, size, bytes_sent);
         if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-            qemu_file_acct_rate_limit(f, size);
+            migration_rate_account(size);
         }
 
         if (ret != RAM_SAVE_CONTROL_DELAYED &&
@@ -727,43 +716,6 @@ uint64_t qemu_file_transferred(QEMUFile *f)
     return f->total_transferred;
 }
 
-int qemu_file_rate_limit(QEMUFile *f)
-{
-    if (qemu_file_get_error(f)) {
-        return 1;
-    }
-    if (f->rate_limit_max == RATE_LIMIT_MAX) {
-        return 0;
-    }
-    if (f->rate_limit_used > f->rate_limit_max) {
-        return 1;
-    }
-    return 0;
-}
-
-uint64_t qemu_file_get_rate_limit(QEMUFile *f)
-{
-    return f->rate_limit_max;
-}
-
-void qemu_file_set_rate_limit(QEMUFile *f, uint64_t limit)
-{
-    /*
-     * 'limit' is per second.  But we check it each 100 miliseconds.
-     */
-    f->rate_limit_max = limit / XFER_LIMIT_RATIO;
-}
-
-void qemu_file_reset_rate_limit(QEMUFile *f)
-{
-    f->rate_limit_used = 0;
-}
-
-void qemu_file_acct_rate_limit(QEMUFile *f, uint64_t len)
-{
-    f->rate_limit_used += len;
-}
-
 void qemu_put_be16(QEMUFile *f, unsigned int v)
 {
     qemu_put_byte(f, v >> 8);
diff --git a/migration/ram.c b/migration/ram.c
index fd5a8db0f8..a706edecc0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3126,7 +3126,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
         t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
         i = 0;
-        while ((ret = qemu_file_rate_limit(f)) == 0 ||
+        while ((ret = migration_rate_exceeded(f)) == 0 ||
                postcopy_has_request(rs)) {
             int pages;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index c7af9050c2..6b783d9c39 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1345,7 +1345,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
             !(se->ops->has_postcopy && se->ops->has_postcopy(se->opaque))) {
             continue;
         }
-        if (qemu_file_rate_limit(f)) {
+        if (migration_rate_exceeded(f)) {
             return 0;
         }
         trace_savevm_section_start(se->idstr, se->section_id);
-- 
2.40.1


