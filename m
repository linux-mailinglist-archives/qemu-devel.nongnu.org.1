Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341E93FCD9
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 19:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZQ-0006CT-J6; Mon, 29 Jul 2024 13:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ9-0004yx-Ca
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:48 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ7-0000Kh-Ds
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:47 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d634c5907so2308294fac.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275624; x=1722880424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UB4g4AW4kPdAduQAIH9J9HggkXdBpq+4KbcMBQUEh2k=;
 b=P3bLKOBnYV0m9Go3/KOoa15TRtAPhONt1Ir1o4f83ttpjKh+P32aMpxJ8cbKevCGsC
 iDrs6ftcsB0J5JqmSxRFXCjQjM6svzNc1xxVAv4WgnDONU1i1bb/ZZyCv0hEVr4OCwXH
 Pqy2XCngdcF2ZNNzL/CkZwBThB3Z4Pwk0z1nq993FcJODljPcWb3QUNL4xv8B9LDETBM
 tzaMO/YPcwipXeNC8a6qz6s3jOGMie9Tk1GH7eUzGdSDG6m1dufGadZHKbF0aVzjJj7N
 OfWPvJAkOYcarSBRH5BTYmFHWEwIEwk5wDw0mxF2VULfLfJWtSFXxjLY9jia0h0h7/II
 mtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275624; x=1722880424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UB4g4AW4kPdAduQAIH9J9HggkXdBpq+4KbcMBQUEh2k=;
 b=fwO55P8gUki6S1CbRTM11knGEc3+gD8s6HunL1hSvcuWPgPOdwFvogZgNP48uwDf8x
 LOvQYZa6j+LMUNqcnZ1GDJudhI9wvB4nLE9Tc5lDtAHKjMPnGhRozgO+AWNkYF2BaEh6
 vG6VtJdOHzHUozgmcfguAEiu+EZfNWZYl+ylg3hSxxJ7feGt9c6gwxH20NmDetmzRkqC
 zK2Cs8jkuIg79wlEFUl/b8te9NaF1fCgshMp3JfwWyTPjmb1NeCWDz6p84vwKCYE8GZE
 IrllJ43ypBJb98qEo8Lli+M+YgV28Wsa4uthk2nVoas1aWWJnt1KY3r4wakUHwhNzkWf
 oL+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLpb1av1LabVEGWIhPzP/mwlrL4hQRe0VdXoKHiE/NnB99X/tNwJwDRcbGEGv3B0yp9biT2EXNWqt6VtibtgAmJfbtE5M=
X-Gm-Message-State: AOJu0YxfXnpDgIFoAfSrfnpRM8RJSsK/BOIzgP3Xx/B8m7W4hVflCTQs
 ne4VCXFFXgKYHwyNZbdvX5csZ4KYKHfC5qU3pWy19AL8ZNWT+RWeEc6ELH0/+5A=
X-Google-Smtp-Source: AGHT+IFO+vcSH7APWFf5jxojh4ssJndI3u0cGbuurEkR46fyja72wNHNXr3HprDSB861CGo6/DQauw==
X-Received: by 2002:a05:6870:80d3:b0:260:e7ed:27f4 with SMTP id
 586e51a60fabf-267d4d82a4fmr10353962fac.27.1722275624250; 
 Mon, 29 Jul 2024 10:53:44 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 11/24] target/riscv: introduce ssp and enabling controls
 for zicfiss
Date: Mon, 29 Jul 2024 10:53:13 -0700
Message-ID: <20240729175327.73705-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x35.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c      |  3 ++
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  6 ++++
 target/riscv/csr.c      | 74 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54fcf380ff..6b50ae0e45 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -998,6 +998,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     /* on reset elp is set to NO_LP_EXPECTED */
     env->elp = NO_LP_EXPECTED;
 
+    /* on reset ssp is set to 0 */
+    env->ssp = 0;
+
     /*
      * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
      * extension is enabled.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7fed5d2750..81283a1d76 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,8 @@ struct CPUArchState {
 
     /* elp state for zicfilp extension */
     cfi_elp      elp;
+    /* shadow stack register for zicfiss extension */
+    target_ulong ssp;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 477e24feaf..589326e516 100644
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
@@ -760,6 +763,7 @@ typedef enum RISCVException {
 /* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_LPE                        BIT(2) /* zicfilp */
+#define MENVCFG_SSE                        BIT(3) /* zicfiss */
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
@@ -774,12 +778,14 @@ typedef enum RISCVException {
 
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
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a5a969a377..d72d6289fb 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -185,6 +185,47 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException cfi_ss(CPURISCVState *env, int csrno)
+{
+    /* no cfi extension, access to csr is illegal */
+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /*
+     * CONFIG_USER_MODE always allow access for now. Better for user mode only
+     * functionality
+     */
+#if !defined(CONFIG_USER_ONLY)
+    if (env->debugger) {
+        return RISCV_EXCP_NONE;
+    }
+    /* current priv not M */
+    if (env->priv != PRV_M) {
+        /* menvcfg says no shadow stack enable */
+        if (!get_field(env->menvcfg, MENVCFG_SSE)) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+
+        /* V = 1 and henvcfg says no shadow stack enable */
+        if (env->virt_enabled &&
+            !get_field(env->henvcfg, HENVCFG_SSE)) {
+            return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        }
+
+        /*
+         * SSP are not accessible to U mode if disabled via senvcfg
+         * CSR
+         */
+        if ((env->priv == PRV_U) &&
+            (!get_field(env->senvcfg, SENVCFG_SSE))) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+    }
+#endif
+
+    return RISCV_EXCP_NONE;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static RISCVException mctr(CPURISCVState *env, int csrno)
 {
@@ -596,6 +637,19 @@ static RISCVException seed(CPURISCVState *env, int csrno)
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
@@ -2111,6 +2165,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if (env_archcpu(env)->cfg.ext_zicfilp) {
             mask |= MENVCFG_LPE;
         }
+
+        if (env_archcpu(env)->cfg.ext_zicfiss) {
+            mask |= MENVCFG_SSE;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2167,6 +2225,13 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
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
@@ -2208,6 +2273,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
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
@@ -4663,6 +4734,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Zcmt Extension */
     [CSR_JVT] = {"jvt", zcmt, read_jvt, write_jvt},
 
+    /* zicfiss Extension, shadow stack register */
+    [CSR_SSP]  = { "ssp", cfi_ss, read_ssp, write_ssp },
+
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
     [CSR_MCYCLE]    = { "mcycle",    any,   read_hpmcounter,
-- 
2.44.0


