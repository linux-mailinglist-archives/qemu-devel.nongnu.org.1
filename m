Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C86EC7ADE3B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkppy-0000cB-Tj; Mon, 25 Sep 2023 13:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppt-0000bK-Lb
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppm-0002Aa-Tr
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:33 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5789ffc8ae0so4473252a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664645; x=1696269445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVrvtyYjxAqD1QhO+2lqCz4dBLw0mw428mjf5hanvQ8=;
 b=hrFGdtbtG7bDSU+0P3pocRdRcYNYub/pJuQ1bB/F91SlTWT3865s72M4fUEAPQ1yng
 Br1F+ZUwDp+qlvqdBmNDOTEtui5251Hykf7AS7qy+/LjxtjP9EtuSZzzH2smZhgTC3aq
 HHqSvqJXUj+DAKgWl7DzrVDpZwq+B5mKrYaUEecFKdN8akTeoeSxhhHo77CLSCoEeiFA
 L2LfpVnXnEfStJJIekdlYxvq2+PrnQh9nHWN2Na6i3ZT83ZS2iDAMKjFBx21CK9U+RzP
 Rhhh10IRKpuHQh85RIhogpdBqq1KMHeKBA8PChs7TZktGT6mbh4i5LN3/cEX9rA6Y1t6
 972A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664645; x=1696269445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVrvtyYjxAqD1QhO+2lqCz4dBLw0mw428mjf5hanvQ8=;
 b=DTjxb+HDrBUarCHfJ/Ef03AyAvCNcobvtONbFGLFU9gXUxSfq1LgczPjtm/xhfRPSz
 h8ROiQdBJYnoITXZcXMpBMaI0EbUFfcFhmuvKqCNh4K0Q1gmHibiODc7kRxg366tF59h
 WqJEVnhZdZlC2jQFGnZWkqLXrPFc/Q7O3R0FVtnBbeMbvAnkGNbWKkp5dIZbgmyGORjr
 XwvHqIAhitiy8oWddPMkLnI1R8QHw8+1LxA+ChMcI5v7PQLS8PW8L6EBG8Ln9F7v0tKB
 UV3I9ymS2VhK0tK+GKzs+dVA1ILJNF15gJBPidWEXO6ERFTpbgeu4yqYg5Cw1zy6XdGZ
 g/vg==
X-Gm-Message-State: AOJu0YyU/lULa9ylfFtF8WhDxfRZtXJfJgnWjSWOk7f3xRcz1DJgkxq3
 INmBNdPR3c8/+0QWT7KkNbhJz2cqto23xq8l5qE=
X-Google-Smtp-Source: AGHT+IEFO9dVvgXpe2qGZGHdkxVsbos9X30/mD2RAusyul6eIYx/M7Y7eCxXtqeUcUDUBvfzZOHRfA==
X-Received: by 2002:a17:90a:540d:b0:26b:5461:8dd5 with SMTP id
 z13-20020a17090a540d00b0026b54618dd5mr4556926pjh.42.1695664644855; 
 Mon, 25 Sep 2023 10:57:24 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 03/19] target/riscv: move
 riscv_cpu_validate_set_extensions() to tcg-cpu.c
Date: Mon, 25 Sep 2023 14:56:53 -0300
Message-ID: <20230925175709.35696-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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

This function is the core of the RISC-V validations for TCG CPUs, and it
has a lot going on.

Functions in cpu.c were made public to allow them to be used by the KVM
accelerator class later on. 'cpu_cfg_ext_get_min_version()' is notably
hard to move it to another file due to its dependency with isa_edata_arr[]
array, thus make it public and use it as is for now.

riscv_cpu_validate_set_extensions() is kept public because it's used by
csr.c in write_misa().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 361 +------------------------------------
 target/riscv/cpu.h         |   8 +-
 target/riscv/csr.c         |   1 +
 target/riscv/tcg/tcg-cpu.c | 357 ++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.h |  27 +++
 5 files changed, 397 insertions(+), 357 deletions(-)
 create mode 100644 target/riscv/tcg/tcg-cpu.h

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 030629294f..7215a29324 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -163,22 +163,21 @@ static const struct isa_ext_data isa_edata_arr[] = {
 /* Hash that stores user set extensions */
 static GHashTable *multi_ext_user_opts;
 
-static bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
+bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
 {
     bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     return *ext_enabled;
 }
 
-static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
-                                   bool en)
+void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
 {
     bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     *ext_enabled = en;
 }
 
