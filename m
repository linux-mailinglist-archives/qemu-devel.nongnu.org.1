Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9EF80A2D6
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 13:10:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZeW-0006kI-3I; Fri, 08 Dec 2023 07:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rBZeH-0006k0-1j; Fri, 08 Dec 2023 07:08:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rBZeA-00047N-5R; Fri, 08 Dec 2023 07:08:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 81D2062364;
 Fri,  8 Dec 2023 12:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26460C433C7;
 Fri,  8 Dec 2023 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702037268;
 bh=VO2CAyyWK+lTU7+41TJKW1+uzk4o614VbtWFasL/Iv8=;
 h=From:To:Cc:Subject:Date:From;
 b=UMUc0GIAbP+inG251WlRIfdV5AvjQgtRZYf30R2WRjXHGclieKdIBUXMkhs7nDsMt
 KPeGyURpxGvwyXoSJJshQyDLiXnhZpTeBkORtBRLBSzuIiN/qBuXCuRQ83DlPBvfYs
 fa57hwPLbAADr5E7AT9VmXYHLdHk85moN7yoECyaQ7oJ08Vp1ISN8tFqZLfyXS7eZm
 9vgm0ezI19LbmQpzLNP6wXx298ayvksB5GfQbNH6eSAnlcnSFOsU0CWDvdAL+4sk72
 UPS/ZTZahyoOnwCbzvy/2i6kV/PNV7IaS9vqhyCWtQlKqEb2CzNomCrTKltEhyIag5
 93zA1u/sEqJIQ==
From: Conor Dooley <conor@kernel.org>
To: qemu-riscv@nongnu.org
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] riscv: support new isa extension detection devicetree
 properties
Date: Fri,  8 Dec 2023 12:07:22 +0000
Message-Id: <20231208-sponge-thickness-c0e9511b1baf@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9673;
 i=conor.dooley@microchip.com; h=from:subject:message-id;
 bh=b9TskK7osol/JpM22uBsKpg7fG01fPE2O9oyQYorem4=;
 b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFbD8UNhjuuXh99+OHz86LRjtqzI9WUVr8JlJ3XlHCD
 v8NdkkiHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIYQGG/y4CL87csbX/naLt
 5Hd4hsHeWzGKMRKchdPZp7+5xnXJcwvDH74v/uWqcVrdBeVWG9U6vtetu7TI58JHzTnR1/jTl1d
 vZAMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp;
 fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Conor Dooley <conor.dooley@microchip.com>

A few months ago I submitted a patch to various lists, deprecating
"riscv,isa" with a lengthy commit message [0] that is now commit
aeb71e42caae ("dt-bindings: riscv: deprecate riscv,isa") in the Linux
kernel tree. Primarily, the goal was to replace "riscv,isa" with a new
set of properties that allowed for strictly defining the meaning of
various extensions, where "riscv,isa" was tied to whatever definitions
inflicted upon us by the ISA manual, which have seen some variance over
time.

Two new properties were introduced: "riscv,isa-base" and
"riscv,isa-extensions". The former is a simple string to communicate the
base ISA implemented by a hart and the latter an array of strings used
to communicate the set of ISA extensions supported, per the definitions
of each substring in extensions.yaml [1]. A beneficial side effect was
also the ability to define vendor extensions in a more "official" way,
as the ISA manual and other RVI specifications only covered the format
for vendor extensions in the ISA string, but not the meaning of vendor
extensions, for obvious reasons.

Add support for setting these two new properties in the devicetrees for
the various devicetree platforms supported by QEMU for RISC-V. The Linux
kernel already supports parsing ISA extensions from these new
properties, and documenting them in the dt-binding is a requirement for
new extension detection being added to the kernel.

A side effect of the implementation is that the meaning for elements in
"riscv,isa" and in "riscv,isa-extensions" are now tied together as they
are constructed from the same source. The same applies to the ISA string
provided in ACPI tables, but there does not appear to be any strict
definitions of meanings in ACPI land either.

