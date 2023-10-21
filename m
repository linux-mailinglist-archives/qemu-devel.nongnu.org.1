Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A267D1B40
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ej-0003f7-NA; Sat, 21 Oct 2023 01:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ee-0003RA-AI
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ec-0001Cp-Hi
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so1438084b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866565; x=1698471365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX1QKkh2g86B30ME+zMrugrJxBElODzFo4hMq8mZ/LA=;
 b=pTK8rl1VCnBwzrmkxgJB32Tb6WHE6VudI620gH2m806VieuGdeyoN8kf3Ii104isU3
 bk1IzHXTMR2TLNMNcBaVf1sXYp9+1dc3/6zGQbwQbO7qPudVPRNAPUibURelOXSb6ZKR
 6xDpM+iMMqNxWLQ3srnlS+KG6+bhG8MV1qS5PiTeMOLYaMGveF6qJNr+lcaj4qt/0asd
 I0PiDepEDG34w8kEaSR14AuFrgKdOdOGl9jNSmgDJqm3+eJbAGPsoO1ieBqc2OSoAn+/
 eZv+SpugOJUazPY9p7Rd3YEj3NbtiHRbN+meexnNrUpmzttP+7OqUHvDTQf0lmz8bh0i
 w7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866565; x=1698471365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uX1QKkh2g86B30ME+zMrugrJxBElODzFo4hMq8mZ/LA=;
 b=PR15+TW9YU3J/nRl2b7q/1X8JQeN4fpCFkMv6bnjMq2d9Y6tU2CQqEyTPzZZTsLzQb
 47tr7pAOEoFRIcc26qZkBkI0ntIV10WqqoH3q8nw4Kxi+MCfaA3VTHRMgFuRNE2EuGvO
 BAJzDoVNezlvT3gydlQMw19SaNLo5ibXmXaguHRR1/rd3Oxz1QeAPEGkT/MN2Pruxiuy
 x0++wv86zyt77JP+95vovdF9yAOdMH4t3GcDzy7HL0JiTu0sUi8nLF9Av5K5m/TNYza6
 djIFXdWwUrMCt3V1b0A+WN31xE84N0369pQexRBfDTdYO4y2QsYljSasKnsWaBbudMvw
 AiKg==
X-Gm-Message-State: AOJu0YxvS0cuh3EZyig8SIC1fCw4249mkM84f+oCcDDokFTYINPeJybR
 nCQKIhpCbCl0h+29t3h9n/28KA4xOM72lJ4EAPU=
X-Google-Smtp-Source: AGHT+IHqoBoJs8SKfiGHWQhWfWbhdOp+spksl/Q8u9I6TjAI9aWKeDHeUlx4fS7VMxwTjkJ1F2mEZA==
X-Received: by 2002:a05:6a00:c92:b0:6bd:ca1d:c51e with SMTP id
 a18-20020a056a000c9200b006bdca1dc51emr3721577pfv.16.1697866565321; 
 Fri, 20 Oct 2023 22:36:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 78/90] target/sparc: Move gen_fop_FD insns to decodetree
Date: Fri, 20 Oct 2023 22:31:46 -0700
Message-Id: <20231021053158.278135-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Move FdTOs, FdTOi, FxTOs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 51 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index aafbd68867..5777e142df 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -263,9 +263,12 @@ FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
+FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 26126467d9..9f686a9995 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,7 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1697,21 +1698,6 @@ static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_FD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i32 dst;
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4833,6 +4819,29 @@ TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
 TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
 TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
 
+static bool do_env_fd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FdTOs, ALL, do_env_fd, a, gen_helper_fdtos)
+TRANS(FdTOi, ALL, do_env_fd, a, gen_helper_fdtoi)
+TRANS(FxTOs, 64, do_env_fd, a, gen_helper_fxtos)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -5173,10 +5182,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
                 case 0x6e: /* fdmulq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
-                    break;
+                case 0xd2: /* fdtoi */
+                case 0x84: /* V9 fxtos */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
@@ -5203,9 +5212,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd2: /* fdtoi */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
-                    break;
                 case 0xd3: /* fqtoi */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
@@ -5230,9 +5236,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
                     break;
-                case 0x84: /* V9 fxtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


