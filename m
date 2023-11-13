Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DF7EA2F7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:35:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blT-00044K-7T; Mon, 13 Nov 2023 13:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blJ-0003eT-5K
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blH-0003DM-15
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:16 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi833014693; Mon, 13 Nov 2023 18:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=VEw4l2n/qMxCe4Y3cSBF4NJl/Wm6hbFg2yBLXddzCx4=;
 b=vBiix1SsC/teskwb3svIUNcxkSsMTLe257KThdnXTzySnAvKU2JmzUJBU4g8td+s/OPW
 n6eNP0MG1QHzfGPULEhXL27wryPCTskhtHRckfuyW04Lpav7JHQTz2nfYzf1KLNpY1SG
 7pcpXRsDNWzSyc7boPypHiA5K9iq4vQeO1zNFsFx8mKvrsmnpE486spjgVQb8RSsppdl
 hrBGNBx+ISKNpPCRrHQiurGxWKIQGf1p07xWq85L8109mp+mlS5qzD+I8aAX9lw6WmRP
 WwEKLfbJ8ikI2Qfki+GcW35TnrR1l1bw776Z5otRiDtTYrc9c6OhRCx/rtIv3s0VRHby yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjkgm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:14 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADH96dw005299; Mon, 13 Nov 2023 18:34:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2Jk026498;
 Mon, 13 Nov 2023 18:34:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-10; Mon, 13 Nov 2023 18:34:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 09/12] tests/qtest: option to suspend during migration
Date: Mon, 13 Nov 2023 10:33:57 -0800
Message-Id: <1699900440-207345-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: fNJvduA1gDLHMqyLFDZyaacIX3uwT3rO
X-Proofpoint-ORIG-GUID: fNJvduA1gDLHMqyLFDZyaacIX3uwT3rO
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

Add an option to suspend the src in a-b-bootblock.S, which puts the guest
in S3 state after one round of writing to memory.  The option is enabled by
poking a 1 into the suspend_me word in the boot block prior to starting the
src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
offset is known.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 tests/migration/i386/Makefile        |  5 ++--
 tests/migration/i386/a-b-bootblock.S | 50 +++++++++++++++++++++++++++++++++---
 tests/migration/i386/a-b-bootblock.h | 26 +++++++++++++------
 tests/qtest/migration-test.c         |  8 ++++--
 4 files changed, 74 insertions(+), 15 deletions(-)

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
index 6bb9999..6f39eb6 100644
--- a/tests/migration/i386/a-b-bootblock.S
+++ b/tests/migration/i386/a-b-bootblock.S
@@ -9,6 +9,23 @@
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
+
+/* Save the suspended status at an address that is not written in the loop. */
+#define suspended           (X86_TEST_MEM_START + 4)
 
 .code16
 .org 0x7c00
@@ -35,8 +52,8 @@ start:             # at 0x7c00 ?
         mov %eax,%ds
 
 # Start from 1MB
-.set TEST_MEM_START, (1024*1024)
-.set TEST_MEM_END, (100*1024*1024)
+.set TEST_MEM_START, X86_TEST_MEM_START
+.set TEST_MEM_END, X86_TEST_MEM_END
 
         mov $65,%ax
         mov $0x3f8,%dx
@@ -69,7 +86,30 @@ innerloop:
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
@@ -95,6 +135,10 @@ gdtdesc:
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
index 5b52391..c83f871 100644
--- a/tests/migration/i386/a-b-bootblock.h
+++ b/tests/migration/i386/a-b-bootblock.h
@@ -4,7 +4,7 @@
  * the header and the assembler differences in your patch submission.
  */
 unsigned char x86_bootsect[] = {
-  0xfa, 0x0f, 0x01, 0x16, 0x8c, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
+  0xfa, 0x0f, 0x01, 0x16, 0xb8, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
   0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
   0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
@@ -13,13 +13,13 @@ unsigned char x86_bootsect[] = {
   0x40, 0x06, 0x7c, 0xf1, 0xb8, 0x00, 0x00, 0x10, 0x00, 0xfe, 0x00, 0x05,
   0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40, 0x06, 0x7c, 0xf2, 0xfe,
   0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8, 0x42, 0x00, 0x66, 0xba,
-  0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
-  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x74, 0x7c,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0xf8, 0x03, 0xee, 0xa1, 0xbe, 0x7c, 0x00, 0x00, 0x83, 0xf8, 0x00, 0x74,
+  0xd3, 0xb8, 0x04, 0x00, 0x10, 0x00, 0x8b, 0x00, 0x83, 0xf8, 0x01, 0x74,
+  0xc7, 0xb0, 0xf1, 0xe6, 0xb2, 0xb8, 0x04, 0x00, 0x10, 0x00, 0xc7, 0x00,
+  0x01, 0x00, 0x00, 0x00, 0x66, 0xb8, 0x01, 0x24, 0x66, 0xba, 0x04, 0x06,
+  0x66, 0xef, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00,
+  0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0xa0, 0x7c, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -49,3 +49,13 @@ unsigned char x86_bootsect[] = {
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
 };
 
+#define SYM_do_zero 0x00007c3d
+#define SYM_gdt 0x00007ca0
+#define SYM_gdtdesc 0x00007cb8
+#define SYM_innerloop 0x00007c51
+#define SYM_mainloop 0x00007c4c
+#define SYM_pre_zero 0x00007c38
+#define SYM_start 0x00007c00
+#define SYM_suspend_me 0x00007cbe
+#define SYM_TEST_MEM_END 0x06400000
+#define SYM_TEST_MEM_START 0x00100000
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 59fbbef..bef1430 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -133,7 +133,7 @@ static char *bootpath;
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
-static void bootfile_create(char *dir)
+static void bootfile_create(char *dir, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
@@ -143,6 +143,7 @@ static void bootfile_create(char *dir)
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
         g_assert(sizeof(x86_bootsect) == 512);
+        x86_bootsect[SYM_suspend_me - SYM_start] = suspend_me;
         content = x86_bootsect;
         len = sizeof(x86_bootsect);
     } else if (g_str_equal(arch, "s390x")) {
@@ -646,6 +647,8 @@ typedef struct {
     bool use_dirty_ring;
     const char *opts_source;
     const char *opts_target;
+    /* suspend the src before migrating to dest. */
+    bool suspend_me;
 } MigrateStart;
 
 /*
@@ -767,6 +770,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
+    bootfile_create(tmpfs, args->suspend_me);
+
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
 
@@ -3329,7 +3334,6 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
-    bootfile_create(tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
-- 
1.8.3.1


