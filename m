Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0127C7FE0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDNC-0004U2-6d; Fri, 13 Oct 2023 04:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qrDN2-0003cK-4S
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qrDMx-0003T8-IA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx7+s1_Shl96QxAA--.29020S3;
 Fri, 13 Oct 2023 16:17:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNwt_ShlyKIiAA--.7352S8; 
 Fri, 13 Oct 2023 16:17:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/7] hw/loongarch/virt: Remove unused 'loongarch_virt_pm' region
Date: Fri, 13 Oct 2023 16:17:49 +0800
Message-Id: <20231013081750.2944412-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231013081750.2944412-1-gaosong@loongson.cn>
References: <20231013081750.2944412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxbNwt_ShlyKIiAA--.7352S8
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

The system test shutdown uses the 'loongarch_virt_pm' region.
We can use the write AcpiFadtData.sleep_clt register to realize the shutdown.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20231012072351.1409344-1-gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c                 | 48 +----------------------------
 tests/tcg/loongarch64/system/boot.S |  7 +++--
 2 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c1791f80dd..2952fe452e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -308,10 +308,6 @@ static void fdt_add_memory_node(MachineState *ms,
     g_free(nodename);
 }
 
-#define PM_BASE 0x10080000
-#define PM_SIZE 0x100
-#define PM_CTRL 0x10
-
 static void virt_build_smbios(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -380,44 +376,6 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
     memmap_entries++;
 }
 
-/*
- * This is a placeholder for missing ACPI,
- * and will eventually be replaced.
- */
-static uint64_t loongarch_virt_pm_read(void *opaque, hwaddr addr, unsigned size)
-{
-    return 0;
-}
-
-static void loongarch_virt_pm_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
-{
-    if (addr != PM_CTRL) {
-        return;
-    }
-
-    switch (val) {
-    case 0x00:
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        return;
-    case 0xff:
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        return;
-    default:
-        return;
-    }
-}
-
-static const MemoryRegionOps loongarch_virt_pm_ops = {
-    .read  = loongarch_virt_pm_read,
-    .write = loongarch_virt_pm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 1
-    }
-};
-
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
@@ -500,7 +458,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
     SysBusDevice *d;
     PCIBus *pci_bus;
     MemoryRegion *ecam_alias, *ecam_reg, *pio_alias, *pio_reg;
-    MemoryRegion *mmio_alias, *mmio_reg, *pm_mem;
+    MemoryRegion *mmio_alias, *mmio_reg;
     int i;
 
     gpex_dev = qdev_new(TYPE_GPEX_HOST);
@@ -560,10 +518,6 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
     fdt_add_rtc_node(lams);
 
-    pm_mem = g_new(MemoryRegion, 1);
-    memory_region_init_io(pm_mem, NULL, &loongarch_virt_pm_ops,
-                          NULL, "loongarch_virt_pm", PM_SIZE);
-    memory_region_add_subregion(get_system_memory(), PM_BASE, pm_mem);
     /* acpi ged */
     lams->acpi_ged = create_acpi_ged(pch_pic, lams);
     /* platform bus */
diff --git a/tests/tcg/loongarch64/system/boot.S b/tests/tcg/loongarch64/system/boot.S
index 67eb1c04ce..37a81bafe7 100644
--- a/tests/tcg/loongarch64/system/boot.S
+++ b/tests/tcg/loongarch64/system/boot.S
@@ -21,9 +21,10 @@ _start:
 	.align 16
 _exit:
 2:      /* QEMU ACPI poweroff */
-	li.w  t0, 0xff
-	li.w  t1, 0x10080010
-	st.w  t0, t1, 0
+	li.w  t0, 0x34
+	li.w  t1, 0x100e001c
+	st.b  t0, t1, 0
+
 	idle  0
 	bl    2b
 
-- 
2.25.1


