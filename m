Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079874783F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 20:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGkct-00015w-B4; Tue, 04 Jul 2023 14:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGkcr-00015C-6e; Tue, 04 Jul 2023 14:19:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGkcp-00078T-1H; Tue, 04 Jul 2023 14:19:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5B27374635C;
 Tue,  4 Jul 2023 20:19:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 27B58746335; Tue,  4 Jul 2023 20:19:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] ppc/pegasos2: Add support for -initrd command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230704181920.27B58746335@zero.eik.bme.hu>
Date: Tue,  4 Jul 2023 20:19:20 +0200 (CEST)
X-Spam-Probability: 10%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index af5489de26..9c9944188b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -44,6 +44,8 @@
 #define PROM_ADDR     0xfff00000
 #define PROM_SIZE     0x80000
 
+#define INITRD_MIN_ADDR 0x600000
+
 #define KVMPPC_HCALL_BASE    0xf000
 #define KVMPPC_H_RTAS        (KVMPPC_HCALL_BASE + 0x0)
 #define KVMPPC_H_VOF_CLIENT  (KVMPPC_HCALL_BASE + 0x5)
@@ -80,6 +82,8 @@ struct Pegasos2MachineState {
     uint64_t kernel_addr;
     uint64_t kernel_entry;
     uint64_t kernel_size;
+    uint64_t initrd_addr;
+    uint64_t initrd_size;
 };
 
 static void *build_fdt(MachineState *machine, int *fdt_size);
@@ -117,7 +121,8 @@ static void pegasos2_init(MachineState *machine)
     I2CBus *i2c_bus;
     const char *fwname = machine->firmware ?: PROM_FILENAME;
     char *filename;
-    int i, sz;
+    int i;
+    ssize_t sz;
     uint8_t *spd_data;
 
     /* init CPU */
@@ -213,6 +218,20 @@ static void pegasos2_init(MachineState *machine)
         warn_report("Using Virtual OpenFirmware but no -kernel option.");
     }
 
+    if (machine->initrd_filename) {
+        pm->initrd_addr = pm->kernel_addr + pm->kernel_size + 64 * KiB;
+        pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
+        pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
+        sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
+                                 machine->ram_size - pm->initrd_addr);
+        if (sz <= 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        pm->initrd_size = sz;
+    }
+
     if (!pm->vof && machine->kernel_cmdline && machine->kernel_cmdline[0]) {
         warn_report("Option -append may be ineffective with -bios.");
     }
@@ -335,6 +354,11 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
         error_report("Memory for kernel is in use");
         exit(1);
     }
+    if (pm->initrd_size &&
+        vof_claim(pm->vof, pm->initrd_addr, pm->initrd_size, 0) == -1) {
+        error_report("Memory for initrd is in use");
+        exit(1);
+    }
     fdt = build_fdt(machine, &sz);
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
@@ -966,6 +990,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
 
     qemu_fdt_add_subnode(fdt, "/chosen");
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                             machine->kernel_cmdline ?: "");
     qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");
-- 
2.30.9


