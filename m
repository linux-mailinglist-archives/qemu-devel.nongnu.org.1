Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C849E807688
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:25:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvd6-00018s-3f; Wed, 06 Dec 2023 12:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvd3-00018i-7f
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:24:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvd0-0003gS-Vb
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:24:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYQcl014591; Wed, 6 Dec 2023 17:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=poJGV6l16x1wEB9PjmRYReQy9aqyUwxSHd5jrD+iWpY=;
 b=lD/V9n439E+bkqf1+CTc7Gg13vxjHJ79d33o3XNLrjaWUSxuYzPXUlLHKnIpHKrdepiP
 8Tw/Rmvs2ydofqiMqMiCaU0fRhRj7V7wGI3Yn+tMEAcPL6xRdlMdI34dl3OWbqZTuxMx
 ho6hC+b+XVSYreRgKu1B3rmU/NojcWwrw9QIrvw9tJlY+8PL0kJeSaXq6Mtq3c8wrfmC
 tMZklFVv+XZPyEENaJXxmtOYSbLeft9vpOBg8Le0LmNh6Ji0tscO+5dyubwaC0lo9b4E
 GqJ/bqc8Z2Ot17UgZ6GVeRBQjHIS2B5RzEtAf/+vuZ9iC1U/KcEfTipSK4vtFpvbWxbW Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc19xqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:24:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6GwOtV037820; Wed, 6 Dec 2023 17:24:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utanc7a9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:24:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HMwka002907;
 Wed, 6 Dec 2023 17:24:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utanc79rv-10; Wed, 06 Dec 2023 17:24:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 09/12] tests/qtest: migration events
Date: Wed,  6 Dec 2023 09:23:34 -0800
Message-Id: <1701883417-356268-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-GUID: -l-ymZQF89YN16qSCms9OSNZ-TzlVVKM
X-Proofpoint-ORIG-GUID: -l-ymZQF89YN16qSCms9OSNZ-TzlVVKM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define a state object to capture events seen by migration tests, to allow
more events to be captured in a subsequent patch, and simplify event
checking in wait_for_migration_pass.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-helpers.c | 24 ++++-------
 tests/qtest/migration-helpers.h |  9 ++--
 tests/qtest/migration-test.c    | 91 +++++++++++++++++++----------------------
 3 files changed, 56 insertions(+), 68 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 24fb7b3..fd3b94e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -24,26 +24,16 @@
  */
 #define MIGRATION_STATUS_WAIT_TIMEOUT 120
 
