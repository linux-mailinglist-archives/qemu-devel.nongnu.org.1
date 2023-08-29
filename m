Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1347478D034
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mu-0000hY-2F; Tue, 29 Aug 2023 19:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IC-0002bj-Lp
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I6-0003Xv-50
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THio7C022974; Tue, 29 Aug 2023 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=1vdErBTqswJKCGBgKcN3iU5n5MlIwhPZ2NAoPmPdHEE=;
 b=ivjfSvvM2hfa8vl9OIqw37nerFf/VFF+0PR16KFV3eq3k2NumVp7IKgaBQc7CF2Kj6WO
 WRBiEGUJffglywhMlNQY1rJFEb8KCWDT/qAZ2VBtq9d3VG4yrow38W3Jjr7RTq7MFIKA
 RnjlUlXw1WmAAWQsXvSNUNBJChq7ur0lceu3T1dhWmtbiED8N/F6x0n7k3+LQgUSoG5p
 UB/aO4JOBGXI7F328tU2dM/khOmFByPujvIXczl+TYiRGFbYUj68ZNYWbb4UvMbzTGm9
 JY7hCPb5yDzleFY0B22Sc7v7+URLyeO3t7ySoAmaHqSG9WdFK770oxDcbxgqjAij7VUX 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k65qpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:12 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THC5h4024776; Tue, 29 Aug 2023 18:18:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6m4011911;
 Tue, 29 Aug 2023 18:18:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-8; Tue, 29 Aug 2023 18:18:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 07/11] tests/qtest: migration events
Date: Tue, 29 Aug 2023 11:18:02 -0700
Message-Id: <1693333086-392798-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-GUID: IJsnKrVwbBg8FLFwevjpVw9mAnjUWGWA
X-Proofpoint-ORIG-GUID: IJsnKrVwbBg8FLFwevjpVw9mAnjUWGWA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define a state object to capture events seen by migration tests, to allow
more events to be captured in a subsequent patch, and simplify event
checking in wait_for_migration_pass.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 24 +++++----------
 tests/qtest/migration-helpers.h |  8 +++--
 tests/qtest/migration-test.c    | 68 +++++++++++++++++++----------------------
 3 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index be00c52..b541108 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -23,26 +23,16 @@
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
index 009e250..59fbb83 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -15,9 +15,11 @@
 
 #include "libqtest.h"
 
-bool migrate_watch_for_stop(QTestState *who, const char *name,
-                            QDict *event, void *opaque);
-bool migrate_watch_for_resume(QTestState *who, const char *name,
+typedef struct QTestMigrationState {
+    bool stop_seen, resume_seen;
+} QTestMigrationState;
+
+bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
 G_GNUC_PRINTF(3, 4)
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37..526a1b7 100644
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
@@ -188,6 +188,13 @@ static void wait_for_serial(const char *side)
     } while (true);
 }
 
+static void wait_for_stop(QTestState *who, QTestMigrationState *state)
+{
+    if (!state->stop_seen) {
+        qtest_qmp_eventwait(who, "STOP");
+    }
+}
+
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -235,21 +242,19 @@ static void read_blocktime(QTestState *who)
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
@@ -586,10 +591,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
-
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to, "RESUME");
 }
 
@@ -720,8 +722,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    got_src_stop = false;
-    got_dst_resume = false;
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
+
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -801,8 +804,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     if (!args->only_target) {
         *from = qtest_init(cmd_source);
         qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_stop,
-                                     &got_src_stop);
+                                     migrate_watch_for_events,
+                                     &src_state);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
@@ -821,8 +824,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr);
     *to = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_resume,
-                                 &got_dst_resume);
+                                 migrate_watch_for_events,
+                                 &dst_state);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -1516,9 +1519,7 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1560,9 +1561,8 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1575,7 +1575,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
-        if (!got_dst_resume) {
+        if (!dst_state.resume_seen) {
             qtest_qmp_eventwait(to, "RESUME");
         }
 
@@ -1696,9 +1696,7 @@ static void test_ignore_shared(void)
 
     migrate_wait_for_dirty_mem(from, to);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
 
     qtest_qmp_eventwait(to, "RESUME");
 
@@ -2139,7 +2137,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2481,9 +2479,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_converge(from);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
     wait_for_serial("dest_serial");
-- 
1.8.3.1


