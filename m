Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19358B17DA
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 02:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYK-0008RF-Kl; Wed, 24 Apr 2024 20:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXv-0008Hg-8Y
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXp-0006IQ-Sy
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso3767685ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003256; x=1714608056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=896AziD89xiuMmVpTfvtSKDrdYS14/szB8aj28YLoDU=;
 b=vM969dZzWl2CZHaPyecu9wIAw2sOIS30nskl2danps9tG3pIWlUEFLMlgUonObv/H3
 LMczEgn7eNI9GOHI1Z2MRQTjonARVxUPxMeXaR8JcTjdC+9TWlILNI05bXnGkqOzIjQS
 6vwVlxI8LmFS/gAJydaKEdM4mEYlC3CznuaUe/fxjExwhM51SZHAsdN9XedRMxuAr4n8
 jDnCw65IZ/oIlCOrteXTc7bqYjsLXc5prLDMcn/zYucHL+JFFxLCdkh5K660VS0ZsMxU
 7M9p+qelAioNDWtwuUnHlaI+ISQDDd/Zi/49EcIrcTocw1n9PLt9rnZ8MRrk9vU0cLkA
 KIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003256; x=1714608056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=896AziD89xiuMmVpTfvtSKDrdYS14/szB8aj28YLoDU=;
 b=gcURgpEEuu1lKlfnDDu3/g4iZGQelnH5dYj0y2WW+VGiO6Ko/FEmT+poI+rjDVjWXS
 A9FiiIRDnQiOGHeml7bKdBwjFrzTsPPObdU+dWrJGCAV8cy0H+3DOBRxpx45QHknNp3t
 zATdzTWrZ83HK6uPmx9wKqOYeEfGz3hcOCcl+k8vwRQ+xuVj034w7hQ3d/XFtowZ0ZKN
 KFQQgCywZBz+ZVkpusJAtXjyRDDvbGgu4RT6FzO/kX1IM6NKWjP91x7jiGe844QBgnfk
 E0g4u/R7HkbYsqE2xAOzpMRJhMCDDDOjMuwexShxSDrs4T7VSzBDpNSiE7Et3vHJrhqB
 QcSA==
X-Gm-Message-State: AOJu0YxVq3qXQTYG7Fs7UWs5oiZw/etAWXg4AMdRIqBPpg9Iltg2KiOo
 zLFq7ZeXVUhz9M2nQ+2dUpB3QTr2KAlPjgAPHQ0UHjXDAxs36Xkbfb2TEE8DKlBX8yn5iaN3BG3
 l
X-Google-Smtp-Source: AGHT+IElsTkakTx++0DdzXrCicB9Up1QLArnpNJp57SVF9Q7ETuBzOHZsjL69PGo8wIJfmPnGLbP6g==
X-Received: by 2002:a17:903:1209:b0:1e4:b4f5:5cfa with SMTP id
 l9-20020a170903120900b001e4b4f55cfamr4972319plh.27.1714003256432; 
 Wed, 24 Apr 2024 17:00:56 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/45] target/hppa: Store full iaoq_f and page bits of iaoq_d
 in TB
Date: Wed, 24 Apr 2024 17:00:10 -0700
Message-Id: <20240425000023.1002026-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

In preparation for CF_PCREL. store the iaoq_f in 3 parts: high
bits in cs_base, middle bits in pc, and low bits in priv.
For iaoq_b, set a bit for either of space or page differing,
else the page offset.

Install iaq entries before goto_tb. The change to not record
the full direct branch difference in TB means that we have to
store at least iaoq_b before goto_tb.  But we since we'll need
both updated before goto_tb for CF_PCREL, do that now.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  2 ++
 target/hppa/cpu.c       | 72 ++++++++++++++++++-----------------------
 target/hppa/translate.c | 29 +++++++++--------
 3 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 4514bc63dc..66cae795bd 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -347,6 +347,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_SR_SAME     PSW_I
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
+#define CS_BASE_DIFFPAGE    (1 << 12)
+#define CS_BASE_DIFFSPACE   (1 << 13)
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 8c8c6181de..003af63e20 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -48,36 +48,43 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
+                          uint64_t *pcsbase, uint32_t *pflags)
 {
     uint32_t flags = env->psw_n * PSW_N;
+    uint64_t cs_base = 0;
+
+    /*
+     * TB lookup assumes that PC contains the complete virtual address.
+     * If we leave space+offset separate, we'll get ITLB misses to an
+     * incomplete virtual address.  This also means that we must separate
+     * out current cpu privilege from the low bits of IAOQ_F.
+     */
+    *pc = hppa_cpu_get_pc(env_cpu(env));
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    if (hppa_is_pa20(env)) {
+        cs_base = env->iaoq_f & MAKE_64BIT_MASK(32, 32);
+    }
+
+    /*
+     * The only really interesting case is if IAQ_Back is on the same page
+     * as IAQ_Front, so that we can use goto_tb between the blocks.  In all
+     * other cases, we'll be ending the TranslationBlock with one insn and
+     * not linking between them.
+     */
+    if (env->iasq_f != env->iasq_b) {
+        cs_base |= CS_BASE_DIFFSPACE;
+    } else if ((env->iaoq_f ^ env->iaoq_b) & TARGET_PAGE_MASK) {
+        cs_base |= CS_BASE_DIFFPAGE;
+    } else {
+        cs_base |= env->iaoq_b & ~TARGET_PAGE_MASK;
+    }
 
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
     /* ??? E, T, H, L, B bits need to be here, when implemented.  */
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_cpu_get_pc(env_cpu(env));
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
     if ((env->sr[4] == env->sr[5])
         & (env->sr[4] == env->sr[6])
         & (env->sr[4] == env->sr[7])) {
@@ -85,6 +92,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     }
 #endif
 
+    *pcsbase = cs_base;
     *pflags = flags;
 }
 
