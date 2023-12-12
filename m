Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0051580EB8B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:20:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1jU-0005Hp-Gp; Tue, 12 Dec 2023 07:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jS-0005H5-6d; Tue, 12 Dec 2023 07:19:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1jQ-0000ND-BJ; Tue, 12 Dec 2023 07:19:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7698D3AEFE;
 Tue, 12 Dec 2023 15:18:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3B3603B94C;
 Tue, 12 Dec 2023 15:18:32 +0300 (MSK)
Received: (nullmailer pid 1003428 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 10/31] hw/riscv/virt.c: do create_fdt() earlier,
 add finalize_fdt()
Date: Tue, 12 Dec 2023 15:17:58 +0300
Message-Id: <20231212121831.1003318-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 49554856f0 fixed a problem, where TPM devices were not appearing
in the FDT, by delaying the FDT creation up until virt_machine_done().
This create a side effect (see gitlab #1925) - devices that need access
to the '/chosen' FDT node during realize() stopped working because, at
that point, we don't have a FDT.

This happens because our FDT creation is monolithic, but it doesn't need
to be. We can add the needed FDT components for realize() time and, at
the same time, do another FDT round where we account for dynamic sysbus
devices.  In other words, the problem fixed by 49554856f0 could also be
fixed by postponing only create_fdt_sockets() and its dependencies,
leaving everything else from create_fdt() to be done during init().

Split the FDT creation in two parts:

- create_fdt(), now moved back to virt_machine_init(), will create FDT
  nodes that doesn't depend on additional (dynamic) devices from the
  sysbus;

- a new finalize_fdt() step is added, where create_fdt_sockets() and
  friends is executed, accounting for the dynamic sysbus devices that
  were added during realize().

This will make both use cases happy: TPM devices are still working as
intended, and devices such as 'guest-loader' have a FDT to work on
during realize().

Fixes: 49554856f0 ("riscv: Generate devicetree only after machine initialization is complete")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1925
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231110172559.73209-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 7a87ba8956e59bec8cc4677c6aa5141e4c023a7d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 505a36dff6..ab1ce22870 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -958,7 +958,6 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", UART0_IRQ, 0x4);
     }
 
-    qemu_fdt_add_subnode(ms->fdt, "/chosen");
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
     g_free(name);
 }
@@ -1019,11 +1018,29 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
     g_free(nodename);
 }
 
-static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+static void finalize_fdt(RISCVVirtState *s)
 {
-    MachineState *ms = MACHINE(s);
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
+
+    create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
+                       &irq_pcie_phandle, &irq_virtio_phandle,
+                       &msi_pcie_phandle);
+
+    create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
+
+    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle);
+
+    create_fdt_reset(s, virt_memmap, &phandle);
+
+    create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
+
+    create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+}
+
+static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
+{
+    MachineState *ms = MACHINE(s);
     uint8_t rng_seed[32];
 
     ms->fdt = create_device_tree(&s->fdt_size);
@@ -1043,28 +1060,16 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
 
-    create_fdt_sockets(s, memmap, &phandle, &irq_mmio_phandle,
-                       &irq_pcie_phandle, &irq_virtio_phandle,
-                       &msi_pcie_phandle);
-
-    create_fdt_virtio(s, memmap, irq_virtio_phandle);
-
-    create_fdt_pcie(s, memmap, irq_pcie_phandle, msi_pcie_phandle);
-
-    create_fdt_reset(s, memmap, &phandle);
-
-    create_fdt_uart(s, memmap, irq_mmio_phandle);
-
-    create_fdt_rtc(s, memmap, irq_mmio_phandle);
-
-    create_fdt_flash(s, memmap);
-    create_fdt_fw_cfg(s, memmap);
-    create_fdt_pmu(s);
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
     /* Pass seed to RNG */
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
                      rng_seed, sizeof(rng_seed));
+
+    create_fdt_flash(s, memmap);
+    create_fdt_fw_cfg(s, memmap);
+    create_fdt_pmu(s);
 }
 
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
@@ -1249,15 +1254,12 @@ static void virt_machine_done(Notifier *notifier, void *data)
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
 
-    /* load/create device tree */
-    if (machine->dtb) {
-        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
-        if (!machine->fdt) {
-            error_report("load_device_tree() failed");
-            exit(1);
-        }
-    } else {
-        create_fdt(s, memmap);
+    /*
+     * An user provided dtb must include everything, including
+     * dynamic sysbus devices. Our FDT needs to be finalized.
+     */
+    if (machine->dtb == NULL) {
+        finalize_fdt(s);
     }
 
     /*
@@ -1525,6 +1527,17 @@ static void virt_machine_init(MachineState *machine)
     }
     virt_flash_map(s, system_memory);
 
+    /* load/create device tree */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else {
+        create_fdt(s, memmap);
+    }
+
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
-- 
2.39.2


