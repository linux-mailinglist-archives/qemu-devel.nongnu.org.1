Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFC92F200
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 00:33:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KB-00005E-O5; Thu, 11 Jul 2024 18:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2K8-0008R8-T4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2K6-0001YB-56
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb70169c23so12917635ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737091; x=1721341891;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sq6ZPtLM8cZpjKl0EALHfFJyJDausZH14SH/XMvmzaY=;
 b=i8GhUYZHr9HnomUP8iloRqDQMc/lAqv1RxmTJN3Qu4nNdvsyXzP0sqo5p4YLiqJ34S
 gZ0n5rhvN2BFR0syGPnkAT0XWJcs57OeT56XLUgGYch+FN0BZEcKmICJnhuec1hY4UzH
 wcr3Ym1H963JZGRTNmwrT9Zxb4wdg0e+3Uabg4lqFBsIHVlFaPWat/R9yO29k8fcaDOA
 m9zdIXUeD0437jeBkrQDn40fH8rAl3+wyAXgdrJ++LcOcW0dCbj4s6DXCMLQ2wspPJUH
 VMgeHD98ijqer0K53RpHwYTPqOafpDLyHs1fiavtd/kNwWdRHo5gFmRxr/W9hFwcatRq
 gdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737091; x=1721341891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sq6ZPtLM8cZpjKl0EALHfFJyJDausZH14SH/XMvmzaY=;
 b=m64ikvN/xGwLkVA7U0xaN/SL0JatBTuhLex+wc9uqMFKS38GcJYTxFFz7vE9rcWT1W
 Yrw9kE97DKbY4G2I/d9xut/9cari2qRYvSjXEwZqaboqEBKb/zNUVkIDIICMzdV/qZWL
 RT1eSPvEItLM0a7oNidDeqHY6V7h4xDQxyA9QSltriT8oxOIeRUbSf/qRpf4pEj9mD/6
 p+6J+MLVzxlNtwn5fQ2Gtj5OxWqW/GQqvUubzg/sQw0nhT1skdvhnuL98LAc6IPL94ZG
 MGQryrZvlRSMrj50Z88EErfo4n4FjtUMFS/muYZcWUAJHVbdOg5spsOj2PWHf4ln3KC6
 4tMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpQLA2+B5T/8xVop5Oe7AwAsfTI1GO+dc1UFbTnflL5ZUMKFhxSdYd0uhKYWjBeQKFFMN+fNFlD+dL4CsiMs8LKhwxWJw=
X-Gm-Message-State: AOJu0YzYdFc5itE4Jdgp/Cwqc8hRN1frSzTg98o9uYjpNaLYC5wKAcvQ
 prynvpV9MIhs1WunwjfJXAvSW46lR4XE/gOzswgoCC/Uzksp+FjORtjm3cQMad8=
X-Google-Smtp-Source: AGHT+IEtRllJw58z5xoeI0uAXNqfsZR17+zreonrSt2yP+iSgMMPrIVcYAX/uaxpldPIaUa4WHsMdQ==
X-Received: by 2002:a17:902:dacb:b0:1fb:284b:b39a with SMTP id
 d9443c01a7336-1fbb6d044a5mr91533685ad.21.1720737090565; 
 Thu, 11 Jul 2024 15:31:30 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:30 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:04 -0700
Subject: [PATCH v8 01/13] target/riscv: Combine set_mode and set_virt
 functions.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-1-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Combining riscv_cpu_set_virt_enabled() and riscv_cpu_set_mode()
functions. This is to make complete mode change information
available through a single function.

This allows to easily differentiate between HS->VS, VS->HS
and VS->VS transitions when executing state update codes.
For example: One use-case which inspired this change is
to update mode-specific instruction and cycle counters
which requires information of both prev mode and current
mode.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h        |  2 +-
 target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++------------------------
 target/riscv/op_helper.c  | 17 +++++---------
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 90b8f1b08f83..46faefd24e09 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -544,7 +544,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3ab..10d3fdaed376 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -619,30 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
     env->geilen = geilen;
 }
 
