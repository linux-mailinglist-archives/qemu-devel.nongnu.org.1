Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BB9775BB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 01:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotd2-0004aC-TF; Thu, 12 Sep 2024 19:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcz-0004O1-96
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcx-00087o-EB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so1297322a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185210; x=1726790010;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3fhINZSx5ghMlTitfFFmHEIn/w1CK0xQ5bZQ2eIF2c=;
 b=LhHvJ2ocyZKPVDsIN9PHndguWMEuo4j5S66tXyZrU5KS6/KVfACMzE2lbn1SascheP
 boHIQgtrveeNYhCCKWmoV2xz2OPIMVxKb9evw4+73znXmMxRgHq+YKWrnXsOPz8Exe2k
 SjEDfbfSdBtjr2A4GE7sVLijvKAlnAMWZGxOyUeY8SRAO9TYcRNvn07Gr0iw/uMzwSXk
 L3UbRSgrA2qbdswvN15+k3UBi8IaeOLqGTF59OyWFRRQWjf7AHQLOQ6WkY3YUAOn1gb7
 a5f7PYHRBsgbQkco8tBq4IXR0rw1EnyWVmEWkhDKFjmFI5/W6TdvTepH3shmXX5DghED
 nBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185210; x=1726790010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3fhINZSx5ghMlTitfFFmHEIn/w1CK0xQ5bZQ2eIF2c=;
 b=RVFXZOk5tsYxAWncYj1M/xo66hGzNehT39qL4qDZExQWO+/DNQzEYjUALnxWZV5AFA
 O0oWsQUDJfA9HyRb97woW7m3Zg+HCFg5o9Gfux3B/qixUOU2YW6PcEbAipAb88KxOP24
 lFHYtZtsQ15OqzDUBWSpGoLGAUzAPZ+qBMWOQTU6UUfb5I9WnEa8NaIc5xZyanRprTW0
 FVtHPZZm08aevEQ1loX0JwywMmhcfhMXkr0ldcfmKXGnAYUeBWeqNMearWXNbXlE/5Tt
 lNIdbpwj1AxbwZGVr4qQzy1HUxY9byFKo9yi3txiOfYip6oTr5S87QmQYDm0i21cfn0/
 37IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPoQWCaM1l3i5ocxvXDi87vZ5QZt24nuYBCm5lFRGh6gIfvoL0AJK5UDfs6kl+UMWP1HLq8Ray13f@nongnu.org
X-Gm-Message-State: AOJu0Yx0qTUA7owPwxZutdH0toRUuODQOkE/i8vskfM28tYaZcEB2lY6
 vYrMz7UuCyonNj67gK2GUrHZEWoqWeKhhwFOHRWS8MXIxZ1/mWoenszvpGBOvjU=
X-Google-Smtp-Source: AGHT+IEcCb9TOgBjE8aK6ahF+TnHQYpQoa9LoPFFyRoH7ZJNdDsfNn41H8H5Lya9YC9PiK3gnOx2Kw==
X-Received: by 2002:a05:6a21:4d8c:b0:1cc:e101:ee64 with SMTP id
 adf61e73a8af0-1cf75599a20mr7231736637.1.1726185209767; 
 Thu, 12 Sep 2024 16:53:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v14 04/20] target/riscv: save and restore elp state on priv
 transitions
Date: Thu, 12 Sep 2024 16:53:04 -0700
Message-ID: <20240912235320.3768582-5-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52e.google.com
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

elp state is recorded in *status on trap entry (less privilege to higher
privilege) and restored in elp from *status on trap exit (higher to less
privilege).

Additionally this patch introduces a forward cfi helper function to
determine if current privilege has forward cfi is enabled or not based on
*envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M).

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 54 +++++++++++++++++++++++++++++++++++++++
 target/riscv/op_helper.c  | 17 ++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e9f26b5121..6c5e199e72 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,6 +547,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a935377b4a..d7b776c556 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,6 +33,7 @@
 #include "cpu_bits.h"
 #include "debug.h"
 #include "tcg/oversized-guest.h"
+#include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
@@ -63,6 +64,33 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
+bool cpu_get_fcfien(CPURISCVState *env)
+{
+    /* no cfi extension, return false */
+    if (!env_archcpu(env)->cfg.ext_zicfilp) {
+        return false;
+    }
+
+    switch (env->priv) {
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            return env->senvcfg & SENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+#ifndef CONFIG_USER_ONLY
+    case PRV_S:
+        if (env->virt_enabled) {
+            return env->henvcfg & HENVCFG_LPE;
+        }
+        return env->menvcfg & MENVCFG_LPE;
+    case PRV_M:
+        return env->mseccfg & MSECCFG_MLPE;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -546,6 +574,15 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
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
@@ -1760,6 +1797,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -1808,6 +1850,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S, virt);
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
@@ -1839,6 +1886,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_M, virt);
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
index 25a5263573..eddedacf4b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -309,6 +309,15 @@ target_ulong helper_sret(CPURISCVState *env)
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
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
 
@@ -349,6 +358,14 @@ target_ulong helper_mret(CPURISCVState *env)
     }
 
     riscv_cpu_set_mode(env, prev_priv, prev_virt);
+    /*
+     * If forward cfi enabled for new priv, restore elp status
+     * and clear mpelp in mstatus
+     */
+    if (cpu_get_fcfien(env)) {
+        env->elp = get_field(env->mstatus, MSTATUS_MPELP);
+    }
+    env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
 
     return retpc;
 }
-- 
2.45.0


