Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7027ADE3E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpqR-0001BC-Ju; Mon, 25 Sep 2023 13:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqP-0000zP-GB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:58:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqN-0002Fm-56
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:58:05 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2776d882214so1170031a91.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664681; x=1696269481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AATH1d0EH+CW85hIdXtiW9XhMpw4Ijx1Pp941W8oPRc=;
 b=B/nQTQNtQf9kA6IoXyxmpAEpFakdtlv7cDsXlr/ZLmHZmmlKt8akH/TlycAFHiGG0I
 kVfJl+uXQVnYhGu/29h5TBajME+AaMo0/F9+N42wZp+m62XWILJreGR0wkMsOgiDa1y2
 rCZ2ahnOn2hSzQaTyOo/wIeJxJ8qzByI1sCYb9tlfaWwuJ2GOWALY788CJf2x+8nICvN
 C/F2sINifUCd31aCANbpthj7MGjzvi1EdULdCvH05Ak0jEKiJjJuqR2Ko4No7u5/Wd83
 dIvOHd9wgE3f8r9ixOOMVKbgCePBrUK/V7KcMG3ctGzqFm19DBfLUpgWO7TCotpRjToV
 o9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664681; x=1696269481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AATH1d0EH+CW85hIdXtiW9XhMpw4Ijx1Pp941W8oPRc=;
 b=O5zMg6gZcdlQ4Qur7dh09M4lF5S3uhzsqW/3w0okWyahpBYaD+W1WtS8cL+5WIRt1b
 5KNoLuUeMDF2p/mIin87gbUeazpNolk+lFdQlmbwoAzT30iwvLeCCGWzob41JlLsAO5l
 d/9v2MJf1SdcYShJgqNsD3CVHvjhepHjvCOY0ZtCwVKPIUVd4c0O2tV8h+1+YO8bSzto
 zLgjuDgma6Ciojc4C/vLasFN7tLmBSiGfUFSCnE8o6Lll3X2KrTSHIDR93hviaDvgMF4
 K5qwMYOmTnG5o5l98ke4IwiV1WbgWn7UnlB0vUpc+kPa99IZQdcPfnybaXeaWgDQDgQF
 sX5g==
X-Gm-Message-State: AOJu0YwRAnRUskIzbNebPwn4/O2qLGxKudcuTSB2/tIf5+lKNBt/58h1
 Bsy5cLOwgLnNL826am6gmKNTYk9u6yK5cfrASoU=
X-Google-Smtp-Source: AGHT+IGjL3SyxGywx4IbF7AxOlmyqx+iIbDryKtVVB7dGxxfjBC2AOWxb69WxwVHpLVUf5btxps4UQ==
X-Received: by 2002:a17:90b:2388:b0:268:4c01:eb56 with SMTP id
 mr8-20020a17090b238800b002684c01eb56mr5339418pjb.2.1695664681496; 
 Mon, 25 Sep 2023 10:58:01 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:58:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 15/19] target/riscv/tcg: introduce tcg_cpu_instance_init()
Date: Mon, 25 Sep 2023 14:57:05 -0300
Message-ID: <20230925175709.35696-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
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

tcg_cpu_instance_init() will be the 'cpu_instance_init' impl for the TCG
accelerator. It'll be called from within riscv_cpu_post_init(), via
accel_cpu_instance_init(), similar to what happens with KVM. In fact, to
preserve behavior, the implementation will be similar to what
riscv_cpu_post_init() already does.

In this patch we'll move riscv_cpu_add_user_properties() and
riscv_init_max_cpu_extensions() and all their dependencies to tcg-cpu.c.
All multi-extension properties code was moved. The 'multi_ext_user_opts'
hash table was also moved to tcg-cpu.c since it's a TCG only structure,
meaning that we won't have to worry about initializing a TCG hash table
when running a KVM CPU anymore.

