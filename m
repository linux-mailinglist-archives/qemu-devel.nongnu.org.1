Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4623823B6D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQ9-0001Qu-54; Wed, 03 Jan 2024 23:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQ6-0001B1-0F
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQ3-0006dO-QF
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjBpUgwZoxalhlFoV5B9Sv8iXcXP+zznwx/LPMyYugs=;
 b=X8uRKvASBJKtK/9WD5DR4no+yy8ZgqPs426FEzbpUiw4Rs215WeBWAqSvaa7YIpH5dpo0J
 TGob5F+vI3EBPkkQVakNO72sp2jrgOlsEQP0WNr+UROIZwFzsyXsKLJwDBzyxIiV19FEc1
 LEqGW9wfwSoHxPRotJIXyBuSScrryYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-rillOv6rPKenQuCdMGtCCg-1; Wed, 03 Jan 2024 23:33:19 -0500
X-MC-Unique: rillOv6rPKenQuCdMGtCCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AFCB848C02;
 Thu,  4 Jan 2024 04:33:19 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4618FC15968;
 Thu,  4 Jan 2024 04:33:14 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 12/26] tests/qtest: option to suspend during migration
Date: Thu,  4 Jan 2024 12:31:57 +0800
Message-ID: <20240104043213.431566-13-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Add an option to suspend the src in a-b-bootblock.S, which puts the guest
in S3 state after one round of writing to memory.  The option is enabled by
poking a 1 into the suspend_me word in the boot block prior to starting the
src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
offset is known.  Generate the bootblock for each test, because suspend_me
may differ for each.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1704312341-66640-11-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/migration/i386/a-b-bootblock.h | 26 ++++++++++-----
 tests/qtest/migration-test.c         | 12 +++++--
 tests/migration/i386/Makefile        |  5 +--
 tests/migration/i386/a-b-bootblock.S | 50 ++++++++++++++++++++++++++--
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
index 5b523917ce..c83f8711db 100644
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
index 41fc837f36..2e2ab6af3c 100644
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
 
@@ -2980,7 +2985,9 @@ static int64_t get_limit_rate(QTestState *who)
 static QTestState *dirtylimit_start_vm(void)
 {
     QTestState *vm = NULL;
-    g_autofree gchar *
+    g_autofree gchar *cmd = NULL;
+
+    bootfile_create(tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
@@ -3329,7 +3336,6 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
-    bootfile_create(tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
diff --git a/tests/migration/i386/Makefile b/tests/migration/i386/Makefile
index 5c0324134a..37a72ae353 100644
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
index 6bb9999d60..6f39eb6051 100644
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
-- 
2.41.0


