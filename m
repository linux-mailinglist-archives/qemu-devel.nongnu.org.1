Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4837DEA04
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:31:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXf-0005aG-2O; Wed, 01 Nov 2023 21:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXY-0005Uq-CS
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:32 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001VL-9b
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:31 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b2e44c7941so277470b6e.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888626; x=1699493426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvXYKg4Es3NrG6eHMj0weL8uuUejOJtJKCTcJARULmU=;
 b=HvP8BLTQDWYG2mqewOAfslLNCFvYSj+73pDS7kurOk5krBXpqXJ8F9DrIvFaeiCylu
 wfgIcQ3Inu1KIc4IXvNIgtxzWLyw4Ve9e9Oycnq3dyIGtqo+7eh7L13bZKoFv9iBy3OM
 M0vtckWo3HToxykvsPiGS6LImQ/1ZM1zk6zgNMpr5Pk9OzT4AVFVPQPw6nyx/GR7SG0C
 QPwP0oeBTBFAMCX05iov7TmsURB9eZ4OAS1fpwK10ucH3NEd8qSAv3npRc7a0lZzX2Hw
 IyGvlpSRUqfwsZJoehIk6dCHvY+AZwwBLXHCg8Bu3rggbHS238+F6emq3trUyyCE5C0R
 bBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888626; x=1699493426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvXYKg4Es3NrG6eHMj0weL8uuUejOJtJKCTcJARULmU=;
 b=AmpQPLBtugyQ4NFKLsfVtjFfe4ijaYQkpuJc3b47MG/kABtKCxDWXedhzGmMpP0RVo
 WC9X8T6PQJE7sxQLN10XrOWHuhGqTOUg/Rydv326phUYyyO21nxoYPcLc4KJuiytHIyI
 lnJyLuYWuCZA/4gdPWbOEa96OEt0QUs5T9yZeBhtY7LHCzQ10Y/B0fCSPAdvlbi3pI3D
 xaMQWWh0/7tbVnO4g5oJXCxzaSEJCBlDINbaZWHphPGLdftgF73lM3QPj1NIo1PVrduy
 Fzt0a9F53fr/0B5muOVYr1MRoPIOHPxktgqv9PMU/Cfj/2bhnnGgh2b25wZ+e/a9ejuI
 XN1A==
X-Gm-Message-State: AOJu0Yw2NjQYR+MBlz1t7msv3T/PWjF2yamxnMIINPQDinGykAOiha4l
 DiCw6+IRYYeO4DPZKV3tN4LgdMP7o6HzyoXJpNc=
X-Google-Smtp-Source: AGHT+IEAeT8ZACoSKhtA8/6XfbaRm5Ed+wGeRybwptB90wuqqV5ZZ343rqKgp5Q16bWkdTf3ccubLg==
X-Received: by 2002:a05:6808:208a:b0:3b5:65b0:425 with SMTP id
 s10-20020a056808208a00b003b565b00425mr7626435oiw.21.1698888626699; 
 Wed, 01 Nov 2023 18:30:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/88] target/hppa: Remove get_temp_tl
Date: Wed,  1 Nov 2023 18:28:58 -0700
Message-Id: <20231102013016.369010-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Replace with tcg_temp_new_tl without recording into ctx.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 99b9fc0561..3c4a759628 100644
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
@@ -4081,9 +4069,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     /* Bound the number of instructions by those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
     ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
-
-    ctx->ntempl = 0;
-    memset(ctx->templ, 0, sizeof(ctx->templ));
 }
 
 static void hppa_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
@@ -4112,7 +4097,6 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUHPPAState *env = cpu_env(cs);
     DisasJumpType ret;
-    int i, n;
 
     /* Execute one insn.  */
 #ifdef CONFIG_USER_ONLY
@@ -4151,12 +4135,6 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