riscv_cpu_add_user_properties() will remain in cpu.c for now due to how
much code it requires to be moved at the same time. We'll do that in the
next patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 150 -------------------------------------
 target/riscv/cpu.h         |   1 -
 target/riscv/tcg/tcg-cpu.c | 149 ++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 151 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cf191d576e..8616c9e2f5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -162,9 +162,6 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 };
 
-/* Hash that stores user set extensions */
-static GHashTable *multi_ext_user_opts;
-
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
 {
     bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
@@ -194,12 +191,6 @@ int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
-bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
-{
-    return g_hash_table_contains(multi_ext_user_opts,
-                                 GUINT_TO_POINTER(ext_offset));
-}
-
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -280,9 +271,6 @@ static const char * const riscv_intr_names[] = {
     "reserved"
 };
 
-static void riscv_cpu_add_user_properties(Object *obj);
-static void riscv_init_max_cpu_extensions(Object *obj);
-
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
     if (async) {
@@ -1206,32 +1194,9 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
-static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
-}
-
-static bool riscv_cpu_has_user_properties(Object *cpu_obj)
-{
-    if (kvm_enabled() &&
-        object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_HOST) != NULL) {
-        return true;
-    }
-
-    return riscv_cpu_is_dynamic(cpu_obj);
-}
-
 static void riscv_cpu_post_init(Object *obj)
 {
     accel_cpu_instance_init(CPU(obj));
-
-    if (tcg_enabled() && riscv_cpu_has_user_properties(obj)) {
-        riscv_cpu_add_user_properties(obj);
-    }
-
-    if (riscv_cpu_has_max_extensions(obj)) {
-        riscv_init_max_cpu_extensions(obj);
-    }
 }
 
 static void riscv_cpu_init(Object *obj)
