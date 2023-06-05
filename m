Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA42F721C4B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 04:56:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60NE-0008KH-Hg; Sun, 04 Jun 2023 22:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60NA-0008Jw-CN; Sun, 04 Jun 2023 22:55:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60N8-0002lc-JM; Sun, 04 Jun 2023 22:55:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b0424c5137so37867185ad.1; 
 Sun, 04 Jun 2023 19:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685933704; x=1688525704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H20rRWKHpUByaL9Luvoyr4JNaBAvvzn8iPUUfaQ3Ss0=;
 b=iKydRJz/5Pg8xh6gQNi1Wz66drXyW7pRFfW/iP+0sejwNAYJWroYXW/l1r1pfodeg5
 i9s0LdTi87UJ8eiLwud22ULZ98pzqvOtFhPZNSSpF6GDxo6tdpoaTqRbPxhZoFuMJkeq
 2tgsBc7aec8JlKyd3nEDQG9GpvEicmWcjYPgdOR+TydcDYHnAz3E1S0kzapbQik01QIq
 rTAGyvUGBD3kpHTRoC2AxobBGVwO2RuVvJAwwfxKN+5u5zzqkkQid/kV8SLdJx1XNBWY
 0zesye0rwOiGUKXURhFcws8x0kz+SPPxLXeQkcQMBUhbkoQ7q251x/ahI785vaxBVVKJ
 IKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685933704; x=1688525704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H20rRWKHpUByaL9Luvoyr4JNaBAvvzn8iPUUfaQ3Ss0=;
 b=cowfCunJAxGYSWlWaqyT6M4Ib5b56D7cko7uRdgoz4DEvxkdV7wjX4W1lN5KpxIrjY
 u/gG9pih2Y4Mzjl0MwRkXNx0yNofNz5VV5C9cOvPxR0ujun4sdhg34sFmXSimOGp4uw+
 Eelp99jVdCpCKER1eb4x+C7Fu3dzCW3gZxSe3xLGr5TnqeWySsKjEmopP5F3mHfUiog9
 es5J3toXc8snLUgzqQWoolCaybEbM3+yfuW3u6X0V25ALVh5wz6bhFMDhh6o2Hg/mfVi
 bOQLQNejzw/wjIdy00rSy6YaHnZdajGhviEmB/siIjYq8rFX5A2ycLDigAYSlEeCpyE2
 fXoA==
X-Gm-Message-State: AC+VfDwAk72oufjlgNzxPO18DH3LmyElmva/hc9Eaxl/ODYHUtMH9wQ1
 Ml57o9q4nj2P+e0iylbXO1Y9ggwNkH0=
X-Google-Smtp-Source: ACHHUZ6pbg5+Cr7WeLVNdWTlt64kBR/NceU8FS5NyWDMr5ylHQJ1w6ookdnwODu06QLtpoXmxYrZ/Q==
X-Received: by 2002:a17:902:c40f:b0:1b1:c72c:753f with SMTP id
 k15-20020a170902c40f00b001b1c72c753fmr8433631plk.59.1685933704188; 
 Sun, 04 Jun 2023 19:55:04 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902c74500b001ae59169f05sm5316778plq.182.2023.06.04.19.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 19:55:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 4/4] target/ppc: Rework store conditional to avoid branch
Date: Mon,  5 Jun 2023 12:54:45 +1000
Message-Id: <20230605025445.161932-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605025445.161932-1-npiggin@gmail.com>
References: <20230605025445.161932-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Rework store conditional to avoid a branch in the success case.
Change some of the variable names and layout while here so
gen_conditional_store more closely matches gen_stqcx_.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2:
- Reinstate lost DEF_MEMOP [Richard]

I think the DEF_MEMOP is redundant here, but admit that's not something
that should be changed with this patch. I will look at cleaning those up
later.

Thanks,
Nick

 target/ppc/translate.c | 63 ++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index acb99d8691..434caad258 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3813,31 +3813,32 @@ static void gen_stdat(DisasContext *ctx)
 
 static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    TCGv t0 = tcg_temp_new();
-    int reg = rS(ctx->opcode);
+    TCGLabel *lfail;
+    TCGv EA;
+    TCGv cr0;
+    TCGv t0;
+    int rs = rS(ctx->opcode);
 
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
+    t0 = tcg_temp_new();
+
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
+    gen_addr_reg_index(ctx, EA);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
 
-    t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[reg], ctx->mem_idx,
+                              cpu_gpr[rs], ctx->mem_idx,
                               DEF_MEMOP(memop) | MO_ALIGN);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-    tcg_gen_br(l2);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(l1);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-
-    gen_set_label(l2);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
@@ -3891,25 +3892,26 @@ static void gen_lqarx(DisasContext *ctx)
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
-    TCGLabel *lab_fail, *lab_over;
-    int rs = rS(ctx->opcode);
+    TCGLabel *lfail;
     TCGv EA, t0, t1;
+    TCGv cr0;
     TCGv_i128 cmp, val;
+    int rs = rS(ctx->opcode);
 
     if (unlikely(rs & 1)) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
 
-    lab_fail = gen_new_label();
-    lab_over = gen_new_label();
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
 
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
@@ -3932,15 +3934,10 @@ static void gen_stqcx_(DisasContext *ctx)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-
-    tcg_gen_br(lab_over);
-    gen_set_label(lab_fail);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(lab_over);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.40.1


