Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631B7D2182
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:15:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRb8-0004Jm-IR; Sun, 22 Oct 2023 02:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaK-0002Jf-Mf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaF-0002LS-92
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:12 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso2136406b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954706; x=1698559506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMWgiRrrSrMARev/+8b7NYY7aqPYWeuca4L/4DviiH8=;
 b=EGtBwJJdRmYHmGsLQefwb2rKFw3UaPR6Mca46SHSZvOV/kG07RGNIUsb3FvKSAnLbT
 TE2LvXxtDusNXPH7yFpO/35llv/45D9ZOKDfuPlJ63k49fI0wl+UAcRUT2TgYpmdNNKE
 7bAGDApj/wzj8pE9D8c70s9kow0CJhI5mgmWe6cSosvZAXGFQKZMMWk0WuIysiDBT96F
 CsA44qa6ekQAvB5Dp4WqURUrken3Ms+dTfJur0cZp7RL/MQUjDnNBfEQmchRJOZqbo2D
 OT5zI0SM5HzM19WMjYEG8u2VDyupIR0q6Z5e0fNPYHCJSfTkBKXvcEdXnFBVINjaueyb
 346A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954706; x=1698559506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMWgiRrrSrMARev/+8b7NYY7aqPYWeuca4L/4DviiH8=;
 b=s5TeTIWL42T3Sr7WatRJXyUF3DJnaZtxdB4rAl3e5Q1mMVPz5DAj2U3moXYyG071Gk
 jtHoXDVc6rq5tDPeNUpygmKPsfctuhFlp/pmDsE4ueTgQE6/t/Ko9nmRhJ+WvBhwrqtD
 wSptztYIWNhrDLK3XZSMH/0eWLVutGpA8XbaNFF0UF5jZsK1wfKY4m3g2RlZt62zhH43
 sox/9/vXxRM7h/Z1UBC/avBvF9Ym3JvcksXnt071jXH+GxYo+gldLvhQWH3TIte2qXq+
 ceZxElQNxdwnOwsqlA0W+rztsriGS6e/ZzmiPZcvdkYT5f9hDBp6kydexliqO40eHoZF
 b1vw==
X-Gm-Message-State: AOJu0Yw19QZrESz6Jauwt0XNyDtbXFHJwr0oeJFWADT8mulla9FqFzsj
 z9/8GD923p7Xr3vagKMI7v3kWF3/nqq1+mPvptY=
X-Google-Smtp-Source: AGHT+IEoplQukrYB/68mk8mOkWBH+ppok3j76DjaNqql912PFBSOEEV1zwm1glKRrjr79515Tw3RTg==
X-Received: by 2002:a05:6a00:14c9:b0:68f:bbc3:df44 with SMTP id
 w9-20020a056a0014c900b0068fbbc3df44mr7867782pfu.0.1697954705806; 
 Sat, 21 Oct 2023 23:05:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 76/90] target/sparc: Move FSMULD to decodetree
Date: Sat, 21 Oct 2023 23:00:17 -0700
Message-Id: <20231022060031.490251-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 43 +++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f18fd99476..6817d52ca2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -260,6 +260,7 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 47f4d0b51c..4a6f25bdf1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1666,22 +1666,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -5092,6 +5076,28 @@ TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
 TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
 TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
 
+static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (!(dc->def->features & CPU_FEATURE_FSMULD)) {
+        return raise_unimpfpop(dc);
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_fsmuld(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5202,11 +5208,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x47: /* fsubq */
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x69: /* fsmuld */
-                    CHECK_FPU_FEATURE(dc, FSMULD);
-                    gen_fop_DFF(dc, rd, rs1, rs2, gen_helper_fsmuld);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-- 
2.34.1


