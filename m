Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630737933DF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 04:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdicX-0000P4-3t; Tue, 05 Sep 2023 22:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1qdicU-0000Ow-Vf
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 22:50:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1qdicR-0002Qz-JK
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 22:50:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_HZ6PdkMwkgAA--.64279S3;
 Wed, 06 Sep 2023 10:50:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c7Y6Pdk8eltAA--.1921S2; 
 Wed, 06 Sep 2023 10:50:00 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, zhaotianrui@loongson.cn
Subject: [PATCH] hw/loongarch: Add virtio-mmio bus support
Date: Wed,  6 Sep 2023 10:50:00 +0800
Message-Id: <20230906025000.3101766-1-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c7Y6Pdk8eltAA--.1921S2
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
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

Add virtio-mmio bus support for LoongArch, so that devices
could be added in the virtio-mmio bus.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 hw/loongarch/Kconfig | 1 +
 hw/loongarch/virt.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 1e7c5b43c5..01ab8ce8e7 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -22,3 +22,4 @@ config LOONGARCH_VIRT
     select DIMM
     select PFLASH_CFI01
     select ACPI_HMAT
+    select VIRTIO_MMIO
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aed..06f4bc3a5e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -560,6 +560,9 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
     fdt_add_rtc_node(lams);
 
+    /* virtio-mmio device */
+    sysbus_create_simple("virtio-mmio", 0x1e200000, qdev_get_gpio_in(pch_pic, 7));
+
     pm_mem = g_new(MemoryRegion, 1);
     memory_region_init_io(pm_mem, NULL, &loongarch_virt_pm_ops,
                           NULL, "loongarch_virt_pm", PM_SIZE);
-- 
2.39.1


