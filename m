Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5F7483C6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Hb-0004aK-6c; Wed, 05 Jul 2023 08:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HZ-0004Zb-2D; Wed, 05 Jul 2023 08:06:53 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HX-0003V2-Ct; Wed, 05 Jul 2023 08:06:52 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55ba5fae2e6so2270478a12.0; 
 Wed, 05 Jul 2023 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688558809; x=1691150809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yzv+S4Ay2gKi030I04Ege67v32G/RQQBhsK1ryB+b/0=;
 b=B3K5NCkO2d2FEc1akVi2XSJbdcvttXNKg0eJcfluRxnDPv7PkGcx9LyRm46FZ8D9NG
 ZWyA8Eop1vtSFevD0TKM7MCkSMMWsI5HeGyIBwiiPk7slrc9A92Lbr3Ij5IdvCN+jkTG
 dnCkG48KOqCio54wwgzhEzuevNAO8iWfUZCK4/ZX7iTKdVYNGtJdgVwTWeiUAjVmXoJt
 DvUp9aIoUobUda9wR7eF/zCpNYyX6h26pjNTlxTrefqao7903uiNjsgV7/gyejmfYvQq
 SmZRi+u/Xg7GIDHZJ7Qj/bSUtrEn7lZG0YvQa+4tKyi9r63Xsbqss4g8UCqaQzA/EdbW
 KJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558809; x=1691150809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yzv+S4Ay2gKi030I04Ege67v32G/RQQBhsK1ryB+b/0=;
 b=gaiUYz4opVvqs6XbMt/ZYYY4rGDABIkAMwm2MF12vMWSPq5wDxe5uOzuhu9QIRjEH8
 0TMZWYlF8Xa16ofyye4lxEn26S9pXu5NuP/LPZaaHkTv8OwPUy3eZxu6krdAjbZEbGh2
 9A6XFSFuad4mdY4pDbzJDQ2EhHVuGEdCTTq70X5Ghf6s2gRsV9GnI/xRp25+Kyr/FqMw
 rXc3Owv4RuUok/ZeK1JqFgv1RtKMsHILhmIl/5d8B55m3+HF67d31sUNgSEre0xcFMp2
 MtFutm+R0s48zEJE2m+r6mFrhqcXDGT+SIP44OsTJ+++J83MHhrYXThGvtX1z4sNvt32
 63Hw==
X-Gm-Message-State: AC+VfDyiASgQycB8IzgSoth8o8yCIhfKq58b+nuNVe0w787AVHSFIAUy
 SWh1YoBWAG1uEm0dA9X+R9E=
X-Google-Smtp-Source: ACHHUZ518X4SG/PV7PtAhIwOlzGK3mwoL0HYw9VsQmkzAMeXGfPtExM2CO1OhFb3uwf7wLPR1HweBw==
X-Received: by 2002:a05:6a20:511:b0:12c:8871:26dd with SMTP id
 17-20020a056a20051100b0012c887126ddmr17286381pzp.25.1688558809479; 
 Wed, 05 Jul 2023 05:06:49 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a00271000b0067459e92801sm15764843pfv.64.2023.07.05.05.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:06:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] target/ppc: SMT support for the HID SPR
Date: Wed,  5 Jul 2023 22:06:29 +1000
Message-Id: <20230705120631.27670-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705120631.27670-1-npiggin@gmail.com>
References: <20230705120631.27670-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

HID is a per-core shared register, skiboot sets this (e.g., setting
HILE) on one thread and that must affect all threads of the core.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.40.1


