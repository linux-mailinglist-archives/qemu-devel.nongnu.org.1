Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED42A7278B4
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q79zX-0002GX-1T; Thu, 08 Jun 2023 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q79zV-0002GN-Al
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:23:29 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q79zT-0006dj-No
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:23:29 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-19f454bd2c8so299858fac.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1686209007; x=1688801007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAX2xowVJiXansk3JI0g3G9zNclRDYMZLzHvwSFZ0uk=;
 b=mWDyjzZiUs+YyzsgxPMQn4hu6y/6c0W2CpFEsRdkaxfe3z+9bppin6ubEx07OeXPrU
 fyE1Ey/fJQp1BOJO/pudVOkRseaUunAna1AR9PjZBnYTl434WvthNoXxvE3pHGAbbZTN
 rrx1cvnp6gpA16wSxbVH8wlTen5e0dv6u3PDo/y1lybpjaKKZWLAZa1d/1nA1wTK0h1j
 zSx9Q54uWK7kpd1PeihsPsTz93MS2jk7JgbomTl3D0QFqYfhTl4OFXF7HS4Fc39KJwsB
 eFMT96s46Th8+xuXMOfN/gai/L4uc7m5T5dZPAAgSxhRodxaM+spBleO5Tq4ahARyoG9
 tE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686209007; x=1688801007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAX2xowVJiXansk3JI0g3G9zNclRDYMZLzHvwSFZ0uk=;
 b=crXQDvVYdIv/sytXZbtv57WB7tG6tkJrULYtsxEskJM8IMdLHU4mJGlg+0Iqe6K5Er
 1g0JcwXzC0in4ml61FcgpyAKaextXa4tD5XXj+v1cJtPDIb/hLIhUv/gnJElDm+KOh4g
 2y+hTKQ5b/Q7KoZEE3P5pnWEXu1xFBZDqR1vtxkGPxhc2t0dxtmrh0/fPxgn5m6UkV++
 UH1H/yafs6Pq4hTFdTWfEbIg9fgBrkLfxmujPIr1fvY1uUow6KzxCBVrsu9QMVxzWJLJ
 AoGYpKqg34BcABFYYdwElgFkc9OVDXL++ipErgtsS3H3swwo/vSEv/msY7/TcTBYsIx6
 U/Vg==
X-Gm-Message-State: AC+VfDyZjDPoV10xn6OSASNyalRGNHsXYhuGbN9cyQ26lVsIwkfk4VAN
 rN40fackBEjxRkOeGG0I4mF51BBhX92IXByPAX9PdRJtKMiv7LHWFh1TZzxMgm2v4PR5dSbnJGi
 Oy6E3fRIuRPNL2LMWLyfhUbjyOCgTeNko/fEqgcVVGaIlQ1MSEchP9CkexxfzsnwSCxIiPuijET
 Mk
X-Google-Smtp-Source: ACHHUZ5URLIUSAS31u3yMNkdFfGKiCxV/NPWG9pemkEbpw7rcgvLRQlnZ9zFN0h97ujbm+cqK0efMA==
X-Received: by 2002:a05:6870:3505:b0:19e:7696:2fc with SMTP id
 k5-20020a056870350500b0019e769602fcmr7222111oah.9.1686209005574; 
 Thu, 08 Jun 2023 00:23:25 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 x144-20020a4a4196000000b0051134f333d3sm274293ooa.16.2023.06.08.00.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 00:23:25 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v4 3/4] target/riscv: Handle Smrnmi interrupt and exception.
Date: Thu,  8 Jun 2023 00:23:13 -0700
Message-Id: <20230608072314.3561109-4-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608072314.3561109-1-tommy.wu@sifive.com>
References: <20230608072314.3561109-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=tommy.wu@sifive.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index da477b6c99..1a926bb661 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -407,6 +407,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
     int virq;
     uint64_t irqs, pending, mie, hsie, vsie;
 
+    /* Priority: RNMI > Other interrupt. */
+    if (riscv_cpu_cfg(env)->ext_smrnmi) {
+        /* If mnstatus.NMIE == 0, all interrupts are disabled. */
+        if (!get_field(env->mnstatus, MNSTATUS_NMIE)) {
+            return RISCV_EXCP_NONE;
+        }
+
+        if (env->rnmip) {
+            return ctz64(env->rnmip); /* since non-zero */
+        }
+    }
+
     /* Determine interrupt enable state of all privilege modes */
     if (env->virt_enabled) {
         mie = 1;
@@ -452,7 +464,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
+    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
+
+    if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
         int interruptno = riscv_cpu_local_irq_pending(env);
@@ -1614,6 +1628,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
     uint64_t s;
+    int mode;
 
     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
@@ -1626,6 +1641,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
+    bool nmi_execp = false;
+
+    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV,
+                                  env->virt_enabled);
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP,
+                                  env->priv);
+        env->mncause = cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1));
+        env->mnepc = env->pc;
+        env->pc = env->rnmi_irqvec;
+        riscv_cpu_set_mode(env, PRV_M);
+        goto handled;
+    }
 
     if  (cause == RISCV_EXCP_SEMIHOST) {
         do_common_semihosting(cs);
@@ -1712,8 +1741,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
 
-    if (env->priv <= PRV_S &&
-            cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
+    mode = env->priv <= PRV_S &&
+        cause < TARGET_LONG_BITS && ((deleg >> cause) & 1) ? PRV_S : PRV_M;
+
+    /*
+     * If the hart encounters an exception while executing in M-mode,
+     * with the mnstatus.NMIE bit clear, the program counter is set to
+     * the RNMI exception trap handler address.
+     */
+    nmi_execp = cpu->cfg.ext_smrnmi &&
+                !get_field(env->mnstatus, MNSTATUS_NMIE) &&
+                !async &&
+                mode == PRV_M;
+
+    if (mode == PRV_S) {
         /* handle the trap in S-mode */
         if (riscv_has_ext(env, RVH)) {
             uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
@@ -1788,8 +1829,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mtval = tval;
         env->mtval2 = mtval2;
         env->mtinst = tinst;
-        env->pc = (env->mtvec >> 2 << 2) +
-                  ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
+        if (cpu->cfg.ext_smrnmi && nmi_execp) {
+            env->pc = env->rnmi_excpvec;
+        } else {
+            env->pc = (env->mtvec >> 2 << 2) +
+                      ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
+        }
         riscv_cpu_set_mode(env, PRV_M);
     }
 
@@ -1802,6 +1847,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
+
+handled:
 #endif
     cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
-- 
2.31.1


