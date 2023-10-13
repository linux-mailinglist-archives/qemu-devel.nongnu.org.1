Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E27C8F3D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:34:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmk-00032p-Hk; Fri, 13 Oct 2023 17:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmC-0001yh-C3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmA-0001Yf-JF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso1017011b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232773; x=1697837573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHzaNUnemb4vfnsXuTxzxiTsIX5bUlSrxUwCk57sNRU=;
 b=XHfQ7yy2GrLajD08CNtmdit0wV2MtbwlM3YPyzUCxYNlzezXMZ6iPEqxktGy3aW319
 PPBzHo6eRoBfL661MgiVWC4BibEFNhRi8bfUTQ9CzlafFvl8QB06fboYeIId/9APH5wS
 dQhxvSI+Ke0ZOqhwFb1SDYFl0MFuppG14e09yrDuS4+20PLVHgm1rxVvgXyEbu4Bo2Vh
 spjSlLFS+Q6Va8tKcolRPkiZ+z83SRjmSyaVmUV+Vt3VrhR8NuvHJ05JiFIfiQhF+RJb
 vN6B+UdzelM8arcxZrIUwrEJsPYERV1FlmTGHAoOT5DHgZpKFpsXf0RIP8a4LjRIgHt/
 aBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232773; x=1697837573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHzaNUnemb4vfnsXuTxzxiTsIX5bUlSrxUwCk57sNRU=;
 b=wEtFpoS2ncH24NZQQ9ofJMTZvOjeUkWIakv+WmWGJmA5huIdCf9U/LxgdL0YnL+Fhk
 sbGAgUKUPCVTnuv2yc4q9BuvyyKKxYtE+zRl0bSq+RhFTTNx4AJJT/Z0dGREKa8smqh5
 HHYsDvVk5oen/56r5ifh8/OlB+aLz1MNX+1eiKtF2MXTMzqOV+WURmMckrf7/2b8UzV4
 asSRwx6yRn3e1Ujaf0vGO48sk1we/J5lp3E43EUJ4OYxfOitoZ1p5zSREyoAABm6DfJ1
 +K/69zysabmwtFnAvLtN2CTNAggLwCxsu3EII3Ah/njKUHiZBiTZFYz7GCsL8RNpPIPV
 F6Rw==
X-Gm-Message-State: AOJu0YzrIMKqCenq7dwBqv7mm+oT/3DGkhlgvMNnsrWWFy9uQF5pKLlb
 DF4uZVwCzDzbu8V2mY8LibOJLwFm6hPwLqATN4U=
X-Google-Smtp-Source: AGHT+IE8tCz4snXJ8toGZ7ddstZubvhLwWjcRw145vCkNpumyhGrhkCr4GRZ+4ob32MeuTwHyes7/A==
X-Received: by 2002:a05:6a00:22c7:b0:68b:f529:a329 with SMTP id
 f7-20020a056a0022c700b0068bf529a329mr29346068pfj.5.1697232773343; 
 Fri, 13 Oct 2023 14:32:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 71/85] target/sparc: Move FSMULD to decodetree
Date: Fri, 13 Oct 2023 14:28:32 -0700
Message-Id: <20231013212846.165724-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 43 +++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 036e2b01d4..a52fac9352 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -254,6 +254,7 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3446821a50..4b37a171ff 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1539,22 +1539,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4916,6 +4900,28 @@ TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
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
@@ -5026,11 +5032,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


