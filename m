Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132F737DE5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbz-0001zi-Li; Wed, 21 Jun 2023 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbx-0001zX-MX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbv-0004m5-PC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zS18JJKibJJt7HbVwcUvhHP+/lNCZnCNg8iKw3QG1ns=; b=LOg4IiA8xcsLZw6M/jtU2evVej
 NkNSk4jpoe9NlgJ5pb2HMoQjdobnTFE801SXYLve6jPJHwhlD4ZV/gcbkQVgK0ALuR1wiT7l0VSqf
 6GZD+uLeV1GLEyxdmJVtifVxNDoR5LJN+HFPpZ5Intd01AleeNR+rby8v0BneTrO5xLniQiU9Rmbc
 kEmjUodRSd5mIOULOQz9EcvDhCmPYGbler/AVrqV4M/4RLrS7JLcCVjemQrjQPuSlzIeGhINjzp8o
 w7u38qLP3bUGyvbSszdtT6Tyutx0Fe3/CxTKzpOw+OgKCt5QUAhGgcmJu1RIt0yfl5eMFOnjFI5/j
 uDhTLrx/r1eSEIVeISaT877+Fco6grUdxrd5auhN5DoamOFXRObMyCm90EiRRabcmPCacTS/Q8Jcm
 Ep4FbXQyPULaaFzpqd3BtScrBJOGzp5P3HJ8MaQHHVZ/aqWYG/14660IEDVpstNdKSSouMNQ8nHf3
 QD1bP/dO3GaF2Q1PmQOa39Of5bnKiv4CcQ9SErI/JuUgofV83YlOjnHMrEDJIKNJXpER62O40PYBk
 I509PojhWvw6Nl4EEAYHgrqfafK6drWXxRyWS/j7PE+01kWHD/q73KafHoiOOPEQzvv6/e9Q/wYql
 2lXU7rscCh622bZJgKxspge13lFU3Z76Vi41L18k8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbk-0001ZB-P7; Wed, 21 Jun 2023 09:54:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:40 +0100
Message-Id: <20230621085353.113233-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 11/24] q800: reimplement mac-io region aliasing using IO
 memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
 include/hw/m68k/q800.h |   1 +
 2 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 359bdf3443..51b8d8ec3c 100644
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
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 17067dfad7..1ed38bf0b1 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -40,6 +40,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     GLUEState glue;
     MemoryRegion macio;
+    MemoryRegion macio_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