-static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
 {
     int i;
 
@@ -193,38 +192,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
-static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
 {
     return g_hash_table_contains(multi_ext_user_opts,
                                  GUINT_TO_POINTER(ext_offset));
 }
 
-static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
-                                    bool value)
-{
-    CPURISCVState *env = &cpu->env;
-    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
-    int min_version;
-
-    if (prev_val == value) {
-        return;
-    }
-
-    if (cpu_cfg_ext_is_user_set(ext_offset)) {
-        return;
-    }
-
-    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
-        /* Do not enable it if priv_ver is older than min_version */
-        min_version = cpu_cfg_ext_get_min_version(ext_offset);
-        if (env->priv_ver < min_version) {
-            return;
-        }
-    }
-
-    isa_ext_update_enabled(cpu, ext_offset, value);
-}
-
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -1023,46 +996,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
-static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
-                                 Error **errp)
-{
-    if (!is_power_of_2(cfg->vlen)) {
-        error_setg(errp, "Vector extension VLEN must be power of 2");
-        return;
-    }
-    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
-        error_setg(errp,
-                   "Vector extension implementation only supports VLEN "
-                   "in the range [128, %d]", RV_VLEN_MAX);
-        return;
-    }
-    if (!is_power_of_2(cfg->elen)) {
-        error_setg(errp, "Vector extension ELEN must be power of 2");
-        return;
-    }
-    if (cfg->elen > 64 || cfg->elen < 8) {
-        error_setg(errp,
-                   "Vector extension implementation only supports ELEN "
-                   "in the range [8, 64]");
-        return;
-    }
-    if (cfg->vext_spec) {
-        if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
-            env->vext_ver = VEXT_VERSION_1_00_0;
-        } else {
-            error_setg(errp, "Unsupported vector spec version '%s'",
-                       cfg->vext_spec);
-            return;
-        }
-    } else if (env->vext_ver == 0) {
-        qemu_log("vector version is not specified, "
-                 "use the default value v1.0\n");
-
-        env->vext_ver = VEXT_VERSION_1_00_0;
-    }
-}
-
-static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
+void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
     int i;