@@ -1244,8 +1209,6 @@ static void riscv_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
-
-    multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
 }
 
 typedef struct RISCVCPUMisaExtConfig {
@@ -1531,119 +1494,6 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
-{
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value;
-
-    if (!visit_type_bool(v, name, &value, errp)) {
-        return;
-    }
-
-    isa_ext_update_enabled(RISCV_CPU(obj), multi_ext_cfg->offset, value);
-
-    g_hash_table_insert(multi_ext_user_opts,
-                        GUINT_TO_POINTER(multi_ext_cfg->offset),
-                        (gpointer)value);
-}
-
-static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
-{
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
-
-    visit_type_bool(v, name, &value, errp);
-}
-
-static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   const RISCVCPUMultiExtConfig *multi_cfg)
-{
-    object_property_add(cpu_obj, multi_cfg->name, "bool",
-                        cpu_get_multi_ext_cfg,
-                        cpu_set_multi_ext_cfg,
-                        NULL, (void *)multi_cfg);
-
-    /*
-     * Set def val directly instead of using
-     * object_property_set_bool() to save the set()
-     * callback hash for user inputs.
-     */
-    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
-                           multi_cfg->enabled);
-}
-
-static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        cpu_add_multi_ext_prop(obj, prop);
-    }
-}
-
-/*
- * Add CPU properties with user-facing flags.
- *
- * This will overwrite existing env->misa_ext values with the
- * defaults set via riscv_cpu_add_misa_properties().
- */
-static void riscv_cpu_add_user_properties(Object *obj)
-{
-#ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-#endif
-
-    riscv_cpu_add_misa_properties(obj);
-
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        qdev_property_add_static(DEVICE(obj), prop);
-    }
-}
-
-/*
- * The 'max' type CPU will have all possible ratified
- * non-vendor extensions enabled.
- */
-static void riscv_init_max_cpu_extensions(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *prop;
-
-    /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
-
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        isa_ext_update_enabled(cpu, prop->offset, true);
-    }
-
-    /* set vector version */
-    env->vext_ver = VEXT_VERSION_1_00_0;
-
-    /* Zfinx is not compatible with F. Disable it */
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinx), false);
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinxmin), false);
-
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zce), false);
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
-    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
-
-    if (env->misa_mxl != MXL_RV32) {
-        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
-    }
-}
-
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9ec0805596..01cbcbe119 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -710,7 +710,6 @@ enum riscv_pmu_event_idx {
 
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
-bool cpu_cfg_ext_is_user_set(uint32_t ext_offset);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
 void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7d890823bd..ac3cf4c035 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -24,6 +24,7 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -31,6 +32,15 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "tcg/tcg.h"
 
+/* Hash that stores user set extensions */
+static GHashTable *multi_ext_user_opts;
+
+static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+{
+    return g_hash_table_contains(multi_ext_user_opts,
+                                 GUINT_TO_POINTER(ext_offset));
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
@@ -570,6 +580,144 @@ static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     return true;
 }
 
+static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    isa_ext_update_enabled(RISCV_CPU(obj), multi_ext_cfg->offset, value);
+
+    g_hash_table_insert(multi_ext_user_opts,
+                        GUINT_TO_POINTER(multi_ext_cfg->offset),
+                        (gpointer)value);
+}
+
+static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
+    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_add_multi_ext_prop(Object *cpu_obj,
+                                   const RISCVCPUMultiExtConfig *multi_cfg)
+{
+    object_property_add(cpu_obj, multi_cfg->name, "bool",
+                        cpu_get_multi_ext_cfg,
+                        cpu_set_multi_ext_cfg,
+                        NULL, (void *)multi_cfg);
+
+    /*
+     * Set def val directly instead of using
+     * object_property_set_bool() to save the set()
+     * callback hash for user inputs.
+     */
+    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
+                           multi_cfg->enabled);
+}
+
+static void riscv_cpu_add_multiext_prop_array(Object *obj,
+                                        const RISCVCPUMultiExtConfig *array)
+{
+    const RISCVCPUMultiExtConfig *prop;
+
+    g_assert(array);
+
+    for (prop = array; prop && prop->name; prop++) {
+        cpu_add_multi_ext_prop(obj, prop);
+    }
+}
+
+/*
+ * Add CPU properties with user-facing flags.
+ *
+ * This will overwrite existing env->misa_ext values with the
+ * defaults set via riscv_cpu_add_misa_properties().
+ */
+static void riscv_cpu_add_user_properties(Object *obj)
+{
+#ifndef CONFIG_USER_ONLY
+    riscv_add_satp_mode_properties(obj);
+#endif
+
+    riscv_cpu_add_misa_properties(obj);
+
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+
+    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
+        qdev_property_add_static(DEVICE(obj), prop);
+    }
+}
+
+/*
+ * The 'max' type CPU will have all possible ratified
+ * non-vendor extensions enabled.
+ */
+static void riscv_init_max_cpu_extensions(Object *obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    const RISCVCPUMultiExtConfig *prop;
+
+    /* Enable RVG, RVJ and RVV that are disabled by default */
+    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+
+    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+        isa_ext_update_enabled(cpu, prop->offset, true);
+    }
+
+    /* set vector version */
+    env->vext_ver = VEXT_VERSION_1_00_0;
+
+    /* Zfinx is not compatible with F. Disable it */
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinx), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zhinxmin), false);
+
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zce), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmp), false);
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcmt), false);
+
+    if (env->misa_mxl != MXL_RV32) {
+        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
+    }
+}
+
+static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
+}
+
+static bool riscv_cpu_has_user_properties(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+}
+
+static void tcg_cpu_instance_init(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    Object *obj = OBJECT(cpu);
+
+    if (riscv_cpu_has_user_properties(obj)) {
+        multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
+        riscv_cpu_add_user_properties(obj);
+    }
+
+    if (riscv_cpu_has_max_extensions(obj)) {
+        riscv_init_max_cpu_extensions(obj);
+    }
+}
+
 static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
 {
     /*
@@ -588,6 +736,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_class_init = tcg_cpu_class_init;
+    acc->cpu_instance_init = tcg_cpu_instance_init;
     acc->cpu_realizefn = tcg_cpu_realizefn;
 }
 
-- 
2.41.0


