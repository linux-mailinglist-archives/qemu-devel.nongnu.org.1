Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D5A7C63F5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4E-0003W4-SM; Thu, 12 Oct 2023 00:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4B-0003Ib-Ca
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn47-0002ZK-V7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c77449a6daso4777805ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083970; x=1697688770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHAbTVpzXkOkiaKjQL0pv/Zh4l94dGYJxhca5PHzkuo=;
 b=d9a/Mly2r6PfEkQg8KiDGZH4YD8IlEJYD9soSj2M6sZoKBboPAjdVLJvRZPQ5cL+eA
 nzn3QiMtS1W17k6rNzSkGo2zBjG9zEnJKox14pFnnGK2+mOrFFqyLcGJ0frf78pb4ZZM
 EiV8tEzgc0gu2ErCNjElO6Rhe9gn8dBvVCsi5UDwgWgVfRSHx9Dra2LtItGJhnx/UX/Z
 sxml4YbFBK5HdmDi8Nq9VAXlGYeVn9nGJw5x8GJVBnoFAVqxpgDJ7pmCASWw/BzFFWus
 wG03jrpf1iCv2/u/dPc1TKAyRKc7Q9gBiUcC6x7SNLRaSX2Ak+cs5chjQBBEdNnivcd2
 Z40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083970; x=1697688770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHAbTVpzXkOkiaKjQL0pv/Zh4l94dGYJxhca5PHzkuo=;
 b=Ocj301BYfz0+OdXJZsVRqgtw1VCheINOMtfBOYfrly8E5Timkq9n6iBy/wcC5eljzf
 2fW85vyldEvFNfyJFYw4t82juxmtepgzSFAyP/JmcBrXQlBeOaO2ob6Zuymrp2ac7T43
 mDhNDXoIRVcgoN0WQ4g7u9JDBN8O1j859TKK9KWszfOdPNnFqYEJNNnFKb8qrpxjZVYv
 LYkZG6Yrnoy8ulGQU54qbjMk0X5vPiVAIqHIfswdvttwqbvSwEfom+kM4oZxuiehgok4
 vkjMhDqHEyBU7UuA982JOhSIx3Ee7AtO48fZc4Br8aoPHaLJUDR5Z5YkbBW7QgIaHPP3
 isFg==
X-Gm-Message-State: AOJu0YzpOgZvqVqztIFZXpCGVreLIkx/FDUpJmTVO9d7H2Bb7V6z0wHE
 iR4BhBQ70TdP3zK6a387yRPKC564zoOuqA==
X-Google-Smtp-Source: AGHT+IHhS+3LMK7wnPqUH5P7BYaGu1xlrWB6VNWQelHxZNuPT8aP7EeN46qwWPoxn4ZSalk0CWPK5g==
X-Received: by 2002:a17:902:ec91:b0:1c8:9d32:3392 with SMTP id
 x17-20020a170902ec9100b001c89d323392mr16095959plg.63.1697083970350; 
 Wed, 11 Oct 2023 21:12:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/54] target/riscv: move riscv_cpu_add_kvm_properties() to
 kvm.c
Date: Thu, 12 Oct 2023 14:10:27 +1000
Message-ID: <20231012041051.2572507-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We'll introduce the KVM accelerator class with a 'cpu_instance_init'
implementation that is going to be invoked during the common
riscv_cpu_post_init() (via accel_cpu_instance_init()). This
instance_init will execute KVM exclusive code that TCG doesn't care
about, such as adding KVM specific properties, initing registers using a
KVM scratch CPU and so on.

The core of the forementioned cpu_instance_init impl is the current
riscv_cpu_add_kvm_properties() that is being used by the common code via
riscv_cpu_add_user_properties() in cpu.c. Move it to kvm.c, together
will all the relevant artifacts, exporting and renaming it to
kvm_riscv_cpu_add_kvm_properties() so cpu.c can keep using it for now.

To make this work we'll need to export riscv_cpu_extensions,
riscv_cpu_vendor_exts and riscv_cpu_experimental_exts from cpu.c as
well. The TCG accelerator will also need to access those in the near
future so this export will benefit us in the long run.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 14 +++++++
 target/riscv/kvm_riscv.h |  3 --
 target/riscv/cpu.c       | 85 +++-------------------------------------
 target/riscv/kvm.c       | 68 +++++++++++++++++++++++++++++++-
 4 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3055d741c5..0afa45aad1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -22,6 +22,7 @@
 
 #include "hw/core/cpu.h"
 #include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
