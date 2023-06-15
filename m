Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1867320EA
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9tYT-0002A7-Vm; Thu, 15 Jun 2023 16:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYP-00027c-SE
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYM-0002Fn-MQ
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35FGJfcQ020981; Thu, 15 Jun 2023 20:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=pdIUyk8OyGwST4QXti/10NUfq0iXMjgoI3tXLydT1bE=;
 b=MgVfhH8SvO7qqfiHX01yzOSZ3P9zGKAwXG386+lM3CCVVVSN54dT4VEwX9ZVAQLPaPzG
 /dF69uwBY1bjRiI81uWksd7fw/fY3Piwp7Qghl6K7NbzxhYhP0V0Pv1EHXxzYPquvfMZ
 0/IzSsJRMY+p0A2zN/hmhtLcE+XWbw53FkEvXrKc5H3gXpFj8R/A2+5h0FgMOTrjtVuT
 mGmR+JXOx904YWPu5SEQJa0RITzkIUAFUw94unV+Txs4fhgabusFDC37A96qkPRVM25C
 oh/VZ8UvwNgy6ugU5JjzseLBcl4vzWA9BpiGM+jZYkZ+wyGayn56D0rkMGK7KAEixZ9E yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqutye9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35FKFYMo038942; Thu, 15 Jun 2023 20:26:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm75mp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FKQeqA003391;
 Thu, 15 Jun 2023 20:26:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r4fm75mmg-4; Thu, 15 Jun 2023 20:26:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 3/3] tests/qtest: live migration suspended state
Date: Thu, 15 Jun 2023 13:26:40 -0700
Message-Id: <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_16,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150176
X-Proofpoint-ORIG-GUID: IA6FiuZrJH1pAsxkr8rGStusXhPj0SC0
X-Proofpoint-GUID: IA6FiuZrJH1pAsxkr8rGStusXhPj0SC0
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

Add a test case to verify that the suspended state is handled correctly in
live migration.  The test suspends the src, migrates, then wakes the dest.

Add an option to suspend the src in a-b-bootblock.S, which puts the guest
in S3 state after one round of writing to memory.  The option is enabled by
poking a 1 into the suspend_me word in the boot block prior to starting the
src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
offset is known.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/migration/i386/Makefile        |  5 ++--
 tests/migration/i386/a-b-bootblock.S | 49 +++++++++++++++++++++++++++++++++---
 tests/migration/i386/a-b-bootblock.h | 22 ++++++++++------
 tests/qtest/migration-helpers.c      |  2 +-
 tests/qtest/migration-test.c         | 31 +++++++++++++++++++++--
 5 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/tests/migration/i386/Makefile b/tests/migration/i386/Makefile
index 5c03241..37a72ae 100644
--- a/tests/migration/i386/Makefile
+++ b/tests/migration/i386/Makefile
@@ -4,9 +4,10 @@
 .PHONY: all clean
 all: a-b-bootblock.h
 
-a-b-bootblock.h: x86.bootsect
+a-b-bootblock.h: x86.bootsect x86.o
 	echo "$$__note" > header.tmp
 	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
+	nm x86.o | awk '{print "#define SYM_"$$3" 0x"$$1}' >> header.tmp
 	mv header.tmp $@
 
 x86.bootsect: x86.boot
@@ -16,7 +17,7 @@ x86.boot: x86.o
 	$(CROSS_PREFIX)objcopy -O binary $< $@
 
 x86.o: a-b-bootblock.S
-	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
+	$(CROSS_PREFIX)gcc -I.. -m32 -march=i486 -c $< -o $@
 
 clean:
 	@rm -rf *.boot *.o *.bootsect
diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
index 3d464c7..63d446f 100644
--- a/tests/migration/i386/a-b-bootblock.S
+++ b/tests/migration/i386/a-b-bootblock.S
@@ -9,6 +9,21 @@
 #
 # Author: dgilbert@redhat.com
 
+#include "migration-test.h"
+
+#define ACPI_ENABLE         0xf1
+#define ACPI_PORT_SMI_CMD   0xb2
+#define ACPI_PM_BASE        0x600
+#define PM1A_CNT_OFFSET     4
+
+#define ACPI_SCI_ENABLE     0x0001
+#define ACPI_SLEEP_TYPE     0x0400
+#define ACPI_SLEEP_ENABLE   0x2000
+#define SLEEP (ACPI_SCI_ENABLE + ACPI_SLEEP_TYPE + ACPI_SLEEP_ENABLE)
+
+#define LOW_ADDR            X86_TEST_MEM_START
+#define HIGH_ADDR           X86_TEST_MEM_END
+#define suspended           HIGH_ADDR
 
 .code16
 .org 0x7c00
@@ -41,12 +56,11 @@ start:             # at 0x7c00 ?
         # bl keeps a counter so we limit the output speed
         mov $0, %bl
 mainloop:
