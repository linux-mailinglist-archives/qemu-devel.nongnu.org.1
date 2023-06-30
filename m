Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF4D743D04
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEWg-0006Zh-AT; Fri, 30 Jun 2023 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVa-0006DY-UK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVX-000738-N1
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOXQV027207; Fri, 30 Jun 2023 13:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=tweEnLDtXK94QGA4kzpJPKTEHGh30plKeG+vCx+uh4g=;
 b=Mb83Ex8ObifMDxoSg5SvPclbOTWEYPJ/NRv7Si1S0M3qXqfiRpHIq7qKF37Ikgqf0YFT
 ruiemyucrvvJ+4rYRi9PEb9T/AGhgoArwY0WzlgSjoHnqJ7pjbLtCRQ035QOOYURPfnc
 fj3tEMaw1EJFhC6dg7YVdJ6mOVRAchRgXzkvfFa/AcBMLrBO2s9gZrvRhSapLcuw7IZ7
 WWwOLKuv3P+v4VhWlWZn/DTRLYv72Or8JBSkyyGpoElfVv5efcmTrc2Z1/MnS4rhHC+a
 Eqw1S1+yeNpKbSegdDRqAtLi2IPNkriUHB2C5dCriAPJYaOmhgBgmJCd+eL8v0v2A7Zc Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ef0bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:54 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UCl6LQ008768; Fri, 30 Jun 2023 13:49:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMv039660;
 Fri, 30 Jun 2023 13:49:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-9; Fri, 30 Jun 2023 13:49:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 08/10] tests/qtest: precopy migration with suspend
Date: Fri, 30 Jun 2023 06:49:46 -0700
Message-Id: <1688132988-314397-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 3vtNqw5Qqg6koKUEQetl4k8Y2ksZGXv3
X-Proofpoint-ORIG-GUID: 3vtNqw5Qqg6koKUEQetl4k8Y2ksZGXv3
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
 tests/qtest/migration-helpers.h |  3 +-
 tests/qtest/migration-test.c    | 69 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 7 deletions(-)

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
index 591103e..20f017d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -121,7 +121,7 @@ static void init_bootfile(const char *bootpath, void *content, size_t len)
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
- * but on the destination we won't have the A.
+ * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
 static void wait_for_serial(const char *side)
 {
@@ -181,6 +181,13 @@ static void wait_for_stop(QTestState *who, QTestMigrationState *state)
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
@@ -235,7 +242,7 @@ static void wait_for_migration_pass(QTestState *who)
 {
     uint64_t pass, prev_pass = 0, changes = 0;
 
-    while (changes < 2 && !src_state.stop_seen) {
+    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
         usleep(1000);
         pass = get_migration_pass(who);
         changes += (pass != prev_pass);
@@ -624,6 +631,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
 
+    src_state.suspend_me = args->suspend_me;
     x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend_me;
 
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -1428,8 +1436,12 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1468,7 +1480,11 @@ static void test_precopy_common(MigrateCommon *args)
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
@@ -1482,6 +1498,11 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
+        if (args->start.suspend_me) {
+            /* wakeup succeeds only if guest is suspended */
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        }
+
         if (!dst_state.resume_seen) {
             qtest_qmp_eventwait(to, "RESUME");
         }
@@ -1512,6 +1533,34 @@ static void test_precopy_unix_plain(void)
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
@@ -2635,7 +2684,7 @@ static bool kvm_dirty_ring_supported(void)
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
-    bool has_uffd;
+    bool has_uffd, is_x86;
     const char *arch;
     g_autoptr(GError) err = NULL;
     int ret;
@@ -2652,6 +2701,7 @@ int main(int argc, char **argv)
 
     has_uffd = ufd_version_check();
     arch = qtest_get_arch();
+    is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
     /*
      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
@@ -2682,6 +2732,13 @@ int main(int argc, char **argv)
 
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


