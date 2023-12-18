Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D9816995
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:16:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF9hh-00014o-Ue; Mon, 18 Dec 2023 04:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rF9hf-00011m-Ae
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rF9hc-0007X9-7N
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:14:23 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx9OpeDYBlRP4BAA--.6179S3;
 Mon, 18 Dec 2023 17:14:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxXeFRDYBlVfMJAA--.47541S15; 
 Mon, 18 Dec 2023 17:14:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org,
 maobibo@loongson.cn
Subject: [PATCH v2 13/17] hw/loongarch: fdt adds pch_msi Controller
Date: Mon, 18 Dec 2023 17:00:55 +0800
Message-Id: <20231218090059.2678224-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218090059.2678224-1-gaosong@loongson.cn>
References: <20231218090059.2678224-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXeFRDYBlVfMJAA--.47541S15
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

fdt adds pch msi controller, we use 'loongson,pch-msi-1.0'.

See:
  drivers/irqchip/irq-loongson-pch-msi.c
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c        | 33 ++++++++++++++++++++++++++++++++-
 include/hw/pci-host/ls7a.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 166e3f1892..859f17c2f6 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -150,6 +150,34 @@ static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
+static void fdt_add_pch_msi_node(LoongArchMachineState *lams,
+                                 uint32_t *extioic_phandle,
+                                 uint32_t *pch_msi_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
+    hwaddr pch_msi_base = VIRT_PCH_MSI_ADDR_LOW;
+    hwaddr pch_msi_size = VIRT_PCH_MSI_SIZE;
+
+    *pch_msi_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/msi@%" PRIx64, pch_msi_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", *pch_msi_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,pch-msi-1.0");
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg",
+                           0, pch_msi_base,
+                           0, pch_msi_size);
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *extioic_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,msi-base-vec",
+                          VIRT_PCH_PIC_IRQ_NUM);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,msi-num-vecs",
+                          EXTIOI_IRQS - VIRT_PCH_PIC_IRQ_NUM);
+    g_free(nodename);
+}
+
 static void fdt_add_flash_node(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -560,7 +588,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle, extioiic_phandle, pch_pic_phandle;
+    uint32_t cpuintc_phandle, extioiic_phandle, pch_pic_phandle, pch_msi_phandle;
 
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
@@ -671,6 +699,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
                               qdev_get_gpio_in(extioi, i + start));
     }
 
+    /* Add PCH MSI node */
+    fdt_add_pch_msi_node(lams, &extioiic_phandle, &pch_msi_phandle);
+
     loongarch_devices_init(pch_pic, lams);
 }
 
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index fe260f0183..cd7c9ec7bc 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -25,6 +25,7 @@
 #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
 #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
 #define VIRT_PCH_REG_SIZE        0x400
+#define VIRT_PCH_MSI_SIZE        0x8
 
 /*
  * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
-- 
2.25.1