@@ -1086,291 +1020,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-/*
- * Check consistency between chosen extensions while setting
- * cpu->cfg accordingly.
- */
-void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
-{
-    CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
-
-    /* Do some ISA extension error checking */
-    if (riscv_has_ext(env, RVG) &&
-        !(riscv_has_ext(env, RVI) && riscv_has_ext(env, RVM) &&
-          riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
-          riscv_has_ext(env, RVD) &&
-          cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
-
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
-            !cpu->cfg.ext_icsr) {
-            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
-            return;
-        }
-
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
-            !cpu->cfg.ext_ifencei) {
-            error_setg(errp, "RVG requires Zifencei but user set "
-                       "Zifencei to false");
-            return;
-        }
-
-        warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
-
-        env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
-        env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
-    }
-
-    if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
-        error_setg(errp,
-                   "I and E extensions are incompatible");
-        return;
-    }
-
-    if (!riscv_has_ext(env, RVI) && !riscv_has_ext(env, RVE)) {
-        error_setg(errp,
-                   "Either I or E extension must be set");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVS) && !riscv_has_ext(env, RVU)) {
-        error_setg(errp,
-                   "Setting S extension without U extension is illegal");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVH) && !riscv_has_ext(env, RVI)) {
-        error_setg(errp,
-                   "H depends on an I base integer ISA with 32 x registers");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVH) && !riscv_has_ext(env, RVS)) {
-        error_setg(errp, "H extension implicitly requires S-mode");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVF) && !cpu->cfg.ext_icsr) {
-        error_setg(errp, "F extension requires Zicsr");
-        return;
-    }
-
-    if ((cpu->cfg.ext_zawrs) && !riscv_has_ext(env, RVA)) {
-        error_setg(errp, "Zawrs extension requires A extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zfa && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "Zfa extension requires F extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
-    }
-
-    if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "Zfh/Zfhmin extensions require F extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zfbfmin && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "Zfbfmin extension depends on F extension");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVD) && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "D extension requires F extension");
-        return;
-    }
-
-    if (riscv_has_ext(env, RVV)) {
-        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
-        /* The V vector extension depends on the Zve64d extension */
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
-    }
-
-    /* The Zve64d extension depends on the Zve64f extension */
-    if (cpu->cfg.ext_zve64d) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
-    }
-
-    /* The Zve64f extension depends on the Zve32f extension */
-    if (cpu->cfg.ext_zve64f) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
-    }
-
-    if (cpu->cfg.ext_zve64d && !riscv_has_ext(env, RVD)) {
-        error_setg(errp, "Zve64d/V extensions require D extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
-        error_setg(errp, "Zve32f/Zve64f extensions require F extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zvfh) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
-    }
-
-    if (cpu->cfg.ext_zvfhmin && !cpu->cfg.ext_zve32f) {
-        error_setg(errp, "Zvfh/Zvfhmin extensions require Zve32f extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
-        error_setg(errp, "Zvfh extensions requires Zfhmin extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
-        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
-        error_setg(errp, "Zvfbfmin extension depends on Zve32f extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zvfbfwma && !cpu->cfg.ext_zvfbfmin) {
-        error_setg(errp, "Zvfbfwma extension depends on Zvfbfmin extension");
-        return;
-    }
-
-    /* Set the ISA extensions, checks should have happened above */
-    if (cpu->cfg.ext_zhinx) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-    }
-
-    if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
-        error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
-        return;
-    }
-
-    if (cpu->cfg.ext_zfinx) {
-        if (!cpu->cfg.ext_icsr) {
-            error_setg(errp, "Zfinx extension requires Zicsr");
-            return;
-        }
-        if (riscv_has_ext(env, RVF)) {
-            error_setg(errp,
-                       "Zfinx cannot be supported together with F extension");
-            return;
-        }
-    }
-
-    if (cpu->cfg.ext_zce) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
-        }
-    }
-
-    /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
-    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
-        }
-        if (riscv_has_ext(env, RVD)) {
-            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
-        }
-    }
-
-    if (env->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
-        error_setg(errp, "Zcf extension is only relevant to RV32");
-        return;
-    }
-
-    if (!riscv_has_ext(env, RVF) && cpu->cfg.ext_zcf) {
-        error_setg(errp, "Zcf extension requires F extension");
-        return;
-    }
-
-    if (!riscv_has_ext(env, RVD) && cpu->cfg.ext_zcd) {
-        error_setg(errp, "Zcd extension requires D extension");
-        return;
-    }
-
-    if ((cpu->cfg.ext_zcf || cpu->cfg.ext_zcd || cpu->cfg.ext_zcb ||
-         cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) && !cpu->cfg.ext_zca) {
-        error_setg(errp, "Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca "
-                         "extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zcd && (cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt)) {
-        error_setg(errp, "Zcmp/Zcmt extensions are incompatible with "
-                         "Zcd extension");
-        return;
-    }
-
-    if (cpu->cfg.ext_zcmt && !cpu->cfg.ext_icsr) {
-        error_setg(errp, "Zcmt extension requires Zicsr extension");
-        return;
-    }
-
-    /*
-     * In principle Zve*x would also suffice here, were they supported
-     * in qemu
-     */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
-         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed || cpu->cfg.ext_zvksh) &&
-        !cpu->cfg.ext_zve32f) {
-        error_setg(errp,
-                   "Vector crypto extensions require V or Zve* extensions");
-        return;
-    }
-
-    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64f) {
-        error_setg(
-            errp,
-            "Zvbc and Zvknhb extensions require V or Zve64{f,d} extensions");
-        return;
-    }
-
-    if (cpu->cfg.ext_zk) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkn), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkr), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkt), true);
-    }
-
-    if (cpu->cfg.ext_zkn) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkne), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknd), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknh), true);
-    }
-
-    if (cpu->cfg.ext_zks) {
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksed), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
-    }
-
-    /*
-     * Disable isa extensions based on priv spec after we
-     * validated and set everything we need.
-     */
-    riscv_cpu_disable_priv_spec_isa_exts(cpu);
-}
-
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 16a2dfa8c7..409d198635 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -445,7 +445,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
-void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
@@ -711,6 +710,13 @@ enum riscv_pmu_event_idx {
 #include "hw/core/tcg-cpu-ops.h"
 extern const struct TCGCPUOps riscv_tcg_ops;
 
+/* used by tcg/tcg-cpu.c*/
+void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
+bool cpu_cfg_ext_is_user_set(uint32_t ext_offset);
+bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
+int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
+void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu);
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 85a31dc420..4b4ab56c40 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
 #include "exec/exec-all.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5904cf7354..47c89fd554 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -19,14 +19,43 @@
 
 #include "qemu/osdep.h"
 #include "exec/exec-all.h"
