Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C7764E38
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOw0e-0004QM-6L; Thu, 27 Jul 2023 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1qOw0Y-0004Q2-B1; Thu, 27 Jul 2023 04:06:03 -0400
Received: from forward102c.mail.yandex.net ([178.154.239.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1qOw0S-0006ys-3F; Thu, 27 Jul 2023 04:05:58 -0400
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:27a9:0:640:8a40:0])
 by forward102c.mail.yandex.net (Yandex) with ESMTP id BDAF660045;
 Thu, 27 Jul 2023 11:05:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id j5HG9SAWtOs0-nd11sTU5; 
 Thu, 27 Jul 2023 11:05:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1690445147; bh=MLJcUZ3ysH8S/MlHXo9RiQS2w9EFUreLeL09xC5HriM=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=c6OUpgGnxYD8tqBEkP3lMehJwo1w/WxkZoXmQ2tLfw8Z2RWYFaA1j7OHvTP9lJVWE
 4WJ5/4PTgWtlQ70W/OntZ7+vz8dWpMLJqpF/MaDnkc/aLooAtxBrd659DFSmQywPJJ
 us8SWrf87JVN/3LV4MRK2TThklQNFiXO0Ai5Wpjw=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Cc: Nikita Shubin <n.shubin@yadro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/riscv: hart: allow other cpu instance
Date: Thu, 27 Jul 2023 11:05:45 +0300
Message-Id: <20230727080545.7908-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.213;
 envelope-from=nikita.shubin@maquefel.me; helo=forward102c.mail.yandex.net
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

From: Nikita Shubin <n.shubin@yadro.com>

Allow using instances derivative from RISCVCPU

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Currently it is not possible to overload instance of RISCVCPU, 
i.e. something like this:

static const TypeInfo riscv_cpu_type_infos[] = {
     {
        .name = TYPE_ANOTHER_RISCV_CPU,
        .parent = TYPE_RISCV_CPU,
        .instance_size = sizeof(MyCPUState),
        .instance_init = riscv_my_cpu_init,
    }
};

Because we have RISCVHartArrayState.harts with exactly 
the size of RISCVCPU.

Using own instances can be used to store some internal hart state.
---
 hw/riscv/boot.c               |  5 +++--
 hw/riscv/riscv_hart.c         | 20 ++++++++++++--------
 hw/riscv/sifive_u.c           |  7 +++++--
 hw/riscv/spike.c              |  4 +++-
 hw/riscv/virt-acpi-build.c    |  2 +-
 hw/riscv/virt.c               |  6 +++---
 include/hw/riscv/riscv_hart.h | 18 +++++++++++++++++-
 7 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 52bf8e67de..c0456dcc2e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,8 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    RISCVCPU *hart = riscv_array_get_hart(harts, 0);
+    return hart->env.misa_mxl_max == MXL_RV32;
 }
 
 /*
@@ -414,7 +415,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
         reset_vec[4] = 0x0182b283;   /*     ld     t0, 24(t0) */
     }
 
-    if (!harts->harts[0].cfg.ext_icsr) {
+    if (!riscv_array_get_hart(harts, 0)->cfg.ext_icsr) {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 613ea2aaa0..74fc10ef48 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -43,24 +43,28 @@ static void riscv_harts_cpu_reset(void *opaque)
 }
 
 static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
-                               char *cpu_type, Error **errp)
+                               char *cpu_type, size_t size, Error **errp)
 {
-    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
-    qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
-    s->harts[idx].env.mhartid = s->hartid_base + idx;
-    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
-    return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
+    RISCVCPU *hart = riscv_array_get_hart(s, idx);
+    object_initialize_child_internal(OBJECT(s), "harts[*]",
+                                    hart, size, cpu_type);
+    qdev_prop_set_uint64(DEVICE(hart), "resetvec", s->resetvec);
+    hart->env.mhartid = s->hartid_base + idx;
+    qemu_register_reset(riscv_harts_cpu_reset, hart);
+    return qdev_realize(DEVICE(hart), NULL, errp);
 }
 
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
+    size_t size = object_type_get_instance_size(s->cpu_type);
     int n;
 
-    s->harts = g_new0(RISCVCPU, s->num_harts);
+    s->harts = g_new0(RISCVCPU *, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
+        s->harts[n] = RISCV_CPU(object_new(s->cpu_type));
+        if (!riscv_hart_realize(s, n, s->cpu_type, size, errp)) {
             return;
         }
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 35a335b8d0..b8a54db81b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -104,6 +104,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     char *nodename;
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
+    RISCVCPU *hart;
     static const char * const ethclk_names[2] = { "pclk", "hclk" };
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -180,9 +181,11 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
             }
-            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
+            hart = riscv_array_get_hart(&s->soc.u_cpus, cpu - 1);
+            isa = riscv_isa_string(hart);
         } else {
-            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
+            hart = riscv_array_get_hart(&s->soc.e_cpus, 0);
+            isa = riscv_isa_string(hart);
         }
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 81f7e53aed..85b7568dad 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -61,6 +61,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     uint32_t cpu_phandle, intc_phandle, phandle = 1;
     char *name, *mem_name, *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
+    RISCVCPU *hart;
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
     };
@@ -103,6 +104,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
         clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
 
         for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            hart = riscv_array_get_hart(&s->soc[socket], cpu);
             cpu_phandle = phandle++;
 
             cpu_name = g_strdup_printf("/cpus/cpu@%d",
@@ -113,7 +115,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
             }
-            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            name = riscv_isa_string(hart);
             qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
             g_free(name);
             qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7331248f59..7cff4e4baf 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -158,7 +158,7 @@ static void build_rhct(GArray *table_data,
     isa_offset = table_data->len - table.table_offset;
     build_append_int_noprefix(table_data, 0, 2);   /* Type 0 */
 
-    cpu = &s->soc[0].harts[0];
+    cpu = riscv_array_get_hart(&s->soc[0], 0);
     isa = riscv_isa_string(cpu);
     len = 8 + strlen(isa) + 1;
     aligned_len = (len % 2) ? (len + 1) : len;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d90286dc46..59b42cc5e4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -236,7 +236,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     uint8_t satp_mode_max;
 
     for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
-        RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
+        RISCVCPU *cpu_ptr = riscv_array_get_hart(&s->soc[socket], cpu);
 
         cpu_phandle = (*phandle)++;
 
@@ -730,12 +730,12 @@ static void create_fdt_pmu(RISCVVirtState *s)
 {
     char *pmu_name;
     MachineState *ms = MACHINE(s);
-    RISCVCPU hart = s->soc[0].harts[0];
+    RISCVCPU *hart = riscv_array_get_hart(&s->soc[0], 0);
 
     pmu_name = g_strdup_printf("/soc/pmu");
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);
+    riscv_pmu_generate_fdt_node(ms->fdt, hart->cfg.pmu_num, pmu_name);
 
     g_free(pmu_name);
 }
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index bbc21cdc9a..a5393c361b 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -38,7 +38,23 @@ struct RISCVHartArrayState {
     uint32_t hartid_base;
     char *cpu_type;
     uint64_t resetvec;
-    RISCVCPU *harts;
+    RISCVCPU **harts;
 };
 
+/**
+ * riscv_array_get_hart:
+ */
+static inline RISCVCPU *riscv_array_get_hart(RISCVHartArrayState *harts, int i)
+{
+    return harts->harts[i];
+}
+
+/**
+ * riscv_array_get_num_harts:
+ */
+static inline unsigned riscv_array_get_num_harts(RISCVHartArrayState *harts)
+{
+    return harts->num_harts;
+}
+
 #endif
-- 
2.39.2


