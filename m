Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBD743D14
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEbU-0000ph-Sz; Fri, 30 Jun 2023 09:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVd-0006EH-GL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVY-00072d-Is
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBObqT015254; Fri, 30 Jun 2023 13:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=CfYn9J9SIM5jiVbuDHtoXznIzpS36Sj+pvO4Hi3j8rQ=;
 b=3T36PBDX8UWrq0sxTJwnnM4XZ8GKzcRHMrWW11/EXy14t72tKLrzFo8M3cE9+73EoSNI
 j/tMHAIOgssvXhNuUlZNB8GxwMrz69PoJq/5EO2y6j6ObSZGZLU5gMQQf4ztbG+paGsS
 19cXgNSn/3TZE1CHK6qLZ8DjIKpNR9EHemp7JokcHJUQeQz2DDIVRDwN+BcWIpqYFBlD
 lTLJwfiUcmx0J7IIT1/FW6BIrpILP+0h2KxPZI81g/Kamow4KLyVLZ+u4InLFLrEG/FF
 JN4sbTjnHjoEu8s4dRFNcOrCB8pK6y018ey3/eS6QZdsQfyzqoma4PdZVOn5rkjD7bMk Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcagh0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UCLvTT008607; Fri, 30 Jun 2023 13:49:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMr039660;
 Fri, 30 Jun 2023 13:49:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-7; Fri, 30 Jun 2023 13:49:52 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 06/10] tests/qtest: migration events
Date: Fri, 30 Jun 2023 06:49:44 -0700
Message-Id: <1688132988-314397-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300118
X-Proofpoint-ORIG-GUID: DhpzVHH3ijjjAEhwupYt57twt7JWX7P3
X-Proofpoint-GUID: DhpzVHH3ijjjAEhwupYt57twt7JWX7P3
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
index b0c355b..2dde3af 100644
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
  * Dirtylimit stop working if dirty page rate error
@@ -174,6 +174,13 @@ static void wait_for_serial(const char *side)
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
@@ -221,21 +228,19 @@ static void read_blocktime(QTestState *who)
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
@@ -487,10 +492,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
-
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to, "RESUME");
 }
 
@@ -617,8 +619,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
@@ -705,8 +708,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     if (!args->only_target) {
         *from = qtest_init(cmd_source);
         qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_stop,
-                                     &got_src_stop);
+                                     migrate_watch_for_events,
+                                     &src_state);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
@@ -725,8 +728,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr);
     *to = qtest_init(cmd_target);
     qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_resume,
-                                 &got_dst_resume);
+                                 migrate_watch_for_events,
+                                 &dst_state);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -1422,9 +1425,7 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1463,9 +1464,8 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1478,7 +1478,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
-        if (!got_dst_resume) {
+        if (!dst_state.resume_seen) {
             qtest_qmp_eventwait(to, "RESUME");
         }
 
@@ -1596,9 +1596,7 @@ static void test_ignore_shared(void)
 
     wait_for_migration_pass(from);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
 
     qtest_qmp_eventwait(to, "RESUME");
 
@@ -2012,7 +2010,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2351,9 +2349,7 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_migration_pass(from);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
     wait_for_serial("dest_serial");
-- 
1.8.3.1


