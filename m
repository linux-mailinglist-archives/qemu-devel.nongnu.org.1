Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1A809F02
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWvq-00011u-IH; Fri, 08 Dec 2023 04:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rBWve-00010X-6D
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rBWva-0008Ej-W0
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:13:49 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRvFD3nJlqOw_AA--.62334S3;
 Fri, 08 Dec 2023 17:13:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH91A3nJlrE5YAA--.822S5; 
 Fri, 08 Dec 2023 17:13:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v1 03/17] hw/loongarch: Add init_cmdline
Date: Fri,  8 Dec 2023 17:00:28 +0800
Message-Id: <20231208090042.2672425-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231208090042.2672425-1-gaosong@loongson.cn>
References: <20231208090042.2672425-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH91A3nJlrE5YAA--.822S5
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
 hw/loongarch/boot.c         | 21 +++++++++++++++++++++
 include/hw/loongarch/virt.h |  2 ++
 target/loongarch/cpu.h      |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 40796d97bd..b3fbed2ea0 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -14,6 +14,20 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 
+static int init_cmdline(struct loongarch_boot_info *info)
+{
+    hwaddr cmdline_addr;
+    cmdline_addr = 0xff00000ULL;
+
+    pstrcpy_targphys("cmdline", 0xff00000ULL,
+                     COMMAND_LINE_SIZE, info->kernel_cmdline);
+
+    info->a0 = 1;
+    info->a1 = cmdline_addr;
+
+    return 0;
+}
+
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -60,6 +74,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
         }
     }
 
+    init_cmdline(info);
+
     return kernel_entry;
 }
 
@@ -70,6 +86,10 @@ static void reset_load_elf(void *opaque)
 
     cpu_reset(CPU(cpu));
     if (env->load_elf) {
+	if (cpu == LOONGARCH_CPU(first_cpu)) {
+            env->gpr[4] = env->boot_info->a0;
+            env->gpr[5] = env->boot_info->a1;
+        }
         cpu_set_pc(CPU(cpu), env->elf_address);
     }
 }
@@ -121,6 +141,7 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
             lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
             lacpu->env.load_elf = true;
             lacpu->env.elf_address = kernel_addr;
+            lacpu->env.boot_info = info;
         }
     }
 }
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index e4126dd0e7..d21de2cef4 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -31,6 +31,8 @@
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
 
+#define COMMAND_LINE_SIZE       512
+
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
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


