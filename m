Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B37D2718
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx3-0006ZO-SJ; Sun, 22 Oct 2023 19:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhww-0006Sp-UE
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwt-0007iv-6s
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1935386b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017613; x=1698622413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLlC1+6RsqQ3wDqMIBtZdR6AKbOwSJfAbRAqRfZAqvg=;
 b=kvfvQwBMTgJYEPSmrYZHss6HyDOGhQzft/yfsW7Zn65sI3l1KPy2ze3H90zIj+XQNe
 K+JORfOZQU0RwuM8mzuJDnYvFj86Pey4BHBxU7XYJi0nLr7YfI3N3qOaPfNUbnjTKAmz
 sY47yMJ9pkLI38mw1Jkd6BrN4RaO6TttZObccUPl/6nc61nsdQDZt00WFfBy+38/7P6O
 jIP0O61BtHqRQLeKgHUoJ5Nu8fRcYezGnUNqoa7G1bWUBCEKGRZfkJfwKU/RedMG5xzD
 ftxmLajN1FSWCBUp9ul2f2Ypb4DT9EkJDV82kQI1i0kaGFE9eOW4Zw5Yame1CkB+hJHV
 m05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017613; x=1698622413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLlC1+6RsqQ3wDqMIBtZdR6AKbOwSJfAbRAqRfZAqvg=;
 b=eUaW2ExhjKpu5NLkCUJIhLVvU6BUR5TO7z06FtZUQHW3yHRX/1XMrXppQiCRx7pwvP
 CVP6el41/5UucuHQnGhYoDZF7txifNCiSzFyONP3td/sZTHeKupijn0VshoPhRMaB41h
 W2NR0zmjvBOIjmxDSNzWjOdxTNBHRx6Nos3xzibP/2dpaXOUDPG7RUD/nemnGKHAVhMw
 haXlCA+m0kn9mqLBCwabOAiGsREYLwwP7YAEvMDrmPENjYNoKAHLjVfnY0LeCsolk2oM
 dib+b5eXYjNR81gx1LqcCSf8PhuAc3PIgbLE+qoh5JXnvTD3Cczo4b3Sa4NyKVCKH6Pt
 cTMg==
X-Gm-Message-State: AOJu0YzlsdPRJUDYlKdbV0KnNfUY0hRjPp/ctA5xbdqyX5rZBU75QXoT
 brhpdm/l4o6usa6pi72DyhJ9/jV/YakKNPoOHqI=
X-Google-Smtp-Source: AGHT+IHpIUVTJ/ilwn5q8fJJMOKjmupk9m2qtwiCPW0arX1jP1dZ+0lbnsv09Z+uqON8X2BESTV7kg==
X-Received: by 2002:aa7:8e4c:0:b0:68f:c1e0:a2c4 with SMTP id
 d12-20020aa78e4c000000b0068fc1e0a2c4mr12901487pfr.3.1698017613582; 
 Sun, 22 Oct 2023 16:33:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 70/94] target/sparc: Move gen_ne_fop_FFF insns to decodetree
Date: Sun, 22 Oct 2023 16:29:08 -0700
Message-Id: <20231022232932.80507-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
index e65335402f..7a341b2c37 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1628,22 +1628,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4852,6 +4836,35 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
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
@@ -5224,6 +5237,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5351,34 +5378,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5395,83 +5406,42 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


