Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E07CBB7A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdm5-0007wb-0d; Tue, 17 Oct 2023 02:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlZ-0007s8-Ax
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlW-0001rD-Kt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so32839355ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524877; x=1698129677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFFgB4yBmei7bH3EbUpFJjxrZVUqKwAxw+HBszM2y2A=;
 b=OJuxJMsUhbM0GulOVoi/Bb63hiXU4lKbn2z1g2UnA+AHPu18CiPl2GBiZKNDXfVd1G
 GLrsUdwoBeh/51rNFJ+QauA+rlMucIPfInQf9PhjDvpEmFiStrO2bGO2Qqovp3d5XjDT
 jS9cziCGWJLp8kgt9mft/OSoXIMKgCq7vJUZX1rcMlnoXzTfUzudMXhr7yo1BXMC04x4
 wEqnnu1ldF4UCqkrWnpHe/KEzgA8M88t9D/GpmNR02VQ0BSaXoaftohrk5J6afuj5Qzh
 3WONUW2iHMKnfs9jDUp1Rp4XUSg5jDa8M5z93vO8tg3rC1/tOjEpnpxDFmjDSf9hlcTi
 KM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524877; x=1698129677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFFgB4yBmei7bH3EbUpFJjxrZVUqKwAxw+HBszM2y2A=;
 b=slvaaJCQRqqLAaRj/yV6CjVCGh6BkiVqb5DusSTnsl52G52dVKxSNBoC4MzfQOdv7W
 irdZp1Ms8ZKdZZu04izqTzdj+BinoSSLM5OKWAXi3GOdCmQIFc0jQeRM9o2lTc9zcLbA
 iPfiZ6ZAWOwCLh3XGg3RqEgI1E3hPDqwkLuXDgsbkB/Ly07YuEIN/ouAAqepLtRaTPyZ
 BpBKDFWKSP9Cmo/yci0JG6wufuFLqOCU7qVzFiDW1lEWcl+fUrTEpQF4paGLVMEKQNSx
 A44/5nPQFWpc3fS7UJVMet9pTPNvGqEKBFYpCMCnXSQAMnmBrAZt/QlQ1iYyKCJZMHuh
 u9fg==
X-Gm-Message-State: AOJu0YwQJZ8IKz0fNlGwzCIDZWK9WkmlVOm3IUvO2sQoaToR0QMNCGl2
 OKRrygG99fQRNqgx59oR7pc7S84C3IC/WP1EolU=
X-Google-Smtp-Source: AGHT+IEyCG2g8b1Sf6pbkbmtfy6WqVrB5FhUa8JyR0iy5rneacss/0jKALPO0GyMrJ8wPwddCyFJ2A==
X-Received: by 2002:a17:902:fa07:b0:1ca:8541:e1fe with SMTP id
 la7-20020a170902fa0700b001ca8541e1femr1338699plb.62.1697524877294; 
 Mon, 16 Oct 2023 23:41:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/20] target/sparc: Remove DisasCompare.is_bool
Date: Mon, 16 Oct 2023 23:40:58 -0700
Message-Id: <20231017064109.681935-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Since we're going to feed cpu_cond to another comparison, we don't
reqire a boolean value -- anything non-zero is sufficient.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5c0b6b2764..a8933d2fc3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -183,7 +183,6 @@ typedef struct DisasContext {
 
 typedef struct {
     TCGCond cond;
-    bool is_bool;
     TCGv c1, c2;
 } DisasCompare;
 
@@ -977,7 +976,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 {
     TCGv t1, t2;
 
-    cmp->is_bool = false;
     cmp->c1 = NULL;
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1040,7 +1038,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
     case 0x5: /* ltu: C */
         cmp->cond = TCG_COND_NE;
-        cmp->is_bool = true;
         if (TARGET_LONG_BITS == 32 || xcc) {
             cmp->c1 = cpu_cc_C;
         } else {
@@ -1071,7 +1068,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     }
     if (cond & 8) {
         cmp->cond = tcg_invert_cond(cmp->cond);
-        cmp->is_bool = false;
     }
 }
 
@@ -1082,7 +1078,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
 
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
-    cmp->is_bool = true;
     cmp->c1 = r_dst = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1169,7 +1164,6 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->is_bool = false;
     cmp->c1 = r_src;
     cmp->c2 = tcg_constant_tl(0);
 }
@@ -2155,18 +2149,14 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
     TCGv_i32 c32, zero, dst, s1, s2;
+    TCGv_i64 c64 = tcg_temp_new_i64();
 
     /* We have two choices here: extend the 32 bit data and use movcond_i64,
        or fold the comparison down to 32 bits and use movcond_i32.  Choose
        the later.  */
     c32 = tcg_temp_new_i32();
-    if (cmp->is_bool) {
-        tcg_gen_extrl_i64_i32(c32, cmp->c1);
-    } else {
-        TCGv_i64 c64 = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
-        tcg_gen_extrl_i64_i32(c32, c64);
-    }
+    tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
+    tcg_gen_extrl_i64_i32(c32, c64);
 
     s1 = gen_load_fpr_F(dc, rs);
     s2 = gen_load_fpr_F(dc, rd);
@@ -2359,8 +2349,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
             dc->npc = JUMP_PC;
-            if (cmp->is_bool) {
-                tcg_gen_mov_tl(cpu_cond, cmp->c1);
+
+            /* The condition for cpu_cond is always NE -- normalize. */
+            if (cmp->cond == TCG_COND_NE) {
+                tcg_gen_sub_tl(cpu_cond, cmp->c1, cmp->c2);
             } else {
                 tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
-- 
2.34.1


