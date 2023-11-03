Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EE77E07A6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8w-0005Oh-0i; Fri, 03 Nov 2023 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8I-0005El-CN
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy88-0003QO-Ux
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:56 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc9784dbc1so12678485ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033127; x=1699637927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwGB6UqbrFaBrfPKz5OCrw7rrJ0PEN4BU/Qe8d0GrsU=;
 b=puJkXJRb1xU6U5EYWWWgdmCrLjphfURcjWO3L3/YYmoQDC7dkU2FjZLpOQaXRoN0dT
 0PCksuV4z/4fIPEHVAeKgyZMoCrrdcZX8RoVqYTsObUcG19iYFdhZu2gsGbfqi5ROD/f
 eIbV411/iCoiRoENd8p5qCszgeUmEkKQ94ydwGI+8ZUVB1Pj/EgITY/N2PqTZKheVGYG
 jR9O4/sAFdHNVl0IvOwI7znguFEmGLQYa0c2nKVSyIVDmP7PcAYEkK5KHe8MFDak+9ck
 zEH0v9jU2GVHvs616RhFqLjPXSWVJOXzhIIrcornpfY98rbGrwqbO7RIZ8KibnYqr6Qo
 JOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033127; x=1699637927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwGB6UqbrFaBrfPKz5OCrw7rrJ0PEN4BU/Qe8d0GrsU=;
 b=SRrSKO/rhBBd4uuiVJJ4zkdFUAmmhEkDMyjh+4Kr85GDcRbJVg0B90rdGsbENGktW2
 lWVDTi89vqSMKigMhf8mO2I8lbQ8VgmZ7VQIFJ1YygK2oFV11VPKot6791xdOjseFcJR
 hao1H3G7xdeO6/hq6nnEm1vu9lnoO6rP4XN22yFE0nDWY0YdbAw8CYkVIvDOMGHjYDS3
 W/4LiwSBRjUnZ6Y30O4GX3RON4Eh8uWX+2IIBvvCLVWXV8XRZzKI7Ipc8cjHtJzgwU/Y
 pN7l0nNycX4Cyx46zIaDI7kj/CrFG9uCd7LtiQLJzOI9VsMVa9u5xBUUXgoX//pcYkPZ
 9Osg==
X-Gm-Message-State: AOJu0YwY0Lh5Kn7x0xtTK1S5kdcrD3QOAYbQ/SpNhAoNKBqNgbtREtJe
 2x2mOM12ZqVLVDHek6urQrjrSw7wyQx6yTEZPiA=
X-Google-Smtp-Source: AGHT+IFQ9f4yrJr44TkIrMidbxZzTqECWlmvras9W09gnyF8dE6rC8oPhVx0Dm5BOkWEdBhWiq8ydw==
X-Received: by 2002:a17:902:d4c3:b0:1cc:6ab6:df26 with SMTP id
 o3-20020a170902d4c300b001cc6ab6df26mr12688510plg.49.1699033126976; 
 Fri, 03 Nov 2023 10:38:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/22] target/sparc: Inline FNEG, FABS
Date: Fri,  3 Nov 2023 10:38:24 -0700
Message-Id: <20231103173841.33651-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are simple bit manipulation insns.
Begin using i128 for float128.
Implement FMOVq with do_qq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  6 ----
 target/sparc/fop_helper.c | 34 ---------------------
 target/sparc/translate.c  | 62 +++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 72 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 55eff66283..74a1575d21 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -37,7 +37,6 @@ DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_1(fabss, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_RWG, f64, env, f64)
 DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -48,7 +47,6 @@ DEF_HELPER_FLAGS_1(fsqrtq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_1(fabsd, TCG_CALL_NO_RWG_SE, f64, f64)
 DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -61,7 +59,6 @@ DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fabsq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env)
@@ -90,15 +87,12 @@ DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
 
-DEF_HELPER_FLAGS_1(fnegs, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
 DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, void, env, s32)
 
 DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_1(fnegd, TCG_CALL_NO_RWG_SE, f64, f64)
-DEF_HELPER_FLAGS_1(fnegq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_RWG, f32, env, s64)
 DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_RWG, f64, env, s64)
 DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 0f8aa3abcd..d6fb769769 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -114,23 +114,6 @@ void helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
                        &env->fp_status);
 }
 
