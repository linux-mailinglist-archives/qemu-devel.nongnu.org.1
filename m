Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF737A7A4E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivGM-0005f8-B0; Wed, 20 Sep 2023 07:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGK-0005eY-6a
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:56 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGI-0002Cp-AL
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:55 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c0b8f42409so4041430a34.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208853; x=1695813653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmVkKvTAOuUNt4UAtysRt2NatN2A0KygpSkxpaxrMiM=;
 b=BPTz8iC9u4jGUy+TzsFWQjqLU52ewchYBKqCH53m24xIE1iUmvaYVh3o6Tuifjpxsh
 /R6Yocc3eOb2nSLqxP75ll8EV8bEAmcM+FmPQwZzvnqqZUDvEZGucVsph3wSkr38Fs0o
 FDvDYkl9qAJp23PkEdILTcC+b+BETq4n9iyeQrVz/UjnJmc9o9Zk6U8hwE2zbjoLll5f
 3yjBpgOBcUo47Bkr8WRgztqdjOdtHd6/MFigPyPGDQylEhUi7zXO8cFrgme80tgsATMB
 QH0jffv/nLRwVqYZx+ysntc9aG36amUjObsDbV3gasgLUovvrhF9kNodcePzAWyzIiMa
 iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208853; x=1695813653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmVkKvTAOuUNt4UAtysRt2NatN2A0KygpSkxpaxrMiM=;
 b=xTLGLDfNL3BJsSwo8kxbhqg2eGpJZHcA4eJsJnL7a7XWh5RLwaaBHoeKF9sTYSMPmE
 QhJ0llexDMCe5ZXLm3bN/GlWdfmL2of6d8AVtdpS+7gytJ/GiwsR+TXg5Ftt8HS40rZU
 v0hnJwXifyRB5JjJsVaX3OovP98kyFxStdMtcsHjU3ytIDhT7QbT6TkV+2nGMknujd3/
 42AtEKrBoQgr8igi7SnvJs8bgx9sJQy5AXjX9Sp7aeXzYszu84+K6Y3I0Hx7zGX1pcN6
 8/9agbs1fnGRcsE1XLWq7VvieIijGMgwhLnepVRHUqrXZxID3RcuYlghTD1bwzp5wUz0
 hW+A==
X-Gm-Message-State: AOJu0YxXG83OCCQJoh6I7QgRJtXaCTeF/R53MQJT15hRZfjeBjSlBlrc
 nf/8W0mIX85XB6456tykCVMUeX/t7Ac0fjl/p7M=
X-Google-Smtp-Source: AGHT+IFeMLgCOFQO1Ungn5IHRT4qQjkzoN+lKOepZQqQeNmiYXk84JhUVRwM1U2Z4bZyMoAeSBEELw==
X-Received: by 2002:a05:6870:b506:b0:1c8:c313:3e0d with SMTP id
 v6-20020a056870b50600b001c8c3133e0dmr2707915oap.46.1695208852847; 
 Wed, 20 Sep 2023 04:20:52 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 08/19] target/riscv: move riscv_cpu_add_kvm_properties() to
 kvm.c
Date: Wed, 20 Sep 2023 08:20:09 -0300
Message-ID: <20230920112020.651006-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu.c       | 85 +++-------------------------------------
 target/riscv/cpu.h       | 14 +++++++
 target/riscv/kvm.c       | 68 +++++++++++++++++++++++++++++++-
 target/riscv/kvm_riscv.h |  3 --
 4 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 048a2dbc77..0dc9b3201d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1370,7 +1370,7 @@ static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
  * change MISA bits during realize() (RVG enables MISA
  * bits but the user is warned about it).
  */
-static void riscv_cpu_add_misa_properties(Object *cpu_obj)
+void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
     int i;
 
@@ -1397,17 +1397,11 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
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
@@ -1469,7 +1463,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
+const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
     MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
     MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
@@ -1487,7 +1481,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 };
 
 /* These are experimental so mark with 'x-' */
-static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
@@ -1513,7 +1507,7 @@ static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property riscv_cpu_options[] = {
+Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
 
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
@@ -1586,75 +1580,6 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
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
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b2e558f730..9dc4113812 100644
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
-- 
2.41.0


