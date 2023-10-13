Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997A7C8F59
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPpH-0008Pu-J9; Fri, 13 Oct 2023 17:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpF-0008NT-3a
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpD-0002TX-89
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1972833b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232962; x=1697837762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGpp9w0A6VQMLD8+KEQ467+lPq6YeB2gwQvkJVTwliw=;
 b=Dja3XeorHtPjPEd9L4Tz/h+FDS8uv1YRjKy4NHVk0UREyi6fKWCQ/diwwXfXVeUdwa
 7PC3rWg8gSKtPZRN3deDcADqB9gbeESAxqpIywl5va+TO6O0TifcaCd3+td4weRDhxBn
 pmEJ2lKtSpLlQw4OFPqQSl8GvsJqqQu3IxRGBP8cK53mdI9u9+KDMWC7tjUWWJgAvS/b
 6DwrVIIJBgeCvVzvhHeVlV5WQtj+nb1h8ogOtlRjt0j7stfKWyGReqkiYMhwPi38E9Ig
 zEXwRDaVnXTTOycCcN/fqXDwnPIddOwBDAWAK5xPNOny3zVoU2E37ogHOYek4dHDv7JR
 5HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232962; x=1697837762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGpp9w0A6VQMLD8+KEQ467+lPq6YeB2gwQvkJVTwliw=;
 b=gknKIK8rjQnSrRmNWPmIR0bn6DxP+YC0r4xt97DzIOz74nAyPYzBv1lDaLgyiqXkca
 CLCjtsF07oC3g2vStu76CZO24WFSZwzWJF/tDZMHt9ZHGlbtw+JVpd6gDNUNSSq8cpWH
 6uhpjkMfowIZ56nO/2hE1DM66BC7KzAuLMpjBiRFzTONQy0Hx2l0k1W3GSDe8sX76tzf
 HtDAxiAdqXON0NJPjr9lIK+Y+g1uJhWUwDcsAsh3YxlpPUBAaxyA33BO1y2y/72A8JSI
 0hHaCIbX9jdY+nIs9c9wIL6VviEEXT4Xy7Iy29e00vfa5Q6VukJT2fk9jihL9qxm50yo
 yKLQ==
X-Gm-Message-State: AOJu0YxGjLso/jEFJexjxKZ5AYCWfatd8ytkrzE8ONAIsb93RdEi9cyh
 wLNPlyVc/X1rNFlhEazi1bu8Nl7yNw5VooaOVWc=
X-Google-Smtp-Source: AGHT+IEWOlcRyWdudWhbslaiahMqGJh4Wyu0pwGyagWdsY1TrkLiXMSNFDwpOaKhr/obVuy04aQ8Tg==
X-Received: by 2002:a05:6a00:2e28:b0:68e:46d2:e331 with SMTP id
 fc40-20020a056a002e2800b0068e46d2e331mr29489954pfb.23.1697232961866; 
 Fri, 13 Oct 2023 14:36:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b0068790c41ca2sm1123984pfb.27.2023.10.13.14.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 81/85] target/sparc: Convert FCMP, FCMPE to decodetree
Date: Fri, 13 Oct 2023 14:28:42 -0700
Message-Id: <20231013212846.165724-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index 5e8d456ab2..c5d6f46737 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -290,6 +290,13 @@ FMOVRs      10 rd:5  110101 rs1:5    0 cond:3  00101 rs2:5
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
index 2ecaa82de5..81d274448a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5105,6 +5105,82 @@ TRANS(FMOVsfcc, 64, do_fmovfcc, a, false, gen_fmovs)
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
+static bool do_fcmpd(DisasContext *dc, arg_FCMPq *a, bool e)
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
@@ -5115,15 +5191,7 @@ TRANS(FMOVqfcc, 64, do_fmovfcc, a, true, gen_fmovq)
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
@@ -5133,61 +5201,22 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5372,14 +5401,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


