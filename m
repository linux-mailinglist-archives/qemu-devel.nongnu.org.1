Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E69775BD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 01:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotdB-0005BU-Bv; Thu, 12 Sep 2024 19:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd8-00053g-QY
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd6-0008Ai-Ph
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:42 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so1947778b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185219; x=1726790019;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2U753PKEt+vnSNTrfcmtA4tw3Grxus2FebHFCCNQ+g=;
 b=1ASdpFinzYDWg8Vs8MBPNzRIrsKeCF+ENxAYlHkt5JtKWIC+Qp7ixmrYCTW2ggsh2c
 +GulUO3JDB43UslfkF52ooTD7pAIGa2ByRCWSbg1NGS1DItWlsEHc28o3Eqb1xSXvi47
 RGnLklyd5NgX80Ss0d10o3Caxgdhy5ldk/KllcnkR/xFWBI85tuzgxC9BQLrCRUEg6Tr
 +eWx7a5TzLcyf+YlKgP3NX50n2WVxZkveMcQUMF493J6dJo0V8WfQugs6BLfr2hIhNxs
 Jnn7VM52lBavWMaHijKUmf1pOs2V0p6XpUtgJuV7ln8xrPigO5nI0bzVgD5RZY+MNtjz
 xcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185219; x=1726790019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2U753PKEt+vnSNTrfcmtA4tw3Grxus2FebHFCCNQ+g=;
 b=mqWcR3DgxINVTOkQQhnCEj3eqgRjqUYcNmrZswSQpS8IF7Eo/hwSYI1Ie1LfKDS8YV
 iZ/WHu+z3Y9fBGKpNgaFrRQJaR5hhlmhZZK8Qf/W0cDgLlYtJJmEWr9tJl8OBaMNTh+l
 +m+JkzOlkN5IpwqRnt2zevFKflcokrLivqfWiLjSKtrmTRgLM5545awxmPu8vvz3PX88
 4iXbAn93gn206NisFyPu7u7GukRSM6vLOo+la/tKD2+Rgb9q9Aasq5A3Aa5v1dXV2fKg
 GVbdorqv7DV92Fg07IjFJflITC7fSGQOJKie5zEDWMhGY6vveshKotlU4Z8XVXYGWc7C
 YdBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5vBRagHIIjoUs/LPvQt9FVXGvzFUdfVWrHyYdRf4ANWxPgHj8NHca22FRXg/jqGiDx+z1PIXH0mIm@nongnu.org
X-Gm-Message-State: AOJu0YyKx8BlxS9kJI8hdU+CvvDYdj9OBo4OtzCE2dw4z9VWBMGZ4Ge+
 4nOGsOmoDw/7bnyC51a8ZxvQeVDTi0DZbvR6QlElkvS3ate8N6oGFHGp+xIhd5o=
X-Google-Smtp-Source: AGHT+IFKsgRLHI36gDDtXoQolyGwNTzL3lGSZu/oGdpbK8nXtDlPe9/QGzH88HFWT3vEPtCQ78hVJw==
X-Received: by 2002:a05:6a00:61cb:b0:717:92d8:ca5c with SMTP id
 d2e1a72fcca58-71907e8ca91mr16166797b3a.3.1726185219451; 
 Thu, 12 Sep 2024 16:53:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 11/20] target/riscv: introduce ssp and enabling controls
 for zicfiss
Date: Thu, 12 Sep 2024 16:53:11 -0700
Message-ID: <20240912235320.3768582-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfiss introduces a new state ssp ("shadow stack register") in cpu.
ssp is expressed as a new unprivileged csr (CSR_SSP=0x11) and holds
virtual address for shadow stack as programmed by software.

Shadow stack (for each mode) is enabled via bit3 in *envcfg CSRs.
Shadow stack can be enabled for a mode only if it's higher privileged
mode had it enabled for itself. M mode doesn't need enabling control,
it's always available if extension is available on cpu.

This patch also implements helper bcfi function which determines if bcfi
is enabled at current privilege or not.

Adds ssp to migration state as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  6 +++++
 target/riscv/cpu_helper.c | 29 ++++++++++++++++++++++
 target/riscv/csr.c        | 52 +++++++++++++++++++++++++++++++++++++++
 target/riscv/machine.c    | 19 ++++++++++++++
 6 files changed, 111 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f5513fab03..4172774087 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1034,6 +1034,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
     /* on reset elp is clear */
     env->elp = false;
