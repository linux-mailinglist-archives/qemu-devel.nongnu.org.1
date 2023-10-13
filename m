Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C80467C8F71
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmD-0001x7-Oz; Fri, 13 Oct 2023 17:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmA-0001hL-3b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:54 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm8-0001Y2-4b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:53 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57bab4e9e1aso1461348eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232771; x=1697837571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fUFReiGGrSAsXHAPvg4XHxZdv3lDyewTKjnxe4wPUw=;
 b=R/kz08jOpD96OjS/CnKenirfsxCwxzFe6pvhxbp3qGeWyOboQEdpOI4tgyC/n5aO37
 YzhCGeWldSQVxkWsd27N2DE6shPCEoCir91W0A6xN1LJkrpDHt6cFMpS3BdPMoNtPxdg
 3qSrmfhN8Sarx691sljCSLyfFslnL2QO7FrZGLM8MCKzsQ4eC+BPJl6H6qKJMsnSJyHE
 ebbzjgz6H+aN/elfV3L/CnCkUkwi1tCl9q+bOhbuh0gdFjkktKGHxGBUdV9Teodg7TRL
 9AMzgvSJV0gtnz0M+4PHzrX2eZUOJrPUA4Pzufedk+B7c7Mr4SusWnUR3UlbeGRCehAP
 AEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232771; x=1697837571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fUFReiGGrSAsXHAPvg4XHxZdv3lDyewTKjnxe4wPUw=;
 b=jC5HomO6yWc+momIJt7xir4Rnes07NPhW1g+xrwMLiZzs8zWMSuxEhwrgZb4CpYwke
 zD8qGNDVn5Z9A6ggBwmP5uYwpCweoLjm43lTCRikENsAam73LkNoy0xO7wpS2JlplcBo
 hmvZF9hM5wk76PrLFeepoMlLgexj9kMBlYy6TZKxOkdcD2JDBQT8UXvPxLsccjKb2yS9
 au2rmm+yBk/tg6qSKIaZOMeairUNm6821bLtRCeVvYmAyvhrxL635zBC5BYhtvRhzChf
 2oRM3mkCeo5i7Z/RnNRt4RZKr0E4KetcyPn2mwopKDWFreCgvB8it0VuE5t2lYE/flRz
 wQpg==
X-Gm-Message-State: AOJu0YxesuRSAffQYZF2Fc7irBf7Hu+Fo9AJyKcCz35FK/HOrEfx5ArG
 osHtD6tWyMEC0/MqbzX1uxXBH8nKFe+tYpivKyI=
X-Google-Smtp-Source: AGHT+IHjuH3DZAaHef/3T8dQsrFU8PJzPZhpuC1lSI+YjI/wxQLiip6rq8VmppMt41P6scjFp5ocww==
X-Received: by 2002:a05:6358:290b:b0:134:ded4:294 with SMTP id
 y11-20020a056358290b00b00134ded40294mr33625483rwb.17.1697232770818; 
 Fri, 13 Oct 2023 14:32:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 68/85] target/sparc: Move gen_fop_FFF insns to decodetree
Date: Fri, 13 Oct 2023 14:28:29 -0700
Message-Id: <20231013212846.165724-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
index 31d84f0cb3..fcf4704ef8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -242,6 +242,10 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
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
index d318c8a6e3..9d68c8cc20 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1526,21 +1526,6 @@ static void gen_op_clear_ieee_excp_and_FTT(void)
     tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
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
@@ -4868,6 +4853,29 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
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
@@ -4985,10 +4993,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4996,9 +5005,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x45: /* fsubs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fsubs);
-                    break;
                 case 0x46: /* fsubd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
                     break;
@@ -5006,9 +5012,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x49: /* fmuls */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
-                    break;
                 case 0x4a: /* fmuld */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
@@ -5016,9 +5019,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


