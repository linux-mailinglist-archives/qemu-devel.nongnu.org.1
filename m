Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A917D2152
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaP-0002SU-02; Sun, 22 Oct 2023 02:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaA-0001Iy-56
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:02 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa6-0002IV-Dn
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:01 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b3e13fc1f7so1677784b6e.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954697; x=1698559497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi3wCnDQ9Ymw74YfvoiX4pceVq28hJP85OjC7WpyrDc=;
 b=bDUn112UcQR0sj7CJYo/lDZYD+Z+w5FUMdAX8lD5lL647XIPjHQs/41MbbxW5000V/
 Wf+N3EUKh2QnA3Y5Ih5HvOI/C/kLJyHppMu4841h/n7L2RUg/iHGhjFjBwycPYVcb2gv
 85fAQWa0S1PyyKAZXXsA23Al7FvkZPK5FbKALOSwSanAS/yWQCjySkYBQDATjr9f+T1f
 KbR2xqqbDa6aG1uoTz7TBeTPUBUDQDiGp9n3MFPefZwVsFdwomrxwf9HdHssuc8KNdeb
 4lS/5nGDKrPikKD8+Hht3K55ySdyHehKGYBO4GHXX9D41/k3NAyfnb3kwof86oyAMrns
 Ws3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954697; x=1698559497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qi3wCnDQ9Ymw74YfvoiX4pceVq28hJP85OjC7WpyrDc=;
 b=CzEOLX2hkvzyh0scmr6z9Q98yEtwOAAjlghYAH6Q2VviTAOejXSYgsw17NTbntdrLq
 fGYEbkhvaKgzhQS7IRzL3X55Kw9kGYcJjVZY4pHQiilBELovafa4fV7186ziLfI70PdQ
 mSVP5MWAIo0wsebVgb1njtElfnPzI/kX3xsFgCes4rPLf6xZuyRiHTZcRZITAweLD/+q
 aSEDQTjh7z+3QhfRvNVpBpepkVA1CQALgGZ4wgbjEcTjw6ys5qbyvs1pNdClOsiHByr9
 OrR2AlFL7lYRGI36qyHEBns5dpGAt8A1SPoJ7bjCDsVYb4Uh4q6TblCJpB59LPVdoYgl
 QHbw==
X-Gm-Message-State: AOJu0YxZ1rpYC2JKaP6Mk4JXajJsh24bRkn7sIzrko+yhAfAjGb+/UAn
 L3OKbGQCUxPHrga2GTNdn3+MY+ISPoDnIjZD7/I=
X-Google-Smtp-Source: AGHT+IFXswCqwdxpnYYkYbL2lxUF6BFkTtKeBmtW2/rGugRdEKCz2oYpdypnl6zaXKWmbzaRiI17cg==
X-Received: by 2002:a05:6358:52cf:b0:143:5180:1700 with SMTP id
 z15-20020a05635852cf00b0014351801700mr8833170rwz.27.1697954696891; 
 Sat, 21 Oct 2023 23:04:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 66/90] target/sparc: Move gen_ne_fop_FFF insns to decodetree
Date: Sat, 21 Oct 2023 23:00:07 -0700
Message-Id: <20231022060031.490251-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
index 23a21f2c20..0290f2aefb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -37,6 +37,7 @@ CALL    01 i:s30
 
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
+@r_r_r_swap .. rd:5  ...... rs2:5 . ........ rs1:5         &r_r_r
 
 &r_r        rd rs
 @r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
@@ -277,6 +278,21 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
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
index 2ec8607f61..1944936760 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1624,22 +1624,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -5015,6 +4999,35 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
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
@@ -5387,6 +5400,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5514,34 +5541,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5558,83 +5569,42 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


