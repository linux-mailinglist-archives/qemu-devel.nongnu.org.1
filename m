Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D5D7C8F67
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm8-0001Q3-UL; Fri, 13 Oct 2023 17:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm3-0000nu-W4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:48 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm1-0001Ug-N7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:47 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b5f0d658dso1390687eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232764; x=1697837564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQRPJj6WZOaTwuZr2WzUjmP0URSl9VgBkYm0unhGK5I=;
 b=aj2HvqMOTsxQHXbD8M88obIdkNy85Hu/TuMOxPtFHFXenCEpNXVOYvB/MQmcY2VpZY
 8SjEHMGFGAmYg/GnjXQ1Agn4pjZ7Cmz68pWnh7IKUrPHCfzOJjZjCKe0F0dfLSbYLvAx
 fJoAB+oS8iJJOWKz0+3q8tjc+kr35eNLyUvYdQWHyNIHGIJkFgmhDQWk2Ne+0rQaxPgM
 f8rba42+93nsMe8V3HRHyMaaDbBpMUP54fN2flb5h1gVBuzXFXuf6xfo1eVBgdrFBU3i
 jLJTA2CPafG90VlZGolOZV9uGk9tzUt2P5xY9ioWmpFjv5crZ14lJYMbMgOmuOeETu8h
 BQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232764; x=1697837564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQRPJj6WZOaTwuZr2WzUjmP0URSl9VgBkYm0unhGK5I=;
 b=agJSMdPQPcJI2o68jm9nyEuhxR4c+uwhSWL3hntFSXowIIwI1f04d1dKaUYfkp3r/d
 Ex3ReBM3ezTguQrG62yXMuBQEwSijsGh0qZ6oQp1nFRJ591JusHw5+FlJxh294veoZmB
 XzuS6/NgYDz2Na3pH2lwbd6jQxrp/axSf/PKHxLckPQZ9E5df4juXZAuq5menMhrWdB3
 5cz3Ri5x65pbtQqImedZDXaz9MUjM8Y63qvm3Rv16MaLIscnGjh3m0TCQVLLYh3sxqTv
 LmKRK1mQoOFxZjgI3gi1jPS+3li1JmDX7Td0UVdD5+rrUrkRYAVPyRkvHw1hVrBGUH+N
 1MWQ==
X-Gm-Message-State: AOJu0Yx4P2iiz1cONqWsDgPcoSxpLAXJSWNU2fQkorO6BccXZTu4YTcV
 OQ/QLP/9myXwNNo3osivYSjrzTzG8jUoXWH0CQ4=
X-Google-Smtp-Source: AGHT+IF1z/Q8r/cBQD5GDR0xTZpJVSahqex2hAnR8imP5f03s/W8fiLaq5hJZMIQIUFkVLGn+w4iqw==
X-Received: by 2002:a05:6358:3407:b0:134:e3d2:1e50 with SMTP id
 h7-20020a056358340700b00134e3d21e50mr28068569rwd.18.1697232764429; 
 Fri, 13 Oct 2023 14:32:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 61/85] target/sparc: Move gen_ne_fop_FFF insns to decodetree
Date: Fri, 13 Oct 2023 14:28:22 -0700
Message-Id: <20231013212846.165724-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Move FANDNOT1s, FANDNOT2s, FANDs, FNANDs, FNORs, FORNOT1s, FORNOT2s,
FORs, FPADD16s, FPADD32s, FPSUB16s, FPSUB32s, FXNORs, FXORs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  16 ++++++
 target/sparc/translate.c  | 116 ++++++++++++++------------------------
 2 files changed, 59 insertions(+), 73 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 362aa00300..96ba61865a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -32,6 +32,7 @@ CALL    01 i:s30
 
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
+@r_r_r_swap .. rd:5  ...... rs2:5 . ........ rs1:5         &r_r_r
 
 &r_r        rd rs
 @r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
@@ -271,6 +272,21 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
     FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