+    /* on reset ssp is set to 0 */
+    env->ssp = 0;
 
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ba4bc212c7..997b579526 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -232,6 +232,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     bool      elp;
+    /* shadow stack register for zicfiss extension */
+    target_ulong ssp;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
@@ -550,6 +552,7 @@ bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
 bool cpu_get_fcfien(CPURISCVState *env);
+bool cpu_get_bcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e7387c9b8f..8223beaceb 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -34,6 +34,9 @@
 
 /* Control and Status Registers */
 
+/* zicfiss user ssp csr */
+#define CSR_SSP             0x011
+
 /* User Trap Setup */
 #define CSR_USTATUS         0x000
 #define CSR_UIE             0x004
@@ -761,6 +764,7 @@ typedef enum RISCVException {
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
+#define MENVCFG_SSE                        BIT(3) /* zicfiss */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -775,12 +779,14 @@ typedef enum RISCVException {
 
 #define SENVCFG_FIOM                       MENVCFG_FIOM
 #define SENVCFG_LPE                        MENVCFG_LPE
+#define SENVCFG_SSE                        MENVCFG_SSE
 #define SENVCFG_CBIE                       MENVCFG_CBIE
 #define SENVCFG_CBCFE                      MENVCFG_CBCFE
 #define SENVCFG_CBZE                       MENVCFG_CBZE
 
 #define HENVCFG_FIOM                       MENVCFG_FIOM
 #define HENVCFG_LPE                        MENVCFG_LPE
+#define HENVCFG_SSE                        MENVCFG_SSE
 #define HENVCFG_CBIE                       MENVCFG_CBIE
 #define HENVCFG_CBCFE                      MENVCFG_CBCFE
 #define HENVCFG_CBZE                       MENVCFG_CBZE
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1c89b126dd..934bbff579 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -91,6 +91,35 @@ bool cpu_get_fcfien(CPURISCVState *env)
     }
 }
 
+bool cpu_get_bcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        /*
+         * If S is not implemented then shadow stack for U can't be turned on
+         * It is checked in `riscv_cpu_validate_set_extensions`, so no need to
+         * check here or assert here
+         */
+        return env->senvcfg & SENVCFG_SSE;
+#ifndef CONFIG_USER_ONLY
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_SSE;
+        }
+        return env->menvcfg & MENVCFG_SSE;
+    case PRV_M: /* M-mode shadow stack is always off */
+        return false;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 919de7970c..604c2698ad 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -184,6 +184,25 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
+{
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* if bcfi not active for current env, access to csr is illegal */
+    if (!cpu_get_bcfien(env)) {
+#if !defined(CONFIG_USER_ONLY)
+        if (env->debugger) {
+            return RISCV_EXCP_NONE;
+        }
+#endif
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
@@ -622,6 +641,19 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 #endif
 }
 
+/* zicfiss CSR_SSP read and write */
+static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->ssp;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->ssp = val;
+    return RISCV_EXCP_NONE;
+}
+
 /* User Floating-Point CSRs */
 static RISCVException read_fflags(CPURISCVState *env, int csrno,
                                   target_ulong *val)
@@ -2354,6 +2386,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
         }
+
+        if (env_archcpu(env)->cfg.ext_zicfiss) {
+            mask |= MENVCFG_SSE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2410,6 +2446,13 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
         mask |= SENVCFG_LPE;
     }
 
+    /* Higher mode SSE must be ON for next-less mode SSE to be ON */
+    if (env_archcpu(env)->cfg.ext_zicfiss &&
+        get_field(env->menvcfg, MENVCFG_SSE) &&
+        (env->virt_enabled ? get_field(env->henvcfg, HENVCFG_SSE) : true)) {
+        mask |= SENVCFG_SSE;
+    }
+
     env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
     return RISCV_EXCP_NONE;
 }
@@ -2451,6 +2494,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= HENVCFG_LPE;
         }
+
+        /* H can light up SSE for VS only if HS had it from menvcfg */
+        if (env_archcpu(env)->cfg.ext_zicfiss &&
+            get_field(env->menvcfg, MENVCFG_SSE)) {
+            mask |= HENVCFG_SSE;
+        }
     }
 
     env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
@@ -4966,6 +5015,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
+    /* zicfiss Extension, shadow stack register */
+    [CSR_SSP]  = { "ssp", cfi_ss, read_ssp, write_ssp },
+
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c3a06c288d..99f0af5077 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -368,6 +368,24 @@ static const VMStateDescription vmstate_elp = {
     }
 };
 
+static bool ssp_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_zicfiss;
+}
+
+static const VMStateDescription vmstate_ssp = {
+    .name = "cpu/ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ssp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -441,6 +459,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
+        &vmstate_ssp,
         NULL
     }
 };
-- 
2.45.0


