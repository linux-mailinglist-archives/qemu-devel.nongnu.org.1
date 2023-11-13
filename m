Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FD7EA2F6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bla-0004hk-Uq; Mon, 13 Nov 2023 13:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blK-0003i9-E5
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blI-0003Dd-GH
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:18 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi6U3009376; Mon, 13 Nov 2023 18:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=/cM3iKr/cSM22uum2WCfUzvKvQd2Mv/AU1hHoL7cKT8=;
 b=VWP2+za1EsZuBb8yV0TOhOoODihTGZrOIHqy84wVOi+G2/z2w0EZDGkOhxZFV7O3cDXN
 xEUklDSgZCBFFuIuPFvRbGqTQDPX2P/7205kIPXPRpFbm5s8oiJTDhXFUPblAkeafFKJ
 IQVT+PnWR0WGnUnTq3nvmd/DmJeAbCYUhlV3tl7F7vt56JLP2wYkl0ERE8sLSwO/HzH4
 OQeyC2DGjObQS28fEJ3YsSx1RccoMPCHObb18iqyHRGufXN/0sYat39rFT4gLtKnD4u+
 Ma2XxEPKg2/fpxnsLJAERVovnJugU1grzDely21pFEK66d+jPtFYwc5+EH0ZSyg6CRi4 qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd3fxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:15 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHIktp005210; Mon, 13 Nov 2023 18:34:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2Jm026498;
 Mon, 13 Nov 2023 18:34:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-11; Mon, 13 Nov 2023 18:34:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 10/12] tests/qtest: precopy migration with suspend
Date: Mon, 13 Nov 2023 10:33:58 -0800
Message-Id: <1699900440-207345-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130151
X-Proofpoint-ORIG-GUID: SpisKQNS8s9f3U7UkL4am6X8q-QcXExa
X-Proofpoint-GUID: SpisKQNS8s9f3U7UkL4am6X8q-QcXExa
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Add a test case to verify that the suspended state is handled correctly
during live migration precopy.  The test suspends the src, migrates, then
wakes the dest.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-helpers.c |  3 ++
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-test.c    | 69 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index fd3b94e..37e8e81 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -32,6 +32,9 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
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
index 3d32699..b478549 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -18,6 +18,8 @@
 typedef struct QTestMigrationState {
     bool stop_seen;
     bool resume_seen;
+    bool suspend_seen;
+    bool suspend_me;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bef1430..42706c9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -178,7 +178,7 @@ static void bootfile_delete(void)
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A.
+ * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
 static void wait_for_serial(const char *side)
 {
@@ -245,6 +245,13 @@ static void wait_for_resume(QTestState *who, QTestMigrationState *state)
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
@@ -299,7 +306,7 @@ static void wait_for_migration_pass(QTestState *who)
 {
     uint64_t pass, prev_pass = 0, changes = 0;
 
-    while (changes < 2 && !src_state.stop_seen) {
+    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
         usleep(1000);
         pass = get_migration_pass(who);
         changes += (pass != prev_pass);
@@ -595,7 +602,8 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
     watch_byte = qtest_readb(from, watch_address);
     do {
         usleep(1000 * 10);
-    } while (qtest_readb(from, watch_address) == watch_byte);
+    } while (qtest_readb(from, watch_address) == watch_byte &&
+             !src_state.suspend_seen);
 }
 
 
@@ -771,6 +779,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
+    src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
@@ -1730,8 +1739,12 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1777,6 +1790,9 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(from);
 
+            if (src_state.suspend_me) {
+                wait_for_suspend(from, &src_state);
+            }
             wait_for_stop(from, &src_state);
 
         } else {
@@ -1793,6 +1809,11 @@ static void test_precopy_common(MigrateCommon *args)
 
         wait_for_resume(to, &dst_state);
 
+        if (args->start.suspend_me) {
+            /* wakeup succeeds only if guest is suspended */
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        }
+
         wait_for_serial("dest_serial");
     }
 
@@ -1879,6 +1900,34 @@ static void test_precopy_unix_plain(void)
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
@@ -3277,7 +3326,7 @@ static bool kvm_dirty_ring_supported(void)
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
-    bool has_uffd;
+    bool has_uffd, is_x86;
     const char *arch;
     g_autoptr(GError) err = NULL;
     const char *qemu_src = getenv(QEMU_ENV_SRC);
@@ -3307,6 +3356,7 @@ int main(int argc, char **argv)
 
     has_uffd = ufd_version_check();
     arch = qtest_get_arch();
+    is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
     /*
      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
@@ -3337,6 +3387,13 @@ int main(int argc, char **argv)
 
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