@@ -93,25 +101,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-
-#ifdef CONFIG_USER_ONLY
-    cpu->env.iaoq_f = tb->pc | PRIV_USER;
-    cpu->env.iaoq_b = tb->cs_base | PRIV_USER;
-#else
-    /* Recover the IAOQ values from the GVA + PRIV.  */
-    uint32_t priv = (tb->flags >> TB_FLAG_PRIV_SHIFT) & 3;
-    target_ulong cs_base = tb->cs_base;
-    target_ulong iasq_f = cs_base & ~0xffffffffull;
-    int32_t diff = cs_base;
-
-    cpu->env.iasq_f = iasq_f;
-    cpu->env.iaoq_f = (tb->pc & ~iasq_f) + priv;
-    if (diff) {
-        cpu->env.iaoq_b = cpu->env.iaoq_f + diff;
-    }
-#endif
-
+    /* IAQ is always up-to-date before goto_tb. */
     cpu->env.psw_n = (tb->flags & PSW_N) != 0;
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 273691fd6a..cc409ffe13 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -768,12 +768,11 @@ static bool use_nullify_skip(DisasContext *ctx)
 static void gen_goto_tb(DisasContext *ctx, int which,
                         const DisasIAQE *f, const DisasIAQE *b)
 {
+    install_iaq_entries(ctx, f, b);
     if (use_goto_tb(ctx, f, b)) {
         tcg_gen_goto_tb(which);
-        install_iaq_entries(ctx, f, b);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        install_iaq_entries(ctx, f, b);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -4574,6 +4573,7 @@ static bool trans_diag_unimp(DisasContext *ctx, arg_diag_unimp *a)
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint64_t cs_base, iaoq_f, iaoq_b;
     int bound;
 
     ctx->cs = cs;
@@ -4583,29 +4583,30 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_first = ctx->base.pc_first | ctx->privilege;
-    ctx->iaq_b.disp = ctx->base.tb->cs_base - ctx->base.pc_first;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D
                     ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
                     : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
+#endif
 
     /* Recover the IAOQ values from the GVA + PRIV.  */
-    uint64_t cs_base = ctx->base.tb->cs_base;
-    uint64_t iasq_f = cs_base & ~0xffffffffull;
-    int32_t diff = cs_base;
+    cs_base = ctx->base.tb->cs_base;
+    iaoq_f = cs_base & MAKE_64BIT_MASK(32, 32);
+    iaoq_f |= ctx->base.pc_first & MAKE_64BIT_MASK(2, 30);
+    iaoq_f |= ctx->privilege;
+    ctx->iaoq_first = iaoq_f;
 
-    ctx->iaoq_first = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
-
-    if (diff) {
-        ctx->iaq_b.disp = diff;
-    } else {
-        ctx->iaq_b.base = cpu_iaoq_b;
+    if (unlikely(cs_base & CS_BASE_DIFFSPACE)) {
         ctx->iaq_b.space = cpu_iasq_b;
+        ctx->iaq_b.base = cpu_iaoq_b;
+    } else if (unlikely(cs_base & CS_BASE_DIFFPAGE)) {
+        ctx->iaq_b.base = cpu_iaoq_b;
+    } else {
+        iaoq_b = (iaoq_f & TARGET_PAGE_MASK) | (cs_base & ~TARGET_PAGE_MASK);
+        ctx->iaq_b.disp = iaoq_b - iaoq_f;
     }
-#endif
 
     ctx->zero = tcg_constant_i64(0);
 
-- 
2.34.1


