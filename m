Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A97E3370
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:05:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COJ-0006WR-2j; Mon, 06 Nov 2023 22:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO4-0006Li-8r
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:20 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO0-0000dj-PW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so42290965ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326255; x=1699931055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvXYKg4Es3NrG6eHMj0weL8uuUejOJtJKCTcJARULmU=;
 b=H0Z+YM9m8+UdOTPcrnjE18vN8pS46LXs4xRiG2i12uTacvkZrwCXaBihx+npvpAvVI
 T6xh3UnyjWkt4WT8u9IAlDUqzCzVzjLwGnVnhDff2ka0JNkUnhHnVirmGfhPsb2xi9rE
 RDDYqgjN9mHwgSpGC4k6mYy8MU5kKGN7WJDgz0h9e1IP7tYenBnaQsZf7mCQ8UfAJ/0t
 O2dmRKjZsALi1q3xGrT/g8FBg33ReKpA/s0tMFpodUM0k3vorD1fsz/u0eEL/FZmR2jW
 jEoeOFjBBwtMTDzE4nP8hy7k/G1RXfAxP1akzV5vYJiITZnZSxBNz8PbaKIx/+Nkdcec
 DFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326255; x=1699931055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvXYKg4Es3NrG6eHMj0weL8uuUejOJtJKCTcJARULmU=;
 b=kt2aXTNiwj3eBjXar4ATztHAUzXN0ylvVPitjIWHZON270twtjSp0Wtvy/XPsLY1v+
 SI3gVk3G+qeL/sQm1m+NSaqPFFUgF4ZPE4fhdlLRGJT5qVa1Uc9GXVApxZzba+BDEM7r
 7AFZADGpDrz1ZOTRsX0c4w0POXU17nCvcLSVKnZEZ19p3EXkISlEtV2y7E1BpYhfDb4b
 FMf8TP1VbzoX1Edm1XPerCVXnY1J20QOZtSbB+KoQajLua6EJWmko3s7Ab9/NuboKY6z
 X1mtj/RQrmc+8rJRSpDfJh/KixguwGaiijkV4CUabVNoBWQUJSUCr5eBVS7U5uJHWJKU
 KUcQ==
X-Gm-Message-State: AOJu0Yw07ZS/KDIfJEMU8rwfTwQkNzUvQrMiyXVhgWRHre/vkLha0Pi0
 gIcBtmXujE0+mNBxG9nxWdSOP9CdfWMSQhGjxOk=
X-Google-Smtp-Source: AGHT+IF+gLH0RQIHqKSzgS4R3aEr+StPuA3h5eJU+/c+W2nAw57J5tneYLpzZrtz8aixi+7pkxp6PA==
X-Received: by 2002:a17:903:18b:b0:1cc:665d:f818 with SMTP id
 z11-20020a170903018b00b001cc665df818mr19007921plg.68.1699326254702; 
 Mon, 06 Nov 2023 19:04:14 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/85] target/hppa: Remove get_temp_tl
Date: Mon,  6 Nov 2023 19:02:50 -0800
Message-Id: <20231107030407.8979-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


