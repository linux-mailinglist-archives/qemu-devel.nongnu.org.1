Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41198318B4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:50:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQts-0000lp-2j; Thu, 18 Jan 2024 06:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQti-0000XT-6Y
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:49:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQtc-00065M-TL
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:49:23 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxefDKD6llkZ4BAA--.8247S3;
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs3HD6llrW8IAA--.40089S13; 
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [RESEND PATCH v4 11/17] hw/loongarch: fdt adds Extend I/O Interrupt
 Controller
Date: Thu, 18 Jan 2024 19:31:17 +0800
Message-Id: <20240118113123.1672939-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240118113123.1672939-1-gaosong@loongson.cn>
References: <20240118113123.1672939-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs3HD6llrW8IAA--.40089S13
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

fdt adds Extend I/O Interrupt Controller,
we use 'loongson,ls2k2000-eiointc'.

See:
https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongson-eiointc.c
https://lore.kernel.org/r/764e02d924094580ac0f1d15535f4b98308705c6.1683279769.git.zhoubinbin@loongson.cn

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231227080821.3216113-12-gaosong@loongson.cn>
---
 include/hw/intc/loongarch_extioi.h |  1 +
 hw/loongarch/virt.c                | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index a0a46b888c..410c6e1121 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -39,6 +39,7 @@
 #define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
 #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
+#define EXTIOI_SIZE                  0x800
 
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 123db98464..8a7a0b7432 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -100,6 +100,31 @@ static void fdt_add_cpuic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
+static void fdt_add_eiointc_node(LoongArchMachineState *lams,
+                                  uint32_t *cpuintc_phandle,
+                                  uint32_t *eiointc_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
+    hwaddr extioi_base = APIC_BASE;
+    hwaddr extioi_size = EXTIOI_SIZE;
+
+    *eiointc_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/eiointc@%" PRIx64, extioi_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", *eiointc_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,ls2k2000-eiointc");
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *cpuintc_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupts", 3);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0,
+                           extioi_base, 0x0, extioi_size);
+    g_free(nodename);
+}
+
 static void fdt_add_flash_node(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -510,7 +535,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle;
+    uint32_t cpuintc_phandle, eiointc_phandle;
 
     /*
      * The connection of interrupts:
@@ -579,6 +604,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
         }
     }
 
+    /* Add Extend I/O Interrupt Controller node */
+    fdt_add_eiointc_node(lams, &cpuintc_phandle, &eiointc_phandle);
+
     pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
-- 
2.25.1


