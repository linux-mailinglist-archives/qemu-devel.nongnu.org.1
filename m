Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC5788824
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZc-00021v-MY; Fri, 25 Aug 2023 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZb-00021i-1e
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:59 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZY-00075B-Mn
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:58 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1ccd5b1b9d0so579799fac.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968995; x=1693573795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IewOBMJEnCMngHd0wMHoX0ePwPlGZOCY8AaJCYGxmSw=;
 b=eNhX3FxGS6IAhOI1PZwGEt3eNSTh64V1Du3xmQiIM6+U+lJfELRGgMryB43lzmmftl
 o3Tjewng0gC1DzZlR6HpxCVHF8eD1sCLdHZoXg9dkdahqtPhLoT7ASxhyf+9sb2fAiKA
 27h3tM/n6ygp6R52mullpur5Qd7+SRE9/4NbuI6wnMVYDT5+Jspros+VWkPyqHYUnbMu
 o0oogrfTbrBO7YPb8wPVzFqgFisJTt8buy5iUh/Lc1KThisNwkawD1cIJMVCZLDABG3V
 yw/ipmQ77jDI+i4EFajajLKkJOPxyOuMBONsRRepg4+dHFuLXfm7stugCA0GZmsPXMOb
 jlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968995; x=1693573795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IewOBMJEnCMngHd0wMHoX0ePwPlGZOCY8AaJCYGxmSw=;
 b=TGB7jvps+RKVkVyavbHm6q9GmTcEyttXHPLjBroMEEbmigxmzgfZFz7EN61cgNaaQ+
 xR5QJWa/s5xgfoSt1gyvUgJoDjdMj/uWo0ydzxws55NveuLoEwfND9ui/xFP6PIgpzD+
 +/fLZnMOXeen/EZXGkx0cF4/2NiVLfp5pIyOhv4jm9ZmTCjVUOh5KYG21llkIbtzLHlW
 DR3M+kv/EpGsvGBKlsC05kB7nRNXSseWpkME6GhaEWUHpuNY0o2O9d2PqPUquLH9I1uq
 nV8ccxmkHmq0vc/cgajSF+e/QbDiVL0nJf9za66gmPi/4w7XcvftW8E1z1EZVupkd69T
 ZNWg==
X-Gm-Message-State: AOJu0YyZarVhb+aNdWJbbzQnV4MRHK7UrlVKY2rRGWwLNrjTx1Cmmtbo
 zdpOgDmIQAzLG5McB15CBkAzA58J+TDgY5I0QmQ=
X-Google-Smtp-Source: AGHT+IF8UJ4KhSPCBIqBUpmvZofM7X3N9sU/Pdu0z1YkjaTp7EkBWU5W3g+AijjgS9pcULMrvRW2dg==
X-Received: by 2002:a05:6870:65a4:b0:1bc:11ec:1752 with SMTP id
 fp36-20020a05687065a400b001bc11ec1752mr3243979oab.36.1692968995346; 
 Fri, 25 Aug 2023 06:09:55 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 18/20] target/riscv/cpu: move priv spec functions to tcg-cpu.c
Date: Fri, 25 Aug 2023 10:08:51 -0300
Message-ID: <20230825130853.511782-19-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2c.google.com
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

Priv spec validation is TCG specific. Move it to the TCG accel class.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 39 --------------------------------------
 target/riscv/cpu.h         |  2 --
 target/riscv/tcg/tcg-cpu.c | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac5ad4727c..6817f94c2c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -172,22 +172,6 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
     *ext_enabled = en;
 }
 
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
-{
-    const RISCVIsaExtData *edata;
-
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (edata->ext_enable_offset != ext_offset) {
-            continue;
-        }
-
-        return edata->min_version;
-    }
-
-    /* Default to oldest priv spec if no match found */
-    return PRIV_VERSION_1_10_0;
-}
-
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -926,29 +910,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-{
-    CPURISCVState *env = &cpu->env;
-    const RISCVIsaExtData *edata;
-
-    /* Force disable extensions if priv spec version does not match */
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
-            (env->priv_ver < edata->min_version)) {
-            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-#ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
-                        " because privilege spec version does not match",
-                        edata->name, env->mhartid);
-#else
-            warn_report("disabling %s extension because "
-                        "privilege spec version does not match",
-                        edata->name);
-#endif
-        }
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d9a17df46a..4254f04684 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -711,9 +711,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
 void set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu);
 
 typedef struct RISCVCPUMultiExtConfig {
     const char *name;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8e3f55d3a6..6c91978920 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -97,6 +97,22 @@ const struct TCGCPUOps riscv_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return edata->min_version;
+    }
+
+    /* Default to oldest priv spec if no match found */
+    return PRIV_VERSION_1_10_0;
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -220,6 +236,29 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVIsaExtData *edata;
+
+    /* Force disable extensions if priv spec version does not match */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
+            (env->priv_ver < edata->min_version)) {
+            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+#ifndef CONFIG_USER_ONLY
+            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+                        " because privilege spec version does not match",
+                        edata->name, env->mhartid);
+#else
+            warn_report("disabling %s extension because "
+                        "privilege spec version does not match",
+                        edata->name);
+#endif
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
-- 
2.41.0


