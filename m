Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B07C7F15
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwS-0004xe-4c; Fri, 13 Oct 2023 03:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwQ-0004w1-3h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwD-0004WB-TZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so1516066f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183423; x=1697788223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uM0E9ceeAMWbhoziwyQzC8KkJu+r5Wws3ZK6kx7zlsI=;
 b=w/bvPJ35yI9w+7OsNGJMY0u9u473e9Z0MK/wEalC2Alq0BXPVPvUYWcZe3owQnTc6r
 IBu6WOtF0UqdPimG2os7IYilkUDgGfKKOBLLeKcRaDyW2BCgDZnAQvSDiuxff6cYv01N
 Ch4VIYwahEgBxmTTqGIRoGMpFupVMW0ihQO/NshlfAHmK2yyFP8WpzyorFUFfh6OtORm
 v/GnX/n/4AX0DYOFhKvhxdAWpTCOL2p2aMx+dGb/mZSzFQK0zABStZrej6pbIjPd1N6I
 EdWqj4NXoouU0nX6+R2DsMADt73RVgAAzO8WlquNKL+zAP2+Bq+PT5kpJ2Szlcmbw1Mi
 crAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183423; x=1697788223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uM0E9ceeAMWbhoziwyQzC8KkJu+r5Wws3ZK6kx7zlsI=;
 b=PzuFttyAKasQdhkam+PqAIZGzi4Cw51vy6Lc+RtZLN5zFbjOpgot65QHJpnjB5C0ll
 Q5IzyaK5FtYCpv9p2MOKQZ3GiUnk11x8vwbkWbozVfkK7zN+zyQWyK882KWam4IWkyhm
 kO21VClEm0uuRdAyD0uPbD9ZKBB+LhNrohsMdcom6A/6432rSb1XxWbQrppN5FsyjM+q
 zNQRBFw2XhpB853iBLbGGKp/p7nkAsiZmBhswSt9GwFxMIFOwZqVb+r00swTVr0MRb4u
 KoDUFwcbeTzNVhYq3+/YZ9o/XbdeOSp1pTlI7G8uX6M1dSmNqRoCmJO5tZaxgPzJwa5K
 Un5Q==
X-Gm-Message-State: AOJu0YzPup7M00h7jsYy7hyoRYt1HJEaCkrex9jN8fXPH7d+4KytowPX
 TfYlIjXZroVhagiw878erSgpwaq63e7PuxjeQiU=
X-Google-Smtp-Source: AGHT+IE9WYCCohzHh/dJgVOrJSIwZVaoJrzToSsXXJJbXMkEQPCaJw3bA7f9gz2HQnSFJFipqQIpyw==
X-Received: by 2002:adf:eec5:0:b0:319:7134:a3cf with SMTP id
 a5-20020adfeec5000000b003197134a3cfmr23274764wrp.31.1697183422786; 
 Fri, 13 Oct 2023 00:50:22 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:22 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 19/78] target/hppa: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:23 +0300
Message-Id: <f896b2cc935370ad4556d2d1019529f61caa3074.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9f3ba9f42f..1df81b0fa2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -480,14 +480,14 @@ static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 static void cond_free(DisasCond *cond)
 {
     switch (cond->c) {
     default:
         cond->a0 = NULL;
         cond->a1 = NULL;
-        /* fallthru */
+        fallthrough;
     case TCG_COND_ALWAYS:
         cond->c = TCG_COND_NEVER;
         break;
     case TCG_COND_NEVER:
         break;
     }
 }
@@ -3831,65 +3831,65 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
     TCGv_reg t;
 
     nullify_over(ctx);
 
     t = get_temp(ctx);
     tcg_gen_ld32u_reg(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
         int mask;
         bool inv = false;
 
         switch (a->c) {
         case 0: /* simple */
             tcg_gen_andi_reg(t, t, 0x4000000);
             ctx->null_cond = cond_make_0(TCG_COND_NE, t);
             goto done;
         case 2: /* rej */
             inv = true;
-            /* fallthru */
+            fallthrough;
         case 1: /* acc */
             mask = 0x43ff800;
             break;
         case 6: /* rej8 */
             inv = true;
-            /* fallthru */
+            fallthrough;
         case 5: /* acc8 */
             mask = 0x43f8000;
             break;
         case 9: /* acc6 */
             mask = 0x43e0000;
             break;
         case 13: /* acc4 */
             mask = 0x4380000;
             break;
         case 17: /* acc2 */
             mask = 0x4200000;
             break;
         default:
             gen_illegal(ctx);
             return true;
         }
         if (inv) {
             TCGv_reg c = load_const(ctx, mask);
             tcg_gen_or_reg(t, t, c);
             ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
         } else {
             tcg_gen_andi_reg(t, t, mask);
             ctx->null_cond = cond_make_0(TCG_COND_EQ, t);
         }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
 
         tcg_gen_extract_reg(t, t, 21 - cbit, 1);
         ctx->null_cond = cond_make_0(TCG_COND_NE, t);
     }
 
  done:
     return nullify_end(ctx);
 }
 
 /*
  * Float class 2
  */
@@ -4219,28 +4219,28 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = ctx->base.is_jmp;
 
     switch (is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
     case DISAS_IAQ_N_STALE:
     case DISAS_IAQ_N_STALE_EXIT:
         copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
         copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
-        /* FALLTHRU */
+        fallthrough;
     case DISAS_IAQ_N_UPDATED:
         if (is_jmp != DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
-        /* FALLTHRU */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


