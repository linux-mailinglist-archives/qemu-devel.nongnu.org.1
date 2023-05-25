Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75A711A97
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLa-0005rF-Hv; Thu, 25 May 2023 19:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLR-0005mf-JK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLL-0005lF-SR
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:09 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so913535ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057162; x=1687649162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mD6kr0K2WWzq0R0KMPRLKEJC7VZQzRuGxAGHXMfdo/k=;
 b=Pm6U3GL6RHGcNAx7Xr1MxoR2GCDU2yvZGygrFqTuiYD15qi0fOhk652GVBaOYQSaS4
 AlO4CQ06Ey5LMe0qf/Am/xreAnOvuqpbEHNtg4An9fXlH4pSVQIgfvoSFYgo15AEi8d9
 eku/dI2rq1PF5OAnAZb1yzTaBsz/apdM+6NSyPY8Cp+mrK328DDYNZ6PBTmi9RnACu1f
 00s7dxZgLMBGkCrdh7Lc7Kldhswh7wOqZE3Tx6QZEgQmV7D1+GCsD+gJoiwOVkLtt4us
 m4rr5X9s7CxCSgiRhKrawQL2SHe+iYzi2a3QttFpHpPob0ZYxr62wlO1QPv7ZUQOJl5Y
 IA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057162; x=1687649162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mD6kr0K2WWzq0R0KMPRLKEJC7VZQzRuGxAGHXMfdo/k=;
 b=ZA/EikkXsdJ8EL9iJ2+Zq7wEa3tUVuK503oW/YBoP2eYTI8ou4+u4aZLIg6aD+PEsE
 d5AEFRaTzvCnIt7gdKoXoVqploobgvgd7PNMHXdmH1GIE/5I9zCV7XoFrnQyhjqvlN0P
 8aofgjWBEMZn7sNkO19o0WgHS/fc2fxJaTZEON9yEsGR5QJL0qkXrlL/36BWpGFuYvef
 WSMgAFFWhzFMaxp0dMWt+isQB5Q+dDlNABa766br83lL5/QRWExoE3XHp7BvrD3py+kQ
 QPq3ppFtZ9IeTXIiyERJ5dgCL9bFzZ/F0AjOXLpeoatqnljJQQOCSk+SJxbtQtLDw5yi
 1yjg==
X-Gm-Message-State: AC+VfDwdauQ+5+/OCagZqt2EN1cnsBYcpxiTUwgBWiD23yixaQ1PT8Nk
 oubQPOK5g4M6ZAIoA4bcEDOhpKZ8sJu5yvUrjzE=
X-Google-Smtp-Source: ACHHUZ7bdVYCoD+4JRS/k8/cXSrX7u+lZC+ZsMK+hUbEM+PeziMDsvhrJ7WzUdgPUXDxmJnnX3tS/g==
X-Received: by 2002:a17:902:e5c9:b0:1ac:8ad0:1707 with SMTP id
 u9-20020a170902e5c900b001ac8ad01707mr546299plf.1.1685057162250; 
 Thu, 25 May 2023 16:26:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 03/20] target/arm: Introduce finalize_memop_{atom,pair}
Date: Thu, 25 May 2023 16:25:41 -0700
Message-Id: <20230525232558.1758967-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Let finalize_memop_atom be the new basic function, with
finalize_memop and finalize_memop_pair testing FEAT_LSE2
to apply the appropriate atomicity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 39 +++++++++++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c |  2 ++
 target/arm/tcg/translate.c     |  1 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..9a33076c3d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -85,6 +85,7 @@ typedef struct DisasContext {
     uint64_t features; /* CPU features bits */
     bool aarch64;
     bool thumb;
+    bool lse2;
     /* Because unallocated encodings generate different exception syndrome
      * information from traps due to FP being disabled, we can't do a single
      * "is fp access disabled" check at a high level in the decode tree.
@@ -552,12 +553,13 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
 }
 
 /**
- * finalize_memop:
+ * finalize_memop_atom:
  * @s: DisasContext
  * @opc: size+sign+align of the memory operation
+ * @atom: atomicity of the memory operation
  *
- * Build the complete MemOp for a memory operation, including alignment
- * and endianness.
+ * Build the complete MemOp for a memory operation, including alignment,
+ * endianness, and atomicity.
  *
  * If (op & MO_AMASK) then the operation already contains the required
  * alignment, e.g. for AccType_ATOMIC.  Otherwise, this an optionally
@@ -567,12 +569,39 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
  * and this is applied here.  Note that there is no way to indicate that
  * no alignment should ever be enforced; this must be handled manually.
  */
-static inline MemOp finalize_memop(DisasContext *s, MemOp opc)
+static inline MemOp finalize_memop_atom(DisasContext *s, MemOp opc, MemOp atom)
 {
     if (s->align_mem && !(opc & MO_AMASK)) {
         opc |= MO_ALIGN;
     }
-    return opc | s->be_data;
+    return opc | atom | s->be_data;
+}
+
+/**
+ * finalize_memop:
+ * @s: DisasContext
+ * @opc: size+sign+align of the memory operation
+ *
+ * Like finalize_memop_atom, but with default atomicity.
+ */
+static inline MemOp finalize_memop(DisasContext *s, MemOp opc)
+{
+    MemOp atom = s->lse2 ? MO_ATOM_WITHIN16 : MO_ATOM_IFALIGN;
+    return finalize_memop_atom(s, opc, atom);
+}
+
+/**
+ * finalize_memop_pair:
+ * @s: DisasContext
+ * @opc: size+sign+align of the memory operation
+ *
+ * Like finalize_memop_atom, but with atomicity for a pair.
+ * C.f. Pseudocode for Mem[], operand ispair.
+ */
+static inline MemOp finalize_memop_pair(DisasContext *s, MemOp opc)
+{
+    MemOp atom = s->lse2 ? MO_ATOM_WITHIN16_PAIR : MO_ATOM_IFALIGN_PAIR;
+    return finalize_memop_atom(s, opc, atom);
 }
 
 /**
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..967400ed68 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14110,6 +14110,8 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     tcg_debug_assert(dc->tbid & 1);
 #endif
 
+    dc->lse2 = dc_isar_feature(aa64_lse2, dc);
+
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
      *   generate code with no special handling for single-stepping (except
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..7a6a8029e5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9183,6 +9183,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->sme_trap_nonstreaming =
             EX_TBFLAG_A32(tb_flags, SME_TRAP_NONSTREAMING);
     }
+    dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.34.1


