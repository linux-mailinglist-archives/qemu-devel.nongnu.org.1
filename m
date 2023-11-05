Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6337E164D
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU5-0003N0-NV; Sun, 05 Nov 2023 15:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU3-0003J1-N7
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:35 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU1-000294-VA
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:35 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5b980391d70so2927748a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215152; x=1699819952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkAbPNyjzsZeyxWh+5iNiCPTFDeY/R9h3v6lIAuzON8=;
 b=AMT6Cm+Ski86UkB8bYk+KHg4hrXUp3MY1yuWLyznqyp07RB59nznixJ0kHkJppEAl8
 87ZdYyAPwJ9oicNeHJPcXmOQiCR3zljDIyMMWMxbDFp2LB5CxmfQGXDuzushfnj0aGoM
 0xpZjJnrSkDH46jDFnv7Vss8+wrjZAvghNjS0dJ9Ogn867ZTLdeXW9kxE59yjXeMOgGb
 5xAUI+4uP1YiIfzFn71n1ilsBE4cDo1H+onY9y5p00nWv7LnYEKHaYx6pGDRoaFEy5F+
 cv8J8FYyZzrBpW/mcDKjzwkhSeZOO318bLg2rmMEDBHiIkG1bDecjpzE8d2EqEOn7Cxx
 A8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215152; x=1699819952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkAbPNyjzsZeyxWh+5iNiCPTFDeY/R9h3v6lIAuzON8=;
 b=oZDs9GbsX5bNLTyOV/ak9z8/BboqyjL9Usa4wW4+KXGz+k+FtWqWydL2Oskf/C3lf4
 ZwUHf0rF6rkj+pc88XchTADr0oU91V+kvb6hgmlZQxnWrin0mUkhrQxFUyzh9b1T3e+4
 3CL6CC9GGVOM5//6TB5Bl9/hXVS0hh8/7mvZxIGRaFd6oGl05Ro3GmJDVN2WTsu5Jg1L
 l9zZu1L2DQrquSMdnF693uiiozGjvuPN4vwj5TJUVedV6x/2WOBOu0pLJbwiJrfWc0sb
 6hOTH9mTyU6EzviDyGpyEPTm6g8yDiD59GAVD74dcCMSR/FqloYErIPVasozgdeseerA
 XJuA==
X-Gm-Message-State: AOJu0YwgvR8ZwjqrCGBgeq5cpEToiCMpcP/sIshtCJaaUxlQlb/5IZj8
 XnTiGMXTrKM1+X2oI4fd+I7aNKHZmzWBRoSdWfY=
X-Google-Smtp-Source: AGHT+IFeZSznT93nptHrFB6AA9wHTYl3UJ9sg4jL3xASFUi88aBjzua6Y4GZsv+bfSwG3iuCs5OzGg==
X-Received: by 2002:a05:6a20:a220:b0:17b:e0a3:f6f4 with SMTP id
 u32-20020a056a20a22000b0017be0a3f6f4mr20241438pzk.25.1699215152488; 
 Sun, 05 Nov 2023 12:12:32 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/21] target/sparc: Change DisasCompare.c2 to int
Date: Sun,  5 Nov 2023 12:12:11 -0800
Message-Id: <20231105201222.202395-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
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

We don't require c2 to be variable, so emphasize that.
We don't currently require c2 to be non-zero, but that will change.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 464f1607e3..a405512e6c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -180,7 +180,8 @@ typedef struct DisasContext {
 
 typedef struct {
     TCGCond cond;
-    TCGv c1, c2;
+    TCGv c1;
+    int c2;
 } DisasCompare;
 
 // This function uses non-native bit order
