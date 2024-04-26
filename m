Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E348B342E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Apr 2024 11:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HyL-00012W-UT; Fri, 26 Apr 2024 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s0HyI-0000oY-JR
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:34:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s0HyF-0001lA-HF
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:34:22 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx9erAdCtmGWYDAA--.2469S3;
 Fri, 26 Apr 2024 17:32:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxU1a2dCtm+yUGAA--.2929S17; 
 Fri, 26 Apr 2024 17:32:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org,
	maobibo@loongson.cn
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 zltjiangshi@gmail.com
Subject: [PATCH v7 15/17] hw/loongarch: fdt remove unused irqchip node
Date: Fri, 26 Apr 2024 17:15:49 +0800
Message-Id: <20240426091551.2397867-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240426091551.2397867-1-gaosong@loongson.cn>
References: <20240426091551.2397867-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxU1a2dCtm+yUGAA--.2929S17
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240307164835.300412-16-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 91a55a81b6..48f73edd8e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -446,34 +446,6 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams,
     g_free(nodename);
 }
 
-static void fdt_add_irqchip_node(LoongArchMachineState *lams)
-{
-    MachineState *ms = MACHINE(lams);
-    char *nodename;
-    uint32_t irqchip_phandle;
-
-    irqchip_phandle = qemu_fdt_alloc_phandle(ms->fdt);
-    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", irqchip_phandle);
-
-    nodename = g_strdup_printf("/intc@%lx", VIRT_IOAPIC_REG_BASE);
-    qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
-
-    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
-                            "loongarch,ls7a");
-
-    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
-                                 2, VIRT_IOAPIC_REG_BASE,
-                                 2, PCH_PIC_ROUTE_ENTRY_OFFSET);
-
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", irqchip_phandle);
-    g_free(nodename);
-}
-
 static void fdt_add_memory_node(MachineState *ms,
                                 uint64_t base, uint64_t size, int node_id)
 {
@@ -1011,8 +983,7 @@ static void loongarch_init(MachineState *machine)
 
     /* Initialize the IO interrupt subsystem */
     loongarch_irq_init(lams);
-    fdt_add_irqchip_node(lams);
-    platform_bus_add_all_fdt_nodes(machine->fdt, "/intc",
+    platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
                                    VIRT_PLATFORM_BUS_BASEADDRESS,
                                    VIRT_PLATFORM_BUS_SIZE,
                                    VIRT_PLATFORM_BUS_IRQ);
-- 
2.25.1


