Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BC7E33A0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:11:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CO4-0006Kb-0M; Mon, 06 Nov 2023 22:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNz-0006K4-9o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:16 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNw-0000d3-0f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:15 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so4829609b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326249; x=1699931049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u6kOr3bnmnyAyVHH0Y0iv4quWP9D74WtGN7YLIlIm3w=;
 b=TzUeQ1oD6uX0GpTyg8SwFM1LUobq4YVLNbQCn/JEuthvYNyxHTmYlSye2gcN6rvrNq
 IYmp6F+6zQgxucHx3l3VUAuYLQFEciNYeYuBgTjaqalCbLQ0PA0JavLw31t2XPTAyzpB
 o7bRrYjRK9UENlx+jcHAIe+f40Y2Myy1/A0aA/Ml9BcqFwzlF6l3CarljAUmYvrfAGvn
 8Wds4jCUD1A4IwohBmG9BHYoCHMoxGFfKOjOJL43aoFxpmHCqXSQGmAsRG1qOAmvPpzC
 HCWqJbaZ4Mk2Hvlt9kPhFWmAEo7q/aPuZQXcSBkFKKQkp0SalMdfl+RQlcLyP5mqBGg5
 LS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326249; x=1699931049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6kOr3bnmnyAyVHH0Y0iv4quWP9D74WtGN7YLIlIm3w=;
 b=cjreOgX1N4J2GJdcpBgVyGZ1G7fqw43awDwh34OKgN940FpRIGy7+avrlaxutuxXBv
 ywZoSeO1IsJaXnSBJPPgABcbuybirV/oGYDYwRZ/EF0JRjZKnRD+f5oaO3AC6DLyY8OW
 ofZRdVS2jA+8l1z5EHOcsIJIaGsi8EpPjEHyyYJwsUgMVqoJwHEMzvzVL1cjrNRI00jf
 UwOZIaTrD9oK2FjPGTVx181PeZupzBpN0OEson1XDp26uKx8HxbJtRIe5FwCGZgTEb9H
 PPDgg+ZS6QZV51+TNZztlqq8pWDhXVHa5DazZVGcBFGvL/ULfC2Bilnjm/gGNVNpGH3A
 sDZA==
X-Gm-Message-State: AOJu0YwcJA96LQ5py3MsUD4NZ64ps1nKBsI8ykODPAWI+6YXndUHMh4R
 qzUBH1qE+E5dtDxfotATV7ndLEAK8DA7VcP1/Fk=
X-Google-Smtp-Source: AGHT+IHdQ8avVyWpNQbjIhfVXnyJ7P4W5Dtm7CeJjEMRXAVflBpyZ+aDfAfieeE9gMHjnpsNP4dpRA==
X-Received: by 2002:a05:6a20:2447:b0:16b:d853:90be with SMTP id
 t7-20020a056a20244700b0016bd85390bemr26426909pzc.25.1699326249479; 
 Mon, 06 Nov 2023 19:04:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/85] target/hppa: Include PSW_P in tb flags and mmu index
Date: Mon,  6 Nov 2023 19:02:43 -0800
Message-Id: <20231107030407.8979-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use a separate mmu index for PSW_P enabled vs disabled.
This means we can elide the tlb flush in cpu_hppa_put_psw
when PSW_P changes.  This turns out to be the majority
of all tlb flushes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        | 36 ++++++++++++++++++++++++------------
 target/hppa/helper.c     |  8 --------
 target/hppa/mem_helper.c |  6 ++----
 target/hppa/translate.c  |  5 +++--
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 798d0c26d7..48d735929e 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,21 +30,33 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
-#define MMU_KERNEL_IDX   11
-#define MMU_PL1_IDX      12
-#define MMU_PL2_IDX      13
-#define MMU_USER_IDX     14
-#define MMU_PHYS_IDX     15
+#define MMU_KERNEL_IDX    7
+#define MMU_KERNEL_P_IDX  8
+#define MMU_PL1_IDX       9
+#define MMU_PL1_P_IDX     10
+#define MMU_PL2_IDX       11
+#define MMU_PL2_P_IDX     12
+#define MMU_USER_IDX      13
+#define MMU_USER_P_IDX    14
+#define MMU_PHYS_IDX      15
 
