Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A67C8F62
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmp-0003z0-Ny; Fri, 13 Oct 2023 17:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmF-0002Pq-Tz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmD-0001ZK-0R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso1017031b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232776; x=1697837576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E6rWcA820AIhQUkQjZUIaMHfBsnT3Jt1vQDJ8CIQNA=;
 b=T2JEsdKG5Og7GZhbJcyebNeNejr/F0gYCF1lZ5IcH8J17RLN82o1i7WJXZ4MPKPHQ/
 CoyO0y44L7CJOmWMrLo8Dc4kZ0mSAkeny9129YeUW9KCYxKQKx4Vw5jafNyUufflBETu
 zOz/0YudGekGns7e5cMLZuhFQLgIHeMXQoJbY7MXe4b90VNnT+vekTrElehK6w+7bQdW
 fQG7awh87hQbpB6OO2f1dRJc/DF9waod8YlYbOZ0at2Z5RCsn740vPMSX927u0Uvb+iw
 o07WA566z92K3qzvH1NMCx30pDDy59/F+BGnIuewl0TKGBvGXBAETlDxL6bmqhe9/QH+
 W2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232776; x=1697837576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+E6rWcA820AIhQUkQjZUIaMHfBsnT3Jt1vQDJ8CIQNA=;
 b=XqdEhiDvG7PmDQZQ0Vjwm9Kq8XizprROSfu0CbgJhiq1S2TA/wJ4Sb1x1bWSfRg7ce
 D8ihkObehr2jaTW4ivHswF4ea5xOi6Q1eEuCNh+I2ElaWQwCVqojug+4OVPTSVG715w0
 HMb/XFtwSZZiSt4XgUX6AkHJu3v1iK4uqlRGPkjhTcq23XyVuLNzzsW4dbMIBn63SF0Q
 cAqdOPvMADRlspD6nJ9BzmzJlvktuHu4hwT854lt+pNBtxu5e4f55rsQdsF1KSRInTAL
 syLBOMe9OhSPqkFkmceS8EOecYxY8O+95aXSAYcPDgstYckQOSsuwpeO68fQT5oAAZyj
 bIPA==
X-Gm-Message-State: AOJu0YzalhImgKRVN0T2uQx7p9WDZRMrRNLcB10EpqtOvU/F9v+HnNbN
 cC10d1GISIAD++UhmsCePwq6z9tYQQXeXnD+uOI=
X-Google-Smtp-Source: AGHT+IF81t5guWyJ8qp1NQOK3+/SKz/+KV8yTaJVH/5tJ2yxvXz+GkgsknQOvXGx6kvqNY1goqKJGg==
X-Received: by 2002:a05:6a00:1388:b0:68c:a81:4368 with SMTP id
 t8-20020a056a00138800b0068c0a814368mr29449711pfg.6.1697232775714; 
 Fri, 13 Oct 2023 14:32:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 74/85] target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
Date: Fri, 13 Oct 2023 14:28:35 -0700
Message-Id: <20231013212846.165724-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 6378dc5d07..4368ac25a9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -256,11 +256,14 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
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
index c1a82b4c9a..1b1ac9b5f0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -56,6 +56,7 @@
 #define gen_helper_fnegd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1540,37 +1541,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4753,6 +4723,29 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
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
@@ -5052,17 +5045,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5096,9 +5086,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


