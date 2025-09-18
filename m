Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBBB4126F
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 04:37:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdM3-0007ma-1W; Tue, 02 Sep 2025 22:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utdLz-0007m2-I4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utdLw-0001sj-EY
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:07 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx77+OqbdoGA0GAA--.11367S3;
 Wed, 03 Sep 2025 10:35:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8ONqbdo7k96AA--.57635S4;
 Wed, 03 Sep 2025 10:35:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] hw/loongarch/virt: Remove unnecessay pre-boot setting
 with BSP
Date: Wed,  3 Sep 2025 10:35:55 +0800
Message-Id: <20250903023556.3082693-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250903023556.3082693-1-maobibo@loongson.cn>
References: <20250903023556.3082693-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8ONqbdo7k96AA--.57635S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

With BSP core, it boots from aux boot code and loads data into register
A0-A2 and PC. Pre-boot setting is not unnecessary and can be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/boot.c    | 22 ----------------------
 target/loongarch/cpu.h |  4 ----
 2 files changed, 26 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 4962668e5a..5799b4c75c 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -353,17 +353,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
 static void reset_load_elf(void *opaque)
 {
     LoongArchCPU *cpu = opaque;
-    CPULoongArchState *env = &cpu->env;
 
     cpu_reset(CPU(cpu));
-    if (env->load_elf) {
-        if (cpu == LOONGARCH_CPU(first_cpu)) {
-            env->gpr[4] = env->boot_info->a0;
-            env->gpr[5] = env->boot_info->a1;
-            env->gpr[6] = env->boot_info->a2;
-        }
-        cpu_set_pc(CPU(cpu), env->elf_address);
-    }
 }
 
 static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
@@ -415,8 +406,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
 {
     void *p, *bp;
     int64_t kernel_addr = VIRT_FLASH0_BASE;
-    LoongArchCPU *lacpu;
-    CPUState *cs;
     uint64_t *data;
 
     if (info->kernel_filename) {
@@ -443,17 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     *(data - 1) = cpu_to_le64(kernel_addr);
     rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
 
-    CPU_FOREACH(cs) {
-        lacpu = LOONGARCH_CPU(cs);
-        lacpu->env.load_elf = true;
-        if (cs == first_cpu) {
-            lacpu->env.elf_address = kernel_addr;
-        } else {
-            lacpu->env.elf_address = VIRT_FLASH0_BASE;
-        }
-        lacpu->env.boot_info = info;
-    }
-
     g_free(boot_code);
     g_free(bp);
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9538e8d61d..7648f94584 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -387,11 +387,7 @@ typedef struct CPUArchState {
 #endif
 
     AddressSpace *address_space_iocsr;
-    bool load_elf;
-    uint64_t elf_address;
     uint32_t mp_state;
-
-    struct loongarch_boot_info *boot_info;
 #endif
 } CPULoongArchState;
 
-- 
2.39.3


