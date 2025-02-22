Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F3A40AC4
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Feb 2025 18:53:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tltgC-0000dW-An; Sat, 22 Feb 2025 12:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tltg3-0000aj-US; Sat, 22 Feb 2025 12:52:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tltg1-0008FT-DT; Sat, 22 Feb 2025 12:52:35 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 263C14E6036;
 Sat, 22 Feb 2025 18:52:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 386Ng7S3LdSR; Sat, 22 Feb 2025 18:52:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 23D6B4E6039; Sat, 22 Feb 2025 18:52:29 +0100 (CET)
Message-Id: <7fac3d50347adbb00bfcd1d1d0bfdf9e73515ebb.1740243918.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740243918.git.balaton@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/4] ppc/amigaone: Implement NVRAM emulation
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Sat, 22 Feb 2025 18:52:29 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

The board has a battery backed NVRAM where U-Boot environment is
stored which is also accessed by AmigaOS and e.g. C:NVGetVar command
crashes without it having at least a valid checksum.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/amigaone.c | 116 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 4290d58613..5273543460 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -21,10 +21,13 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/ppc/ppc.h"
+#include "system/block-backend.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
 
+#include <zlib.h> /* for crc32 */
+
 #define BUS_FREQ_HZ 100000000
 
 /*
@@ -46,6 +49,103 @@ static const char dummy_fw[] = {
     0x4e, 0x80, 0x00, 0x20, /* blr */
 };
 
+#define NVRAM_ADDR 0xfd0e0000
+#define NVRAM_SIZE (4 * KiB)
+
+#define TYPE_A1_NVRAM "a1-nvram"
+OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
+
+struct A1NVRAMState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mr;
+    BlockBackend *blk;
+};
+
+/* read callback not used because of romd mode, only here just in case */
+static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    A1NVRAMState *s = opaque;
+    uint8_t *p = memory_region_get_ram_ptr(&s->mr);
+
+    return p[addr];
+}
+
+static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
+                        unsigned int size)
+{
+    A1NVRAMState *s = opaque;
+    uint8_t *p = memory_region_get_ram_ptr(&s->mr);
+
+    p[addr] = val;
+    if (s->blk) {
+        blk_pwrite(s->blk, addr, 1, &val, 0);
+    }
+}
+
+static const MemoryRegionOps nvram_ops = {
+    .read = nvram_read,
+    .write = nvram_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void nvram_realize(DeviceState *dev, Error **errp)
+{
+    A1NVRAMState *s = A1_NVRAM(dev);
+    void *p;
+    uint32_t *c;
+
+    memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
+                                  NVRAM_SIZE, &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+    c = p = memory_region_get_ram_ptr(&s->mr);
+    if (s->blk) {
+        if (blk_getlength(s->blk) != NVRAM_SIZE) {
+            error_setg(errp, "NVRAM backing file size must be %ld bytes",
+                       NVRAM_SIZE);
+            return;
+        }
+        blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                     BLK_PERM_ALL, &error_fatal);
+        if (blk_pread(s->blk, 0, NVRAM_SIZE, p, 0) < 0) {
+            error_setg(errp, "Cannot read NVRAM contents from backing file");
+            return;
+        }
+    }
+    if (*c == 0) {
+        *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
+        if (s->blk) {
+            blk_pwrite(s->blk, 0, 4, p, 0);
+        }
+    }
+}
+
+static const Property nvram_properties[] = {
+    DEFINE_PROP_DRIVE("drive", A1NVRAMState, blk),
+};
+
+static void nvram_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = nvram_realize;
+    device_class_set_props(dc, nvram_properties);
+}
+
+static const TypeInfo nvram_types[] = {
+    {
+        .name = TYPE_A1_NVRAM,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(A1NVRAMState),
+        .class_init = nvram_class_init,
+    },
+};
+DEFINE_TYPES(nvram_types)
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -72,7 +172,7 @@ static void amigaone_init(MachineState *machine)
     DeviceState *dev;
     I2CBus *i2c_bus;
     uint8_t *spd_data;
-    int i;
+    DriveInfo *di;
 
     /* init CPU */
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -97,6 +197,16 @@ static void amigaone_init(MachineState *machine)
         memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
     }
 
+    /* nvram */
+    dev = qdev_new(TYPE_A1_NVRAM);
+    di = drive_get(IF_MTD, 0, 0);
+    if (di) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
+    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
     /* allocate and load firmware */
     rom = g_new(MemoryRegion, 1);
     memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
@@ -136,7 +246,7 @@ static void amigaone_init(MachineState *machine)
     pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
-                             0, 0x1000000);
+                             0, 0xe0000);
     memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
     mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
@@ -153,7 +263,7 @@ static void amigaone_init(MachineState *machine)
     qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
                                 qdev_get_gpio_in(DEVICE(cpu),
                                 PPC6xx_INPUT_INT));
-    for (i = 0; i < PCI_NUM_PINS; i++) {
+    for (int i = 0; i < PCI_NUM_PINS; i++) {
         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
                                                              "pirq", i));
     }
-- 
2.30.9


