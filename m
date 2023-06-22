Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58486739D7D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGhq-0000kd-HQ; Thu, 22 Jun 2023 05:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhn-0000kN-Hj; Thu, 22 Jun 2023 05:34:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhl-0003NV-W9; Thu, 22 Jun 2023 05:34:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b55bc0c907so37493205ad.0; 
 Thu, 22 Jun 2023 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426456; x=1690018456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJQeOCVTk4IYZUoWEWRQMehatOO+sQzn5G0/NFJ9jWQ=;
 b=gvzmWDnUt5FpVHiGh/YY4/xI/qL1lDzDQkdnt3Jan8BoGA2VfQB6brd3pRyoPtbJdy
 Hzhnn4kcD6PO3b4VGdwXlkfT51zf2qCLiTKY92YvdkDyo1uIT6dPy1oX08obMRUrJw79
 LEb4LAUut144bZVV+cJNTb9AAQ0oo/virS1pEwRDNj9Rh0V+YOcTx7S37wlv4W8Dp/rl
 fH0hjDEE20Gxz+gqBm2iUyKsKUHqqhlb1z+RYfL6FzDIBVs7BWNomB4SDM4EAOHC/r5s
 4ELiQB9duLBja9u/1ST4cIWNcJ96krSSsBDQYlhxpUJ4FrsWs7iXg36PdxD+pkSRXuSY
 7SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426456; x=1690018456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJQeOCVTk4IYZUoWEWRQMehatOO+sQzn5G0/NFJ9jWQ=;
 b=hi76w8YMbT6vUVCDLvRTt2oh2M6zSRwnp+mLWXD0iF4tbK79ubHspmiYQa+xuFTp/Z
 nbUqftRWrac3yeh3PXE6ucbZ2XT8D/1GAxxu4o+1xjaztq6OPo1VdxHZ8QSDr5sJo+KI
 6S/FmDyPvEYT+gXpj8GdFkyFkzgkBbkd0JhCH8j5HHcI0bR1Fgw/XjC/NdkA24jSrQtd
 N0crGhUwwS1NM+8DU1LqU+i3LW6g5lAj5sUySscU3zEza3HvWFM81dL92Z8LeLKO4yX8
 k61IHBAbxJGZZN+Vt+KWlqraXF7DyQDrQz4Yvi3kOlvIor9APVgJZdy863dYvSbO6A0/
 crFQ==
X-Gm-Message-State: AC+VfDw5GzTE5Pd//JRnQnHefheiu1Tcj+ODbgnjb6/evGAgPs/OrZU3
 q+aEeRxza482hzH+xlyukEYS5G3N1oM=
X-Google-Smtp-Source: ACHHUZ5OvyE6D7Rmq/6sKGERS11n+uxp0bDn/UKuJXmnOx5U4QAXwnMGgAbNQGBLIyDu471Zd0snQA==
X-Received: by 2002:a17:902:6b44:b0:1b5:3500:9e22 with SMTP id
 g4-20020a1709026b4400b001b535009e22mr16457820plt.63.1687426455951; 
 Thu, 22 Jun 2023 02:34:15 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] target/ppc: Add support for SMT CTRL register
Date: Thu, 22 Jun 2023 19:33:52 +1000
Message-Id: <20230622093357.255649-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

A relatively simple case to begin with, CTRL is a SMT shared register
where reads and writes need to synchronise against state changes by
other threads in the core.

Atomic serialisation operations are used to achieve this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h      |  2 ++
 target/ppc/misc_helper.c | 25 +++++++++++++++++++++++++
 target/ppc/translate.c   | 18 +++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 38efbc351c..fda40b8a60 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -704,6 +704,8 @@ DEF_HELPER_3(store_dcr, void, env, tl, tl)
 
 DEF_HELPER_2(load_dump_spr, void, env, i32)
 DEF_HELPER_2(store_dump_spr, void, env, i32)
+DEF_HELPER_3(spr_write_CTRL, void, env, i32, tl)
+
 DEF_HELPER_4(fscr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_4(msr_facility_check, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 40ddc5c08c..a058eb24cd 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -43,6 +43,31 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
              env->spr[sprn]);
 }
 
+void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
+                           target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t run = val & 1;
+    uint32_t ts, ts_mask;
+
+    assert(sprn == SPR_CTRL);
+
+    env->spr[sprn] &= ~1U;
+    env->spr[sprn] |= run;
+
+    ts_mask = ~(1U << (8 + env->spr[SPR_TIR]));
+    ts = run << (8 + env->spr[SPR_TIR]);
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+
+        cenv->spr[sprn] &= ts_mask;
+        cenv->spr[sprn] |= ts;
+    }
+}
+
+
 #ifdef TARGET_PPC64
 static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
                                   const char *caller, uint32_t cause,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5d585393c5..41a8b800bd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -438,7 +438,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
-void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
     TCGv t0 = tcg_temp_new();
@@ -447,6 +447,22 @@ void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
     tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
     tcg_gen_or_tl(t1, t1, t0);
     gen_store_spr(sprn, t1);
+}
+
+void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!(ctx->flags & POWERPC_FLAG_SMT)) {
+        spr_write_CTRL_ST(ctx, sprn, gprn);
+        goto out;
+    }
+
+    if (!gen_serialize(ctx)) {
+        return;
+    }
+
+    gen_helper_spr_write_CTRL(cpu_env, tcg_constant_i32(sprn),
+                              cpu_gpr[gprn]);
+out:
     spr_store_dump_spr(sprn);
 
     /*
-- 
2.40.1


