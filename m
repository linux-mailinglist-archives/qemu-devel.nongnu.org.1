Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5B8318B3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 12:50:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQQsI-0005OP-Aq; Thu, 18 Jan 2024 06:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rQQs9-0005F6-9r
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rQQrz-0004n2-KU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 06:47:49 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuvDKD6llj54BAA--.8008S3;
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXs3HD6llrW8IAA--.40089S12; 
 Thu, 18 Jan 2024 19:47:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [RESEND PATCH v4 10/17] hw/loongarch: fdt adds cpu interrupt
 controller node
Date: Thu, 18 Jan 2024 19:31:16 +0800
Message-Id: <20240118113123.1672939-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240118113123.1672939-1-gaosong@loongson.cn>
References: <20240118113123.1672939-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXs3HD6llrW8IAA--.40089S12
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

fdt adds cpu interrupt controller node,
we use 'loongson,cpu-interrupt-controller'.

See:
https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongarch-cpu.c
https://lore.kernel.org/r/20221114113824.1880-2-liupeibao@loongson.cn

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231227080821.3216113-11-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 129cad92e5..123db98464 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -81,7 +81,23 @@ static void virt_flash_map(LoongArchMachineState *lams,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+}
+
+static void fdt_add_cpuic_node(LoongArchMachineState *lams,
+                               uint32_t *cpuintc_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
 
+    *cpuintc_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/cpuic");
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", *cpuintc_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,cpu-interrupt-controller");
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
+    g_free(nodename);
 }
 
 static void fdt_add_flash_node(LoongArchMachineState *lams)
@@ -494,6 +510,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
+    uint32_t cpuintc_phandle;
 
     /*
      * The connection of interrupts:
@@ -528,6 +545,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     memory_region_add_subregion(&lams->system_iocsr, MAIL_SEND_ADDR,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
+    /* Add cpu interrupt-controller */
+    fdt_add_cpuic_node(lams, &cpuintc_phandle);
+
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
-- 
2.25.1


