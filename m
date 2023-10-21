Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922307D1B2D
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4iE-0008Bu-LD; Sat, 21 Oct 2023 01:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hc-00077F-7T
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:13 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ha-0001WD-JF
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:11 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b2e4107f47so1111396b6e.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866749; x=1698471549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HHLpF3OVuW1DDKSYABmjOz0eUOo6D7/qnjKtalhCCY=;
 b=pQogtzJdYQ5gE20uWJgC8Rn7w3Tgnd5R3X1C1o4/FIv25xoaCSJmGeMwi4uxUV1YBE
 IcdgbwkejV0SUxTEyE3iExsN0g8fytL1jN//8xKicR2urY3M0oF71mRKFU1nYaazOFgR
 EaeFtlVkCLqWupLGW8lvXCPT/+9Wdhi4CCjSAZVUqsTt540vGAqCf6XyPRKu/O2XmeB/
 VnIW1MIRYC+ZJhNbtNzCYiMeS2bFDpwws3Ku7RHq1iFIvbRQR8d+NlQRBj2ezXnHx/n8
 mbitR28M8mMP3JuhBguhjRy1+cTRLmh7n+Cao/67GBDVvIvlWhQp+jL70oxh4T5YvAai
 Hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866749; x=1698471549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HHLpF3OVuW1DDKSYABmjOz0eUOo6D7/qnjKtalhCCY=;
 b=AuoZx9eSGqIlqdRpX2u4gbeRolTLwmGEkb7tOf+qf5YT28M7FdastoS5cfQAk+Wz4U
 2cX//m8NkND1GrbHdmwPqcJlPqbz1Z3o6y6z4rM5PuhSZHlni2KzN026iUekqePeUtJC
 kARHiizA9kH/bfVMX6fZ/ZCdtVDaAXjrPsiRqTt0pQNBAdeh4oKtwFuOw6sg8hrsgT6K
 jlhbk8dYDcwCoBrb1iW9BOn1j0uetD4p3uRUen1fbolaNNYzKOhHrzkFpQBo7Gtg71/s
 SdCQuxbJVybe8uVF+tNRPZH/g4MOWsWej7Ech10Kn0QY1eeNPLIbp1xwoOGTQPZ9qBEr
 Cf2Q==
X-Gm-Message-State: AOJu0YyyzZWBGk0UjOwxIMW5w37wDhGSepdJUbbLtJn0LAcJTJHNBtho
 uU39LQ1nFGVpysDMY1tVD10Tuzf/vp7ZNNZ+pzM=
X-Google-Smtp-Source: AGHT+IHaIGXVVqXTQKEBxR+VplK9wL0F3spvyS5yW53G6PDflPcTTP3InSnOJdMDDepEc6ZNfSD6Hg==
X-Received: by 2002:a05:6808:309a:b0:3b2:e5cb:8e53 with SMTP id
 bl26-20020a056808309a00b003b2e5cb8e53mr4951796oib.10.1697866749291; 
 Fri, 20 Oct 2023 22:39:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 82/90] target/sparc: Move FiTOq, FsTOq to decodetree
Date: Fri, 20 Oct 2023 22:31:50 -0700
Message-Id: <20231021053158.278135-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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
 target/sparc/translate.c  | 44 +++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 908b2ba408..a444819d6c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -273,6 +273,8 @@ FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index def29dd4b8..39598514c0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1669,19 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i64))
 {
@@ -4921,6 +4908,29 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
+static bool do_env_qf(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i32))
+{
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
+TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5206,15 +5216,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xd3: /* fqtoi */
                 case 0xcb: /* fqtod */
                 case 0x83: /* V9 fqtox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
-                    break;
                 case 0xcd: /* fstoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fstoq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-- 
2.34.1


