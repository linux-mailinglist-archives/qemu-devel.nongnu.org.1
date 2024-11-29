Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC479DB162
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 03:11:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGTzK-0005kH-No; Wed, 27 Nov 2024 21:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tGTzG-0005j8-Op
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 21:10:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tGTzC-0006vE-0f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 21:10:33 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa8S0UdnIVRKAA--.14883S3;
 Thu, 28 Nov 2024 10:10:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxNMAQ0UdnfNJqAA--.46399S6;
 Thu, 28 Nov 2024 10:10:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/intc/loongarch_ipi: Implment cpu hotplug interface
Date: Thu, 28 Nov 2024 10:10:23 +0800
Message-Id: <20241128021024.662057-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241128021024.662057-1-maobibo@loongson.cn>
References: <20241128021024.662057-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxNMAQ0UdnfNJqAA--.46399S6
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add logic cpu allocation and cpu mapping with cpu hotplug interface.
When cpu is added, connect ipi gpio irq to CPU IRQ_IPI irq pin.

Also use hotplug_handler_plug() to nofity ipi object when cold-plug
is created.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 46 +++++++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c     |  5 ++---
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 9296006cf6..579c9c830b 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -65,25 +65,71 @@ static int loongarch_cpu_by_arch_id(LoongsonIPICommonState *lics,
 static void loongarch_cpu_plug(HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp)
 {
+    LoongarchIPIState *lis = LOONGARCH_IPI(hotplug_dev);
     Object *obj = OBJECT(dev);
+    LoongArchCPU *cpu;
+    int phy_id, index;
 
     if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
         warn_report("LoongArch IPI: Invalid %s device type",
                                        object_get_typename(obj));
         return;
     }
+
+    cpu = LOONGARCH_CPU(dev);
+    phy_id = cpu->phy_id;
+    if ((phy_id >= MAX_PHY_ID) || (phy_id < 0)) {
+        warn_report("LoongArch IPI: Invalid phy id %d", phy_id);
+        return;
+    }
+
+    if (lis->present_cpu[phy_id] >= 0) {
+        warn_report("LoongArch IPI: phy id %d is added already", phy_id);
+        return;
+    }
+
+    index = find_first_zero_bit(lis->present_cpu_map, LOONGARCH_MAX_CPUS);
+    if (index == LOONGARCH_MAX_CPUS) {
+        error_setg(errp, "no free cpu slots available");
+        return;
+    }
+
+    /* connect ipi irq to cpu irq */
+    set_bit(index, lis->present_cpu_map);
+    lis->present_cpu[phy_id] = index;
+    lis->cs[phy_id] = CPU(dev);
+    qdev_connect_gpio_out(DEVICE(lis), index, qdev_get_gpio_in(dev, IRQ_IPI));
 }
 
 static void loongarch_cpu_unplug(HotplugHandler *hotplug_dev,
                                  DeviceState *dev, Error **errp)
 {
+    LoongarchIPIState *lis = LOONGARCH_IPI(hotplug_dev);
     Object *obj = OBJECT(dev);
+    LoongArchCPU *cpu;
+    int phy_id;
 
     if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
         warn_report("LoongArch IPI: Invalid %s device type",
                                        object_get_typename(obj));
         return;
     }
+
+    cpu = LOONGARCH_CPU(dev);
+    phy_id = cpu->phy_id;
+    if ((phy_id >= MAX_PHY_ID) || (phy_id < 0)) {
+        warn_report("LoongArch IPI: Invalid phy id %d", phy_id);
+        return;
+    }
+
+    if (lis->present_cpu[phy_id] < 0) {
+        warn_report("LoongArch IPI: phy id %d is not added", phy_id);
+        return;
+    }
+
+    clear_bit(lis->present_cpu[phy_id], lis->present_cpu_map);
+    lis->present_cpu[phy_id] = INVALID_CPU;
+    lis->cs[phy_id] = NULL;
 }
 
 static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9a635d1d3d..8147897cc7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -794,6 +794,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
     uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
+    Error *local_err = NULL;
 
     /*
      * Extended IRQ model.
@@ -859,9 +860,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         lacpu = LOONGARCH_CPU(cpu_state);
         env = &(lacpu->env);
         env->address_space_iocsr = &lvms->as_iocsr;
-
-        /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
+        hotplug_handler_plug(HOTPLUG_HANDLER(ipi), cpudev, &local_err);
         env->ipistate = ipi;
     }
 
-- 
2.39.3


