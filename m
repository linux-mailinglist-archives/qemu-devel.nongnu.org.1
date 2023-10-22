Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF27D2164
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbO-0004kE-5e; Sun, 22 Oct 2023 02:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaF-0001os-4C
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaC-0002Ke-Pb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso2076797b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954703; x=1698559503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnIQrvzJCX4VoBhqb/gTJTcjxh0opmIuZUH0PLud/BA=;
 b=lVI6SEoa2GXSGCQgFeSb4hACYDC1VdQKplBrkfZXa1NHFdEMF4dEx8xnl2zcGsWQdl
 JhNcUfMpx6uiFgXEInvzvCrnVjjU8OiEVyKE+cmJr2Dttf6IJuiZ7OA+/EETS9ehS4Ol
 iu3anTaUOf04zIYrT/73o/+cnupB5Otme9Ps/3DA3X+TZtNE3Dn58dD7XO+YHm4V8NMm
 0nMuFZQ8ebF7wCu5OvU/hOKzU9XPxLCnXkEqVPSbky3dV90Ab+j1AZnxpFpHdzrKkBBh
 9U+NUA8V/tjMxK5j8D/A4pDjAe9HvZpBfhvESA0yIT0u3GDS21Si18l8fHCo11f3opwS
 Vhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954703; x=1698559503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnIQrvzJCX4VoBhqb/gTJTcjxh0opmIuZUH0PLud/BA=;
 b=FCrkNaRSILgOU3eDxpoLaRyBwon/0sIskP5Id9gDo2ZMx+lYgLmm89hHtNWSlHQU+i
 MD42YLsWV8gv5+HoTZmHGtXWTrWNfMIDdCPW5ey/6cAVoydWEsUwozkfkvb6Tsai9ju0
 jIdQEOeoc7AW/GBEjDe6YreiadfiFCbwHcm5zJwsFVTVVSG00hscahYz6030j8uxQqp6
 QJ+AnGxpuPQuAaHUD8iD8VhOBVpJqVzKFdOoNnbIoYLxP7FLDq53ShaNGLItJXFz3uDf
 5CrHCFg8//poONW4kQFcXvsRo96o3Rx0UY6o8OrfexlT0eM9/qtl+cQVS5AtxAWSWCrN
 BmWw==
X-Gm-Message-State: AOJu0YxI8aWP4MSdqcVrSy2gN8l6decToPWuLYIs/Weblsqysvoyj2n6
 dSHEKLrvjoKzP+dPsLXYBp4l5MGgsdlKO1n7xoE=
X-Google-Smtp-Source: AGHT+IGYZ07lUG+tJntF6s0Lar42M1frSvr9NstN6t5c7hr3mdSbyu7vmRRmxrvLGO356NRQwKFmPQ==
X-Received: by 2002:a05:6a00:21c4:b0:6bf:50df:2df5 with SMTP id
 t4-20020a056a0021c400b006bf50df2df5mr3987052pfj.13.1697954703234; 
 Sat, 21 Oct 2023 23:05:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 73/90] target/sparc: Move gen_fop_FFF insns to decodetree
Date: Sat, 21 Oct 2023 23:00:14 -0700
Message-Id: <20231022060031.490251-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 4cb250265d..09444e313f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,10 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
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
index acc8f5d8cd..1bcdaf31d8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1653,21 +1653,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -5044,6 +5029,29 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
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
@@ -5161,10 +5169,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5172,9 +5181,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x45: /* fsubs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fsubs);
-                    break;
                 case 0x46: /* fsubd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
                     break;
@@ -5182,9 +5188,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x49: /* fmuls */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
-                    break;
                 case 0x4a: /* fmuld */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
@@ -5192,9 +5195,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


