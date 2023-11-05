Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E244E7E1654
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:16:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU5-0003NO-Sm; Sun, 05 Nov 2023 15:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU2-0003DO-OC
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:34 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU1-00028p-2b
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:34 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c398717726so1112436b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215151; x=1699819951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgIxHuiUR0KbU50wGlTRe50Tyohq8BBHuIGeTYCLasg=;
 b=Iv0hlws/PehyuotA02pgfn9UuK2isSDMONm+vv+SSI/IBvkWomL2ps6CZbmlcNG15l
 I/LgBNd+eahkyVKGXbM35oSbl3Almg46fEqtHlO7k6SYXy+KYT2FNxcDEurIUqTN8gY+
 HC82Xo7kz/p3o2iVOGs+PsUSHY/r4Fa7CJ0jlLWfOwXt+Blws+dTq+AVMpkUsPwd7z03
 TzXtCYJDpLjjBSTn29VC8q1tduFBF+10FYKx4Ouyp6EZioUBo4qbLl733FPqyQBJWq1p
 TXnJNIPItcmBj5LREJh9VjFDd4mgg0/wURCophEvpi0nc3Rl/j8AygJKoZ50fsvGpANc
 4h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215151; x=1699819951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgIxHuiUR0KbU50wGlTRe50Tyohq8BBHuIGeTYCLasg=;
 b=CKK+CECFzJX20PWl29A2Ki8CRrNkEvm2EakWLPa81mQftBPQrvyeGFq/gIh+OxeQVY
 IZcYjguJc3Fu2TQackAfLlFqcJeee2LSOcOrU1Je5CWIaptVexs8MFm41notbzThzOqa
 3Dn+SKdvMICdo4vtI/I2ZSBnN2bkR7TAciGbBctNcthyuNYeMYEfROYtYODQeA3dwG+X
 wQj4P4oniJF8btSP/hII9nvuionGJ6h0GDfhLH1yEi4AsEyM9hsSqHBVpwxmeFbd7Qb/
 VqP1k5GEuwpjsLr7sr00q8hCWK3oa9cdeyD6AhmIhZKo/ubCMAJ17lgjcaAllcVaw9xu
 LcxA==
X-Gm-Message-State: AOJu0YyNsnRHT9RSnU6exLwjTxPYvjx6F7d6VqmU8PfhuakJAoEI5gDD
 FSKMAWJbJkkrX1yZ8w0kDnLHWSMJBTdJ4Le2KXs=
X-Google-Smtp-Source: AGHT+IGINTc/WiNvPduwKrhG6AJ6YUo0RqD+M83qnLItj+nWjEMFUtVLP/4pPpRBLewncf0bQYTH4Q==
X-Received: by 2002:a05:6a00:1a8a:b0:690:cae9:714d with SMTP id
 e10-20020a056a001a8a00b00690cae9714dmr7042611pfv.13.1699215151675; 
 Sun, 05 Nov 2023 12:12:31 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 09/21] target/sparc: Remove DisasCompare.is_bool
Date: Sun,  5 Nov 2023 12:12:10 -0800
Message-Id: <20231105201222.202395-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Since we're going to feed cpu_cond to another comparison, we don't
reqire a boolean value -- anything non-zero is sufficient.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7c4fcf8326..464f1607e3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -180,7 +180,6 @@ typedef struct DisasContext {
 
 typedef struct {
     TCGCond cond;
-    bool is_bool;
     TCGv c1, c2;
 } DisasCompare;
 
@@ -1039,7 +1038,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 {
     TCGv t1;
 
-    cmp->is_bool = false;
     cmp->c1 = t1 = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1104,7 +1102,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 
     case 0x5: /* ltu: C */
         cmp->cond = TCG_COND_NE;
-        cmp->is_bool = true;
         if (TARGET_LONG_BITS == 32 || xcc) {
             tcg_gen_mov_tl(t1, cpu_cc_C);
         } else {
@@ -1132,7 +1129,6 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     }
     if (cond & 8) {
         cmp->cond = tcg_invert_cond(cmp->cond);
-        cmp->is_bool = false;
     }
 }
 
@@ -1143,7 +1139,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
 
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
-    cmp->is_bool = true;
     cmp->c1 = r_dst = tcg_temp_new();
     cmp->c2 = tcg_constant_tl(0);
 
@@ -1230,7 +1225,6 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->is_bool = false;
     cmp->c1 = r_src;
     cmp->c2 = tcg_constant_tl(0);
 }
@@ -2232,18 +2226,14 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
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
@@ -2445,8 +2435,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
             dc->npc = JUMP_PC;
-            if (cmp->is_bool) {
-                tcg_gen_mov_tl(cpu_cond, cmp->c1);
+
+            /* The condition for cpu_cond is always NE -- normalize. */
+            if (cmp->cond == TCG_COND_NE) {
+                tcg_gen_xor_tl(cpu_cond, cmp->c1, cmp->c2);
             } else {
                 tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
-- 
2.34.1


