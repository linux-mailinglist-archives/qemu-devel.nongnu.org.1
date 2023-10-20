Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6717D1757
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLq-0007iY-6U; Fri, 20 Oct 2023 16:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLM-0007gV-DY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLK-00088d-Nn
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso996524b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834617; x=1698439417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cad+KwQheUGAcPjvv3O2I1LwfS0pIqR17J6IWZnIATQ=;
 b=yrLd8elnFUXOPkMWbt7snigo7S8/mpPGXZad+c4iuMVkhqRUTENPF2vKEvl4tjGCry
 2n7SRxex6CoPTmXwo5WMnyhhcmmUpR5OMOaxD0wxwQOuMPPiWtI3DhYos9d9tV/jardS
 0tI3eRNSNyD2MTN3AFwBceYkk1FdpPvFlZiF6AxmMbu9MuJyGMea1+ScVB1rN9y5MwuH
 vafhPBL7/fEt+QJq62M2iOxvhH3qouARVbcVfDOT/ywvAFYV3m9jH59Ajk7D79encrv2
 ZDb+C+unTvHHVfQvFiOXhwyQ+W1/e+zcD0ABkO9ToNfCKiHSrWGjMuJwn1CqwTpQpse0
 6W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834617; x=1698439417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cad+KwQheUGAcPjvv3O2I1LwfS0pIqR17J6IWZnIATQ=;
 b=TRy2IkE9v3W+Kgr8SZgqm3zgpxrAaoBx+a0fgdXYuoe/YaQIe9yomuKfuLQHmU36bn
 /7aRsxmQ6wMCzrr04/nl1W++2SWW72rxr3zkIj6Few5yNKHlAipgCUEGOiEkKfQLzKEz
 vFYo/6gE3h1xwyp8/JTrspgjbgeYLlsFTqDSJ/M+Ay31NkTweVQ+1UN4wz7wOLmN4MaD
 uS2fZZxBVN/oaEy0o8WH2Yx+Q0YKR+EX3l2P4gbUFlP30lhBfIQiur3v8afbRyx20/wR
 AjBl66P2/3TItTgR/8UKr7CF/1dbqbRCngJIj/yzOZ7Gz8FUvoWX/EqMIVSs6CyetArw
 W/Yg==
X-Gm-Message-State: AOJu0YzKCkwy4BF6efVy0WhVqpmBL4J4JXPWvfikuwT0XkqTXpNhKSLi
 2XopIZ46E1onWTUqXiQ/j21b0MPFg1sGDwgKAMI=
X-Google-Smtp-Source: AGHT+IEpELimzyakNmbobOsPfsNo4t6ny6h8iQF5fJ6ErPUND8CVBNMIlycwWvxhNf9peNjxV/nJ2Q==
X-Received: by 2002:a05:6a20:e125:b0:f0:50c4:4c43 with SMTP id
 kr37-20020a056a20e12500b000f050c44c43mr4314914pzb.5.1697834617169; 
 Fri, 20 Oct 2023 13:43:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/65] target/hppa: Remove get_temp_tl
Date: Fri, 20 Oct 2023 13:42:30 -0700
Message-Id: <20231020204331.139847-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


