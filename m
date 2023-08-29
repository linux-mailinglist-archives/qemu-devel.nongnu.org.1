Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4F78D05A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mx-0000kB-HI; Tue, 29 Aug 2023 19:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IC-0002by-RY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I6-0003YY-57
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THinQ5007100; Tue, 29 Aug 2023 18:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=UNxLun2DOapVva8NGN0SFSfM2/dSJ1uh5JMJ64QcNFo=;
 b=BwrdQbQmyUu1W9hDE19XvfLdKsIiQ+EbdxWcqJJzWL7VzxlvOl6nwIde4+C21uxIj7F+
 UXua/mFXVEprmK6NcpkGfD9d2LxtUiwDpWhf/c6Gg1CB7TIkaXq1SpxLvNCEgV0lFyJK
 aqZHoCfNo8zidyuBrhB4P4eJTFbed+HAGgUhXvGck/3Yn4Zhw8bboYHSCcdtDVnWdPFK
 +rq3a1ZKL9xhTK2P5Z7K2f33KoqTX0rpzIPSHfltg2EVD7BrY6ddEtpIfJpS/OIryzHP
 oCEWYAL+Lr+XXkyJV8geEXuxe+04yomzT5hwOQmb5NFsu8lYLv6PYrKc6YxmQddUtXB4 YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcnprw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:12 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THEWLS024792; Tue, 29 Aug 2023 18:18:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6m6011911;
 Tue, 29 Aug 2023 18:18:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-9; Tue, 29 Aug 2023 18:18:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 08/11] tests/qtest: option to suspend during migration
Date: Tue, 29 Aug 2023 11:18:03 -0700
Message-Id: <1693333086-392798-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: yK492flz7xITd9QxQ-yN63LNzp9oPGfT
X-Proofpoint-GUID: yK492flz7xITd9QxQ-yN63LNzp9oPGfT
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

Add an option to suspend the src in a-b-bootblock.S, which puts the guest
in S3 state after one round of writing to memory.  The option is enabled by
poking a 1 into the suspend_me word in the boot block prior to starting the
src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
offset is known.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/migration/i386/Makefile        |  5 ++--
 tests/migration/i386/a-b-bootblock.S | 51 +++++++++++++++++++++++++++++++++---
 tests/migration/i386/a-b-bootblock.h | 22 ++++++++++------
 tests/qtest/migration-test.c         |  4 +++
 4 files changed, 68 insertions(+), 14 deletions(-)

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
index 3d464c7..62d79b2 100644
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
@@ -41,12 +58,11 @@ start:             # at 0x7c00 ?
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
@@ -57,7 +73,30 @@ innerloop:
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
@@ -83,6 +122,10 @@ gdtdesc:
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
index b7b0fce..4d46873 100644
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
+  0x83, 0xf8, 0x00, 0x74, 0xd3, 0xb8, 0x04, 0x00, 0x10, 0x00, 0x8b, 0x00,
+  0x83, 0xf8, 0x01, 0x74, 0xc7, 0xb0, 0xf1, 0xe6, 0xb2, 0xb8, 0x04, 0x00,
+  0x10, 0x00, 0xc7, 0x00, 0x01, 0x00, 0x00, 0x00, 0x66, 0xb8, 0x01, 0x24,
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
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 526a1b7..32fea73 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -608,6 +608,8 @@ typedef struct {
     bool use_dirty_ring;
     const char *opts_source;
     const char *opts_target;
+    /* suspend the src before migrating to dest. */
+    bool suspend_me;
 } MigrateStart;
 
 /*
@@ -725,6 +727,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
 
+    x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend_me;
+
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
-- 
1.8.3.1