Link: https://lore.kernel.org/qemu-riscv/20230702-eats-scorebook-c951f170d29f@spud/ [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/extensions.yaml [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- use g_strdup() for multiletter extension string copying
- wrap stuff in #ifndef to prevent breaking the user mode build
- rename riscv_isa_set_props() -> riscv_isa_write_fdt()

CC: Alistair Francis <Alistair.Francis@wdc.com>
CC: Bin Meng <bin.meng@windriver.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Weiwei Li <liwei1518@gmail.com>
CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
CC: qemu-riscv@nongnu.org
CC: qemu-devel@nongnu.org
---
 hw/riscv/sifive_u.c |  7 ++-----
 hw/riscv/spike.c    |  6 ++----
 hw/riscv/virt.c     |  6 ++----
 target/riscv/cpu.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h  |  1 +
 5 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ec76dce6c9..2f227f15bc 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -171,7 +171,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa;
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
@@ -180,11 +179,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
             }
-            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
+            riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
+            riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
-        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
@@ -194,7 +192,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
         g_free(intc);
         g_free(nodename);
     }
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 81f7e53aed..64074395bc 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
     uint32_t cpu_phandle, intc_phandle, phandle = 1;
-    char *name, *mem_name, *clint_name, *clust_name;
+    char *mem_name, *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -113,9 +113,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
             }
-            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
-            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
-            g_free(name);
+            riscv_isa_write_fdt(&s->soc[socket].harts[cpu], fdt, cpu_name);
             qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
             qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c7fc97e273..05beb0a297 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -238,7 +238,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     int cpu;
     uint32_t cpu_phandle;
     MachineState *ms = MACHINE(s);
-    char *name, *cpu_name, *core_name, *intc_name, *sv_name;
+    char *cpu_name, *core_name, *intc_name, *sv_name;
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
     uint8_t satp_mode_max;
 
@@ -259,9 +259,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             g_free(sv_name);
         }
 
-        name = riscv_isa_string(cpu_ptr);
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
-        g_free(name);
+        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
 
         if (cpu_ptr->cfg.ext_zicbom) {
             qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 83c7c0cf07..ce413b9f00 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
+#include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
@@ -1735,6 +1736,55 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
+#ifndef CONFIG_USER_ONLY
+static char **riscv_isa_extensions_list(RISCVCPU *cpu, int *count)
+{
+    int maxlen = ARRAY_SIZE(riscv_single_letter_exts) + ARRAY_SIZE(isa_edata_arr);
+    char **extensions = g_new(char *, maxlen);
+
+    for (int i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
+        if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
+            extensions[*count] = g_new(char, 2);
+            snprintf(extensions[*count], 2, "%c",
+                     qemu_tolower(riscv_single_letter_exts[i]));
+            (*count)++;
+        }
+    }
+
+    for (const RISCVIsaExtData *edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
+            extensions[*count] = g_strdup(edata->name);
+            (*count)++;
+        }
+    }
+
+    return extensions;
+}
+
+void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
+{
+    const size_t maxlen = sizeof("rv128i");
+    g_autofree char *isa_base = g_new(char, maxlen);
+    g_autofree char *riscv_isa;
+    char **isa_extensions;
+    int count = 0;
+
+    riscv_isa = riscv_isa_string(cpu);
+    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
+
+    snprintf(isa_base, maxlen, "rv%di", TARGET_LONG_BITS);
+    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
+
+    isa_extensions = riscv_isa_extensions_list(cpu, &count);
+    qemu_fdt_setprop_string_array(fdt, nodename, "riscv,isa-extensions",
+                                  isa_extensions, count);
+
+    for (int i = 0; i < count; i++) {
+        g_free(isa_extensions[i]);
+    }
+}
+#endif
+
 static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
     ObjectClass *class_a = (ObjectClass *)a;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bf58b0f0b5..5bbce607c4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -496,6 +496,7 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
-- 
2.39.2