-        # Start from 1MB
-        mov $(1024*1024),%eax
+        mov $LOW_ADDR,%eax
 innerloop:
         incb (%eax)
         add $4096,%eax
-        cmp $(100*1024*1024),%eax
+        cmp $HIGH_ADDR,%eax
         jl innerloop
 
         inc %bl
@@ -57,7 +71,30 @@ innerloop:
         mov $0x3f8,%dx
         outb %al,%dx
 
-        jmp mainloop
+        # should this test suspend?
+        mov (suspend_me),%eax
+        cmp $0,%eax
+        je mainloop
+
+        # are we waking after suspend?  do not suspend again.
+        mov $suspended,%eax
+        mov (%eax),%eax
+        cmp $1,%eax
+        je mainloop
+
+        # enable acpi
+        mov $ACPI_ENABLE,%al
+        outb %al,$ACPI_PORT_SMI_CMD
+
+        # suspend to ram
+        mov $suspended,%eax
+        movl $1,(%eax)
+        mov $SLEEP,%ax
+        mov $(ACPI_PM_BASE + PM1A_CNT_OFFSET),%dx
+        outw %ax,%dx
+        # not reached.  The wakeup causes reset and restart at 0x7c00, and we
+        # do not save and restore registers as a real kernel would do.
+
 
         # GDT magic from old (GPLv2)  Grub startup.S
         .p2align        2       /* force 4-byte alignment */
@@ -83,6 +120,10 @@ gdtdesc:
         .word   0x27                    /* limit */
         .long   gdt                     /* addr */
 
+        /* test launcher can poke a 1 here to exercise suspend */
+suspend_me:
+        .int  0
+
 /* I'm a bootable disk */
 .org 0x7dfe
         .byte 0x55
diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
index b7b0fce..b39773f 100644
--- a/tests/migration/i386/a-b-bootblock.h
+++ b/tests/migration/i386/a-b-bootblock.h
@@ -4,20 +4,20 @@
  * the header and the assembler differences in your patch submission.
  */
 unsigned char x86_bootsect[] = {
-  0xfa, 0x0f, 0x01, 0x16, 0x78, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
+  0xfa, 0x0f, 0x01, 0x16, 0xa4, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
   0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
   0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
   0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
   0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
   0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8,
-  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
-  0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00,
-  0x27, 0x00, 0x60, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xa1, 0xaa, 0x7c, 0x00, 0x00,
+  0x83, 0xf8, 0x00, 0x74, 0xd3, 0xb8, 0x00, 0x00, 0x40, 0x06, 0x8b, 0x00,
+  0x83, 0xf8, 0x01, 0x74, 0xc7, 0xb0, 0xf1, 0xe6, 0xb2, 0xb8, 0x00, 0x00,
+  0x40, 0x06, 0xc7, 0x00, 0x01, 0x00, 0x00, 0x00, 0x66, 0xb8, 0x01, 0x24,
+  0x66, 0xba, 0x04, 0x06, 0x66, 0xef, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
+  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x8c, 0x7c,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -49,3 +49,9 @@ unsigned char x86_bootsect[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
 };
 
+#define SYM_gdt 0x00007c8c
+#define SYM_gdtdesc 0x00007ca4
+#define SYM_innerloop 0x00007c3d
+#define SYM_mainloop 0x00007c38
+#define SYM_start 0x00007c00
+#define SYM_suspend_me 0x00007caa
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index be00c52..433d678 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -28,7 +28,7 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
 {
     bool *seen = opaque;
 
-    if (g_str_equal(name, "STOP")) {
+    if (g_str_equal(name, "STOP") || g_str_equal(name, "SUSPEND")) {
         *seen = true;
         return true;
     }
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355b..73b07b3 100644
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
@@ -507,6 +507,8 @@ typedef struct {
     bool use_dirty_ring;
     const char *opts_source;
     const char *opts_target;
+    /* suspend the src before migrating to dest. */
+    bool suspend;
 } MigrateStart;
 
 /*
@@ -617,6 +619,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
+    x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend;
+
     got_src_stop = false;
     got_dst_resume = false;
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -1475,7 +1479,13 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(to);
 
-            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            if (!args->start.suspend) {
+                qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            }
+        }
+
+        if (args->start.suspend) {
+            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
         }
 
         if (!got_dst_resume) {
@@ -1508,6 +1518,18 @@ static void test_precopy_unix_plain(void)
     test_precopy_common(&args);
 }
 
+static void test_precopy_unix_suspend(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+        .live = true,
+        .start.suspend = true,
+    };
+
+    test_precopy_common(&args);
+}
 
 static void test_precopy_unix_dirty_ring(void)
 {
@@ -2682,6 +2704,11 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("/migration/precopy/unix/suspend",
+                       test_precopy_unix_suspend);
+    }
+
     if (has_uffd) {
         qtest_add_func("/migration/postcopy/plain", test_postcopy);
         qtest_add_func("/migration/postcopy/recovery/plain",
-- 
1.8.3.1