-float32 helper_fnegs(float32 src)
-{
-    return float32_chs(src);
-}
-
-#ifdef TARGET_SPARC64
-float64 helper_fnegd(float64 src)
-{
-    return float64_chs(src);
-}
-
-F_HELPER(neg, q)
-{
-    QT0 = float128_chs(QT1);
-}
-#endif
-
 /* Integer to float conversion.  */
 float32 helper_fitos(CPUSPARCState *env, int32_t src)
 {
@@ -229,23 +212,6 @@ int64_t helper_fqtox(CPUSPARCState *env)
 }
 #endif
 
-float32 helper_fabss(float32 src)
-{
-    return float32_abs(src);
-}
-
-#ifdef TARGET_SPARC64
-float64 helper_fabsd(float64 src)
-{
-    return float64_abs(src);
-}
-
-void helper_fabsq(CPUSPARCState *env)
-{
-    QT0 = float128_abs(QT1);
-}
-#endif
-
 float32 helper_fsqrts(CPUSPARCState *env, float32 src)
 {
     return float32_sqrt(src, &env->fp_status);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0e494d3ebd..254f185b83 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -43,9 +43,7 @@
 #else
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
-# define gen_helper_fabsd(D, S)                 qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
-# define gen_helper_fnegd(D, S)                 qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -61,7 +59,6 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
-# define gen_helper_fabsq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
@@ -79,7 +76,6 @@
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fnegq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
@@ -1239,13 +1235,13 @@ static void gen_op_fmovs(TCGv_i32 dst, TCGv_i32 src)
 static void gen_op_fnegs(TCGv_i32 dst, TCGv_i32 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fnegs(dst, src);
+    tcg_gen_xori_i32(dst, src, 1u << 31);
 }
 
 static void gen_op_fabss(TCGv_i32 dst, TCGv_i32 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fabss(dst, src);
+    tcg_gen_andi_i32(dst, src, ~(1u << 31));
 }
 
 static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
@@ -1257,13 +1253,33 @@ static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
 static void gen_op_fnegd(TCGv_i64 dst, TCGv_i64 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fnegd(dst, src);
+    tcg_gen_xori_i64(dst, src, 1ull << 63);
 }
 
 static void gen_op_fabsd(TCGv_i64 dst, TCGv_i64 src)
 {
     gen_op_clear_ieee_excp_and_FTT();
-    gen_helper_fabsd(dst, src);
+    tcg_gen_andi_i64(dst, src, ~(1ull << 63));
+}
+
+static void gen_op_fnegq(TCGv_i128 dst, TCGv_i128 src)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+
+    tcg_gen_extr_i128_i64(l, h, src);
+    tcg_gen_xori_i64(h, h, 1ull << 63);
+    tcg_gen_concat_i64_i128(dst, l, h);
+}
+
+static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
+{
+    TCGv_i64 l = tcg_temp_new_i64();
+    TCGv_i64 h = tcg_temp_new_i64();
+
+    tcg_gen_extr_i128_i64(l, h, src);
+    tcg_gen_andi_i64(h, h, ~(1ull << 63));
+    tcg_gen_concat_i64_i128(dst, l, h);
 }
 
 #ifdef TARGET_SPARC64
@@ -4629,13 +4645,11 @@ TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
 TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
 TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
 
-static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
+static bool do_qq(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i128, TCGv_i128))
 {
     TCGv_i128 t;
 
-    if (!avail_64(dc)) {
-        return false;
-    }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4645,30 +4659,14 @@ static bool trans_FMOVq(DisasContext *dc, arg_FMOVq *a)
 
     gen_op_clear_ieee_excp_and_FTT();
     t = gen_load_fpr_Q(dc, a->rs);
+    func(t, t);
     gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-static bool do_qq(DisasContext *dc, arg_r_r *a,
-                  void (*func)(TCGv_env))
-{
-    if (gen_trap_ifnofpu(dc)) {
-        return true;
-    }
-    if (gen_trap_float128(dc)) {
-        return true;
-    }
-
-    gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
-    func(tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
-    return advance_pc(dc);
-}
-
-TRANS(FNEGq, 64, do_qq, a, gen_helper_fnegq)
-TRANS(FABSq, 64, do_qq, a, gen_helper_fabsq)
+TRANS(FMOVq, 64, do_qq, a, tcg_gen_mov_i128)
+TRANS(FNEGq, 64, do_qq, a, gen_op_fnegq)
+TRANS(FABSq, 64, do_qq, a, gen_op_fabsq)
 
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
-- 
2.34.1