-bool migrate_watch_for_stop(QTestState *who, const char *name,
-                            QDict *event, void *opaque)
-{
-    bool *seen = opaque;
-
-    if (g_str_equal(name, "STOP")) {
-        *seen = true;
-        return true;
-    }
-
-    return false;
-}
-
-bool migrate_watch_for_resume(QTestState *who, const char *name,
+bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
-    bool *seen = opaque;
+    QTestMigrationState *state = opaque;
 
-    if (g_str_equal(name, "RESUME")) {
-        *seen = true;
+    if (g_str_equal(name, "STOP")) {
+        state->stop_seen = true;
+        return true;
+    } else if (g_str_equal(name, "RESUME")) {
+        state->resume_seen = true;
         return true;
     }
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e31dc85..3d32699 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -15,9 +15,12 @@
 
 #include "libqtest.h"
 
-bool migrate_watch_for_stop(QTestState *who, const char *name,
-                            QDict *event, void *opaque);
-bool migrate_watch_for_resume(QTestState *who, const char *name,
+typedef struct QTestMigrationState {
+    bool stop_seen;
+    bool resume_seen;
+} QTestMigrationState;
+
+bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
 G_GNUC_PRINTF(3, 4)
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0fbaa6a..05c0740 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,8 +43,8 @@
 unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
-static bool got_src_stop;
-static bool got_dst_resume;
+static QTestMigrationState src_state;
+static QTestMigrationState dst_state;
 
 /*
  * An initial 3 MB offset is used as that corresponds
@@ -230,6 +230,20 @@ static void wait_for_serial(const char *side)
     } while (true);
 }
 
+static void wait_for_stop(QTestState *who, QTestMigrationState *state)
+{
+    if (!state->stop_seen) {
+        qtest_qmp_eventwait(who, "STOP");
+    }
+}
+
+static void wait_for_resume(QTestState *who, QTestMigrationState *state)
+{
+    if (!state->resume_seen) {
+        qtest_qmp_eventwait(who, "RESUME");
+    }
+}
+
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -277,21 +291,19 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
+/*
+ * Wait for two changes in the migration pass count, but bail if we stop.
+ */
 static void wait_for_migration_pass(QTestState *who)
 {
-    uint64_t initial_pass = get_migration_pass(who);
-    uint64_t pass;
+    uint64_t pass, prev_pass = 0, changes = 0;
 
-    /* Wait for the 1st sync */
-    while (!got_src_stop && !initial_pass) {
-        usleep(1000);
-        initial_pass = get_migration_pass(who);
-    }
-
-    do {
+    while (changes < 2 && !src_state.stop_seen) {
         usleep(1000);
         pass = get_migration_pass(who);
-    } while (pass == initial_pass && !got_src_stop);
+        changes += (pass != prev_pass);
+        prev_pass = pass;
+    }
 }
 
 static void check_guests_ram(QTestState *who)
@@ -617,10 +629,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
-
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to, "RESUME");
 }
 
@@ -756,8 +765,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    got_src_stop = false;
-    got_dst_resume = false;
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
 
@@ -848,8 +857,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     if (!args->only_target) {
         *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_stop,
-                                     &got_src_stop);
+                                     migrate_watch_for_events,
+                                     &src_state);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
@@ -869,8 +878,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr);
     *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
     qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_resume,
-                                 &got_dst_resume);
+                                 migrate_watch_for_events,
+                                 &dst_state);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -1717,9 +1726,7 @@ static void test_precopy_common(MigrateCommon *args)
          */
         if (args->result == MIG_TEST_SUCCEED) {
             qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-            if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
-            }
+            wait_for_stop(from, &src_state);
             migrate_ensure_converge(from);
         }
     }
@@ -1765,9 +1772,8 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(from);
 
-            if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
-            }
+            wait_for_stop(from, &src_state);
+
         } else {
             wait_for_migration_complete(from);
             /*
@@ -1780,9 +1786,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
-        if (!got_dst_resume) {
-            qtest_qmp_eventwait(to, "RESUME");
-        }
+        wait_for_resume(to, &dst_state);
 
         wait_for_serial("dest_serial");
     }
@@ -1821,9 +1825,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 
     if (stop_src) {
         qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-        if (!got_src_stop) {
-            qtest_qmp_eventwait(from, "STOP");
-        }
+        wait_for_stop(from, &src_state);
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
@@ -1844,10 +1846,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     if (stop_src) {
         qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
     }
-
-    if (!got_dst_resume) {
-        qtest_qmp_eventwait(to, "RESUME");
-    }
+    wait_for_resume(to, &dst_state);
 
     wait_for_serial("dest_serial");
 
@@ -1966,9 +1965,7 @@ static void test_ignore_shared(void)
 
     migrate_wait_for_dirty_mem(from, to);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
 
     qtest_qmp_eventwait(to, "RESUME");
 
@@ -2503,7 +2500,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2842,9 +2839,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_converge(from);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
     wait_for_serial("dest_serial");
@@ -3177,7 +3172,7 @@ static void test_migrate_dirty_limit(void)
         throttle_us_per_full =
         read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     }
 
     /* Now cancel migrate and wait for dirty limit throttle switch off */
@@ -3189,7 +3184,7 @@ static void test_migrate_dirty_limit(void)
         throttle_us_per_full =
         read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     } while (throttle_us_per_full != 0 && --max_try_count);
 
     /* Assert dirty limit is not in service */
@@ -3218,7 +3213,7 @@ static void test_migrate_dirty_limit(void)
         throttle_us_per_full =
         read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
         usleep(100);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     }
 
     /*
-- 
1.8.3.1


