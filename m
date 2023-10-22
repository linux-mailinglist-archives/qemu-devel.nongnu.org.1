Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26097D217A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdZ-00078W-EF; Sun, 22 Oct 2023 02:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdS-0006RJ-8X
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdN-00036N-7T
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9d922c039so18128685ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954894; x=1698559694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Evq7CIpzXcx3yrXwcB1jo0LKSLZATdCv+zawU7+n2WQ=;
 b=VvaKaJqU3A/hF8ePQ4ym9l6Osvk8AxM981eGkK9lnuT0/ALY7gRxTkorH8B/ix/jny
 IuO7L5Ui4rCaDUk8tWnL7l+hdyfREWsJ65bDvhtGIJWwifkrbV8yVWnQ7r+cM6XAo0WE
 T3fnHkv7BH/CBGZ+s8xLrU/j6UQ2y+F2Fb5A+algWz8+wShtLiT0VxHle4pfavR12zXU
 NPhT5RENwgcw+VzoA90KD7sU5PXKU39hPr3531+dBBZUi9Qu/NZjrI9Hn1fOS5gJnfQ+
 Z+d9gZKiGFqrKt5mGXcVPA5Ew5n2QGeyVglMG4X5Efs+Fyh8hCzQi7CAvTw1X0To/+hO
 dyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954894; x=1698559694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Evq7CIpzXcx3yrXwcB1jo0LKSLZATdCv+zawU7+n2WQ=;
 b=e1EhIyP8j2HTyAOwDIXCAHeblMt4dfhtXBpLPajfcQB3wdaLQ3hW1Ji/s13dOBG7HX
 jU/BPsUd9KaDMOhx173o6st/oNcfg2IiHqN2/P5NgD353dL1XE6DSzsQXMfYURiVsRFI
 RwtLh+Ggu3kmrdunjc6SIJa4URQBH31fYYEjYEUjotyh0QfXT9RzoDwvR2DQwcjZFyEQ
 jCam7LoH0ePQLtS2c32qfg60aTlffeg9NYrzDlRswLPrCOrDJVptqEMAE6xIAMpDJXqq
 Twj+o/HoyEsmyMbeVGNdbAZsP9AUu2MN3St4hCoH2dui254F/62gMb3JAMVhfr/JY+RC
 djYQ==
X-Gm-Message-State: AOJu0Yy24SJsNdRHttpn7kZy5XJuOk3cK5bkcTnqwgFaeVoBnAinZViD
 WnVCkbB7wZZkHT8sFhIk4NNwgxbuEdQ21pl3zA0=
X-Google-Smtp-Source: AGHT+IG2+td1dGi74giuk8e0nJr5cCvSDxs38gbqQc4geoLbp9gJNm7Jwb6SVTEd9b5eJwncQGUjcw==
X-Received: by 2002:a17:902:eecc:b0:1c5:ba50:2b28 with SMTP id
 h12-20020a170902eecc00b001c5ba502b28mr5701344plb.25.1697954894465; 
 Sat, 21 Oct 2023 23:08:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 86/90] target/sparc: Convert FCMP, FCMPE to decodetree
Date: Sat, 21 Oct 2023 23:00:27 -0700
Message-Id: <20231022060031.490251-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index de1c18d93b..dee155143c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5286,6 +5286,82 @@ TRANS(FMOVsfcc, 64, do_fmovfcc, a, false, gen_fmovs)
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
@@ -5296,15 +5372,7 @@ TRANS(FMOVqfcc, 64, do_fmovfcc, a, true, gen_fmovq)
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
@@ -5314,61 +5382,22 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5553,14 +5582,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


