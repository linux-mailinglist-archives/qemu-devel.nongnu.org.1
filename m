Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADA7D79A0
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6n-0002Cm-7R; Wed, 25 Oct 2023 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6B-0000z0-NN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5x-0006cE-6s
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so2218955ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279568; x=1698884368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qt73rqnYlScESAX1GLvymJtn101eThzhHh8tymn5hTE=;
 b=DULBObys5g8APW5N3EyCjBIjqk38rVMbS3j/IPPe4p/LVP851+zrv/EzwxX5+aWlXX
 9pkZdH60R0AF5V4RL0oKXe3CJ8F3bIQYsiiHgVCczc5IEOmEeHSf+n2/4BgxuIjiPJsj
 vk4fEtBk4ewHiSO12Y61y2seKoZvFFqeRzUPWgPY9CLz77koPT0iiBfWPj4BNIHaXg9Y
 VSrIEKHuxI7snLaPW3NFU+2ERlkqgB64MYQQJQpCC51lOycUMrAqUsYSLJMOSsuXpC9K
 ++XAKvVhckZMPl93aEb3ehT8DUl9EgmxG1oGqcUVujQW0rEOvLrr2ONlH/SO255L8mqL
 QyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279568; x=1698884368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qt73rqnYlScESAX1GLvymJtn101eThzhHh8tymn5hTE=;
 b=HqOwYxAfn9MoxxxDNXupFM/bIHqdRCDfJbMROFNvLGn70Gu2K3BuM9rXfKVk22Wu8k
 3hyHElRVlE2svprDR2RobWPwNP2Ji2Yxcd9ggSrVs8DaQM6t+W5YOKXOETuFSfTD+B5Z
 0dfbpcdIf7DcuWbC5TqZ4cigP8znCp29UtR0/J9iUr34bYGycD+SxtkPKwK+h5SigRWB
 xu79DUI0m0zOfc5V9NAJBgk4Nysr59tR91e00llkupizrN7MS8YIgJGxqriwUZokbzmJ
 O726FA+QyGW0FqqOqKgdVNMkr0dvJh4R0+yoPTZDyphO6VU7TFpgCg2okpWunSSCuMiv
 MhdQ==
X-Gm-Message-State: AOJu0Yy86dXGuycUmu9A1kZ8hW21d3m/fT6BbIIxmYXbohwZWxsJmWOW
 VKc8T2BH0jgrsB0/d6XVnS5qTyBZaNCjCvJIwYw=
X-Google-Smtp-Source: AGHT+IGTJJ1fSEooAMyiMi7hrBbQEqHGAkkYEKBY6J1FiyqTT/iTF+I9yVzo+HWSOzafY1NwdJZ2Jg==
X-Received: by 2002:a17:902:fa87:b0:1c9:de48:fc78 with SMTP id
 lc7-20020a170902fa8700b001c9de48fc78mr14022761plb.7.1698279567902; 
 Wed, 25 Oct 2023 17:19:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/29] target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
Date: Wed, 25 Oct 2023 17:14:32 -0700
Message-Id: <20231026001542.1141412-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..49e6a7b62d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, int32_t disp)
+                                        TCGv cmp, uint64_t imm, int32_t disp)
 {
     uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
+        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
@@ -472,27 +472,20 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         return DISAS_NORETURN;
     } else {
-        TCGv_i64 z = load_zero(ctx);
+        TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
+        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         return DISAS_PC_UPDATED;
     }
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                               int32_t disp, int mask)
+                               int32_t disp)
 {
-    if (mask) {
-        TCGv tmp = tcg_temp_new();
-        DisasJumpType ret;
-
-        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
-        ret = gen_bcond_internal(ctx, cond, tmp, disp);
-        return ret;
-    }
-    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
+                              is_tst_cond(cond), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
     DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
     return ret;
 }
 
@@ -2827,35 +2820,35 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x38:
         /* BLBC */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTEQ, ra, disp21);
         break;
     case 0x39:
         /* BEQ */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x3A:
         /* BLT */
-        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x3B:
         /* BLE */
-        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x3C:
         /* BLBS */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTNE, ra, disp21);
         break;
     case 0x3D:
         /* BNE */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x3E:
         /* BGE */
-        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x3F:
         /* BGT */
-        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
-- 
2.34.1


