Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B96447CBACC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdOI-0004LM-Fp; Tue, 17 Oct 2023 02:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdOF-0004Dd-Aj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:17:15 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNr-0004pV-O3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:17:09 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57babef76deso2965066eaf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523410; x=1698128210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nScph8hjHzM4G7+Y2vCkY31j2HzlZ3TJQFgFIJqxRZI=;
 b=ESktbTOvpFxK+wKGRun8zevtJ7AvqjIVaofxj7NppvFw/pxcY3LqFetu/MkQTeCwkJ
 G0yu5eU2AwRh6lOJVG/IWOky4l2Kw3W9lmT/qknQ28flp64f/JtjpGH7VOyqYrBRQxbI
 jyEdZKHYydQ4jde9Bi+BIhqTaJ+QQDGIooJw6vsBCaal0RNNl5hseFiRW4PM1vvS99m8
 Y+Ut3N1zbWifq+tILhJKSGAemFF7mhclsU27IfdDhnoprX715wqqg2ALbRjnX77KXFN6
 KZD+hleboCoL9ymQ7cpnz71ChM/js03gwzbB8Fuxq50dj3DABDuCj3QQ3Bzagp2q7248
 nSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523410; x=1698128210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nScph8hjHzM4G7+Y2vCkY31j2HzlZ3TJQFgFIJqxRZI=;
 b=NTyl/Fcr0Poz8ih1RwyvrGToHKPRTUNA3rE/3sWDNxaqa8fdHFVXW1TVlcRAucXDpv
 cnhPzGxsSwLRB6OfdmMwdZ3PtU9xB365pl/8zLSSEdrdIuoxGqCOZoBnAcUi97VmcKsu
 5deGRfj+gShTneydRnAwqFoV+A066jDD80Q1aqak+x9aF/y5yewUzvzdMFNRSriqNJA/
 xqwH4o655OTdQkiHzO0/ZcRfOO0yEtG7b8s5ly9Zz1JkyQ70QwFjrSL64FKeEfuRRtI/
 bfN/d8Hvhx97+whfSxEzIepH02lStMlhyILzzllUiBvVosI0Uf+CQ9NdEQWBMY2FE7Xz
 615A==
X-Gm-Message-State: AOJu0YytaC4Uk4ZtbdOpMShc5UdkfUXOTaOdGJ/vYkyUTQWRivl/xhzV
 HyNk8BFx7aD8V+skdTrzEaOQPCVyaKCa1KjBpdk=
X-Google-Smtp-Source: AGHT+IGGAaHtQ1pKVMCZ96s6Y5PqyUpInt4g8yUdXGqkmYT3SHn9unE1eo2BNSTJv+uE9WSgdcluig==
X-Received: by 2002:a05:6359:5e02:b0:134:e458:688d with SMTP id
 pw2-20020a0563595e0200b00134e458688dmr1508922rwb.15.1697523410533; 
 Mon, 16 Oct 2023 23:16:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 76/90] target/sparc: Move FSMULD to decodetree
Date: Mon, 16 Oct 2023 23:12:30 -0700
Message-Id: <20231017061244.681584-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
index 0f7d898071..96d9139d21 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -253,6 +253,7 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f1bc85c1d7..7f94bb99e0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1624,22 +1624,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -5018,6 +5002,28 @@ TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
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
@@ -5128,11 +5134,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