@@ -1039,12 +1040,12 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     TCGv t1;
 
     cmp->c1 = t1 = tcg_temp_new();
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 
     switch (cond & 7) {
     case 0x0: /* never */
         cmp->cond = TCG_COND_NEVER;
-        cmp->c1 = cmp->c2;
+        cmp->c1 = tcg_constant_tl(0);
         break;
 
     case 0x1: /* eq: Z */
@@ -1140,7 +1141,7 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
     cmp->c1 = r_dst = tcg_temp_new();
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 
     switch (cc) {
     default:
@@ -1226,7 +1227,7 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
     cmp->c1 = r_src;
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
@@ -2232,7 +2233,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
        or fold the comparison down to 32 bits and use movcond_i32.  Choose
        the later.  */
     c32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
+    tcg_gen_setcondi_i64(cmp->cond, c64, cmp->c1, cmp->c2);
     tcg_gen_extrl_i64_i32(c32, c64);
 
     s1 = gen_load_fpr_F(dc, rs);
@@ -2252,7 +2253,7 @@ static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
     TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
-    tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, cmp->c2,
+    tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, tcg_constant_tl(cmp->c2),
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
     gen_store_fpr_D(dc, rd, dst);
@@ -2266,10 +2267,11 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 #ifdef TARGET_SPARC64
     int qd = QFPREG(rd);
     int qs = QFPREG(rs);
+    TCGv c2 = tcg_constant_tl(cmp->c2);
 
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2], cmp->c1, cmp->c2,
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2], cmp->c1, c2,
                         cpu_fpr[qs / 2], cpu_fpr[qd / 2]);
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2 + 1], cmp->c1, cmp->c2,
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2 + 1], cmp->c1, c2,
                         cpu_fpr[qs / 2 + 1], cpu_fpr[qd / 2 + 1]);
 
     gen_update_fprs_dirty(dc, qd);
@@ -2409,7 +2411,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
     if (annul) {
         TCGLabel *l1 = gen_new_label();
 
-        tcg_gen_brcond_tl(tcg_invert_cond(cmp->cond), cmp->c1, cmp->c2, l1);
+        tcg_gen_brcondi_tl(tcg_invert_cond(cmp->cond), cmp->c1, cmp->c2, l1);
         gen_goto_tb(dc, 0, npc, dest);
         gen_set_label(l1);
         gen_goto_tb(dc, 1, npc + 4, npc + 8);
@@ -2423,7 +2425,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                 tcg_gen_mov_tl(cpu_pc, cpu_npc);
                 tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
                 tcg_gen_movcond_tl(cmp->cond, cpu_npc,
-                                   cmp->c1, cmp->c2,
+                                   cmp->c1, tcg_constant_tl(cmp->c2),
                                    tcg_constant_tl(dest), cpu_npc);
                 dc->pc = npc;
                 break;
@@ -2438,9 +2440,9 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
 
             /* The condition for cpu_cond is always NE -- normalize. */
             if (cmp->cond == TCG_COND_NE) {
-                tcg_gen_xor_tl(cpu_cond, cmp->c1, cmp->c2);
+                tcg_gen_xori_tl(cpu_cond, cmp->c1, cmp->c2);
             } else {
-                tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
+                tcg_gen_setcondi_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
         }
     }
@@ -2612,7 +2614,7 @@ static bool do_tcc(DisasContext *dc, int cond, int cc,
     flush_cond(dc);
     lab = delay_exceptionv(dc, trap);
     gen_compare(&cmp, cc, cond, dc);
-    tcg_gen_brcond_tl(cmp.cond, cmp.c1, cmp.c2, lab);
+    tcg_gen_brcondi_tl(cmp.cond, cmp.c1, cmp.c2, lab);
 
     return advance_pc(dc);
 }
@@ -3849,8 +3851,9 @@ static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 static bool do_mov_cond(DisasContext *dc, DisasCompare *cmp, int rd, TCGv src2)
 {
     TCGv dst = gen_load_gpr(dc, rd);
+    TCGv c2 = tcg_constant_tl(cmp->c2);
 
-    tcg_gen_movcond_tl(cmp->cond, dst, cmp->c1, cmp->c2, src2, dst);
+    tcg_gen_movcond_tl(cmp->cond, dst, cmp->c1, c2, src2, dst);
     gen_store_gpr(dc, rd, dst);
     return advance_pc(dc);
 }
-- 
2.34.1


