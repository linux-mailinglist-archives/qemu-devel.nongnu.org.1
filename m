Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F107DEA1C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYP-0005td-7B; Wed, 01 Nov 2023 21:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXp-0005lZ-Gq
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXm-0001cl-Cb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5b8c39a2dceso290743a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888644; x=1699493444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdEYiuOYJXkuv427aOu34bhOpMdqGfn9qCvVFPH2z9A=;
 b=CWTAKTx1V/8IobZA91ZcgRkIUJ4S40FkdnDWDp68+C/+X/0LfixSzZaECNX7j2z/Tp
 2Kt0BRfcgQoNyEgGHbLBJTZZHHqw9mRqz/Y7yoXZKFfzEPYNaoj1WjP39WAgnb93mwXJ
 Uj6c+5ILdJ3fTY5eB/PiCed3psDX9FtnRj1shR7mG6JZG6iftT0cUXfGHKkB0aDg0fYk
 1GvtBu+6E5ffpxs2g1Ld6u6sEEOkxc1Wp9TkZL9j+CLFUTx/329Hdz5MSLiVt64rvFRA
 wGWMyoqxK183DG27DiH9piyBi5NQ/TEQBCSZedKmMSmSAt97rm+nFps96M5yBMBSIT2B
 S6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888644; x=1699493444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdEYiuOYJXkuv427aOu34bhOpMdqGfn9qCvVFPH2z9A=;
 b=gT5CQvAGeuvYx5g/Jsc/aSh+HXsEs3oOKhrLRboHG8wcRSjZIx/sXaPw8ueiLtHmv3
 f63XyIaSLF4lxLm5yevvx1t6H4b389dPqzPxm5EqESPD4bDCgUa1VGEXMb2I5pDi0nwZ
 ITrDrl/wous21OwcKVhlw4Amxd1ipavDyxxERIGH0+ocL1t8anZXFxan0pegTJG3CGey
 02arLn0IdAh/BK4uqELnZv2hir7JIN8dUtWYw1cknLv7PS8AzwV/OwOWKfY47CY3TDaL
 SWTMdEIFwD5eb31LDgoyGklSqHO0GsYpjMZfUBG5j3yZzmaQAlctaM1m7KiOLYtjyXHi
 nVng==
X-Gm-Message-State: AOJu0Yy5WMoNgGMwddYCqYUqwVauYYd63ZdAk55pKF2WblM0A4tcbCKT
 1SK7ddHs351oVTzV66zDXA1euuxOTtTIcshK6xs=
X-Google-Smtp-Source: AGHT+IGJBtoeIWmMXQ0touC/A6uxtcuLeMZFB377Z39KcnDKzTEqVjS9J5cGgFFA/04gDZSiEh8Jlg==
X-Received: by 2002:a05:6a20:e114:b0:14d:abc:73dc with SMTP id
 kr20-20020a056a20e11400b0014d0abc73dcmr18685959pzb.32.1698888642947; 
 Wed, 01 Nov 2023 18:30:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 27/88] target/hppa: Pass DisasContext to copy_iaoq_entry
Date: Wed,  1 Nov 2023 18:29:15 -0700
Message-Id: <20231102013016.369010-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Interface change only, no functional effect.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4e0bc48b09..e342cc1d08 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -717,7 +717,8 @@ static target_ureg gva_offset_mask(DisasContext *ctx)
             : MAKE_64BIT_MASK(0, 32));
 }
 
-static void copy_iaoq_entry(TCGv_reg dest, target_ureg ival, TCGv_reg vval)
+static void copy_iaoq_entry(DisasContext *ctx, TCGv_reg dest,
+                            target_ureg ival, TCGv_reg vval)
 {
     if (unlikely(ival == -1)) {
         tcg_gen_mov_reg(dest, vval);
@@ -738,8 +739,8 @@ static void gen_excp_1(int exception)
 
 static void gen_excp(DisasContext *ctx, int exception)
 {
-    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-    copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
+    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
     nullify_save(ctx);
     gen_excp_1(exception);
     ctx->base.is_jmp = DISAS_NORETURN;
@@ -795,8 +796,8 @@ static void gen_goto_tb(DisasContext *ctx, int which,
         tcg_gen_movi_reg(cpu_iaoq_b, b);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
-        copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, f, cpu_iaoq_b);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, b, ctx->iaoq_n_var);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -1752,7 +1753,7 @@ static bool do_dbranch(DisasContext *ctx, target_ureg dest,
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
-            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         ctx->iaoq_n = dest;
         if (is_n) {
@@ -1762,7 +1763,7 @@ static bool do_dbranch(DisasContext *ctx, target_ureg dest,
         nullify_over(ctx);
 
         if (link != 0) {
-            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
 
         if (is_n && use_nullify_skip(ctx)) {
@@ -1860,7 +1861,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
 
     if (ctx->null_cond.c == TCG_COND_NEVER) {
         if (link != 0) {
-            copy_iaoq_entry(cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         next = tcg_temp_new();
         tcg_gen_mov_reg(next, dest);
@@ -1906,7 +1907,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         tmp = tcg_temp_new();
         next = tcg_temp_new();
 
-        copy_iaoq_entry(tmp, ctx->iaoq_n, ctx->iaoq_n_var);
+        copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_movcond_reg(c, next, a0, a1, tmp, dest);
         ctx->iaoq_n = -1;
         ctx->iaoq_n_var = next;
@@ -2643,8 +2644,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
             nullify_over(ctx);
 
             /* Advance the instruction queue.  */
-            copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
             nullify_set(ctx, 0);
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
@@ -3433,7 +3434,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
-        copy_iaoq_entry(cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
+        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
     }
     if (a->n && use_nullify_skip(ctx)) {
@@ -3442,7 +3443,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
     } else {
-        copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
         if (ctx->iaoq_b == -1) {
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
         }
@@ -3556,14 +3557,14 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
     nullify_over(ctx);
     dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
 
-    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
     if (ctx->iaoq_b == -1) {
         tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
     }
-    copy_iaoq_entry(cpu_iaoq_b, -1, dest);
+    copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
     tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
     if (a->l) {
-        copy_iaoq_entry(cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
+        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
     }
     nullify_set(ctx, a->n);
     tcg_gen_lookup_and_goto_ptr();
@@ -4218,7 +4219,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_IAQ_N_STALE_EXIT:
         if (ctx->iaoq_f == -1) {
             tcg_gen_mov_reg(cpu_iaoq_f, cpu_iaoq_b);
-            copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
 #ifndef CONFIG_USER_ONLY
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
 #endif
@@ -4247,8 +4248,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
-        copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
-        copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
         /* FALLTHRU */
     case DISAS_IAQ_N_UPDATED:
-- 
2.34.1


