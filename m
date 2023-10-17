Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81A7CBB1C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNx-0003rj-PC; Tue, 17 Oct 2023 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNt-0003aO-5W
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNr-0004oz-Af
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso13871245ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523409; x=1698128209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2ISP4lr5rnIMwb0yZS6PTt451/dWOxiq52Nw5r1cw8=;
 b=vsE51kRQU/FCBPQJAn6YdyAcDrxrFPpCKCIM8JYq9LnFtV7CVcIV9Ehd9cCI6kQeZK
 +DcT4rb7TkU2bivYjWx5GJ+JQnfyc4vfcdf6M+CBHefDREKApGhpe3OOWE+7/s6EzNXy
 0FxkdkkDcJbAkx4HoaYEa4XH4HG3vR60KVqRjYj6oZeg3cyKZh/BvB3SlDUJ7ztoyhmu
 IACdF8bC/3kWNZM9Thes5z8CZfKokfbczw1IeU5lg8tRX3A9srI1zU0PxTdfIbvByCQS
 TuEAj5WpnIcJYn0nX2Dy7PS/WYkfWTTF0pUMBDpFG1JbjGcJrjGetCOU1HM5IvblweR6
 Erew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523409; x=1698128209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2ISP4lr5rnIMwb0yZS6PTt451/dWOxiq52Nw5r1cw8=;
 b=CgRPAK8//Xf0Z3ZpLYsgR7AuDC+IZ29iDiQl7p25FY2+OGKqHNWZEtExD2vWI+85nO
 QGV7wMU+Jzv/IysATk5iO3mJ81hN/IY5O7EG4ZZRIPFNeJgTEUf8Z51sITbQJht9BbUo
 qa7dBDYX3sQDTIu1wHVawtR2/alDE9iiUI3LQUTvEBiW51JNTv10iQtXTjBLVUuKRg21
 akTNrJvUs9RQEQX24bQsnx1XXD32V2bjcihzc50u+sJ88swkI5wVhAuASrHyh/umX4dB
 dcYLIhmsWgrp98fYELWa/Ff5YDUUrW+H6s+0ISUt0LVSq8X4f7twe0yXHhwyYMLJfHpO
 hVJQ==
X-Gm-Message-State: AOJu0YwaWQKcyboc1S1syIRcPblLTpOBapSl9zXhwNEWNyISDin4DW2H
 WIrHvZDhf2unjgiuR//IDu2grB7NaeLIbMiHZqs=
X-Google-Smtp-Source: AGHT+IHzWtzqGAKBuTBq55iNiH2vfE75jOkeAZK+mGQWoP52Ao9y06b5b9Fvsc+8/DpYJS9Pz7Wy1w==
X-Received: by 2002:a17:902:e841:b0:1bd:d510:78fb with SMTP id
 t1-20020a170902e84100b001bdd51078fbmr1715700plg.3.1697523408951; 
 Mon, 16 Oct 2023 23:16:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 74/90] target/sparc: Move gen_fop_DDD insns to decodetree
Date: Mon, 16 Oct 2023 23:12:28 -0700
Message-Id: <20231017061244.681584-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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

Move FADDd, FSUBd, FMULd, FDIVd.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 55 ++++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d70f193883..a86c9c85f7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -242,9 +242,13 @@ FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
+FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
+FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
+FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
+FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6b3b60fb22..a875ca716b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1611,21 +1611,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -5022,6 +5007,30 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FADDd, ALL, do_env_ddd, a, gen_helper_faddd)
+TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
+TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
+TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5099,31 +5108,23 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x45: /* fsubs */
                 case 0x49: /* fmuls */
                 case 0x4d: /* fdivs */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x42: /* faddd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_faddd);
-                    break;
+                case 0x46: /* fsubd */
+                case 0x4a: /* fmuld */
+                case 0x4e: /* fdivd */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x43: /* faddq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x46: /* fsubd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
-                    break;
                 case 0x47: /* fsubq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x4a: /* fmuld */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
-                    break;
                 case 0x4b: /* fmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
-                case 0x4e: /* fdivd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fdivd);
-                    break;
                 case 0x4f: /* fdivq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fdivq);
-- 
2.34.1


