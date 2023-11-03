Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11277E07B0
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:43:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8u-0005Mj-LA; Fri, 03 Nov 2023 13:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8D-0005DY-3Y
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8A-0003Qs-3W
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so9883445ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033128; x=1699637928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YO+NoiOvuNpNkKkH1QgyxJDWN9EGHZREt+ntpOXGlhM=;
 b=zAaRB/pyAJIt3zt6HdwpDXwFJnL7SHMC8nhnOxSZLUeHCsW5w6LZw8SUbUHBy7D2Bi
 4mLAyd96/tZ8zDyr4h174hYK5sB7Y58HkZWnwwLjh3C4laHKaGLrKQUuquOp2nLglWT+
 balc8ar1zHwSpj2AoaPgwwODmWRL9UerJAphDHx4VdxAk+YhOux6v9xHiGbR2PjjeH21
 fru/lumWhyrE2yM35RaSZ5IvpnuCz5c8oIbuvL8UrdIAKnp4BXVMzKd4DcVqrtCi4wAs
 c+8bxRFdHZtzcl7o7pl7t5Km3K9eHkJUC5sfWEqIYrPQnbv7G2+omSqlm1yhmA7umn80
 8huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033128; x=1699637928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YO+NoiOvuNpNkKkH1QgyxJDWN9EGHZREt+ntpOXGlhM=;
 b=SUV4q/0t3p/D2dB/d42nbHIVaQ52XL6Sn/+o9ZQ7UbYuQR1ZImzp8swWlRzMDzfoSQ
 YL24VJqqXxHkcEhWNn8aAjV4qliWk9tsjxebS95FO1rs6ozxS2qZSbMjvqcVrXbJmJc+
 1CPRsh8GW5s4+3Iwo7mCOkqbtTKKMs6sIJYtwg2mPrdaXga1EUKEVlzWT1vVNVk+Z6/g
 w/ME9pA++ZgeHLiGaBXBkaVEgznQCnaprwQNF0hNImAtiuH5RduoGUpzJ507pOBdAsBJ
 TTtFRp0+XnD/n1T0oj+ruEA510Xet2uSi+0dEciAKMBoPUaOnw1EItQitUEhxi1/T/Vl
 n7/w==
X-Gm-Message-State: AOJu0YxwpqljvHH5QWPHvp/88fR+E44PA1fiDFF7lOVneseQ5Xg3qUKP
 lUm5oFBFnx7deWeY7oaGdpaPxvqht6dJti6HO/o=
X-Google-Smtp-Source: AGHT+IFFnVwM7qMLd2TAHvtiZSE5ETc3WAUq35DiwD8/U9X+QVE2Tg/fBeoazKMg6O5j+N09ZrqqvQ==
X-Received: by 2002:a17:902:ec81:b0:1cc:6e5e:a980 with SMTP id
 x1-20020a170902ec8100b001cc6e5ea980mr11930660plg.3.1699033127770; 
 Fri, 03 Nov 2023 10:38:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/22] target/sparc: Use i128 for FSQRTq
Date: Fri,  3 Nov 2023 10:38:25 -0700
Message-Id: <20231103173841.33651-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/sparc/helper.h     |  2 +-
 target/sparc/fop_helper.c | 26 ++++++++++++++++++++++++--
 target/sparc/translate.c  | 12 +++++++-----
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 74a1575d21..eea2fa570c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -43,7 +43,7 @@ DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fsqrtq, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_RWG, i128, env, i128)
 DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index d6fb769769..d639e50965 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -26,6 +26,28 @@
 #define QT0 (env->qt0)
 #define QT1 (env->qt1)
 
+static inline float128 f128_in(Int128 i)
+{
+    union {
+        Int128 i;
+        float128 f;
+    } u;
+
+    u.i = i;
+    return u.f;
+}
+
+static inline Int128 f128_ret(float128 f)
+{
+    union {
+        Int128 i;
+        float128 f;
+    } u;
+
+    u.f = f;
+    return u.i;
+}
+
 static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
 {
     target_ulong status = get_float_exception_flags(&env->fp_status);
@@ -222,9 +244,9 @@ float64 helper_fsqrtd(CPUSPARCState *env, float64 src)
     return float64_sqrt(src, &env->fp_status);
 }
 
-void helper_fsqrtq(CPUSPARCState *env)
+Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 {
-    QT0 = float128_sqrt(QT1, &env->fp_status);
+    return f128_ret(float128_sqrt(f128_in(src), &env->fp_status));
 }
 
 #define GEN_FCMP(name, size, reg1, reg2, FS, E)                         \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 254f185b83..6c08bf909e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4669,8 +4669,10 @@ TRANS(FNEGq, 64, do_qq, a, gen_op_fnegq)
 TRANS(FABSq, 64, do_qq, a, gen_op_fabsq)
 
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
-                       void (*func)(TCGv_env))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 t;
+
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4679,11 +4681,11 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
-    func(tcg_env);
+
+    t = gen_load_fpr_Q(dc, a->rs);
+    func(t, tcg_env, t);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, t);
     return advance_pc(dc);
 }
 
-- 
2.34.1


