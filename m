Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC4953EC1
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 03:09:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRJ-0000yw-5F; Thu, 15 Aug 2024 21:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR8-0000nY-Lo
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR5-0002J1-9l
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so1238320b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770442; x=1724375242;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8b7a0gi99dpsPKxT9wPuan9wLTMnPj9TVhKehOaaRM=;
 b=nlNbp9ZPHPhb+yorKns9JPOTnlcRpIa2WDD2v6WPR6HOxi6JS7cmvVx3ElAqAJuSw1
 sbHaVA2riK0nd8arO4I/fyga5zewlDeoh13URe1eI3Ufy83s4LLcsSqkoDrHcv7P1xYm
 VVd22+tr/g2PQJ2ZXdaJWIdc4VbS0N7vOk/UjKrcZeBqGLFfN2JF2vezKKqoEm3b1naM
 bSo5yCVVfnjCGtqUWpJGogr1JMrq2nBe0AVLBNW3/LZInTFGJDQjj08s3LwEZK/PKFvR
 YLj6VeHl/J9RGAPLOF92MlTxJzQXlDm59XoW++bb0QDJjYnIWRd6DUKW+8USrrPiTkON
 djtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770442; x=1724375242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8b7a0gi99dpsPKxT9wPuan9wLTMnPj9TVhKehOaaRM=;
 b=qmSamWgXQkmeeORJBuTLwt9tLTZItTT5otGuYWlJc2gsXxtluDLMwM4c9Yao1WwCWz
 BfWi0hlzpcPCw5h29S5emCRmJz17gzBKPrfE61n/YgOnJGcfldQBt3F/zvoCqrmwGYMW
 8BP2p2yx2EIScX9Fm/Z7CB85C0jHxSI+4H1RhfW5tnNLqKvYaTmp8y4Gv5/AfBR0g2uc
 pfDUyHoHEM8YIGZMcySrPwLVcQbLltUKEJ0FhzbeF+uxqpYSv3FMMcobpSECqBuvcrP0
 FnnemoUPmgl2fGdz/6yAs+DTd154dkWuPEyciz+/EZ/PaW9Cn8/ABY6XxAqSS6GRwQqp
 d4KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjuPhTq4C+GlilDWZUGb6fAhUzR9Y7IvhCKUAOKctuRwwwk07cFv8wes4B0omOLhJkhQ7JB/O9KThnFHQW91nviXmN8a8=
X-Gm-Message-State: AOJu0Yw8haEuUDqbTSIQiRRSlRrzpgjduIhXan6+3RlezKOKHhdoW1VT
 AGRUEr8WQXUy1riCPbxh+LDRuMG+tzMrScZRd5PFj1HubVa783q47ynfZWplQMM86f8unqEnKPM
 j
X-Google-Smtp-Source: AGHT+IGJj4wbvfmzxLAeKa0hwDCafcGW/4VZKG4xspcToQHPwJmt3GM+2DsP6OVeVrTNo5D9YiKVRg==
X-Received: by 2002:a05:6a00:66ce:b0:70d:21b4:46ca with SMTP id
 d2e1a72fcca58-713c4e3e079mr1506409b3a.11.1723770441514; 
 Thu, 15 Aug 2024 18:07:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 03/16] target/riscv: save and restore elp state on priv
 transitions
Date: Thu, 15 Aug 2024 18:06:57 -0700
Message-ID: <20240816010711.3055425-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

elp state is recorded in *status on trap entry (less privilege to higher
privilege) and restored in elp from *status on trap exit (higher to less
privilege).

Additionally this patch introduces a forward cfi helper function to
determine if current privilege has forward cfi is enabled or not based on
*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
new field `ufcfien` is introduced which is by default set to false and
helper function returns value deposited in `ufcfien` for qemu-user.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.c        |  5 ++++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 18 +++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e1f05e5b1..083d405516 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 
+#ifdef CONFIG_USER_ONLY
+    /* qemu-user for riscv, fcfi is off by default */
+    env->ufcfien = false;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f966c36a31..7be0fa30f7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,6 +226,7 @@ struct CPUArchState {
     bool      elp;
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
+    bool ufcfien;
 #endif
 
 #ifndef CONFIG_USER_ONLY
@@ -530,6 +531,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..12484ca7d2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,34 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+#ifdef CONFIG_USER_ONLY
+    return env->ufcfien;
+#else
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return env->senvcfg & MENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +575,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
     bool current_virt = env->virt_enabled;
 
+    /*
+     * If zicfilp extension available and henvcfg.LPE = 1,
+     * then apply SPELP mask on mstatus
+     */
+    if (env_archcpu(env)->cfg.ext_zicfilp &&
+        get_field(env->henvcfg, HENVCFG_LPE)) {
+        mstatus_mask |= SSTATUS_SPELP;
+    }
+
     g_assert(riscv_has_ext(env, RVH));
 
     if (current_virt) {
@@ -1754,6 +1792,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected)) {
         /* handle the trap in S-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
 
@@ -1802,6 +1845,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
+        /* save elp status */
+        if (cpu_get_fcfien(env)) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
+        }
+
         if (riscv_has_ext(env, RVH)) {
             if (env->virt_enabled) {
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -1833,6 +1881,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M);
     }
 
+    /*
+     * Interrupt/exception/trap delivery is asynchronous event and as per
+     * zicfilp spec CPU should clear up the ELP state. No harm in clearing
+     * unconditionally.
+     */
+    env->elp = false;
+
     /*
      * NOTE: it is not necessary to yield load reservations here. It is only
      * necessary for an SC from "another hart" to cause a load reservation
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca..5848aaf437 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -313,6 +313,15 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv);
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear spelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
+
     return retpc;
 }
 
@@ -357,6 +366,15 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_cpu_set_virt_enabled(env, prev_virt);
     }
 
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mpelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_MPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
+
     return retpc;
 }
 
-- 
2.44.0