+#include "tcg-cpu.h"
 #include "cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
 #include "qemu/accel.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "hw/core/accel-cpu.h"
 
 
+static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
+                                    bool value)
+{
+    CPURISCVState *env = &cpu->env;
+    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
+    int min_version;
+
+    if (prev_val == value) {
+        return;
+    }
+
+    if (cpu_cfg_ext_is_user_set(ext_offset)) {
+        return;
+    }
+
+    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
+        /* Do not enable it if priv_ver is older than min_version */
+        min_version = cpu_cfg_ext_get_min_version(ext_offset);
+        if (env->priv_ver < min_version) {
+            return;
+        }
+    }
+
+    isa_ext_update_enabled(cpu, ext_offset, value);
+}
+
 static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 {
     if (riscv_has_ext(env, RVH) && env->priv_ver < PRIV_VERSION_1_12_0) {
@@ -85,6 +114,334 @@ static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
     }
 }
 
+static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
+                                 Error **errp)
+{
+    if (!is_power_of_2(cfg->vlen)) {
+        error_setg(errp, "Vector extension VLEN must be power of 2");
+        return;
+    }
+
+    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
+        error_setg(errp,
+                   "Vector extension implementation only supports VLEN "
+                   "in the range [128, %d]", RV_VLEN_MAX);
+        return;
+    }
+
+    if (!is_power_of_2(cfg->elen)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+
+    if (cfg->elen > 64 || cfg->elen < 8) {
+        error_setg(errp,
+                   "Vector extension implementation only supports ELEN "
+                   "in the range [8, 64]");
+        return;
+    }
+
+    if (cfg->vext_spec) {
+        if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
+            env->vext_ver = VEXT_VERSION_1_00_0;
+        } else {
+            error_setg(errp, "Unsupported vector spec version '%s'",
+                       cfg->vext_spec);
+            return;
+        }
+    } else if (env->vext_ver == 0) {
+        qemu_log("vector version is not specified, "
+                 "use the default value v1.0\n");
+
+        env->vext_ver = VEXT_VERSION_1_00_0;
+    }
+}
+
+/*
+ * Check consistency between chosen extensions while setting
+ * cpu->cfg accordingly.
+ */
+void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
+
+    /* Do some ISA extension error checking */
+    if (riscv_has_ext(env, RVG) &&
+        !(riscv_has_ext(env, RVI) && riscv_has_ext(env, RVM) &&
+          riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
+          riscv_has_ext(env, RVD) &&
+          cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
+            !cpu->cfg.ext_icsr) {
+            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
+            return;
+        }
+
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
+            !cpu->cfg.ext_ifencei) {
+            error_setg(errp, "RVG requires Zifencei but user set "
+                       "Zifencei to false");
+            return;
+        }
+
+        warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
+
+        env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
+        env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
+    }
+
+    if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
+        error_setg(errp,
+                   "I and E extensions are incompatible");
+        return;
+    }
+
+    if (!riscv_has_ext(env, RVI) && !riscv_has_ext(env, RVE)) {
+        error_setg(errp,
+                   "Either I or E extension must be set");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVS) && !riscv_has_ext(env, RVU)) {
+        error_setg(errp,
+                   "Setting S extension without U extension is illegal");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVH) && !riscv_has_ext(env, RVI)) {
+        error_setg(errp,
+                   "H depends on an I base integer ISA with 32 x registers");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVH) && !riscv_has_ext(env, RVS)) {
+        error_setg(errp, "H extension implicitly requires S-mode");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVF) && !cpu->cfg.ext_icsr) {
+        error_setg(errp, "F extension requires Zicsr");
+        return;
+    }
+
+    if ((cpu->cfg.ext_zawrs) && !riscv_has_ext(env, RVA)) {
+        error_setg(errp, "Zawrs extension requires A extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zfa && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zfa extension requires F extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zfh) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zfhmin), true);
+    }
+
+    if (cpu->cfg.ext_zfhmin && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zfh/Zfhmin extensions require F extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zfbfmin && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zfbfmin extension depends on F extension");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVD) && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "D extension requires F extension");
+        return;
+    }
+
+    if (riscv_has_ext(env, RVV)) {
+        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        /* The V vector extension depends on the Zve64d extension */
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64d), true);
+    }
+
+    /* The Zve64d extension depends on the Zve64f extension */
+    if (cpu->cfg.ext_zve64d) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve64f), true);
+    }
+
+    /* The Zve64f extension depends on the Zve32f extension */
+    if (cpu->cfg.ext_zve64f) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zve32f), true);
+    }
+
+    if (cpu->cfg.ext_zve64d && !riscv_has_ext(env, RVD)) {
+        error_setg(errp, "Zve64d/V extensions require D extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zve32f && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zve32f/Zve64f extensions require F extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfh) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvfhmin), true);
+    }
+
+    if (cpu->cfg.ext_zvfhmin && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfh/Zvfhmin extensions require Zve32f extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
+        error_setg(errp, "Zvfh extensions requires Zfhmin extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
+        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfbfmin extension depends on Zve32f extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfbfwma && !cpu->cfg.ext_zvfbfmin) {
+        error_setg(errp, "Zvfbfwma extension depends on Zvfbfmin extension");
+        return;
+    }
+
+    /* Set the ISA extensions, checks should have happened above */
+    if (cpu->cfg.ext_zhinx) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+    }
+
+    if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
+        error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
+        return;
+    }
+
+    if (cpu->cfg.ext_zfinx) {
+        if (!cpu->cfg.ext_icsr) {
+            error_setg(errp, "Zfinx extension requires Zicsr");
+            return;
+        }
+        if (riscv_has_ext(env, RVF)) {
+            error_setg(errp,
+                       "Zfinx cannot be supported together with F extension");
+            return;
+        }
+    }
+
+    if (cpu->cfg.ext_zce) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
+        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
+        }
+    }
+
+    /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
+    if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
+        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
+        }
+        if (riscv_has_ext(env, RVD)) {
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
+        }
+    }
+
+    if (env->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+        error_setg(errp, "Zcf extension is only relevant to RV32");
+        return;
+    }
+
+    if (!riscv_has_ext(env, RVF) && cpu->cfg.ext_zcf) {
+        error_setg(errp, "Zcf extension requires F extension");
+        return;
+    }
+
+    if (!riscv_has_ext(env, RVD) && cpu->cfg.ext_zcd) {
+        error_setg(errp, "Zcd extension requires D extension");
+        return;
+    }
+
+    if ((cpu->cfg.ext_zcf || cpu->cfg.ext_zcd || cpu->cfg.ext_zcb ||
+         cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) && !cpu->cfg.ext_zca) {
+        error_setg(errp, "Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca "
+                         "extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zcd && (cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt)) {
+        error_setg(errp, "Zcmp/Zcmt extensions are incompatible with "
+                         "Zcd extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zcmt && !cpu->cfg.ext_icsr) {
+        error_setg(errp, "Zcmt extension requires Zicsr extension");
+        return;
+    }
+
+    /*
+     * In principle Zve*x would also suffice here, were they supported
+     * in qemu
+     */
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
+         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed || cpu->cfg.ext_zvksh) &&
+        !cpu->cfg.ext_zve32f) {
+        error_setg(errp,
+                   "Vector crypto extensions require V or Zve* extensions");
+        return;
+    }
+
+    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64f) {
+        error_setg(
+            errp,
+            "Zvbc and Zvknhb extensions require V or Zve64{f,d} extensions");
+        return;
+    }
+
+    if (cpu->cfg.ext_zk) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkn), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkr), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkt), true);
+    }
+
+    if (cpu->cfg.ext_zkn) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zkne), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknd), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zknh), true);
+    }
+
+    if (cpu->cfg.ext_zks) {
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkb), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkc), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zbkx), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksed), true);
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zksh), true);
+    }
+
+    /*
+     * Disable isa extensions based on priv spec after we
+     * validated and set everything we need.
+     */
+    riscv_cpu_disable_priv_spec_isa_exts(cpu);
+}
+
 /*
  * We'll get here via the following path:
  *
diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
new file mode 100644
index 0000000000..630184759d
--- /dev/null
+++ b/target/riscv/tcg/tcg-cpu.h
@@ -0,0 +1,27 @@
+/*
+ * riscv TCG cpu class initialization
+ *
+ * Copyright (c) 2023 Ventana Micro Systems Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_TCG_CPU_H
+#define RISCV_TCG_CPU_H
+
+#include "cpu.h"
+
+void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
+
+#endif
-- 
2.41.0


