Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F77D273E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui0D-0007os-Sd; Sun, 22 Oct 2023 19:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui08-0007em-Ov
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:56 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui04-0008Sj-T8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:56 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2f5aed39cso1975948b6e.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017811; x=1698622611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmQyG43mCrJ9kXy27QqhFZG91TAM/SqRMs/u01+5FU8=;
 b=vRf4ygMoipbmCh8S9e4iLESiIPDYClB2rbDkYKCNgccUToADBVASJcRA//mGsi3J4l
 jsLsqvAY67C8I/LZGy02rVHyF0EVud6neBHIhdpFBj/bgBZJfc8Lwiu9xvIdmVwsarZh
 TdYfP4bhqnb9HRlYzwJGPsWrAZyjLsuKhT7GxZ02rCPHEHQMKhk5LKUMdQAErGUkZ/8l
 R0lC2JjyYamqgy2IkZl8D78fDA6lHFdx0tu8wjZgeysvrDi3LqdhlBLmVfPQ05I0QFdG
 92GCg3sdfJ25Q4kCl+j7rluxGuwHJ8cnehUUp5WFyDiO8sSm1O3xco4+kiM+tiZQ2+9g
 tFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017811; x=1698622611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmQyG43mCrJ9kXy27QqhFZG91TAM/SqRMs/u01+5FU8=;
 b=XaJ8yfv/v04V5XJu2IHfJNtNXTvJKaGN+8QtPSvENAhmOz8odzpZZSZc/Yx5J8n37F
 NJqqFQpQZzVHBJUAxj/eLarlBnQlVMeqCPfx6+4Ycd3xDk2P6YLcyab7DHrFJR6xVY4z
 7WMEgvoLAaNTIp4jJ3EE3b9I8MHRSH3krhlBzPHGQFbQaYzrzTL1HPFRkNWZ7rMv2224
 GpNQE7++EXripI7BHmgpj2ujatMK87h4CNh/3o6fsIwp5jxxbZcyhAr6lSnUylOtj7BR
 ng6hO058vwBZEU4LrMcWYz0ocTAd1RzfhU8aOCfOfwsRaY7MHbdv0nNR26VpwBvqzRtq
 KLrA==
X-Gm-Message-State: AOJu0YzJ+9Ef52KerYfFjAvvJDOqzV6qE3ayHAsUkU4eMlOStIzKKUOU
 stVvf3BIdCZlGK/iQMRP3kB4kFzalOE+AHaZdzc=
X-Google-Smtp-Source: AGHT+IFGDefPQ+vRUfMWy1uGS1F1H3no3xk8flTQBqEOxKCy3RcKEOW7HsB7ENNzl1JzXUL3jfhYGA==
X-Received: by 2002:a05:6808:ab7:b0:3ad:f5b7:d691 with SMTP id
 r23-20020a0568080ab700b003adf5b7d691mr8995670oij.18.1698017810828; 
 Sun, 22 Oct 2023 16:36:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 90/94] target/sparc: Convert FCMP, FCMPE to decodetree
Date: Sun, 22 Oct 2023 16:29:28 -0700
Message-Id: <20231022232932.80507-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   7 ++
 target/sparc/translate.c  | 145 +++++++++++++++++++++++---------------
 2 files changed, 96 insertions(+), 56 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d4487e326a..f197bb0b36 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -296,6 +296,13 @@ FMOVRs      10 rd:5  110101 rs1:5    0 cond:3  00101 rs2:5
 FMOVRd      10 rd:5  110101 rs1:5    0 cond:3  00110 rs2:5
 FMOVRq      10 rd:5  110101 rs1:5    0 cond:3  00111 rs2:5
 
