Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA474B040
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhm-0003Et-RQ; Fri, 07 Jul 2023 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhh-00032x-01; Fri, 07 Jul 2023 07:32:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhf-0006nP-Dx; Fri, 07 Jul 2023 07:32:48 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b8a6ca994eso1611608a34.1; 
 Fri, 07 Jul 2023 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729565; x=1691321565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbNq/01MgOjIPRTLf1s/y3co3sqpAmHZNoVphu0ZvvY=;
 b=U4XTCjKa/FrrA8OS2exKRq7UVxkS062OHXmdwYNOWRsUGuyzdvgAUPfKxtZrPYdKe7
 zs2unnmRs2EY5mycehl4kdBjXaWssMte59Js840Ql/mLYUUewB0a4N/bJPFatpCfXF8d
 7OVquMsLmp/y90W9HTqyJvsTXYhiP3taqhJ/iQFDGDCbTkO0qXHdtYQKXD1IKs6hWJDG
 Lf+u9M3GZUB5sRqk6AWQ2w5Dt3De1lq+XNhKLcrok8HtZ5dL0eY/8hC168wY3NA5Y9oX
 FFLx2pR1+Ep7vusTWeYqRkFxLXS1dTJs5wfrvxS+PGVfjbYQ9yQix6jAVycGLeptc5qP
 HHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729565; x=1691321565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbNq/01MgOjIPRTLf1s/y3co3sqpAmHZNoVphu0ZvvY=;
 b=c8JzJg8SIkBM6c3FuKHQmjcELzDPaVyZLVYZ8y3+Eu59tzOVW04fIM6GjMIEahNvhR
 WDPsMDkQYevZe9ioqX3GAtBbLTcWcvNhyYk+06T511T6MloRtHw7F6NA8aPyhbjTi0sB
 G+8o0RB0jYTIihWP7xXoodvYiiXx0n/EXRM6VGuF6BhfjGcSZiUk46DdAL9wIoHYS2Mq
 z49UeVgGzJEjsx36rZQFIFH3pCVqxDo+xwgWsTAyBea/eVFAZsmJasNegzlC9MyumnOy
 GpsjXmw6VwLCIXGlRaNEbtKTJYCEd0kgTuOU0a+MFfLKKgQql8NyPf4NBbNAolvbavJD
 Fong==
X-Gm-Message-State: ABy/qLZmaTe/wHn9ys421seEg/mzAuc+qkMYE6ZlLZICKDGEb4cAz6xe
 /C3P3cgXnFdhI8dbWGl24L+znRlgA5A=
X-Google-Smtp-Source: APBJJlHeuB0h7IR4thIlsj2zUAVfYZDYpyA/EZgra2mTyjJDUCCL5efYSajzK+H98lkV/dn0mrkeuQ==
X-Received: by 2002:a05:6830:10c:b0:6b2:ab63:6ed with SMTP id
 i12-20020a056830010c00b006b2ab6306edmr4847997otp.35.1688729565213; 
 Fri, 07 Jul 2023 04:32:45 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:45 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 32/60] target/ppc: SMT support for the HID SPR
Date: Fri,  7 Jul 2023 08:30:40 -0300
Message-ID: <20230707113108.7145-33-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

HID is a per-core shared register, skiboot sets this (e.g., setting
HILE) on one thread and that must affect all threads of the core.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230705120631.27670-3-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c    |  2 +-
 target/ppc/helper.h      |  1 +
 target/ppc/misc_helper.c | 21 +++++++++++++++++++++
 target/ppc/spr_common.h  |  1 +
 target/ppc/translate.c   | 16 ++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 905a59aea9..720aad9e05 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5638,7 +5638,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 828f7844c8..abec6fe341 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -704,6 +704,7 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
 
 DEF_HELPER_2(load_dump_spr, void, env, i32)
 DEF_HELPER_2(store_dump_spr, void, env, i32)
+DEF_HELPER_3(spr_core_write_generic, void, env, i32, tl)
 DEF_HELPER_3(spr_write_CTRL, void, env, i32, tl)
 
 DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 26e546cc9c..692d058665 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -43,6 +43,27 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
              env->spr[sprn]);
 }
 
+void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
+                                   target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
+
+    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
+
+    if (nr_threads == 1) {
+        env->spr[sprn] = val;
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cenv->spr[sprn] = val;
+    }
+}
+
 void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
                            target_ulong val)
 {
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index fbf52123b5..5995070eaf 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -82,6 +82,7 @@ void spr_noaccess(DisasContext *ctx, int gprn, int sprn);
 void spr_read_generic(DisasContext *ctx, int gprn, int sprn);
 void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
+void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4556297ab5..e6a0709066 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -438,6 +438,22 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
+void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_generic(ctx, sprn, gprn);
+        return;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
+    gen_helper_spr_core_write_generic(cpu_env, tcg_constant_i32(sprn),
+                                      cpu_gpr[gprn]);
+    spr_store_dump_spr(sprn);
+}
+
 static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
-- 
2.41.0


