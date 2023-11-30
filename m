Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC377FFDB0
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:39:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ojM-0001yP-9j; Thu, 30 Nov 2023 16:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8ojF-0001sO-LJ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8ojD-0000qq-SB
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULYZo9012082; Thu, 30 Nov 2023 21:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=w6xDiiACgtheRyyQpm9PrHPpJqcbFfKgR+PLMoF/aF0=;
 b=l8jFtjylaDmPzK8Ww0fsOWqDFkE/jcn518rY5M67xr01/8vkbZvZ3gAHNWrPnmy4hcf5
 xHduTPKM0D2ssU/Izt7h/XKdIqevhMvp2wEXFgTiAjXnu/GmemWvqtHzcEy3pV4kZQrB
 JmLWsrYjmn/Xy9fvnxBu7Tc82PQStUu8j0YSU9I6MjXvyMuH3EGadoxR/YllG70tvWr0
 75ZbjODDyE+8jTwgUsjQdFLYqTRwPTPKbq/T+U8YalwXS0XGRvmpiumuC2boMoAQ7hfC
 8En8128hoJj1oY2ldaHy4c5j3ZXOf5BlqeWiBF/J/GxK/W6Py69Ju5Be0i3sB7FOBXPf vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq1xnr2v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:46 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AUL0J8A012729; Thu, 30 Nov 2023 21:37:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTgN016589;
 Thu, 30 Nov 2023 21:37:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-14; Thu, 30 Nov 2023 21:37:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 13/14] tests/qtest: bootfile per vm
Date: Thu, 30 Nov 2023 13:37:26 -0800
Message-Id: <1701380247-340457-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_21,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300158
X-Proofpoint-ORIG-GUID: MoZPV-T57-9XPc9o4OqOjIg56v5vFCBV
X-Proofpoint-GUID: MoZPV-T57-9XPc9o4OqOjIg56v5vFCBV
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

Create a separate bootfile for the outgoing and incoming vm, so the block
layer can lock the file during the background migration test.  Otherwise,
the test fails with:
  "Failed to get "write" lock.  Is another process using the image
   [/tmp/migration-test-WAKPD2/bootsect]?"

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-test.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index af661f8..e16710f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -124,7 +124,8 @@ static bool ufd_version_check(void)
 #endif
 
 static char *tmpfs;
-static char *bootpath;
+static char *src_bootpath;
+static char *dst_bootpath;
 
 /* The boot file modifies memory area in [start_address, end_address)
  * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
@@ -133,13 +134,13 @@ static char *bootpath;
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
-static void bootfile_create(char *dir, bool suspend_me)
+static char *bootfile_create(char *dir, const char *prefix, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
     size_t len;
+    char *bootpath = g_strdup_printf("%s/%s-bootsect", dir, prefix);
 
-    bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
         g_assert(sizeof(x86_bootsect) == 512);
@@ -153,7 +154,7 @@ static void bootfile_create(char *dir, bool suspend_me)
         /*
          * sane architectures can be programmed at the boot prompt
          */
-        return;
+        return NULL;
     } else if (strcmp(arch, "aarch64") == 0) {
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
@@ -166,13 +167,15 @@ static void bootfile_create(char *dir, bool suspend_me)
 
     g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
     fclose(bootfile);
+    return bootpath;
 }
 
-static void bootfile_delete(void)
+static void bootfile_delete(char *bootpath)
 {
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
+    if (bootpath) {
+        unlink(bootpath);
+        g_free(bootpath);
+    }
 }
 
 /*
@@ -766,6 +769,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
+    const char *arch_boot_fmt = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
@@ -781,7 +785,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
-    bootfile_create(tmpfs, args->suspend_me);
+    src_bootpath = bootfile_create(tmpfs, "src", args->suspend_me);
+    dst_bootpath = bootfile_create(tmpfs, "dst", args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
@@ -792,15 +797,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         } else {
             machine_alias = "q35";
         }
-        arch_opts = g_strdup_printf(
-            "-drive if=none,id=d0,file=%s,format=raw "
-            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
+        arch_boot_fmt = "-drive if=none,id=d0,file=%s,format=raw "
+                        "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1";
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         memory_size = "128M";
         machine_alias = "s390-ccw-virtio";
-        arch_opts = g_strdup_printf("-bios %s", bootpath);
+        arch_boot_fmt = "-bios %s";
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
@@ -818,13 +822,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         memory_size = "150M";
         machine_alias = "virt";
         machine_opts = "gic-version=max";
-        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
+        arch_boot_fmt = "-cpu max -kernel %s";
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
 
+    if (arch_boot_fmt) {
+        arch_source = g_strdup_printf(arch_boot_fmt, src_bootpath);
+        arch_target = g_strdup_printf(arch_boot_fmt, dst_bootpath);
+    }
+
     if (!getenv("QTEST_LOG") && args->hide_stderr) {
 #ifndef _WIN32
         ignore_stderr = "2>/dev/null";
@@ -3052,13 +3061,13 @@ static QTestState *dirtylimit_start_vm(void)
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
 
-    bootfile_create(tmpfs, false);
+    src_bootpath = bootfile_create(tmpfs, "src", false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
                           "-serial file:%s/vm_serial "
                           "-drive file=%s,format=raw ",
-                          tmpfs, bootpath);
+                          tmpfs, src_bootpath);
 
     vm = qtest_init(cmd);
     return vm;
@@ -3589,7 +3598,8 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
-    bootfile_delete();
+    bootfile_delete(src_bootpath);
+    bootfile_delete(dst_bootpath);
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s",
-- 
1.8.3.1


