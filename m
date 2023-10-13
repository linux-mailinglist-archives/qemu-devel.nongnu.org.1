Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A97C7FD7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4b-00013G-F8; Fri, 13 Oct 2023 03:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD45-0000TU-N4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD43-0006rW-Vo
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so19507905e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183910; x=1697788710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uM0E9ceeAMWbhoziwyQzC8KkJu+r5Wws3ZK6kx7zlsI=;
 b=JfuhK8k1pzlSQcEchsvUx25ZUUjMiakv8m+OTiqNu0Z1vZLJ5glQ+HhDpUvYC43Sks
 xUVWeTyJAkyLAN+QbME9PPrkUHWZUH90WKAZ+JQ5dzEJoLa0CjIG7OSBg9oncugtBYCb
 qyr8fN0ZNbIJtPnInNNFsnbZhHwJA0+V+Z2kgrO4scoQ3vTSzKdITj+/JDwiznm2bMMP
 N5wlyAZwi8OlH8qaIpZda1zh0ULfc5S6NhRI0K3RFmMr/qSjq0BVrYfU4gKEmTosUEIx
 4TCVvxtfT4IrzzD1ZDP8vaQoEyJN7zXjc3qHeASu6dzB9blhCks88ikvdCA14qmC6/gk
 ALcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183910; x=1697788710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uM0E9ceeAMWbhoziwyQzC8KkJu+r5Wws3ZK6kx7zlsI=;
 b=Zcr7ADRorImBDmmTtfZ7YCeedc7sWId/l0Lk/zkTE3D6+Sb3jGNmAPJOddchUxD61o
 Ndb1lVpuqouWRWt5DmVvrn2KLJ9XLQtk0fo5oSnEYSLizL8wqypBZvwjlzDD4ctlpCV0
 x7IooFYWdQ+cHxryP1owMTjhcGUJ9wjt7QD3ecrHrBCj0pne5cHTmuuo+Q5VK5/FUzsS
 7jEvJTD8f6tPIzH2QQTtsQ5SZP1xm4UePhlFwhyMC+eCyWz9hJMmSm2+PsKU1j+nGfxn
 1C/0eXQ+brUu8E8T+EHnQygjUxwJ0YWs323pF3EIutm2IyPamtZqfEogLDhnSBAVqu5X
 wdGw==
X-Gm-Message-State: AOJu0YyLGUmEq6t6lv8ZpTzhxhQP5NkddP3BI9GAMEeI2+gFkfkbe5AQ
 IJi/dgcrIgduhwZrtE7eJMd3EM0ikU9d2XQP6PI=
X-Google-Smtp-Source: AGHT+IGj9WjKLhocneIGnWgQY4VWYWfqAG5I8/jQEB+ZDJk2PtZDAt/uR/lg4zme+GfxZfRurIlzVg==
X-Received: by 2002:a1c:791a:0:b0:406:5308:cfeb with SMTP id
 l26-20020a1c791a000000b004065308cfebmr23395756wme.11.1697183910348; 
 Fri, 13 Oct 2023 00:58:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:29 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 19/78] target/hppa: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:46 +0300
Message-Id: <f896b2cc935370ad4556d2d1019529f61caa3074.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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


