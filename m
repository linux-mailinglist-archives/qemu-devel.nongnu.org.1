Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324477D79B7
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9r-0002nV-KO; Wed, 25 Oct 2023 20:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9X-0001zL-HJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:11 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9S-0008Di-VN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:11 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so224305a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279785; x=1698884585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bk59M1JI+E4cyB0CQ9rgcLwL2YU9APHWN+wZfRVduds=;
 b=OStBVrJE9kNGAQ6mc1jAacHy6OCQOWpAwm2ZsdZAUgLAUGmMpBYSbpe5oNNXnEA9EQ
 mUrQATaUILyb+CMdg0oM9ELxI9cDaqz+YDoEJ6V59CZn5+8EhYSqpk2J2hMReRpttRfR
 kfgBvBQYAO2VIZIOm9fdRMuYjKjh3Qi0rxQLHWdZlEfTK5by9gbQnbbOeXwRf0iXRafq
 JojLMmHGz/FNeN+pQJRNuatR1H9jnIiaTgyJVyQYLXUCiavul34Pmg5IUkf7y9qnPMf5
 lubsi0YFPcKdyawbs24K+fYNqSwGsGjwVxNiCHYCfwXgH6VOkmT5mGDkZAynxUer03oN
 kg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279785; x=1698884585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bk59M1JI+E4cyB0CQ9rgcLwL2YU9APHWN+wZfRVduds=;
 b=QTZ4pZRCm2iHOwJqjb2hvszUdQrNWXPHEVK91ikeOWXtHJiMq14X02rlF0H/I5xg1H
 MxCHeLyNmMlZ5q1qUibhES75SiMqHpkc8xI5A4UJpU7tKkOYK1bAt+nYGvHC7IraC2Gj
 3H0Hhu80e5BN4e6voHeyN9U9r51kWNtQFZuKxg45dS7XDn5A3DMx3VEQM7qmMEOtOeqH
 XGbZqY5ExHuE2F56drLtJZBbs7tMURdJOwHkHpW9YSPeWgy4lz7TOe1EjY3xbPNiFBnf
 dWAgW/fdfHBl7OREvhqWEL4cENaaGDseUwBtkktUbq1vVUlC26Bel8zEdUvX8xFE7MP5
 5+Qw==
X-Gm-Message-State: AOJu0YythxVSvCIFi+qHB+/nR05JOYuM5EVyudCRjI3zxv/ezK+FcfmZ
 I90NbqxX2PyGhmuhErUtDDzJp92Gjwa/GBVCQHY=
X-Google-Smtp-Source: AGHT+IHKiDN31fWCb7lBGMVGzUJ2Rj8ft8Gl3XwMWohW2t7lDSi6S3E7hRJeJoVOCXyfK9uroQzipg==
X-Received: by 2002:a17:90a:6e05:b0:27c:edf3:d045 with SMTP id
 b5-20020a17090a6e0500b0027cedf3d045mr16250718pjk.40.1698279785096; 
 Wed, 25 Oct 2023 17:23:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 70/94] target/sparc: Move gen_ne_fop_FFF insns to decodetree
Date: Wed, 25 Oct 2023 17:15:18 -0700
Message-Id: <20231026001542.1141412-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
index 09ca9c51bd..949d1954a4 100644
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
@@ -4855,6 +4839,35 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
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
@@ -5227,6 +5240,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5354,34 +5381,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5398,83 +5409,42 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


