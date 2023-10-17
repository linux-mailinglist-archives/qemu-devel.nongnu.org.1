Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D807CBAD2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdOG-0004Gm-TZ; Tue, 17 Oct 2023 02:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNw-0003o1-D4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNu-0004pz-6D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:55 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c4fc2ce697so3737620a34.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523412; x=1698128212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuIByJHH5v/TZr5fDP/carJPcPPWSe3W25nTOp2MILs=;
 b=qNd/p9Mp4QqEkXxuzoUvzhRu1qFTNOJJLSFsva/2zuyrU163o8NX4mLtPO3Pf+cRcw
 /qgIvKTLwMLPUl3h0g6vITFM/hiyiHVNHktCVPGYK01zty7s2XrZmYRijvfQ2Zt7d+Xn
 eJAo/o4AK9yUyvC4RBmIJwZt+Clmv7u4hQ1FZ+wfGeSebwo3bkfzNrnzMUlf1Ie7RFUh
 8YW/8+OntOR5695Wo8cHsUhatg33aa4ovNLiIhVpk5p4d1UqE6YXuu6ZkRSIfIm/aEEm
 XEqMzC2hgQ6AwnRhhO7llOjtfF/1KWR1UT8C7cVpJApvlrk05EG04n6CNKaH4O7QHC1N
 fHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523412; x=1698128212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuIByJHH5v/TZr5fDP/carJPcPPWSe3W25nTOp2MILs=;
 b=wIPXOMR7YzgEZeJGMbxFWe2+GZ6lyh7UkQwSKqK1lbgGffe1BoHuLSduNmjCK8OtIt
 b6tuuSdVKLrYByByOTNQ2CMu/NLew/GwGsQrRWXeNfsxaPetTVJOWKZHdKJc+pgmjwHj
 f/6Ju9dpLPMwfj6rh8RTMpOI7zbCK3VXQ1jmVvaAMwveCkU1J3aTvqX6ha/7d9FTl5gx
 a3iPuuZTfNV1KK32vzAVWmcorXC7mpoCjr3TkMde7yPmazD1LOAcCBlmDVmrnaNWOs1T
 cxM6/Qp6JBMd7ZBhGlV93/80E17G/Z8lhDFp9Y2E6p1kDqGxv5EBp9VMD7D0ZsJ358rD
 4GBw==
X-Gm-Message-State: AOJu0YwhB0RdNoG8LY/mfJMn4dIWUoPZ9p37rH3yPWUfDdDZvVMIIkAV
 BvVrjOdpNXSYtZjjSEJb6R+FVVItrsGjpk1X3d8=
X-Google-Smtp-Source: AGHT+IFPPlQsxajonilcaIMZ9Xohz4nQ+bjRgvNmbSkK9uhzpyq7SFN3G9HyGoPLazalUo/SMMGACQ==
X-Received: by 2002:a05:6359:6d49:b0:14f:736b:7745 with SMTP id
 tf9-20020a0563596d4900b0014f736b7745mr1213531rwb.31.1697523412063; 
 Mon, 16 Oct 2023 23:16:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 78/90] target/sparc: Move gen_fop_FD insns to decodetree
Date: Mon, 16 Oct 2023 23:12:32 -0700
Message-Id: <20231017061244.681584-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
index a98b3b2bdd..a0af20f042 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -256,9 +256,12 @@ FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
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
index 28d63c9915..acb9e58319 100644
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
@@ -1655,21 +1656,6 @@ static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
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
@@ -4802,6 +4788,29 @@ TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
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
@@ -5142,10 +5151,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5172,9 +5181,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd2: /* fdtoi */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
-                    break;
                 case 0xd3: /* fqtoi */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
@@ -5199,9 +5205,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