+FCMPs       10 000 cc:2 110101 rs1:5  0 0101 0001 rs2:5
+FCMPd       10 000 cc:2 110101 rs1:5  0 0101 0010 rs2:5
+FCMPq       10 000 cc:2 110101 rs1:5  0 0101 0011 rs2:5
+FCMPEs      10 000 cc:2 110101 rs1:5  0 0101 0101 rs2:5
+FCMPEd      10 000 cc:2 110101 rs1:5  0 0101 0110 rs2:5
+FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
+
 {
   [
     EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 42c3a51b38..8ba07fac2f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5122,6 +5122,82 @@ TRANS(FMOVsfcc, 64, do_fmovfcc, a, false, gen_fmovs)
 TRANS(FMOVdfcc, 64, do_fmovfcc, a, false, gen_fmovd)
 TRANS(FMOVqfcc, 64, do_fmovfcc, a, true, gen_fmovq)
 
+static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
+{
+    TCGv_i32 src1, src2;
+
+    if (avail_32(dc) && a->cc != 0) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    if (e) {
+        gen_op_fcmpes(a->cc, src1, src2);
+    } else {
+        gen_op_fcmps(a->cc, src1, src2);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(FCMPs, ALL, do_fcmps, a, false)
+TRANS(FCMPEs, ALL, do_fcmps, a, true)
+
+static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
+{
+    TCGv_i64 src1, src2;
+
+    if (avail_32(dc) && a->cc != 0) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    if (e) {
+        gen_op_fcmped(a->cc, src1, src2);
+    } else {
+        gen_op_fcmpd(a->cc, src1, src2);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(FCMPd, ALL, do_fcmpd, a, false)
+TRANS(FCMPEd, ALL, do_fcmpd, a, true)
+
+static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
+{
+    if (avail_32(dc) && a->cc != 0) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT0(QFPREG(a->rs1));
+    gen_op_load_fpr_QT1(QFPREG(a->rs2));
+    if (e) {
+        gen_op_fcmpeq(a->cc);
+    } else {
+        gen_op_fcmpq(a->cc);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(FCMPq, ALL, do_fcmpq, a, false)
+TRANS(FCMPEq, ALL, do_fcmpq, a, true)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5132,15 +5208,7 @@ TRANS(FMOVqfcc, 64, do_fmovfcc, a, true, gen_fmovq)
 /* before an instruction, dc->pc must be static */
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
-    unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1 __attribute__((unused));
-    TCGv_i32 cpu_src1_32, cpu_src2_32;
-    TCGv_i64 cpu_src1_64, cpu_src2_64;
-    TCGv_i32 cpu_dst_32 __attribute__((unused));
-    TCGv_i64 cpu_dst_64 __attribute__((unused));
-
-    opc = GET_FIELD(insn, 0, 1);
-    rd = GET_FIELD(insn, 2, 6);
+    unsigned int opc = GET_FIELD(insn, 0, 1);
 
     switch (opc) {
     case 0:
@@ -5150,61 +5218,22 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     case 2:                     /* FPU & Logical Operations */
         {
             unsigned int xop = GET_FIELD(insn, 7, 12);
-            TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
 
             if (xop == 0x34) {   /* FPU Operations */
                 goto illegal_insn; /* in decodetree */
             } else if (xop == 0x35) {   /* FPU Operations */
-                if (gen_trap_ifnofpu(dc)) {
-                    goto jmp_insn;
-                }
-                gen_op_clear_ieee_excp_and_FTT();
-                rs1 = GET_FIELD(insn, 13, 17);
-                rs2 = GET_FIELD(insn, 27, 31);
-                xop = GET_FIELD(insn, 18, 26);
-
-                switch (xop) {
-                    case 0x51: /* fcmps, V9 %fcc */
-                        cpu_src1_32 = gen_load_fpr_F(dc, rs1);
-                        cpu_src2_32 = gen_load_fpr_F(dc, rs2);
-                        gen_op_fcmps(rd & 3, cpu_src1_32, cpu_src2_32);
-                        break;
-                    case 0x52: /* fcmpd, V9 %fcc */
-                        cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                        cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                        gen_op_fcmpd(rd & 3, cpu_src1_64, cpu_src2_64);
-                        break;
-                    case 0x53: /* fcmpq, V9 %fcc */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        gen_op_load_fpr_QT0(QFPREG(rs1));
-                        gen_op_load_fpr_QT1(QFPREG(rs2));
-                        gen_op_fcmpq(rd & 3);
-                        break;
-                    case 0x55: /* fcmpes, V9 %fcc */
-                        cpu_src1_32 = gen_load_fpr_F(dc, rs1);
-                        cpu_src2_32 = gen_load_fpr_F(dc, rs2);
-                        gen_op_fcmpes(rd & 3, cpu_src1_32, cpu_src2_32);
-                        break;
-                    case 0x56: /* fcmped, V9 %fcc */
-                        cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                        cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                        gen_op_fcmped(rd & 3, cpu_src1_64, cpu_src2_64);
-                        break;
-                    case 0x57: /* fcmpeq, V9 %fcc */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        gen_op_load_fpr_QT0(QFPREG(rs1));
-                        gen_op_load_fpr_QT1(QFPREG(rs2));
-                        gen_op_fcmpeq(rd & 3);
-                        break;
-                    default:
-                        goto illegal_insn;
-                }
+                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
+                TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
+                TCGv_i32 cpu_dst_32;
+                TCGv cpu_dst = tcg_temp_new();
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                rs1 = GET_FIELD(insn, 13, 17);
-                rs2 = GET_FIELD(insn, 27, 31);
+                int rs1 = GET_FIELD(insn, 13, 17);
+                int rs2 = GET_FIELD(insn, 27, 31);
+                int rd = GET_FIELD(insn, 2, 6);
+
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
                 }
@@ -5389,14 +5418,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         goto illegal_insn; /* in decodetree */
     }
     advance_pc(dc);
+#ifdef TARGET_SPARC64
  jmp_insn:
+#endif
     return;
  illegal_insn:
     gen_exception(dc, TT_ILL_INSN);
     return;
+#ifdef TARGET_SPARC64
  nfpu_insn:
     gen_op_fpexception_im(dc, FSR_FTT_UNIMPFPOP);
     return;
+#endif
 }
 
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


