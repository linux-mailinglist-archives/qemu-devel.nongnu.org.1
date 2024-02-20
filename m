Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E929885BC6A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 13:43:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPRR-0003BR-Oa; Tue, 20 Feb 2024 07:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rcPRO-0003AC-RQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rcPRH-0000DT-Dc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:41:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxdfH5ndRlRD8PAA--.40156S3;
 Tue, 20 Feb 2024 20:41:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxPs_3ndRl5MM8AA--.25558S7; 
 Tue, 20 Feb 2024 20:41:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/5] tests: Add migration test for loongarch64
Date: Tue, 20 Feb 2024 20:41:26 +0800
Message-Id: <20240220124126.1164081-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220124126.1164081-1-maobibo@loongson.cn>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPs_3ndRl5MM8AA--.25558S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar1ftFW8ZF13uF1DKFyfAFc_yoWxAFyDpw
 18Cw1Ikan7GF17t3WfWryj9F1fAw1xCr1aga97Jr40yrZYyFy8Aw1Ygry2qFn3X3yjgF4S
 vwn5tr17K3WDAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds migration test support for loongarch64. The test code
comes from aarch64 mostly, only that it it booted as bios in qemu since
kernel requires elf format and bios uses binary format.

In addition to providing the binary, this patch also includes the source
code and the build script in tests/migration/loongarch64. So users can
change the source and/or re-compile the binary as they wish.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/migration/Makefile                 |  2 +-
 tests/migration/loongarch64/Makefile     | 18 ++++++++++
 tests/migration/loongarch64/a-b-kernel.S | 46 ++++++++++++++++++++++++
 tests/migration/loongarch64/a-b-kernel.h | 13 +++++++
 tests/migration/migration-test.h         |  3 ++
 tests/qtest/meson.build                  |  4 +++
 tests/qtest/migration-test.c             | 10 ++++++
 7 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tests/migration/loongarch64/Makefile
 create mode 100644 tests/migration/loongarch64/a-b-kernel.S
 create mode 100644 tests/migration/loongarch64/a-b-kernel.h

diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 13e99b1692..cfebfe23f8 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x
+TARGET_LIST = i386 aarch64 s390x loongarch64
 
 SRC_PATH = ../..
 
diff --git a/tests/migration/loongarch64/Makefile b/tests/migration/loongarch64/Makefile
new file mode 100644
index 0000000000..5d8719205f
--- /dev/null
+++ b/tests/migration/loongarch64/Makefile
@@ -0,0 +1,18 @@
+# To specify cross compiler prefix, use CROSS_PREFIX=
+#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
+
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: loongarch64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+loongarch64.kernel: loongarch64.elf
+	$(CROSS_PREFIX)objcopy -j .text -O binary $< $@
+
+loongarch64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/migration/loongarch64/a-b-kernel.S b/tests/migration/loongarch64/a-b-kernel.S
new file mode 100644
index 0000000000..078f91b306
--- /dev/null
+++ b/tests/migration/loongarch64/a-b-kernel.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024 Loongson Technology Corporation Limited
+ */
+#include "../migration-test.h"
+
+#define LOONGARCH_CSR_CRMD          0
+#define LOONGARCH_VIRT_UART         0x1FE001E0
+.section .text
+
+        .globl  _start
+_start:
+        /* output char 'A' to UART16550 */
+        li.d    $t0, LOONGARCH_VIRT_UART
+        li.w    $t1, 'A'
+        st.b    $t1, $t0, 0
+
+        /* traverse test memory region */
+	li.d    $t0, LOONGARCH_TEST_MEM_START
+        li.d    $t1, LOONGARCH_TEST_MEM_END
+        li.d    $t2, TEST_MEM_PAGE_SIZE
+
+clean:
+        st.b    $zero, $t0, 0
+        add.d   $t0,   $t0, $t2
+        bne     $t0,   $t1, clean
+
+mainloop:
+        li.d    $t0, LOONGARCH_TEST_MEM_START
+        li.d    $t1, LOONGARCH_TEST_MEM_END
+        li.d    $t2, TEST_MEM_PAGE_SIZE
+
+        li.d    $t4, LOONGARCH_VIRT_UART
+        li.w    $t5, 'B'
+
+innerloop:
+        ld.bu   $t3, $t0, 0
+        addi.w  $t3, $t3, 1
+        ext.w.b $t3, $t3
+        st.b    $t3, $t0, 0
+        add.d   $t0, $t0, $t2
+        bne     $t0, $t1, innerloop
+
+        st.b    $t5, $t4, 0
+        b       mainloop
+        nop
diff --git a/tests/migration/loongarch64/a-b-kernel.h b/tests/migration/loongarch64/a-b-kernel.h
new file mode 100644
index 0000000000..6019450229
--- /dev/null
+++ b/tests/migration/loongarch64/a-b-kernel.h
@@ -0,0 +1,13 @@
+
+unsigned char loongarch64_kernel[] = {
+  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
+  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x01, 0x14, 0x0d, 0x80, 0x0c, 0x14,
+  0x2e, 0x00, 0x00, 0x14, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
+  0x8d, 0xf9, 0xff, 0x5f, 0x0c, 0x00, 0x01, 0x14, 0x0d, 0x80, 0x0c, 0x14,
+  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
+  0x11, 0x08, 0x81, 0x03, 0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02,
+  0xef, 0x5d, 0x00, 0x00, 0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
+  0x8d, 0xed, 0xff, 0x5f, 0x11, 0x02, 0x00, 0x29, 0xff, 0xcf, 0xff, 0x53,
+  0x00, 0x00, 0x40, 0x03
+};
+
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index 68512c0b1b..b6e9914f9c 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -32,4 +32,7 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
+/* LoongArch64 */
+#define LOONGARCH_TEST_MEM_START (8 * 1024 * 1024)
+#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
 #endif /* MIGRATION_TEST_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b89e8634b..b634587b0a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,6 +249,10 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+qtests_loongarch64 = \
+  qtests_filter + \
+  ['migration-test']
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..8a25edfa77 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -132,6 +132,7 @@ static char *bootpath;
 #include "tests/migration/i386/a-b-bootblock.h"
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
+#include "tests/migration/loongarch64/a-b-kernel.h"
 
 static void bootfile_create(char *dir, bool suspend_me)
 {
@@ -158,6 +159,9 @@ static void bootfile_create(char *dir, bool suspend_me)
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
         g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        content = loongarch64_kernel;
+        len = sizeof(loongarch64_kernel);
     } else {
         g_assert_not_reached();
     }
@@ -823,6 +827,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
+    } else if (strcmp(arch, "loongarch64") == 0) {
+        memory_size = "256M";
+        machine_alias = "virt";
+        arch_opts = g_strdup_printf("-cpu max -bios %s", bootpath);
+        start_address = LOONGARCH_TEST_MEM_START;
+        end_address = LOONGARCH_TEST_MEM_END;
     } else {
         g_assert_not_reached();
     }
-- 
2.39.3