+
+    FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
+    FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
+    FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
+    FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
+    FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
+    FANDNOTs    10 ..... 110110 ..... 0 0110 0101 .....    @r_r_r   # FANDNOT2s
+    FANDNOTs    10 ..... 110110 ..... 0 0110 1001 .....    @r_r_r_swap # ... 1s
+    FXORs       10 ..... 110110 ..... 0 0110 1101 .....    @r_r_r
+    FNANDs      10 ..... 110110 ..... 0 0110 1111 .....    @r_r_r
+    FANDs       10 ..... 110110 ..... 0 0111 0001 .....    @r_r_r
+    FXNORs      10 ..... 110110 ..... 0 0111 0011 .....    @r_r_r
+    FORNOTs     10 ..... 110110 ..... 0 0111 0111 .....    @r_r_r    # FORNOT2s
+    FORNOTs     10 ..... 110110 ..... 0 0111 1011 .....    @r_r_r_swap # ... 1s
+    FORs        10 ..... 110110 ..... 0 0111 1101 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3b6f4bef95..30329b94dd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1497,22 +1497,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_ne_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
-                           void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 dst, src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, src1, src2);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-#endif
-
 static void gen_fop_DD(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
 {
@@ -4839,6 +4823,35 @@ TRANS(FABSd, 64, do_dd, a, gen_helper_fabsd)
 TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
 TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
 
+static bool do_fff(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    func(src1, src1, src2);
+    gen_store_fpr_F(dc, a->rd, src1);
+    return advance_pc(dc);
+}
+
+TRANS(FPADD16s, VIS1, do_fff, a, tcg_gen_vec_add16_i32)
+TRANS(FPADD32s, VIS1, do_fff, a, tcg_gen_add_i32)
+TRANS(FPSUB16s, VIS1, do_fff, a, tcg_gen_vec_sub16_i32)
+TRANS(FPSUB32s, VIS1, do_fff, a, tcg_gen_sub_i32)
+TRANS(FNORs, VIS1, do_fff, a, tcg_gen_nor_i32)
+TRANS(FANDNOTs, VIS1, do_fff, a, tcg_gen_andc_i32)
+TRANS(FXORs, VIS1, do_fff, a, tcg_gen_xor_i32)
+TRANS(FNANDs, VIS1, do_fff, a, tcg_gen_nand_i32)
+TRANS(FANDs, VIS1, do_fff, a, tcg_gen_and_i32)
+TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
+TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
+TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5211,6 +5224,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x06a: /* VIS I fnot1 */
                 case 0x074: /* VIS I fsrc1 */
                 case 0x078: /* VIS I fsrc2 */
+                case 0x051: /* VIS I fpadd16s */
+                case 0x053: /* VIS I fpadd32s */
+                case 0x055: /* VIS I fpsub16s */
+                case 0x057: /* VIS I fpsub32s */
+                case 0x063: /* VIS I fnors */
+                case 0x065: /* VIS I fandnot2s */
+                case 0x069: /* VIS I fandnot1s */
+                case 0x06d: /* VIS I fxors */
+                case 0x06f: /* VIS I fnands */
+                case 0x071: /* VIS I fands */
+                case 0x073: /* VIS I fxnors */
+                case 0x077: /* VIS I fornot2s */
+                case 0x07b: /* VIS I fornot1s */
+                case 0x07d: /* VIS I fors */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5338,34 +5365,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add16_i64);
                     break;
-                case 0x051: /* VIS I fpadd16s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_vec_add16_i32);
-                    break;
                 case 0x052: /* VIS I fpadd32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
                     break;
-                case 0x053: /* VIS I fpadd32s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_add_i32);
-                    break;
                 case 0x054: /* VIS I fpsub16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_sub16_i64);
                     break;
-                case 0x055: /* VIS I fpsub16s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_vec_sub16_i32);
-                    break;
                 case 0x056: /* VIS I fpsub32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
                     break;
-                case 0x057: /* VIS I fpsub32s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_sub_i32);
-                    break;
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
@@ -5382,83 +5393,42 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_nor_i64);
                     break;
-                case 0x063: /* VIS I fnors */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_nor_i32);
-                    break;
                 case 0x064: /* VIS I fandnot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_andc_i64);
                     break;
-                case 0x065: /* VIS I fandnot2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_andc_i32);
-                    break;
                 case 0x068: /* VIS I fandnot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
                     break;
-                case 0x069: /* VIS I fandnot1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs2, rs1, tcg_gen_andc_i32);
-                    break;
                 case 0x06c: /* VIS I fxor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
                     break;
-                case 0x06d: /* VIS I fxors */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_xor_i32);
-                    break;
                 case 0x06e: /* VIS I fnand */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_nand_i64);
                     break;
-                case 0x06f: /* VIS I fnands */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_nand_i32);
-                    break;
                 case 0x070: /* VIS I fand */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_and_i64);
                     break;
-                case 0x071: /* VIS I fands */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_and_i32);
-                    break;
                 case 0x072: /* VIS I fxnor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_eqv_i64);
                     break;
-                case 0x073: /* VIS I fxnors */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_eqv_i32);
-                    break;
-                    break;
                 case 0x076: /* VIS I fornot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_orc_i64);
                     break;
-                case 0x077: /* VIS I fornot2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_orc_i32);
-                    break;
                 case 0x07a: /* VIS I fornot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
                     break;
-                case 0x07b: /* VIS I fornot1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs2, rs1, tcg_gen_orc_i32);
-                    break;
                 case 0x07c: /* VIS I for */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_or_i64);
                     break;
-                case 0x07d: /* VIS I fors */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_or_i32);
-                    break;
                 case 0x07e: /* VIS I fone */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


