Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F87CBAF5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdO2-00044E-H7; Tue, 17 Oct 2023 02:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNr-0003Uw-N5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:51 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNp-0004oJ-4l
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:51 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c4a25f6390so3543129a34.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523407; x=1698128207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNj/xziie8J5tcU5TOuNOrD/R+wPDckkYUxdB/9hsF8=;
 b=rVjSLoVLgtW8TfkBlKpAspYWmRmq+xR6gsb3uSvk4C2ByTOWxbb8/y0PLYpi3Zf+WL
 bwMMbbDaf9y0TCXZ5va0eP2l6YIfq/l2SLTGri+oN58kVYRATlc8nzUnNvSqWUdM5Iub
 PpSEwATaHigyNNPSsEVzYKWPkTkMxZqPP7pZyGzWqecfu2xPOiXUdFHk+a2xTL60DrtL
 7wghp+u3JvoqN7tVOOt2pJzzeNXEdCo0LYrISTMshss8mesBAldKC/bmsdNSHAEWHz0y
 0pD6apInCQ1cjDUnbVCjMUn1+MaM0NDwn+dYere3dRAKqyp/aB7WwgubQ7VATvardBlr
 BDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523407; x=1698128207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNj/xziie8J5tcU5TOuNOrD/R+wPDckkYUxdB/9hsF8=;
 b=QVATbgo9XTOTzEwTw60hiQkIWHKJlP+APMpnDU3KLkwQPHjQphgQfMv1EsI+c9QX/q
 jY1j5o5GITRO5De1DQQD16NhSwFtURlbUmsvm7KcnJiW8L3ipOsNzX2BW2EHSGjosmcA
 hrFTWv35x+y2sZitzKSgy8ES5ExzLJ1PfWkD2AwJzSyV+4NIB+Us0T8m9ngxic/9pF4p
 d2Bv8mZ7U/zAlbIKomU5bwyDetdy1saCt+vK+a65Z8a/PoPpjQai9qct9QIK0xLYA1s5
 zwYjPzP9WPFxMUbJ7z3FXFyXBTlEOba8Gza7vj8p+ZOC1Y4syVATkWoK+Oqx9R0+l1oy
 Mzgw==
X-Gm-Message-State: AOJu0YyR2tPGbsvSjaQuD5QNkVelg/PNHjDf+iDkV9v/qUWrLu/bN1Gy
 tDmAUTLeDXcczCSUpFPebsxsHXw5KM5Z77Eiwds=
X-Google-Smtp-Source: AGHT+IEu3a3Rn3xHrm+mjl0XBmrtJ7YwerKLG8HgV137hBe7soXXV3NW+JuclgFgLLNG9VLTLy59nQ==
X-Received: by 2002:a9d:62da:0:b0:6b9:dc90:8a85 with SMTP id
 z26-20020a9d62da000000b006b9dc908a85mr1322258otk.24.1697523407709; 
 Mon, 16 Oct 2023 23:16:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 73/90] target/sparc: Move gen_fop_FFF insns to decodetree
Date: Mon, 16 Oct 2023 23:12:27 -0700
Message-Id: <20231017061244.681584-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Move FADDs, FSUBs, FMULs, FDIVs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 +++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7fdd8e37d1..d70f193883 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -241,6 +241,10 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
+FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
+FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
+FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
+FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ffcd630a91..6b3b60fb22 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1611,21 +1611,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 dst, src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4970,6 +4955,29 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
 TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
 TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
 
+static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    func(src1, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, src1);
+    return advance_pc(dc);
+}
+
+TRANS(FADDs, ALL, do_env_fff, a, gen_helper_fadds)
+TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
+TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
+TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5087,10 +5095,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x82: /* V9 fdtox */
                 case 0x88: /* V9 fxtod */
                 case 0x2b: /* fsqrtq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x41: /* fadds */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fadds);
-                    break;
+                case 0x45: /* fsubs */
+                case 0x49: /* fmuls */
+                case 0x4d: /* fdivs */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x42: /* faddd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_faddd);
                     break;
@@ -5098,9 +5107,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x45: /* fsubs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fsubs);
-                    break;
                 case 0x46: /* fsubd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
                     break;
@@ -5108,9 +5114,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x49: /* fmuls */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
-                    break;
                 case 0x4a: /* fmuld */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
@@ -5118,9 +5121,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
-                case 0x4d: /* fdivs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fdivs);
-                    break;
                 case 0x4e: /* fdivd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fdivd);
                     break;
-- 
2.34.1


