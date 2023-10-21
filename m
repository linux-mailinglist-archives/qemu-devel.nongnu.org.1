Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD697D1B0E
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4hs-0007UT-Jl; Sat, 21 Oct 2023 01:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hb-00077E-RL
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hZ-0001W6-Pr
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:11 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5b837dc2855so1121507a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866748; x=1698471548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzXDIm+XB6/+J2teHXfrkX/njJ++UKPy0u9EIz6nhBs=;
 b=EyP/PD+W2NiAlIoqzlXr0m3+KfRtzHwg6x94oNTFdPf65N5i7EmuHbCe/zObLzEBJS
 +FVlv13EroJ4+gyJ3/e1olHSKOphwIUCR4ioZqqxH5NBuovxQCR0IitOPmigS3NSaCZu
 1E+h4l/pYvCLrh8E6D0zm89/8S0WeTc9pkoEs/7617UPDXIXL2ES0oHzGZG+Pqb5U3W2
 HytF6R1ybQxAtfRU+EI5f+P6tfsQBXGvL+7f0nJ62xMXvaYtvCSziFyvn4wbBuyBtTt3
 3J29x1lq/ABnh6AB7ZNxeXiPN0F96+4OtfYYOrnP5+1LmZxPcEHsmPYA9z8IKqMNC9cM
 MhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866748; x=1698471548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzXDIm+XB6/+J2teHXfrkX/njJ++UKPy0u9EIz6nhBs=;
 b=wKWiSikd2UXioN/y21xYlfAC9WrbStWnbvqg5Xn/16/tPFXHpKTD30DD4arFM92UyM
 zGfDsFTpAeOLFoCXGyL12hL7bBmtO0d60ioDcj3Z+ABYDSPc9vkJuu3+g9ywmfyzMSGI
 EeExTYa4/m48EGn/b9kHTAuhGmBZKFhsvZAzeWkYaHrFAOHoQmhgrikbgVBD0hOTCnJV
 F5p8EfSIcnatxkK4ckCEuy27+8Vz9kZN/LnLFfbuE4C6hHsEbGIFPltC126vJmlF5jD0
 woAZ9P+FKE/oSaZD23KFV7FNBRw0Tk0muVyEThy+vYXSXrSC1ShaN5bIR+CsRM7Y0/8o
 2ptg==
X-Gm-Message-State: AOJu0Yxb/fv9PAAiHVnwyVEpqeWlfCmCTSsq38PSfpGdfxll7vAfp5Qt
 /gfMEotiOeG5gSv0M6twXGaSQcMc/356W0b/dPM=
X-Google-Smtp-Source: AGHT+IGEl1Q6LCtVuST6oenDjFt38oZhe8b+W1l2M5sqrzca4iq2U0dQb/0b8UPq81EFn0KScnihFw==
X-Received: by 2002:a17:902:d4c7:b0:1ca:3cd7:eadb with SMTP id
 o7-20020a170902d4c700b001ca3cd7eadbmr4408586plg.9.1697866748414; 
 Fri, 20 Oct 2023 22:39:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 81/90] target/sparc: Move FqTOd, FqTOx to decodetree
Date: Fri, 20 Oct 2023 22:31:49 -0700
Message-Id: <20231021053158.278135-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 431152dde9..908b2ba408 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -264,6 +264,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
@@ -271,6 +272,7 @@ FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index fd3ffa1b96..def29dd4b8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,7 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
@@ -1668,20 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr))
-{
-    TCGv_i64 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i32))
 {
@@ -4910,6 +4897,30 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
+static bool do_env_dq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    dst = gen_dest_fpr_D(dc, a->rd);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
+TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5193,11 +5204,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                 case 0xc7: /* fqtos */
                 case 0xd3: /* fqtoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
-                    break;
+                case 0x83: /* V9 fqtox */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
@@ -5223,10 +5232,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x83: /* V9 fqtox */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


