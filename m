Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF27ADE36
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkppm-0000ZP-SN; Mon, 25 Sep 2023 13:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppl-0000Yu-EW
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppj-0002AG-Bv
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c3f97f2239so62327675ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664642; x=1696269442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvYfHSfqGjzJzjhxgz67b1ioP9Sb4vSPyH/KcYL/z1w=;
 b=cMmDwQTzcmlYT/7N/38Zk9ImfcbJQG6kB4Kf5JqpF5N1gAAD3DI3yA8l3Gm8ii7UH1
 vBlx8nzKE1sXOPhfOpPMjS+VAw1NZQLF5ekg+WB4Zb8cp1nNbtxbqoVWoLFtNkNP8OHh
 wsUqku3fD2uk3Q+Cu6gq/QCtvK+uzz2JM7AAoK2ZsYjJJ2nW1LHHPjNDCUmdekDGLvgB
 Ds2ynXl3slWvGvi66R/swCkmHi+ar4gCsS3Lxqw7xucWU7UERbgeE0OdssbFpZ4zDU88
 HXefesNmqcROzD7I7SGC4rL+clRk5ul0F2fRdBCLy3EOazHhpMjaakzdCyCJFrHIqT6M
 T/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664642; x=1696269442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvYfHSfqGjzJzjhxgz67b1ioP9Sb4vSPyH/KcYL/z1w=;
 b=a3x48B9B3zrrz5VjD1TjbcoJwHa5rfeu7dstnVybGHX+Bwt2guoo36Iig9MMdYiG6M
 DlQMqvW5agun9ak/H78nxLSh5KtAOeXzhmixHFjoEbxZLMh52UNPMFCBMCw5sav/meEI
 sHfZ/o0xGUH64y5dh/Hq9v/VYGyBZ2nomgZxBmxX3I60H0ISKTQu4QAJfLNU8RR49Nv5
 aIncrIJ2kQpaH+qdby1hcY8Q8izwWEt8ztseEWAKw+RNnItVoaYGGO/sFMuvAgbGN4TI
 BYWaFjk0aS1MKfOJFa/sOWRAFbZ6j4keLItyZ+O97OfBnsX6k6I/GyqDKW9kilmscfDo
 VS5A==
X-Gm-Message-State: AOJu0YzEG7KW9nHIvbRw+pE7nG2SmFZ0dMNYMA3Yd9BcTJ23EEPUZQb4
 ZRDCtSdCMnPzO5h/GJLhXfzlfOzvyDDfNC3aPX4=
X-Google-Smtp-Source: AGHT+IHIkbqVGfWdHdE1gZ4HHr8HSre88z+m9EBEUs0mUeyckAIsza9XHDf7eGTNtstii1XOSIPxnA==
X-Received: by 2002:a17:90b:3588:b0:274:6cc9:ec69 with SMTP id
 mm8-20020a17090b358800b002746cc9ec69mr6057606pjb.49.1695664641688; 
 Mon, 25 Sep 2023 10:57:21 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 02/19] target/riscv: move riscv_cpu_realize_tcg() to
 TCG::cpu_realizefn()
Date: Mon, 25 Sep 2023 14:56:52 -0300
Message-ID: <20230925175709.35696-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

riscv_cpu_realize_tcg() was added to allow TCG cpus to have a different
realize() path during the common riscv_cpu_realize(), making it a good
choice to start moving TCG exclusive code to tcg-cpu.c.

Rename it to tcg_cpu_realizefn() and assign it as a implementation of
accel::cpu_realizefn(). tcg_cpu_realizefn() will then be called during
riscv_cpu_realize() via cpu_exec_realizefn(). We'll use a similar
approach with KVM in the near future.

riscv_cpu_validate_set_extensions() is too big and with too many
dependencies to be moved in this same patch. We'll do that next.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 128 -----------------------------------
 target/riscv/tcg/tcg-cpu.c | 133 +++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 128 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e72c49c881..030629294f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,9 +23,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "pmu.h"
 #include "internals.h"
-#include "time_helper.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -1064,29 +1062,6 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
-static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
-{
-    CPURISCVState *env = &cpu->env;
-    int priv_version = -1;
-
-    if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
-            priv_version = PRIV_VERSION_1_12_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
-            priv_version = PRIV_VERSION_1_11_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
-            priv_version = PRIV_VERSION_1_10_0;
-        } else {
-            error_setg(errp,
-                       "Unsupported privilege spec version '%s'",
-                       cpu->cfg.priv_spec);
-            return;
-        }
-
-        env->priv_ver = priv_version;
-    }
-}
-
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
@@ -1111,33 +1086,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-    CPUClass *cc = CPU_CLASS(mcc);
-    CPURISCVState *env = &cpu->env;
-
-    /* Validate that MISA_MXL is set properly. */
-    switch (env->misa_mxl_max) {
-#ifdef TARGET_RISCV64
-    case MXL_RV64:
-    case MXL_RV128:
-        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
-        break;
-#endif
-    case MXL_RV32:
-        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
-}
-
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -1511,74 +1459,6 @@ static void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 #endif
 }
 
