Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428BC7E3386
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPF-0007cO-Cp; Mon, 06 Nov 2023 22:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COP-0006q5-Hl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:42 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gZ-4I
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:41 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc938f9612so29845425ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326267; x=1699931067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UdEYiuOYJXkuv427aOu34bhOpMdqGfn9qCvVFPH2z9A=;
 b=U8M71DpHChWu7eYp76cFRFiYV3A002/WkEmw0OqhU0tYf+y6rzoMeZ3mgv//eKh01N
 elPjlbY8Vg/u7LdKBRYBUh0IAss5OJYEbt+rXuvz2igzR1CD9PDRb8NiRJAS7b0nZT87
 Kp69qcIIuisaIfcfI13DWtF8PWESARpRUzpIg/oiWNfGcxSpTygiC2ys1kczfsrAt4vX
 SQlX1qMTMDkfFeTxGWFFb0JTB/GRY8uP9Ahe1hU30gwO7P8CHMbvheQGsPh2/7oDtRPw
 w2zBxH0kue/zjoHUTQwDwF6q3/bIu7LxuWqNCX28ossALVzRenV1/wgdppSIuED2ZzSJ
 Bdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326267; x=1699931067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdEYiuOYJXkuv427aOu34bhOpMdqGfn9qCvVFPH2z9A=;
 b=km0PS20+1/TZeS56lsM2YcrmriHeJ/b6VCIMaZhV9MAN+Fh7pxJVPPMs0e7/L6FdKs
 +Rx4Apgk0erqLkTRFMSvCZNLlExr4UNj3RjUCfOJiVRSyR6xJ+g4rFIMZuRvgdzmmqP6
 ed4S1dQkdnANaEqJJrT1McLV9VtPVCYFBHfd4ZP0KbPfhX6Xh+qN70z8up/AFUoz79bP
 QzOWIr116eMOvhItjkVMvihKzKFwZJfw5SwmkV4LgGQZrIShwEfQRg183vWztpjYHGFE
 UeqO3mhdZyprS8ELSctcVj+oIeJDg9a4inzie1peETflMwDkZxoGuD2NWtCdH2CMlPfV
 eYOQ==
X-Gm-Message-State: AOJu0YxAL5GqxTgV8v7s/4nKEAy8pdIea6sMYJ4/CenGQeIg3ArWBehE
 pSvHZ6XT8tItNBaQdYuwft953i0mNrFMyeACfns=
X-Google-Smtp-Source: AGHT+IFey3rmLbmUHVhGyKI/yxoXuQUrIOYvRJNdEDvdPDYb5LVEtriYqw0EVcRaNEqeg626pURVkQ==
X-Received: by 2002:a17:903:4091:b0:1cc:446c:770c with SMTP id
 z17-20020a170903409100b001cc446c770cmr16077230plc.33.1699326267303; 
 Mon, 06 Nov 2023 19:04:27 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/85] target/hppa: Pass DisasContext to copy_iaoq_entry
Date: Mon,  6 Nov 2023 19:03:07 -0800
Message-Id: <20231107030407.8979-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


