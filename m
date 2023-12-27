Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A381ED3D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 09:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPAY-0006L6-JU; Wed, 27 Dec 2023 03:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rIPAU-0006KL-1Z
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rIPAR-0002JW-4Z
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:21:33 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVPB93otlPfcEAA--.23722S3;
 Wed, 27 Dec 2023 16:21:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxib153otly4QMAA--.16227S6; 
 Wed, 27 Dec 2023 16:21:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v3 04/17] hw/loongarch: Add init_cmdline
Date: Wed, 27 Dec 2023 16:08:08 +0800
Message-Id: <20231227080821.3216113-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231227080821.3216113-1-gaosong@loongson.cn>
References: <20231227080821.3216113-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxib153otly4QMAA--.16227S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Add init_cmline and set boot_info->a0, a1

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c    | 20 ++++++++++++++++++++
 target/loongarch/cpu.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index faff880153..27eae6f0cb 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -13,6 +13,7 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
+#include <asm-generic/setup.h>
 
 static unsigned int slave_boot_code[] = {
                   /* Configure reset ebase.         */
@@ -62,6 +63,16 @@ static unsigned int slave_boot_code[] = {
     0x4c000020,   /* jirl       $r0,$r1,0           */
 };
 
+static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
+{
+    hwaddr cmdline_addr = (hwaddr)p - (hwaddr)start;
+
+    info->a0 = 1;
+    info->a1 = cmdline_addr;
+
+    memcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
+}
+
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -121,6 +132,10 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
+	if (cpu == LOONGARCH_CPU(first_cpu)) {
+            env->gpr[4] = env->boot_info->a0;
+            env->gpr[5] = env->boot_info->a1;
+        }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
 }
@@ -160,8 +175,13 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
 
 static void init_boot_rom(struct loongarch_boot_info *info, void *p)
 {
+    void *start = p;
+
     memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
     p += sizeof(slave_boot_code);
+
+    init_cmdline(info, p, start);
+    p += COMMAND_LINE_SIZE;
 }
 
 static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 00d1fba597..c7c695138e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -362,6 +362,8 @@ typedef struct CPUArchState {
     uint64_t elf_address;
     /* Store ipistate to access from this struct */
     DeviceState *ipistate;
+
+    struct loongarch_boot_info *boot_info;
 #endif
 } CPULoongArchState;
 
-- 
2.25.1


