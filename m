Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1A7DEA0F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:33:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYM-0005t4-1M; Wed, 01 Nov 2023 21:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXn-0005lU-Np
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:49 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXl-0001ch-TZ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:47 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ce31c4a653so210639a34.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888644; x=1699493444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7b9B75syRRFox+ySjdaas6fiuQ+tj66tig0BEDzKTxY=;
 b=bK3CjHk8fAFXXSNes7rWr56JzuOpSJWX7QuTb4RXUqXcxreel1WJg2LGxmVg2/BzlG
 aO2LVUsrQKRE1dy1d9TEilRANvDYOC/bml3RHai2dXWQLrtTDObjlWHthBGjjegzrtv9
 tecTj082uqS4haKaKCfgmHbq9LoDgvFUqYzTnoANziwUvf7snJJfIGY9XBLVVWuqbNXk
 GdlsXIZyLCVcV4elkty3YuLDIkz8XkB+fdvDmstmEOWxdosDezokTw7GJOcV/PNS2YO8
 SjuUOerJyTMO9p9QNXmbCWLhoGmRnjMtgsg4yCo87SNPdVyBKhp+KJ7QpA/wqdLAGe6Y
 KHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888644; x=1699493444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b9B75syRRFox+ySjdaas6fiuQ+tj66tig0BEDzKTxY=;
 b=BvxkkxgD9xwX3OKUq9Fj5UHHl6LcmHVCruQCD9YOdrzzxIeeaB2PqUMQYoMS+ZDXCF
 +KvNdBTpJhFMkxDtVcWqOxJTpXsp2hJdS9hkFt0+0W3Be+tn4Amswm7gyEt8FCosnFfa
 so01YbEiV6/Ls3IQilWB5Jzn2cP/Lw43BLZFlb94OoBrE82KC4lCpvkXo7oSuF0Ppuwb
 pRVd2l9i6bUbOf0iCKpYzhzYbG/wFZGVjaDpU2XU6iwH6ZJrpaB9waiao6W4bYry+a5K
 SJCFhfduv0Z5LNzgilJItsL0f7ak1O1zFOmjFp4rlY7D0uXCGarW4Br5XDViE5oAgThB
 7vwA==
X-Gm-Message-State: AOJu0YyliTV4pjsPnacBJXaxq+/6pYLzg8AD5Fw681VcK6X8d0eBMBCa
 iT6/dhJ2RIOmGwSGUfyp9t7yo3G+QXDAI/9iYqc=
X-Google-Smtp-Source: AGHT+IELdaTEsMdZOosAR6OA3ixpZUaT9X+DcyYK2jxcZlI8YRZIT77/F/CLA0PaKCv7pMqdfEqi9g==
X-Received: by 2002:a05:6830:1e35:b0:6d3:a14:f3f1 with SMTP id
 t21-20020a0568301e3500b006d30a14f3f1mr7009128otr.7.1698888643774; 
 Wed, 01 Nov 2023 18:30:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 28/88] target/hppa: Always use copy_iaoq_entry to set
 cpu_iaoq_[fb]
Date: Wed,  1 Nov 2023 18:29:16 -0700
Message-Id: <20231102013016.369010-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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


