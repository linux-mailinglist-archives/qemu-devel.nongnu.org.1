Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E077E337E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPJ-0008IT-OS; Mon, 06 Nov 2023 22:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COP-0006pj-AO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COJ-0000ge-QF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:41 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so37382055ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326268; x=1699931068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7b9B75syRRFox+ySjdaas6fiuQ+tj66tig0BEDzKTxY=;
 b=Eu9Fv75pnGt1inaYDskgz1sEyfteJNzKDk3CyDaUEqbELMWdHInQS8E81QeVlkLjHK
 c0ZuJx6n9qEc/N1xPH3LUBoe20/DxvrcYgdUV6JHVGdIztNLaDESNLmoOMf2fw2g1eyi
 oioiKFxWm8mw+IkN13/MBhMQ+qsJ6I2TA8G3JRqIM+b13KOSVvPuv14Acmh62Eu+qnJA
 gbD1QbbO+KeHbSMl3jX07pePZtTU+bkmPilBlOETtFQji7f2rIpGKTK6iCtgOO30QtNQ
 6opul/ve3//l2cZcYKLyuoVt6jTbC8gHdcbT0JFbJuViAhY4CLSJhvlfL2phOAAr2W0s
 447Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326268; x=1699931068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b9B75syRRFox+ySjdaas6fiuQ+tj66tig0BEDzKTxY=;
 b=rkJfTDrYeyZHlVTl/8pz2TQXAqN9p4lOYQQiog1cfpRxUF+ZsvxBWXFnHBdmwlfm1S
 uc8Fp5IHYxAetnxDfNGKtiYfGaK/blK6nZhLlJtZAagAhyV5E/+NsxBhl81ltnKHRJTj
 gsNjqqrWusURILfNZvN0DXL/H2ztniz0PZN+CRZiEN2n7FZSAjuL6HzITRdToIVa4AJH
 als4ywhc1tElm8oFru8OuBgkAzEYh7D48oPkkmkkCUJu7aasDhszMlxsPNF3PDeVQMad
 NqF9rpBZ+j9Q9wVUZCvkFzT+9wyxo+6z9dRxLMozYTM6GFEdTzWmlukpHU1r/KcxdE1N
 C0pw==
X-Gm-Message-State: AOJu0Yxnkv30mKzeX/mAqVB9Nbm/OUGZAjLz4FhuFg3YZ6QUtX3V+S5N
 3lxxoDhlBV6YVGPhPKlDvqMWbSZMbcyH57NUhoc=
X-Google-Smtp-Source: AGHT+IH56zNsE9QedxseFAHmaPYMe30Zf157kJCDNv1iT/nMICQlrBvMGMQmCx91IkxgJL3OIcCEiw==
X-Received: by 2002:a17:903:190:b0:1cc:50ad:4e with SMTP id
 z16-20020a170903019000b001cc50ad004emr23126228plg.47.1699326268136; 
 Mon, 06 Nov 2023 19:04:28 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/85] target/hppa: Always use copy_iaoq_entry to set
 cpu_iaoq_[fb]
Date: Mon,  6 Nov 2023 19:03:08 -0800
Message-Id: <20231107030407.8979-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This will be how we ensure that the IAOQ is always
valid per PSW.W, therefore all stores to these two
variables must be done with this function.

Use third argument -1 if the destination is always dynamic,
and fourth argument NULL if the destination is always static.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e342cc1d08..348fdb75e5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -792,8 +792,8 @@ static void gen_goto_tb(DisasContext *ctx, int which,
 {
     if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
         tcg_gen_goto_tb(which);
-        tcg_gen_movi_reg(cpu_iaoq_f, f);
-        tcg_gen_movi_reg(cpu_iaoq_b, b);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, f, NULL);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, b, NULL);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
         copy_iaoq_entry(ctx, cpu_iaoq_f, f, cpu_iaoq_b);
@@ -1867,8 +1867,9 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         tcg_gen_mov_reg(next, dest);
         if (is_n) {
             if (use_nullify_skip(ctx)) {
-                tcg_gen_mov_reg(cpu_iaoq_f, next);
-                tcg_gen_addi_reg(cpu_iaoq_b, next, 4);
+                copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
+                tcg_gen_addi_reg(next, next, 4);
+                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
                 nullify_set(ctx, 0);
                 ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
                 return true;
@@ -1890,8 +1891,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
         /* We do have to handle the non-local temporary, DEST, before
            branching.  Since IOAQ_F is not really live at this point, we
            can simply store DEST optimistically.  Similarly with IAOQ_B.  */
-        tcg_gen_mov_reg(cpu_iaoq_f, dest);
-        tcg_gen_addi_reg(cpu_iaoq_b, dest, 4);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
+        next = tcg_temp_new();
+        tcg_gen_addi_reg(next, dest, 4);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
 
         nullify_over(ctx);
         if (link != 0) {
@@ -1970,6 +1973,8 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
    aforementioned BE.  */
 static void do_page_zero(DisasContext *ctx)
 {
+    TCGv_reg tmp;
+
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
        next insn within the privileged page.  */
@@ -2006,8 +2011,11 @@ static void do_page_zero(DisasContext *ctx)
 
     case 0xe0: /* SET_THREAD_POINTER */
         tcg_gen_st_reg(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
-        tcg_gen_ori_reg(cpu_iaoq_f, cpu_gr[31], 3);
-        tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
+        tmp = tcg_temp_new();
+        tcg_gen_ori_reg(tmp, cpu_gr[31], 3);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
+        tcg_gen_addi_reg(tmp, tmp, 4);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
         break;
 
@@ -3438,8 +3446,9 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
     }
     if (a->n && use_nullify_skip(ctx)) {
-        tcg_gen_mov_reg(cpu_iaoq_f, tmp);
-        tcg_gen_addi_reg(cpu_iaoq_b, cpu_iaoq_f, 4);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
+        tcg_gen_addi_reg(tmp, tmp, 4);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
     } else {
@@ -3447,7 +3456,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         if (ctx->iaoq_b == -1) {
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
         }
-        tcg_gen_mov_reg(cpu_iaoq_b, tmp);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
         nullify_set(ctx, a->n);
     }
@@ -4218,7 +4227,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
         if (ctx->iaoq_f == -1) {
-            tcg_gen_mov_reg(cpu_iaoq_f, cpu_iaoq_b);
+            copy_iaoq_entry(ctx, cpu_iaoq_f, -1, cpu_iaoq_b);
             copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
 #ifndef CONFIG_USER_ONLY
             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
@@ -4228,7 +4237,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                                 ? DISAS_EXIT
                                 : DISAS_IAQ_N_UPDATED);
         } else if (ctx->iaoq_b == -1) {
-            tcg_gen_mov_reg(cpu_iaoq_b, ctx->iaoq_n_var);
+            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
         }
         break;
 
-- 
2.34.1


