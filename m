Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444A7398C0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBJ-0004q3-G3; Thu, 22 Jun 2023 03:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040j-5N
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sf-GG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N9dbx-1pzbmM2yXN-015dpb; Thu, 22
 Jun 2023 09:55:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 11/24] q800: reimplement mac-io region aliasing using IO memory
 region
Date: Thu, 22 Jun 2023 09:55:31 +0200
Message-Id: <20230622075544.210899-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K3FMKbnxpGgyPBsWTdsRCNyIeX227QH53/qvHARZCrD2EA0tdwo
 XCaGwRBGj2eFEgpaay4BZALNnvwInQkuLhHCMRT9n3jezMAO9a7BW4bZ6dKeirwdPAjYhDT
 PDm5A98JbHk0MichyaavqOrurf9J2RdKLsPEKq/fegUegtFLWEHCSk52SBcGZW9Ijsvq4Ci
 fW2dc8gvWTTRv6Ar9BDkQ==
UI-OutboundReport: notjunk:1;M01:P0:Nb02S1CrR2I=;Yex8n4caz6nMa0/zHpmgXONSQpi
 7l1e8P3LDwR8tbR4KH1osu3PbhAeH/Dkxh8xxsA61X5XQlXql3/HZ+aLGstqdUYEm28FkHH73
 jsJ6LJrJJY/tFkkw7y/K2dSuU4qZeCV//+j56vb/+fzq7Q/78yFvJCRfpSKT5C5U0yNDzuZlc
 weHG4Qij3WEJT04Ek3bomtsunrHlZGH9rcltWJxyHsgaJJ7ySOfOw+qvSMkLgvXmBcfuVusZ8
 Ow+ntvQxV7GN0NvBreYIPLYK0/BNWjvFLrzHpBSpsCNHKqC2Pq2zFz+28f2uRTZwOpU4WCPXk
 y/3nKarck+0MTVCesnru1m8mvbWn7/hvXPNJECf0sphYllSsTcgdhHm1c+LOys2H+Vj4p/Jda
 aB0oo8yiM9IQ7GQh5VhzXwsoNH5vt+oyOleDebVxPKFF+qkMy6Vn3JRNZs2afMLQeAekAvyJU
 W46aMpk7wflIzghtcqt5Yp79hHPRIM59sG1sIhUVQ76qs1hlvSM69Uz0LY7AaCBWDgoBgAta9
 z5oU8AoNxHS+du/kbMmRXgcmMdDuDsvArAhz52sY3EvEdxDmtXrkeS0eYR5J/gokKLaqmQ0PL
 3Nui4OU404aV2zSO6X+OKeHp7+iPS04TZXaGoZnYhHNKqzWUMYTC1gm95xpOs2dldftSfx5ID
 XjfZPGyUp2dlafxXtS9yg/k87kl1dArlnsgBcp7FNg==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The current use of aliased memory regions causes us 2 problems: firstly the
output of "info qom-tree" is absolutely huge and difficult to read, and
secondly we have already reached the internal limit for memory regions as
adding any new memory region into the mac-io region causes QEMU to assert
with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
failed".

Implement the mac-io region aliasing using a single IO memory region that
applies IO_SLICE_MASK representing the maximum size of the aliased region and
then forwarding the access to the existing mac-io memory region using the
address space API.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |   1 +
 hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
 2 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 17067dfad791..1ed38bf0b180 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -40,6 +40,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     GLUEState glue;
     MemoryRegion macio;
+    MemoryRegion macio_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 359bdf3443a6..51b8d8ec3c14 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -59,6 +59,7 @@
 
 #define IO_BASE               0x50000000
 #define IO_SLICE              0x00040000
+#define IO_SLICE_MASK         (IO_SLICE - 1)
 #define IO_SIZE               0x04000000
 
 #define VIA_BASE              (IO_BASE + 0x00000)
@@ -127,6 +128,68 @@ static uint8_t fake_mac_rom[] = {
     0x60, 0xFE                          /* bras [self] */
 };
 
