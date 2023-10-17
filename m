Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C2A7CBB89
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlu-0007wH-7L; Tue, 17 Oct 2023 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlZ-0007sW-Rg
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlX-0001rU-Df
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso44513485ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524878; x=1698129678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZyDk50srskapKLjo7jm3988q6EoPl5W35pXSSUqy8Q=;
 b=eW3HtNtpAXH5uyQTBflf1zQMPkyVCzzVIdXh9uQJXnyGWkQal96uvogdm+eUI9768q
 gK9CyX49GKJzDtg2bS3QfXnT/Q3ng2GfD5/en654yJTF7wBiF5eEcoCKDuDHcLfRro4a
 sxy717WsZ9kw59SAerbItkbtZZSRwvX93NJ5ZbZigLoORMO8mslIjeKEMrcd4GNqsLJ0
 KfIPC2dUqcmdyvb/CAtysg8gu3br5gIdRbHPmvZCxWM2AIOTgsiF2zTyPWg7CFbxZe32
 z0GXGTvDCNJ85YIoO3FoYtNajMxtOy1Be00k3r4TzqliewQOGnAtnsokGVUmpuIVLX4K
 H/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524878; x=1698129678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZyDk50srskapKLjo7jm3988q6EoPl5W35pXSSUqy8Q=;
 b=hMAbndtxW6qDv2/VoeJf8cz2SGdlBrnDa05ujdd7i4o8oA/iqyZf6CIP/UgrQ59pM0
 21Iis1Pg/1C1cmueRikGOxwJPspiFc7PxCRiPeq6cZNU5HGYeaZtK4xy4FJie7qxKCdX
 cs4AJmq+yIWO3nl42CtRe9tlVlcHHEMBS8EigwM625Owjxiq2scCGQ1vAZEBMDJOWPGn
 MTw54QnhsFPDIbpyFPVB6ksYyGzyWrUWk4l6WrscaJy0iM4kU94l2iJjQsNVeK+8D9XO
 5wCPTTdlIu9RSyJyEK5HnsTkUWn/DbwqGVKruMM5pVb/vKgyZe8CbdvVm502Y0iWf75s
 hMbQ==
X-Gm-Message-State: AOJu0YxgMUveYvH/AgXl327tJaw1UEnauZlifTAEpEqePG7GpA+h212+
 HPU4bM93ads6YhEaALIrsduhY+579Bmdj2+k0Gc=
X-Google-Smtp-Source: AGHT+IFxwh3jZnrXRTyGxeg3y1Ei9DqnupuFFFFYSnJin9KhylU4G3xg1YL9kw+2SGYtA+gsfTtQkQ==
X-Received: by 2002:a17:903:2307:b0:1c8:a63a:2087 with SMTP id
 d7-20020a170903230700b001c8a63a2087mr1899227plh.65.1697524878020; 
 Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/20] target/sparc: Change DisasCompare.c2 to int
Date: Mon, 16 Oct 2023 23:40:59 -0700
Message-Id: <20231017064109.681935-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

We don't require c2 to be variable, so emphasize that.
We don't currently require c2 to be non-zero, but that will change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a8933d2fc3..32d29f16b5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -183,7 +183,8 @@ typedef struct DisasContext {
 
 typedef struct {
     TCGCond cond;
-    TCGv c1, c2;
+    TCGv c1;
+    int c2;
 } DisasCompare;
 
 // This function uses non-native bit order
@@ -974,15 +975,15 @@ static void gen_op_next_insn(void)
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
-    TCGv t1, t2;
+    TCGv t1, t2, zero;
 
     cmp->c1 = NULL;
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 
     switch (cond & 7) {
     case 0x0: /* never */
         cmp->cond = TCG_COND_NEVER;
-        cmp->c1 = cmp->c2;
+        cmp->c1 = tcg_constant_tl(0);
         break;
 
     case 0x1: /* eq */
@@ -998,11 +999,12 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
     case 0x2: /* le: Z | (N ^ V) */
         cmp->cond = TCG_COND_LT;
         cmp->c1 = t1 = tcg_temp_new();
+        zero = tcg_constant_tl(0);
         if (TARGET_LONG_BITS == 32 || xcc) {
-            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, cpu_cc_Z, cmp->c2);
+            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, cpu_cc_Z, zero);
         } else {
             tcg_gen_ext32u_tl(t1, cpu_icc_Z);
-            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, t1, cmp->c2);
+            tcg_gen_negsetcond_tl(TCG_COND_EQ, t1, t1, zero);
         }
         t2 = tcg_temp_new();
         tcg_gen_xor_tl(t2, cpu_cc_N, cpu_cc_V);
@@ -1079,7 +1081,7 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
     cmp->c1 = r_dst = tcg_temp_new();
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 
     switch (cc) {
     default:
@@ -1165,7 +1167,7 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
     cmp->c1 = r_src;
-    cmp->c2 = tcg_constant_tl(0);
+    cmp->c2 = 0;
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
@@ -2155,7 +2157,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
        or fold the comparison down to 32 bits and use movcond_i32.  Choose
        the later.  */
     c32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i64(cmp->cond, c64, cmp->c1, cmp->c2);
+    tcg_gen_setcondi_i64(cmp->cond, c64, cmp->c1, cmp->c2);
     tcg_gen_extrl_i64_i32(c32, c64);
 
     s1 = gen_load_fpr_F(dc, rs);
@@ -2175,7 +2177,7 @@ static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
     TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
-    tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, cmp->c2,
+    tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, tcg_constant_tl(cmp->c2),
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
     gen_store_fpr_D(dc, rd, dst);
@@ -2189,10 +2191,11 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
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
@@ -2323,7 +2326,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
     if (annul) {
         TCGLabel *l1 = gen_new_label();
 
-        tcg_gen_brcond_tl(tcg_invert_cond(cmp->cond), cmp->c1, cmp->c2, l1);
+        tcg_gen_brcondi_tl(tcg_invert_cond(cmp->cond), cmp->c1, cmp->c2, l1);
         gen_goto_tb(dc, 0, npc, dest);
         gen_set_label(l1);
         gen_goto_tb(dc, 1, npc + 4, npc + 8);
@@ -2337,7 +2340,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                 tcg_gen_mov_tl(cpu_pc, cpu_npc);
                 tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
                 tcg_gen_movcond_tl(cmp->cond, cpu_npc,
-                                   cmp->c1, cmp->c2,
+                                   cmp->c1, tcg_constant_tl(cmp->c2),
                                    tcg_constant_tl(dest), cpu_npc);
                 dc->pc = npc;
                 break;
@@ -2352,9 +2355,9 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
 
             /* The condition for cpu_cond is always NE -- normalize. */
             if (cmp->cond == TCG_COND_NE) {
-                tcg_gen_sub_tl(cpu_cond, cmp->c1, cmp->c2);
+                tcg_gen_subi_tl(cpu_cond, cmp->c1, cmp->c2);
             } else {
-                tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
+                tcg_gen_setcondi_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
         }
     }
@@ -2554,7 +2557,7 @@ static bool trans_Tcc(DisasContext *dc, arg_Tcc *a)
     flush_cond(dc);
     lab = delay_exceptionv(dc, trap);
     gen_compare(&cmp, a->cc, a->cond, dc);
-    tcg_gen_brcond_tl(cmp.cond, cmp.c1, cmp.c2, lab);
+    tcg_gen_brcondi_tl(cmp.cond, cmp.c1, cmp.c2, lab);
 
     return advance_pc(dc);
 }
@@ -3913,8 +3916,9 @@ TRANS(SRA_i, ALL, do_shift_i, a, false, false)
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


