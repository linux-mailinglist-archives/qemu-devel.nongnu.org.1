Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E17CEA66
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVg-0002Cs-Cf; Wed, 18 Oct 2023 17:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVd-00029l-IK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVb-00051x-Ol
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso4938736b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666118; x=1698270918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yNNnMvCvmrDYJiKz9Ub7lGJTKCUT9fcUBHvGYsxWNA=;
 b=lGpLBR8Fgat67nmlpmzUHguqxuXGUWFZMRZKTTjAkRVwMz/mdOE2j8pOpZ3V8ENgS7
 h9hddAN8gbzTWrTbopgdVuFA6BWggBqzc9kEN0R/3s+f6id2/9Beuqd5Y85iMOYUCN1k
 AjgP2HgoI8wTh8t+uiipcW2W75/s9Gkf549sNHRf81es/+o7hBdCwfgfsbugq/5rzBr8
 cK/7JvTD/+Qh4scK2Y5gkm6mCH4rG7v0YapMlvEjdV3NhqCJCIUimeLo59Po+5+bXdxI
 tYys+w7GpcdmyZ/qAasIde/tvMnJm5GlDQW9A0Dvvay12yJ6o7tWWqqPRMtBcTjnSLKI
 6fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666118; x=1698270918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yNNnMvCvmrDYJiKz9Ub7lGJTKCUT9fcUBHvGYsxWNA=;
 b=l+uTQWcuYqHVjz6mJMaBg24s4KvR6cxC57vAeV1LA9P5MVY9Qbrs38NQ6l2mSnSV0B
 v8KtWseEIQ5Zbi4AyMPg2HVwlwddq2i4f5fLYxgLqNBHj2W5L62JHUbAJ9ji0YfwJ75Q
 dEzuR+52w1fBs02HxlNH/OTpWzNHRmDI4Np5oVes+OMbVRyrggSKxD9KAtMyerRLJXM3
 aHuEQTH0amw+U50AJNtmscDhTQA5iItTHpoM7cObHkEy2cexZ2EEn9w5AZwfI0LzxgQK
 bvfZndA+/KQQ/aX/Fu60Sq/IWS8bWV5bHJmesjlKdJDDOBqUbEUIBrEp+4lpMPv18N7R
 LREQ==
X-Gm-Message-State: AOJu0YwDlsnILR0OH2d/FWPc2HjKcSr/XcteVjJsVd1MHKHc3NTgRGLP
 bHFZ7vwuwwcu3TVRwwLE5t6j+Kq69oUcZAvG7yA=
X-Google-Smtp-Source: AGHT+IHeBuFkR1n/Tz0hCu2wWZ/I9nicB4CbgAL7GpcV+BOToMpKGKLCbs7/KIRB7oLB/IPBW8WQMQ==
X-Received: by 2002:a62:f245:0:b0:6b7:e577:3f7b with SMTP id
 y5-20020a62f245000000b006b7e5773f7bmr274404pfl.21.1697666118465; 
 Wed, 18 Oct 2023 14:55:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 48/61] target/hppa: Remove remaining TARGET_REGISTER_BITS
 redirections
Date: Wed, 18 Oct 2023 14:51:22 -0700
Message-Id: <20231018215135.1561375-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The conversions to/from i64 can be eliminated entirely,
folding computation into adjacent operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 46 ++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 682cb518d6..c782c57149 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -33,15 +33,6 @@
 #undef  HELPER_H
 
 