+static MemTxResult macio_alias_read(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    MemTxResult r;
+    uint32_t val;
+
+    addr &= IO_SLICE_MASK;
+    addr |= IO_BASE;
+
+    switch (size) {
+    case 4:
+        val = address_space_ldl_be(&address_space_memory, addr, attrs, &r);
+        break;
+    case 2:
+        val = address_space_lduw_be(&address_space_memory, addr, attrs, &r);
+        break;
+    case 1:
+        val = address_space_ldub(&address_space_memory, addr, attrs, &r);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    *data = val;
+    return r;
+}
+
+static MemTxResult macio_alias_write(void *opaque, hwaddr addr, uint64_t value,
+                                     unsigned size, MemTxAttrs attrs)
+{
+    MemTxResult r;
+
+    addr &= IO_SLICE_MASK;
+    addr |= IO_BASE;
+
+    switch (size) {
+    case 4:
+        address_space_stl_be(&address_space_memory, addr, value, attrs, &r);
+        break;
+    case 2:
+        address_space_stw_be(&address_space_memory, addr, value, attrs, &r);
+        break;
+    case 1:
+        address_space_stb(&address_space_memory, addr, value, attrs, &r);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static const MemoryRegionOps macio_alias_ops = {
+    .read_with_attrs = macio_alias_read,
+    .write_with_attrs = macio_alias_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static void q800_machine_init(MachineState *machine)
 {
     Q800MachineState *m = Q800_MACHINE(machine);
@@ -137,10 +200,8 @@ static void q800_machine_init(MachineState *machine)
     int bios_size;
     ram_addr_t initrd_base;
     int32_t initrd_size;
-    MemoryRegion *io;
     MemoryRegion *dp8393x_prom = g_new(MemoryRegion, 1);
     uint8_t *prom;
-    const int io_slice_nb = (IO_SIZE / IO_SLICE) - 1;
     int i, checksum;
     MacFbMode *macfb_mode;
     ram_addr_t ram_size = machine->ram_size;
@@ -187,16 +248,10 @@ static void q800_machine_init(MachineState *machine)
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
      * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
      */
-    io = g_new(MemoryRegion, io_slice_nb);
-    for (i = 0; i < io_slice_nb; i++) {
-        char *name = g_strdup_printf("mac_m68k.io[%d]", i + 1);
-
-        memory_region_init_alias(&io[i], NULL, name, get_system_memory(),
-                                 IO_BASE, IO_SLICE);
-        memory_region_add_subregion(get_system_memory(),
-                                    IO_BASE + (i + 1) * IO_SLICE, &io[i]);
-        g_free(name);
-    }
+    memory_region_init_io(&m->macio_alias, OBJECT(machine), &macio_alias_ops,
+                          &m->macio, "mac-io.alias", IO_SIZE - IO_SLICE);
+    memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
+                                &m->macio_alias);
 
     /* IRQ Glue */
     object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
@@ -212,7 +267,8 @@ static void q800_machine_init(MachineState *machine)
     }
     sysbus = SYS_BUS_DEVICE(via1_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_mmio_map(sysbus, 1, VIA_BASE);
+    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 1));
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
     /* A/UX mode */
@@ -230,7 +286,8 @@ static void q800_machine_init(MachineState *machine)
     via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
     sysbus = SYS_BUS_DEVICE(via2_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
+    memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
+                                sysbus_mmio_get_region(sysbus, 1));
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA2));
 
@@ -264,7 +321,8 @@ static void q800_machine_init(MachineState *machine)
                              OBJECT(get_system_memory()), &error_abort);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_mmio_map(sysbus, 0, SONIC_BASE);
+    memory_region_add_subregion(&m->macio, SONIC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
@@ -305,7 +363,8 @@ static void q800_machine_init(MachineState *machine)
     qdev_connect_gpio_out(escc_orgate, 0,
                           qdev_get_gpio_in(DEVICE(&m->glue),
                                            GLUE_IRQ_IN_ESCC));
-    sysbus_mmio_map(sysbus, 0, SCC_BASE);
+    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
 
     /* SCSI */
 
@@ -325,8 +384,10 @@ static void q800_machine_init(MachineState *machine)
                                                   VIA2_IRQ_SCSI_BIT)));
     sysbus_connect_irq(sysbus, 1, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
                                                   VIA2_IRQ_SCSI_DATA_BIT)));
-    sysbus_mmio_map(sysbus, 0, ESP_BASE);
-    sysbus_mmio_map(sysbus, 1, ESP_PDMA);
+    memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+    memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 1));
 
     scsi_bus_legacy_handle_cmdline(&esp->bus);
 
@@ -334,7 +395,8 @@ static void q800_machine_init(MachineState *machine)
 
     dev = qdev_new(TYPE_SWIM);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
+    memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     /* NuBus */
 
-- 
2.40.1