-/* This function can only be called to set virt when RVH is enabled */
-void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
-{
-    /* Flush the TLB on all virt mode changes. */
-    if (env->virt_enabled != enable) {
-        tlb_flush(env_cpu(env));
-    }
-
-    env->virt_enabled = enable;
-
-    if (enable) {
-        /*
-         * The guest external interrupts from an interrupt controller are
-         * delivered only when the Guest/VM is running (i.e. V=1). This means
-         * any guest external interrupt which is triggered while the Guest/VM
-         * is not running (i.e. V=0) will be missed on QEMU resulting in guest
-         * with sluggish response to serial console input and other I/O events.
-         *
-         * To solve this, we check and inject interrupt after setting V=1.
-         */
-        riscv_cpu_update_mip(env, 0, 0);
-    }
-}
-
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
@@ -715,7 +691,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
     }
 }
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
+void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
@@ -736,6 +712,28 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
      * preemptive context switch. As a result, do both.
      */
     env->load_res = -1;
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Flush the TLB on all virt mode changes. */
+        if (env->virt_enabled != virt_en) {
+            tlb_flush(env_cpu(env));
+        }
+
+        env->virt_enabled = virt_en;
+        if (virt_en) {
+            /*
+             * The guest external interrupts from an interrupt controller are
+             * delivered only when the Guest/VM is running (i.e. V=1). This
+             * means any guest external interrupt which is triggered while the
+             * Guest/VM is not running (i.e. V=0) will be missed on QEMU
+             * resulting in guest with sluggish response to serial console
+             * input and other I/O events.
+             *
+             * To solve this, we check and inject interrupt after setting V=1.
+             */
+            riscv_cpu_update_mip(env, 0, 0);
+        }
+    }
 }
 
 /*
@@ -1648,6 +1646,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool virt = env->virt_enabled;
     bool write_gva = false;
     uint64_t s;
 
@@ -1778,7 +1777,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
                 htval = env->guest_phys_fault_addr;
 
-                riscv_cpu_set_virt_enabled(env, 0);
+                virt = false;
             } else {
                 /* Trap into HS mode */
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV, false);
@@ -1799,7 +1798,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->htinst = tinst;
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
-        riscv_cpu_set_mode(env, PRV_S);
+        riscv_cpu_set_mode(env, PRV_S, virt);
     } else {
         /* handle the trap in M-mode */
         if (riscv_has_ext(env, RVH)) {
@@ -1815,7 +1814,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             mtval2 = env->guest_phys_fault_addr;
 
             /* Trapping to M mode, virt is disabled */
-            riscv_cpu_set_virt_enabled(env, 0);
+            virt = false;
         }
 
         s = env->mstatus;
@@ -1830,7 +1829,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mtinst = tinst;
         env->pc = (env->mtvec >> 2 << 2) +
                   ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
-        riscv_cpu_set_mode(env, PRV_M);
+        riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
     /*
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2baf5bc3ca19..ec1408ba0fb1 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -264,7 +264,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
 target_ulong helper_sret(CPURISCVState *env)
 {
     uint64_t mstatus;
-    target_ulong prev_priv, prev_virt;
+    target_ulong prev_priv, prev_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -307,11 +307,9 @@ target_ulong helper_sret(CPURISCVState *env)
         if (prev_virt) {
             riscv_cpu_swap_hypervisor_regs(env);
         }
-
-        riscv_cpu_set_virt_enabled(env, prev_virt);
     }
 
-    riscv_cpu_set_mode(env, prev_priv);
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
 
     return retpc;
 }
@@ -347,16 +345,13 @@ target_ulong helper_mret(CPURISCVState *env)
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
     env->mstatus = mstatus;
-    riscv_cpu_set_mode(env, prev_priv);
-
-    if (riscv_has_ext(env, RVH)) {
-        if (prev_virt) {
-            riscv_cpu_swap_hypervisor_regs(env);
-        }
 
-        riscv_cpu_set_virt_enabled(env, prev_virt);
+    if (riscv_has_ext(env, RVH) && prev_virt) {
+        riscv_cpu_swap_hypervisor_regs(env);
     }
 
+    riscv_cpu_set_mode(env, prev_priv, prev_virt);
+
     return retpc;
 }
 

-- 
2.34.1