@@ -713,6 +714,19 @@ bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
 void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu);
 
+typedef struct RISCVCPUMultiExtConfig {
+    const char *name;
+    uint32_t offset;
+    bool enabled;
+} RISCVCPUMultiExtConfig;
+
+extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
+extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
+extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
+extern Property riscv_cpu_options[];
+
+void riscv_cpu_add_misa_properties(Object *cpu_obj);
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 44b850a046..da9630c4af 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -19,10 +19,7 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
-/* Temporarily implemented in cpu.c */
 void kvm_riscv_cpu_add_kvm_properties(Object *obj);
-
-void kvm_riscv_init_user_properties(Object *cpu_obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d831dc375b..c73500151f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1366,7 +1366,7 @@ static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  * change MISA bits during realize() (RVG enables MISA
  * bits but the user is warned about it).
  */
-static void riscv_cpu_add_misa_properties(Object *cpu_obj)
+void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
     int i;
 
@@ -1393,17 +1393,11 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
-typedef struct RISCVCPUMultiExtConfig {
-    const char *name;
-    uint32_t offset;
-    bool enabled;
-} RISCVCPUMultiExtConfig;
-
 #define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .enabled = _defval}
 
-static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
+const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
@@ -1465,7 +1459,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
+const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
     MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
     MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
@@ -1483,7 +1477,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 };
 
 /* These are experimental so mark with 'x-' */
-static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
@@ -1509,7 +1503,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property riscv_cpu_options[] = {
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
@@ -1582,75 +1576,6 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
     }
 }
 
-#ifdef CONFIG_KVM
-static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
-                                    const char *name,
-                                    void *opaque, Error **errp)
-{
-    const char *propname = opaque;
-    bool value;
-
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-
-    if (value) {
-        error_setg(errp, "extension %s is not available with KVM",
-                   propname);
-    }
-}
-
-static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
-{
-    /* Check if KVM created the property already */
-    if (object_property_find(obj, prop_name)) {
-        return;
-    }
-
-    /*
-     * Set the default to disabled for every extension
-     * unknown to KVM and error out if the user attempts
-     * to enable any of them.
-     */
-    object_property_add(obj, prop_name, "bool",
-                        NULL, cpu_set_cfg_unavailable,
-                        NULL, (void *)prop_name);
-}
-
-static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-}
-
-void kvm_riscv_cpu_add_kvm_properties(Object *obj)
-{
-    Property *prop;
-    DeviceState *dev = DEVICE(obj);
-
-    kvm_riscv_init_user_properties(obj);
-    riscv_cpu_add_misa_properties(obj);
-
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
-
-    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if KVM created the property already */
-        if (object_property_find(obj, prop->name)) {
-            continue;
-        }
-        qdev_property_add_static(dev, prop);
-    }
-}
-#endif
-
 /*
  * Add CPU properties with user-facing flags.
  *
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 31d2ede4b6..e682a70311 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -345,6 +345,52 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
+                                    const char *name,
+                                    void *opaque, Error **errp)
+{
+    const char *propname = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value) {
+        error_setg(errp, "extension %s is not available with KVM",
+                   propname);
+    }
+}
+
+static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
+{
+    /* Check if KVM created the property already */
+    if (object_property_find(obj, prop_name)) {
+        return;
+    }
+
+    /*
+     * Set the default to disabled for every extension
+     * unknown to KVM and error out if the user attempts
+     * to enable any of them.
+     */
+    object_property_add(obj, prop_name, "bool",
+                        NULL, cpu_set_cfg_unavailable,
+                        NULL, (void *)prop_name);
+}
+
+static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
+                                        const RISCVCPUMultiExtConfig *array)
+{
+    const RISCVCPUMultiExtConfig *prop;
+
+    g_assert(array);
+
+    for (prop = array; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -754,7 +800,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 }
 
-void kvm_riscv_init_user_properties(Object *cpu_obj)
+static void riscv_init_user_properties(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
     KVMScratchCPU kvmcpu;
@@ -1272,6 +1318,26 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
 
+void kvm_riscv_cpu_add_kvm_properties(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    riscv_init_user_properties(obj);
+    riscv_cpu_add_misa_properties(obj);
+
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
+
+    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
+        /* Check if KVM created the property already */
+        if (object_property_find(obj, prop->name)) {
+            continue;
+        }
+        qdev_property_add_static(dev, prop);
+    }
+}
+
 static void riscv_host_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-- 
2.41.0


