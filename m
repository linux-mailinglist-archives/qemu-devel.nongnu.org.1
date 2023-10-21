Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B37D1B02
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4el-0003fX-BT; Sat, 21 Oct 2023 01:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ef-0003UF-7C
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ed-0001Cz-DD
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so1431393b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866566; x=1698471366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UCx7G6xXInkBQRxZhBdyJBzDLdL126Uv8HJlOHmi98=;
 b=v08xtNyTNPEMr0rVYNt+c4oyQgz9G47luTIXrG4y7lf7nA5thn0UOz1PTMWGQoY633
 jIi04k6DWYYL2EtM3jDmv8oZvAX8IJPimh3dIYN4oXb2Y22dXd3WR2J/lnfJgtmKa2UC
 umuCyDsCbJV5hLjeEIhrD7209Ydqp3GShSG1KYIjkGpAp6YocQUllVec2DzX4I6TxCD3
 YVJ03k1uqoziHCOlVwZFjWour9WcyJ2BqsEmg8XdtBo/UDWLnXdx60x+ho3foe4NCx2x
 EonaHEpQ1bpNUnS5CHCoAjxPpPKCmgkmEGmJj5qy2cbA2nP/AuNa9xwtmubA+NuzF0hb
 7lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866566; x=1698471366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UCx7G6xXInkBQRxZhBdyJBzDLdL126Uv8HJlOHmi98=;
 b=dNS2g7QjE+iU9mtUukJz4stKSYRauMzy0Yy8ku0OZtbxMzdvbuWV8YlTrg1d2Aqil+
 TkwhlilbZjkVnVEBPuWg6+m5L0e6LQW0RdVfsVwIpLUgos+3ygi0LXUMejctfz0ZYI0b
 gz3GYjDuk/MOtB071uN1szo7LzLHqCkfg9gZmU/aGcVkjEHtrUIMWvJBY4Y0ydGRSj68
 CHz83HMGqiTy5ebUmlWOxJkjbnIa3d9FhRwDVynfyztLiAjZKsEEI9wP9TZgYIctY1kJ
 O5JWJfqmF9YCRFWmUNnW74jnDOpMMs/6JZ+xpNoFUUOH9SG3SQ755GkQHiOPF1cMcZm6
 yO4w==
X-Gm-Message-State: AOJu0Yz/6BiveKsuu/B/sGUcppsabvmI82fjiYWLZcyEPu98jMt3b7mn
 vKQbpXbuq/AhvqI+c5Nb+xElMInLNMqwAawzLm0=
X-Google-Smtp-Source: AGHT+IHYeYc4igPOVrT4GhrF8JJFdDrR4fKpFpoJ4BMIbhvoo3Abpx8RgkrrihxpJM3LmPwNqqfgzQ==
X-Received: by 2002:a05:6a00:13a5:b0:6bb:4360:159e with SMTP id
 t37-20020a056a0013a500b006bb4360159emr4355979pfg.17.1697866566126; 
 Fri, 20 Oct 2023 22:36:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 79/90] target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
Date: Fri, 20 Oct 2023 22:31:47 -0700
Message-Id: <20231021053158.278135-80-richard.henderson@linaro.org>
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

Note that gen_ne_fop_DF was incorrectly named and does pass env.
The two sets of helpers should have been unified.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 67 ++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5777e142df..3ad598a08b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -262,11 +262,14 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9f686a9995..0eb56f5fac 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -54,6 +54,7 @@
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
@@ -1667,37 +1668,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-#ifdef TARGET_SPARC64
-static void gen_fop_DF(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
-static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4886,6 +4856,29 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_df(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
+TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
+TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
+
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
 {
@@ -5185,17 +5178,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc6: /* fdtos */
                 case 0xd2: /* fdtoi */
                 case 0x84: /* V9 fxtos */
+                case 0xc8: /* fitod */
+                case 0xc9: /* fstod */
+                case 0x81: /* V9 fstox */
                     g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
                     break;
-                case 0xc8: /* fitod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fitod);
-                    break;
-                case 0xc9: /* fstod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fstod);
-                    break;
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5229,9 +5219,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x81: /* V9 fstox */
-                    gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-- 
2.34.1


