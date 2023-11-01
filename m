Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6C7DDBCC
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aB-0005yO-Kz; Wed, 01 Nov 2023 00:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a1-0005vd-SS
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:46 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a0-0007Xg-1q
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:45 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b52360cdf0so3256575b6e.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811903; x=1699416703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cOnNSYWB7XAtsxHVFuDBMfF9/R148G1DBxMPo0dbbQ=;
 b=QV9eMQuGqq6zOvt+c0Yn6NsLhhfArOdd8+hc51gVaEzvPmrnvdGwQWYEbPRYdx1LrI
 9rGVz3SFHg2jMG0MFzYZOXExxU+az9LTbw0uURTivVyP8UjkU851QY8IR1uh5hiWD6Jb
 8qzvGMYSsvTfykpHO09/+LH6Mbx0AewX1au7xWM0OHJO+mbOEm0rww/F3ZN2YawZRNmm
 pYI0RFZ2Fr2dvDHWI95HMiDrYz+Go8sRzMQNEIcuwXL7ILAV0HCBhB3uJNh5PpFkUanh
 IY1Wl5S4rd3PbuqYrJZ6dlLIMfWbeoMfqiuLWR3fY21OWU8IcXTMrrw1bQhGhBOViYDq
 jLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811903; x=1699416703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cOnNSYWB7XAtsxHVFuDBMfF9/R148G1DBxMPo0dbbQ=;
 b=XeucR6UrwD80yYyUS6viyqjWm1t3pVW+V/8Fb78i4xpDf9apijzNUHWme07CDYZkqj
 WKFsnAj7v1Ldty7lLGuXVTxdsV/V8Y7HyQ7Y/dmHMcCJRwYMDu4Yutv5IGHsWanBzBfE
 thFrGE/bm6g0uRYvHH263QTr63caPhgT/rpUssuekVxdmisYpDpFF2bFOnLtsAkPDea4
 VIWzfCCOK0Xp0ZcDUrefbGetJQjv+hQ1rPfhnHVBD4eU5C15OivMmgxomsLZ/SmOzIzG
 SWQc1Whvx1fVSyyzNi30WL0nggGsgTc1zAdqFpK+iUMP7mnZbCwdQb1E/6TYzvy6+r6B
 huNQ==
X-Gm-Message-State: AOJu0YwOTmWSRLFdluDy56N8+0XhxTDkXMIkRFJ1tLEB6OKnsC24lGly
 cO2+TRi1Bfl69j2Q+DftC9oKUrd4yZzGYxIhRjY=
X-Google-Smtp-Source: AGHT+IHWHHPoKh9SysGwJowDdRC7FZLG6W8KvAfgRlBA9HlzIqx+SUYx3dfalIqLCKNe1cXpv1OhIw==
X-Received: by 2002:a05:6808:1586:b0:3b2:f393:dab1 with SMTP id
 t6-20020a056808158600b003b2f393dab1mr15930653oiw.21.1698811902933; 
 Tue, 31 Oct 2023 21:11:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/21] target/sparc: Change DisasCompare.c2 to int
Date: Tue, 31 Oct 2023 21:11:21 -0700
Message-Id: <20231101041132.174501-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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