-/* Since we have a distinction between register size and address size,
-   we need to redefine all of these.  */
-
-#define tcg_gen_extu_reg_tl  tcg_gen_mov_i64
-#define tcg_gen_trunc_i64_reg tcg_gen_mov_i64
-#define tcg_gen_extu_reg_i64 tcg_gen_mov_i64
-#define tcg_gen_ext_reg_i64  tcg_gen_mov_i64
-
-
 typedef struct DisasCond {
     TCGCond c;
     TCGv_i64 a0, a1;
@@ -1332,8 +1323,7 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_extu_reg_tl(addr, modify <= 0 ? ofs : base);
-    tcg_gen_andi_tl(addr, addr, gva_offset_mask(ctx));
+    tcg_gen_andi_tl(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
@@ -1945,13 +1935,11 @@ static bool trans_mfsp(DisasContext *ctx, arg_mfsp *a)
     unsigned rt = a->t;
     unsigned rs = a->sp;
     TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new();
 
     load_spr(ctx, t0, rs);
     tcg_gen_shri_i64(t0, t0, 32);
-    tcg_gen_trunc_i64_reg(t1, t0);
 
-    save_gpr(ctx, rt, t1);
+    save_gpr(ctx, rt, t0);
 
     cond_free(&ctx->null_cond);
     return true;
@@ -2008,22 +1996,21 @@ static bool trans_mtsp(DisasContext *ctx, arg_mtsp *a)
 {
     unsigned rr = a->r;
     unsigned rs = a->sp;
-    TCGv_i64 t64;
+    TCGv_i64 tmp;
 
     if (rs >= 5) {
         CHECK_MOST_PRIVILEGED(EXCP_PRIV_REG);
     }
     nullify_over(ctx);
 
-    t64 = tcg_temp_new_i64();
-    tcg_gen_extu_reg_i64(t64, load_gpr(ctx, rr));
-    tcg_gen_shli_i64(t64, t64, 32);
+    tmp = tcg_temp_new_i64();
+    tcg_gen_shli_i64(tmp, load_gpr(ctx, rr), 32);
 
     if (rs >= 4) {
-        tcg_gen_st_i64(t64, tcg_env, offsetof(CPUHPPAState, sr[rs]));
+        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUHPPAState, sr[rs]));
         ctx->tb_flags &= ~TB_FLAG_SR_SAME;
     } else {
-        tcg_gen_mov_i64(cpu_sr[rs], t64);
+        tcg_gen_mov_i64(cpu_sr[rs], tmp);
     }
 
     return nullify_end(ctx);
@@ -2114,11 +2101,8 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
     /* We don't implement space registers in user mode. */
     tcg_gen_movi_i64(dest, 0);
 #else
-    TCGv_i64 t0 = tcg_temp_new_i64();
-
-    tcg_gen_mov_i64(t0, space_select(ctx, a->sp, load_gpr(ctx, a->b)));
-    tcg_gen_shri_i64(t0, t0, 32);
-    tcg_gen_trunc_i64_reg(dest, t0);
+    tcg_gen_mov_i64(dest, space_select(ctx, a->sp, load_gpr(ctx, a->b)));
+    tcg_gen_shri_i64(dest, dest, 32);
 #endif
     save_gpr(ctx, a->t, dest);
 
@@ -3152,10 +3136,8 @@ static bool trans_shrp_sar(DisasContext *ctx, arg_shrp_sar *a)
         TCGv_i64 s = tcg_temp_new_i64();
 
         tcg_gen_concat32_i64(t, load_gpr(ctx, a->r2), load_gpr(ctx, a->r1));
-        tcg_gen_extu_reg_i64(s, cpu_sar);
-        tcg_gen_andi_i64(s, s, 31);
-        tcg_gen_shr_i64(t, t, s);
-        tcg_gen_trunc_i64_reg(dest, t);
+        tcg_gen_andi_i64(s, cpu_sar, 31);
+        tcg_gen_shr_i64(dest, t, s);
     }
     save_gpr(ctx, a->t, dest);
 
@@ -3196,10 +3178,8 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
             tcg_gen_rotri_i32(t32, t32, sa);
             tcg_gen_extu_i32_i64(dest, t32);
         } else {
-            TCGv_i64 t64 = tcg_temp_new_i64();
-            tcg_gen_concat32_i64(t64, t2, cpu_gr[a->r1]);
-            tcg_gen_shri_i64(t64, t64, sa);
-            tcg_gen_trunc_i64_reg(dest, t64);
+            tcg_gen_concat32_i64(dest, t2, cpu_gr[a->r1]);
+            tcg_gen_extract_i64(dest, dest, sa, 32);
         }
     }
     save_gpr(ctx, a->t, dest);
-- 
2.34.1


