Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC8F7E3409
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRx-0005sF-N0; Mon, 06 Nov 2023 22:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRq-0005aL-56
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:14 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRk-0001Ts-CU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:13 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2802c41b716so4331285a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326486; x=1699931286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RBKs2IAIkMEse1k0yUz0XaeAfVR+6S9yQC7lCh199ew=;
 b=Q00pu0MPKkWz9gp8/d0BA6jd8mUmYjbACCm2ERxAkl2yUwEm9SWOUcf6RekuB8ySaR
 pvaUG81sJSiiYEGbJ4MdGxcW8pMPjcRqDP3aQxa8kzUw4xVLTspofedUFbc4arEMklnu
 lGgaAub2DHE1ixEsc1axL2FV00yrLIwU6v+xPBIG+1GPDcvtA8qh7TkWeqRdHgNp9VUG
 x4TxGlAKM8lsx8jIBPcap2SGd99FkzBbvnn3wVxig3zTqiAaYiHbscIsPOZKzIHdCL6a
 Ey+lqQ8x6uVuS/D9VzwLzMNmUVX0IK8dTAeprKkq2E7CH8Pavb5fknFUmuqJ+woG1qHp
 ZjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326486; x=1699931286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBKs2IAIkMEse1k0yUz0XaeAfVR+6S9yQC7lCh199ew=;
 b=iM8n8BPNaBXcpkSGf6KBbqw74UndvtvZoAhOJLsH8DdmrdspHxaYkprzmVU+I6dwFZ
 9DbmI78dZ1RVsqeBk6GmtY/2d2bNViRf1ufhoaoBCO0fWfpMv+eTX2lXi2SwQh7rLenb
 0EptK6/fXpoTViooaX9dMfnBY1AbXaDipMZT+CMbu95TdfFVOmYkxzcKFJ8WHNSqvFKp
 D2CqhtRQBSsUFASFvknL9nIJHuY92kkbq+0XTj/L/Uef4CWeZ+ib0FP4Y5y7fX3gYD70
 u8nitNx3XwEcIqW+4dAwbjdw7crtGJwrbf2KfH+fB2VaYryuK/blAkXFFLA5BB/OPtoA
 FfMg==
X-Gm-Message-State: AOJu0Yza8hagCury8dM56irB9+5kUVivfKygMjdcmk87ndph25+lVD4r
 uXN7iYl3QlRRIHb9rhe7DDKd16rOdJQD/ejl66w=
X-Google-Smtp-Source: AGHT+IFyJ7JPWI0VVjIXmLCGocDCY28Z9glb2e/7W6SnvIx72C15+NuUu1I93AWyEuq03klAw/Oy3Q==
X-Received: by 2002:a17:90a:fd01:b0:27f:ebfa:1112 with SMTP id
 cv1-20020a17090afd0100b0027febfa1112mr25099778pjb.5.1699326486480; 
 Mon, 06 Nov 2023 19:08:06 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 78/85] target/hppa: Add unwind_breg to CPUHPPAState
Date: Mon,  6 Nov 2023 19:04:00 -0800
Message-Id: <20231107030407.8979-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Fill in the insn_start value during form_gva, and copy
it out to the env field in hppa_restore_state_to_opc.
The value is not yet consumed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       |  8 +++++++-
 target/hppa/cpu.c       |  1 +
 target/hppa/translate.c | 13 ++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index ea8e7e99a4..144794d089 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -45,7 +45,7 @@
 #define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
 #define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 /* No need to flush MMU_PHYS_IDX  */
 #define HPPA_MMU_FLUSH_MASK                             \
@@ -208,6 +208,12 @@ typedef struct CPUArchState {
     target_ulong cr_back[2]; /* back of cr17/cr18 */
     target_ulong shadow[7];  /* shadow registers */
 
+    /*
+     * During unwind of a memory insn, the base register of the address.
+     * This is used to construct CR_IOR for pa2.0.
+     */
+    uint32_t unwind_breg;
+
     /*
      * ??? The number of entries isn't specified by the architecture.
      * BTLBs are not supported in 64-bit machines.
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e1597ba8a5..04de1689d7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -80,6 +80,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     if (data[1] != (target_ulong)-1) {
         cpu->env.iaoq_b = data[1];
     }
+    cpu->env.unwind_breg = data[2];
     /*
      * Since we were executing the instruction at IAOQ_F, and took some
      * sort of action that provoked the cpu_restore_state, we can infer
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4102f5faf3..bcce65d587 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,6 +44,7 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
+    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -234,6 +235,13 @@ void hppa_translate_init(void)
                                         "iasq_b");
 }
 
+static void set_insn_breg(DisasContext *ctx, int breg)
+{
+    assert(ctx->insn_start != NULL);
+    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
+    ctx->insn_start = NULL;
+}
+
 static DisasCond cond_make_f(void)
 {
     return (DisasCond){
@@ -1324,6 +1332,8 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
     TCGv_i64 ofs;
     TCGv_i64 addr;
 
+    set_insn_breg(ctx, rb);
+
     /* Note that RX is mutually exclusive with DISP.  */
     if (rx) {
         ofs = tcg_temp_new_i64();
@@ -4458,7 +4468,8 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b);
+    tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
+    ctx->insn_start = tcg_last_op();
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


