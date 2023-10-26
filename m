Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3F7D799E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAQ-0006CY-Ox; Wed, 25 Oct 2023 20:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9l-0003Hl-1L
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:27 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9f-0008HE-8Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so242973a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279798; x=1698884598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3Q80+YPvNL1h+vw0KOE43P0va8bo0EfHjxknGckkgM=;
 b=fFZHcsRj2xEFsCUqsgLrrIEF/+yRWT3YZfa5y+AEXIF2DiZ8WJZQ4F07gQu+IFrOw8
 tCWdjN6GhWZRmsPtEvIyE059czxFVarS8l2rjVc88++5b4ycWxWGEy+dfK8qy2VLcy9F
 gPCa0e6B/H2y2J4xsw47SzSFg6vRQcimmmDNemXN3rASZDO2iIk2YKPArCWWIXWgSZmd
 +hG9+7T1Wbm6/mRVyN4K1IWbrN/F71cdTgfP+wSr5mwx2fdUGskWtkPmwlFEjwP/nB4s
 42iVizZDRNwYqT2OGe01QNtAcwII5lwUe+4us166j2HsmNE0Xa/ZLGlP1dBdPggzh5aU
 N//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279798; x=1698884598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3Q80+YPvNL1h+vw0KOE43P0va8bo0EfHjxknGckkgM=;
 b=FyJ2bKhNPvXBqXsj6Qkt/zGWW2LQmEOhuvU4EaGpsEZz5JE0qg1WM6RwUTrq+qeuQ7
 ARtmxCyq3QoRBm88RK94W+EYQuZ4/h4mk5bARadRLUo5RKjtllFAymSoGZfHB2S9tkqX
 U3aivWJMlkAkBpd5UZa0h5OcHnN0puGzkXlZ4Xm1XPhx3FmaQXp2WrvJ4adVKxFWwAPz
 ximpU/pQpRvLADz+tx1zrXy9+zyahBNq+VB124Ik4XwUBLFanRmke2PulH9+oFWRrEKi
 uy8xZ5+N35tB2nOZ0iBsDkOXg2o+1hDDUYIP2zRFKAj/OC6973UqcTK6hZ7oBUM8Bam3
 098g==
X-Gm-Message-State: AOJu0YyhJuEN2FtSt8z4HDLHhUq0qCaECwu2ngtFviTWE9dZhpgPiBJv
 pcidWq1AB82ix8qH8No572WrY6GikiWSa/33IJg=
X-Google-Smtp-Source: AGHT+IFiDif9sUkhiH946zTWzNPoDMSIY6L6t/7BJeo59qSsZsuFOvvqoYUW54zZwcyaafVUy3Q1Wg==
X-Received: by 2002:a17:90a:1d9:b0:27c:fb63:9c89 with SMTP id
 25-20020a17090a01d900b0027cfb639c89mr17226330pjd.0.1698279797891; 
 Wed, 25 Oct 2023 17:23:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 87/94] target/sparc: Move FdTOq, FxTOq to decodetree
Date: Wed, 25 Oct 2023 17:15:35 -0700
Message-Id: <20231026001542.1141412-117-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c76e603f2d..e1f5394d17 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -267,6 +267,7 @@ FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
@@ -275,6 +276,7 @@ FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
 FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ad2d794b3d..40823f1325 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -77,6 +77,7 @@
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
@@ -1672,19 +1673,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4813,6 +4801,29 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
+static bool do_env_qd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_D(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FdTOq, ALL, do_env_qd, a, gen_helper_fdtoq)
+TRANS(FxTOq, 64, do_env_qd, a, gen_helper_fxtoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5100,11 +5111,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x83: /* V9 fqtox */
                 case 0xcc: /* fitoq */
                 case 0xcd: /* fstoq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-                    break;
+                case 0x8c: /* V9 fxtoq */
+                    g_assert_not_reached(); /* in decodetree */
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
@@ -5118,10 +5127,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x8c: /* V9 fxtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-                    break;
 #endif
                 default:
                     goto illegal_insn;
-- 
2.34.1