-#define PRIV_TO_MMU_IDX(priv)    (MMU_KERNEL_IDX + (priv))
-#define MMU_IDX_TO_PRIV(mmu_idx) ((mmu_idx) - MMU_KERNEL_IDX)
+#define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
+#define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
+#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 /* No need to flush MMU_PHYS_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
-        (1 << MMU_KERNEL_IDX | 1 << MMU_PL1_IDX |       \
-         1 << MMU_PL2_IDX    | 1 << MMU_USER_IDX)
+        (1 << MMU_KERNEL_IDX | 1 << MMU_KERNEL_P_IDX |  \
+         1 << MMU_PL1_IDX    | 1 << MMU_PL1_P_IDX    |  \
+         1 << MMU_PL2_IDX    | 1 << MMU_PL2_P_IDX    |  \
+         1 << MMU_USER_IDX   | 1 << MMU_USER_P_IDX)
+
+/* Indicies to flush for access_id changes. */
+#define HPPA_MMU_FLUSH_P_MASK \
+        (1 << MMU_KERNEL_P_IDX | 1 << MMU_PL1_P_IDX  |  \
+         1 << MMU_PL2_P_IDX    | 1 << MMU_USER_P_IDX)
 
 /* Hardware exceptions, interrupts, faults, and traps.  */
 #define EXCP_HPMC                1  /* high priority machine check */
@@ -249,7 +261,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
     return MMU_USER_IDX;
 #else
     if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return PRIV_TO_MMU_IDX(env->iaoq_f & 3);
+        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
     }
     return MMU_PHYS_IDX;  /* mmu disabled */
 #endif
@@ -299,8 +311,8 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     *cs_base = env->iaoq_b & -4;
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
 #else
-    /* ??? E, T, H, L, B, P bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D);
+    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
     *pc = (env->psw & PSW_C
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index a8d3f456ee..cba8160b3d 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -51,7 +51,6 @@ target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
 {
-    target_ureg old_psw = env->psw;
     target_ureg cb = 0;
 
     env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
@@ -67,13 +66,6 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     cb |= ((psw >>  9) & 1) <<  8;
     cb |= ((psw >>  8) & 1) <<  4;
     env->psw_cb = cb;
-
-    /* If PSW_P changes, it affects how we translate addresses.  */
-    if ((psw ^ old_psw) & PSW_P) {
-#ifndef CONFIG_USER_ONLY
-        tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
-#endif
-    }
 }
 
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 350485f619..729032288d 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -144,7 +144,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
     /* access_id == 0 means public page and no check is performed */
-    if ((env->psw & PSW_P) && ent->access_id) {
+    if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         /* If bits [31:1] match, and bit 0 is set, suppress write.  */
         int match = ent->access_id * 2 + 1;
 
@@ -373,9 +373,7 @@ void HELPER(ptlbe)(CPUHPPAState *env)
 
 void cpu_hppa_change_prot_id(CPUHPPAState *env)
 {
-    if (env->psw & PSW_P) {
-        tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
-    }
+    tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_P_MASK);
 }
 
 void HELPER(change_prot_id)(CPUHPPAState *env)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9f3ba9f42f..f6a656325c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4071,8 +4071,9 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
-    ctx->mmu_idx = (ctx->tb_flags & PSW_D ?
-                    PRIV_TO_MMU_IDX(ctx->privilege) : MMU_PHYS_IDX);
+    ctx->mmu_idx = (ctx->tb_flags & PSW_D
+                    ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
+                    : MMU_PHYS_IDX);
 
     /* Recover the IAOQ values from the GVA + PRIV.  */
     uint64_t cs_base = ctx->base.tb->cs_base;
-- 
2.34.1


