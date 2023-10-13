Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB047C8038
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDNA-0004DE-31; Fri, 13 Oct 2023 04:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qrDMy-0003Z4-Ll
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qrDMv-0003SR-0B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:04 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxyeo0_Shl9aQxAA--.20476S3;
 Fri, 13 Oct 2023 16:17:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNwt_ShlyKIiAA--.7352S7; 
 Fri, 13 Oct 2023 16:17:56 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/7] hw/loongarch/virt: Remove unused ISA Bus
Date: Fri, 13 Oct 2023 16:17:48 +0800
Message-Id: <20231013081750.2944412-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231013081750.2944412-1-gaosong@loongson.cn>
References: <20231013081750.2944412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxbNwt_ShlyKIiAA--.7352S7
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The LoongArch 'virt' machine doesn't use its ISA I/O region.

If a ISA device were to be mapped there, there is no support
for ISA IRQ. Unlikely useful. Simply remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231010135342.40219-3-philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/Kconfig        | 1 -
 hw/loongarch/virt.c         | 5 -----
 include/hw/loongarch/virt.h | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index fcd5f2b4b6..5727efed6d 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -5,7 +5,6 @@ config LOONGARCH_VIRT
     imply VIRTIO_VGA
     imply PCI_DEVICES
     imply NVDIMM
-    select ISA_BUS
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c6f64e941b..c1791f80dd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -878,11 +878,6 @@ static void loongarch_init(MachineState *machine)
         machine_memory_devices_init(machine, device_mem_base, device_mem_size);
     }
 
-    /* Add isa io region */
-    memory_region_init_alias(&lams->isa_io, NULL, "isa-io",
-                             get_system_io(), 0, VIRT_ISA_IO_SIZE);
-    memory_region_add_subregion(address_space_mem, VIRT_ISA_IO_BASE,
-                                &lams->isa_io);
     /* load the BIOS image. */
     loongarch_firmware_init(lams);
 
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index f1659655c6..674f4655e0 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -16,8 +16,6 @@
 
 #define LOONGARCH_MAX_CPUS      256
 
-#define VIRT_ISA_IO_BASE        0x18000000UL
-#define VIRT_ISA_IO_SIZE        0x0004000
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
 #define VIRT_BIOS_SIZE          (4 * MiB)
@@ -38,7 +36,6 @@ struct LoongArchMachineState {
 
     MemoryRegion lowmem;
     MemoryRegion highmem;
-    MemoryRegion isa_io;
     MemoryRegion bios;
     bool         bios_loaded;
     /* State for other subsystems/APIs: */
-- 
2.25.1


