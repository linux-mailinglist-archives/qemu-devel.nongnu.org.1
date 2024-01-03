Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B088F82362F
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7YR-0002sx-P1; Wed, 03 Jan 2024 15:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7YO-0002q9-Lf
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:09:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7YM-00030z-LH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:09:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JXXkI006835; Wed, 3 Jan 2024 20:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=WOx16+Qz+oIai3FaefU+mhmYaviyvUmdvn/+rSLkfkU=;
 b=WNpZHN8IYv4+ikM76mfUkzE9ClUQ8o2OPr1k+1b9oh6Qc+BzOZUKHVf3bmugL6/rX6zS
 PRFwp5luBehnF/2vlYj7kj743LUFttXlLIf3R7kEOSie5qnZ+rHWnjwie6q3NYXg6vU2
 gWvZrth4CKEY8vRxy1LQQXkM8HmyBMduaKCK8d2VdF/sU0WPNEIKzkXofiBfTJW/mu1N
 8EOny4KGIdhwORkdYGrZ/eMWkDEw6vIv1mzAXtlCJM0RsHSTemmw4MFoYwzFi76Bd+S6
 SN0CRhMsVElz5EEiX3FjvIPDgCPubFKMg0gMvZZBaw1WFwDZBxU0Jel1u38EhFB1DTWj MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vabrv5s8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:55 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K22g9013704; Wed, 3 Jan 2024 20:05:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZx020511;
 Wed, 3 Jan 2024 20:05:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-12; Wed, 03 Jan 2024 20:05:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 11/12] tests/qtest: precopy migration with suspend
Date: Wed,  3 Jan 2024 12:05:40 -0800
Message-Id: <1704312341-66640-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-ORIG-GUID: Y-6Pr8GkJaXmMlnF4m9x9UgLH130Lh9j
X-Proofpoint-GUID: Y-6Pr8GkJaXmMlnF4m9x9UgLH130Lh9j
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c |  3 ++
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-test.c    | 62 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 3 deletions(-)

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
index 2e2ab6a..a3bfbf2 100644
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
+    if (state->suspend_me && !state->suspend_seen) {
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
@@ -584,6 +591,12 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
         usleep(1000 * 10);
     } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
 
+
+    /* If suspended, src only iterates once, and watch_byte may never change */
+    if (src_state.suspend_me) {
+        return;
+    }
+
     /*
      * Now ensure that already transferred bytes are
      * dirty again from the guest workload. Note the
@@ -771,6 +784,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
+    src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
@@ -1717,6 +1731,7 @@ static void test_precopy_common(MigrateCommon *args)
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
         wait_for_serial("src_serial");
+        wait_for_suspend(from, &src_state);
     }
 
     if (args->live) {
@@ -1793,6 +1808,11 @@ static void test_precopy_common(MigrateCommon *args)
 
         wait_for_resume(to, &dst_state);
 
+        if (args->start.suspend_me) {
+            /* wakeup succeeds only if guest is suspended */
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+        }
+
         wait_for_serial("dest_serial");
     }
 
@@ -1879,6 +1899,34 @@ static void test_precopy_unix_plain(void)
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
@@ -3279,7 +3327,7 @@ static bool kvm_dirty_ring_supported(void)
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
-    bool has_uffd;
+    bool has_uffd, is_x86;
     const char *arch;
     g_autoptr(GError) err = NULL;
     const char *qemu_src = getenv(QEMU_ENV_SRC);
@@ -3309,6 +3357,7 @@ int main(int argc, char **argv)
 
     has_uffd = ufd_version_check();
     arch = qtest_get_arch();
+    is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
     /*
      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
@@ -3339,6 +3388,13 @@ int main(int argc, char **argv)
 
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


