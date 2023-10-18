Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D587CEA44
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESC-00010N-H5; Wed, 18 Oct 2023 17:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES7-0000jE-9S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES4-0004Mx-RV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so3701732b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665899; x=1698270699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tf30naxwG8ULfBR8Z80R+ehNXjBaz2adScdYG1B0wU=;
 b=NCSlLadgE/GDmykhjXg+w4Y37UXtENolz0RqrRYfRDENiraCzJVMlXRXkpvRWQ/0Xt
 60LuXd03KPrCyBT7UEy0rPft5YcjVFEbiytVD0tiCP+7eNStLnZMyDl6QP5gurhALeZV
 CAihLL4LLTuhee+uhq41iqBrS5x9JWg6r8ffYxM6IWyTfVk3YNPfsOflyPAlrA27I37c
 sPMwZKnc9kjkvrWZ3mRIXGZS3dcNRAWJQnCibrhtwAZ46YzgMVjHoKfWzNiNWPg3/esB
 UQhEEOWJvNcVAOyv8e+XkVhUt7ffjZSD53ubG94wSdI8kTbCt9T3Ou/SD3oLW4Q9ZyJQ
 Lzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665899; x=1698270699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tf30naxwG8ULfBR8Z80R+ehNXjBaz2adScdYG1B0wU=;
 b=xTmeXCJOjqNtU/9gBe0osm3aamzRBPcHO+7RSTU/WjJqloRmnplOqKdneicRfLJX2J
 DFoSm6IcuIAp08WAnCPOKJsV8FiGblmXFlnaIr5bqPDvQmtJWa0xolT4uKhUiH3qvKkH
 v3IlRUSqwYy4LoZHg8rQTMfCXMmgLRFJplizBJxx7vlIyU3qoJ7DrL5uG+BS97nS/ab0
 izRLJaOyUDoCwxofuAwhB8n4W22jKOHPAMvuKwBqpnPApZqB+I0/lxrD4yN2/l+ovrF3
 tSvBds2Iz5+DcAjwv3O2M/mXTGg11qwK+Qv4vnqtUEbYAQvRgS+NzLNYY1KKsk4NZjhv
 0yog==
X-Gm-Message-State: AOJu0YzQr7Lau8b7XJjFFu/XqL7dbKQCImcEi1QHvsD0LNThQTdEBWo/
 bE3IcmCb2BQUnlHdapbh9bt1+zV6b8ZcW1vtb6k=
X-Google-Smtp-Source: AGHT+IGYJGDuOrbfnUrWbhpI0nFKFd/mvXgWybVVtdRXT3C+j1M7eM+EwGnUnYrGBiY9sqC/mQWPag==
X-Received: by 2002:a05:6a00:b53:b0:6b5:ec98:4289 with SMTP id
 p19-20020a056a000b5300b006b5ec984289mr357415pfo.14.1697665899423; 
 Wed, 18 Oct 2023 14:51:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 03/61] target/hppa: Remove get_temp_tl
Date: Wed, 18 Oct 2023 14:50:37 -0700
Message-Id: <20231018215135.1561375-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Replace with tcg_temp_new_tl without recording into ctx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3065fbf625..5302381a56 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -254,9 +254,6 @@ typedef struct DisasContext {
     target_ureg iaoq_n;
     TCGv_reg iaoq_n_var;
 
-    int ntempl;
-    TCGv_tl  templ[4];
-
     DisasCond null_cond;
     TCGLabel *null_lab;
 
@@ -491,15 +488,6 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-static TCGv_tl get_temp_tl(DisasContext *ctx)
-{
-    unsigned i = ctx->ntempl++;
-    g_assert(i < ARRAY_SIZE(ctx->templ));
-    return ctx->templ[i] = tcg_temp_new_tl();
-}
-#endif
-
 static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
 {
     TCGv_reg t = tcg_temp_new();
@@ -1374,7 +1362,7 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
         if (sp < 0) {
             sp = ~sp;
         }
-        spc = get_temp_tl(ctx);
+        spc = tcg_temp_new_tl();
         load_spr(ctx, spc, sp);
         return spc;
     }
@@ -1384,7 +1372,7 @@ static TCGv_i64 space_select(DisasContext *ctx, int sp, TCGv_reg base)
 
     ptr = tcg_temp_new_ptr();
     tmp = tcg_temp_new();
-    spc = get_temp_tl(ctx);
+    spc = tcg_temp_new_tl();
 
     tcg_gen_shri_reg(tmp, base, TARGET_REGISTER_BITS - 5);
     tcg_gen_andi_reg(tmp, tmp, 030);
@@ -1420,7 +1408,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva, TCGv_reg *pofs,
 #ifdef CONFIG_USER_ONLY
     *pgva = (modify <= 0 ? ofs : base);
 #else
-    TCGv_tl addr = get_temp_tl(ctx);
+    TCGv_tl addr = tcg_temp_new_tl();
     tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
     if (ctx->tb_flags & PSW_W) {
         tcg_gen_andi_tl(addr, addr, 0x3fffffffffffffffull);
@@ -4080,9 +4068,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-
-    ctx->ntempl = 0;
-    memset(ctx->templ, 0, sizeof(ctx->templ));
 }
 
 static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
@@ -4111,7 +4096,6 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUHPPAState *env = cpu_env(cs);
     DisasJumpType ret;
-    int i, n;
 
     /* Execute one insn.  */
 #ifdef CONFIG_USER_ONLY
@@ -4150,12 +4134,6 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         }
     }
 
-    /* Forget any temporaries allocated.  */
-    for (i = 0, n = ctx->ntempl; i < n; ++i) {
-        ctx->templ[i] = NULL;
-    }
-    ctx->ntempl = 0;
-
     /* Advance the insn queue.  Note that this check also detects
        a priority change within the instruction queue.  */
     if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-- 
2.34.1