-static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
-{
-    if (riscv_has_ext(env, RVH) && env->priv_ver < PRIV_VERSION_1_12_0) {
-        error_setg(errp, "H extension requires priv spec 1.12.0");
-        return;
-    }
-}
-
-static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
-{
-    RISCVCPU *cpu = RISCV_CPU(dev);
-    CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_HOST)) {
-        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
-        return;
-    }
-
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    riscv_cpu_validate_priv_spec(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    riscv_cpu_validate_misa_priv(env, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
-        /*
-         * Enhanced PMP should only be available
-         * on harts with PMP support
-         */
-        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
-        return;
-    }
-
-    riscv_cpu_validate_set_extensions(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-#ifndef CONFIG_USER_ONLY
-    CPU(dev)->tcg_cflags |= CF_PCREL;
-
-    if (cpu->cfg.ext_sstc) {
-        riscv_timer_init(cpu);
-    }
-
-    if (cpu->cfg.pmu_num) {
-        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
-            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          riscv_pmu_timer_cb, cpu);
-        }
-     }
-#endif
-}
-
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -1597,14 +1477,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (tcg_enabled()) {
-        riscv_cpu_realize_tcg(dev, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
     riscv_cpu_finalize_features(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 795a8f06b2..5904cf7354 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -18,10 +18,142 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/exec-all.h"
 #include "cpu.h"
+#include "pmu.h"
+#include "time_helper.h"
+#include "qapi/error.h"
 #include "qemu/accel.h"
 #include "hw/core/accel-cpu.h"
 
+
+static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
+{
+    if (riscv_has_ext(env, RVH) && env->priv_ver < PRIV_VERSION_1_12_0) {
+        error_setg(errp, "H extension requires priv spec 1.12.0");
+        return;
+    }
+}
+
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    CPUClass *cc = CPU_CLASS(mcc);
+    CPURISCVState *env = &cpu->env;
+
+    /* Validate that MISA_MXL is set properly. */
+    switch (env->misa_mxl_max) {
+#ifdef TARGET_RISCV64
+    case MXL_RV64:
+    case MXL_RV128:
+        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
+        break;
+#endif
+    case MXL_RV32:
+        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (env->misa_mxl_max != env->misa_mxl) {
+        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
+        return;
+    }
+}
+
+static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    int priv_version = -1;
+
+    if (cpu->cfg.priv_spec) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
+            priv_version = PRIV_VERSION_1_12_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
+            priv_version = PRIV_VERSION_1_11_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+            priv_version = PRIV_VERSION_1_10_0;
+        } else {
+            error_setg(errp,
+                       "Unsupported privilege spec version '%s'",
+                       cpu->cfg.priv_spec);
+            return;
+        }
+
+        env->priv_ver = priv_version;
+    }
+}
+
+/*
+ * We'll get here via the following path:
+ *
+ * riscv_cpu_realize()
+ *   -> cpu_exec_realizefn()
+ *      -> tcg_cpu_realizefn() (via accel_cpu_realizefn())
+ */
+static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
+
+    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
+        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
+        return false;
+    }
+
+    riscv_cpu_validate_misa_mxl(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    riscv_cpu_validate_priv_spec(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    riscv_cpu_validate_misa_priv(env, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    if (cpu->cfg.epmp && !cpu->cfg.pmp) {
+        /*
+         * Enhanced PMP should only be available
+         * on harts with PMP support
+         */
+        error_setg(errp, "Invalid configuration: EPMP requires PMP support");
+        return false;
+    }
+
+    riscv_cpu_validate_set_extensions(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    CPU(cs)->tcg_cflags |= CF_PCREL;
+
+    if (cpu->cfg.ext_sstc) {
+        riscv_timer_init(cpu);
+    }
+
+    if (cpu->cfg.pmu_num) {
+        if (!riscv_pmu_init(cpu, cpu->cfg.pmu_num) && cpu->cfg.ext_sscofpmf) {
+            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          riscv_pmu_timer_cb, cpu);
+        }
+     }
+#endif
+
+    return true;
+}
+
 static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
 {
     /*
@@ -41,6 +173,7 @@ static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
     acc->cpu_class_init = tcg_cpu_class_init;
+    acc->cpu_realizefn = tcg_cpu_realizefn;
 }
 
 static const TypeInfo tcg_cpu_accel_type_info = {
-- 
2.41.0


