Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34B78D041
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mw-0000jY-Rd; Tue, 29 Aug 2023 19:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IC-0002bt-Qb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I6-0003ZS-Pq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THnLOL021253; Tue, 29 Aug 2023 18:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Fhb57Vsnw9yolR+L7YBCREWXSS5UQDBkOEELlen67TU=;
 b=RYoSqDo+q5pjvQtzWW6MFrxpf5qT34jHbnFsYtU2AN7P6kDAoTFTIz0lxVjipImSVbji
 eMpqWseR82S5Dn5j5OxhQUzMPVxXRLL8Ph5mbnt93FCJlKD8ePzEngzv1eemdrGMM1KJ
 usBfot3k3FuXAnOIMhbjr25SxOS/D9ClUOyg2zMwS4LAcSY4YZ8WSE2+Zz2Z+u1jOOTr
 ugfLS2cNP+05Wj91j8OrYYh4NBd0kt4VHfepamMZeeVBu2XCl4AaGLyI6sEC13luj95t
 2hlWBzVxqIiDtKkzDJlI4NNUqvNzFijsW9MqMK9yIGcUWXpv2b/fqeyCSUzqYp8Ei6zC Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nywk30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:13 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THCEqY024859; Tue, 29 Aug 2023 18:18:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6m8011911;
 Tue, 29 Aug 2023 18:18:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-10; Tue, 29 Aug 2023 18:18:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 09/11] tests/qtest: precopy migration with suspend
Date: Tue, 29 Aug 2023 11:18:04 -0700
Message-Id: <1693333086-392798-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: gfg4ptBhSLM9QqjYoeXGOIh2JOLY7RS4
X-Proofpoint-GUID: gfg4ptBhSLM9QqjYoeXGOIh2JOLY7RS4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Add a test case to verify that the suspended state is handled correctly
during live migration precopy.  The test suspends the src, migrates, then
wakes the dest.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-helpers.c |  3 ++
 tests/qtest/migration-helpers.h |  3 +-
 tests/qtest/migration-test.c    | 73 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b541108..d1fec49 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -31,6 +31,9 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     if (g_str_equal(name, "STOP")) {
         state->stop_seen = true;
         return true;
+    } else if (g_str_equal(name, "SUSPEND")) {
+        state->suspend_seen = true;
+        return true;
     } else if (g_str_equal(name, "RESUME")) {
         state->resume_seen = true;
         return true;
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 59fbb83..bac8699 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -16,7 +16,8 @@
 #include "libqtest.h"
 
 typedef struct QTestMigrationState {
-    bool stop_seen, resume_seen;
+    bool suspend_me;
+    bool stop_seen, suspend_seen, resume_seen;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 32fea73..cc508ef 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -135,7 +135,7 @@ static void init_bootfile(const char *bootpath, void *content, size_t len)
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A.
+ * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
 static void wait_for_serial(const char *side)
 {
@@ -195,6 +195,13 @@ static void wait_for_stop(QTestState *who, QTestMigrationState *state)
     }
 }
 
+static void wait_for_suspend(QTestState *who, QTestMigrationState *state)
+{
+    if (!state->suspend_seen) {
+        qtest_qmp_eventwait(who, "SUSPEND");
+    }
+}
+
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -249,7 +256,7 @@ static void wait_for_migration_pass(QTestState *who)
 {
     uint64_t pass, prev_pass = 0, changes = 0;
 
-    while (changes < 2 && !src_state.stop_seen) {
+    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
         usleep(1000);
         pass = get_migration_pass(who);
         changes += (pass != prev_pass);
@@ -545,7 +552,8 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
     watch_byte = qtest_readb(from, watch_address);
     do {
         usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte);
+    } while (qtest_readb(from, watch_address) == watch_byte &&
+             !src_state.suspend_seen);
 }
 
 
@@ -727,6 +735,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
 
+    src_state.suspend_me = args->suspend_me;
     x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend_me;
 
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -1522,8 +1531,12 @@ static void test_precopy_common(MigrateCommon *args)
          * change anything.
          */
         if (args->result == MIG_TEST_SUCCEED) {
-            qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-            wait_for_stop(from, &src_state);
+            if (src_state.suspend_me) {
+                wait_for_suspend(from, &src_state);
+            } else {
+                qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+                wait_for_stop(from, &src_state);
+            }
             migrate_ensure_converge(from);
         }
     }
@@ -1565,7 +1578,11 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(from);
 
-            wait_for_stop(from, &src_state);
+            if (src_state.suspend_me) {
+                wait_for_suspend(from, &src_state);
+            } else {
+                wait_for_stop(from, &src_state);
+            }
 
         } else {
             wait_for_migration_complete(from);
@@ -1579,10 +1596,16 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
+        /* Always get RESUME first after switchover */
         if (!dst_state.resume_seen) {
             qtest_qmp_eventwait(to, "RESUME");
         }
 
+        if (args->start.suspend_me) {
+            /* wakeup succeeds only if guest is suspended */
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        }
+
         wait_for_serial("dest_serial");
     }
 
@@ -1609,6 +1632,34 @@ static void test_precopy_unix_plain(void)
     test_precopy_common(&args);
 }
 
+static void test_precopy_unix_suspend_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        /*
+         * despite being live, the test is fast because the src
+         * suspends immediately.
+         */
+        .live = true,
+        .start.suspend_me = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_suspend_notlive(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        .start.suspend_me = true,
+    };
+
+    test_precopy_common(&args);
+}
 
 static void test_precopy_unix_dirty_ring(void)
 {
@@ -2765,7 +2816,7 @@ static bool kvm_dirty_ring_supported(void)
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
-    bool has_uffd;
+    bool has_uffd, is_x86;
     const char *arch;
     g_autoptr(GError) err = NULL;
     int ret;
@@ -2782,6 +2833,7 @@ int main(int argc, char **argv)
 
     has_uffd = ufd_version_check();
     arch = qtest_get_arch();
+    is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
     /*
      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
@@ -2812,6 +2864,13 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
+    if (is_x86) {
+        qtest_add_func("/migration/precopy/unix/suspend/live",
+                       test_precopy_unix_suspend_live);
+        qtest_add_func("/migration/precopy/unix/suspend/notlive",
+                       test_precopy_unix_suspend_notlive);
+    }
+
     if (has_uffd) {
         qtest_add_func("/migration/postcopy/plain", test_postcopy);
         qtest_add_func("/migration/postcopy/recovery/plain",
-- 
1.8.3.1


