Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE09745A02
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGdI-0001YH-5l; Mon, 03 Jul 2023 06:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGce-0000Rz-2r; Mon, 03 Jul 2023 06:17:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcW-0000vs-F0; Mon, 03 Jul 2023 06:17:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666e97fcc60so2433225b3a.3; 
 Mon, 03 Jul 2023 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688379443; x=1690971443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBViwVhIYzu532EaMl3x0qE7yvkZKt8huP9izDEd8Mg=;
 b=X5n2trSOmUkNSxPQP2fb3cBMPsbET8APQ6T0s+u/Mr8U0qEYAmCsVxuCmIPSx4G1w1
 J6DDSvBZBY2rEF/+zxAa/w6ppxFphBYhmBrqzCzD1NPQsIPNctp5+UhI8zUuvJ5EbCM+
 GdpHh/TbsFr2X/uOjtzF8c5u+QYHYHI5mJm1Gwzzr9YyC8Ygl1S8OQwxGdxTkYzeUmu3
 PjBLc8CNaTSA5IwvQDb0VRUrsHJ+pJ2vT3DPbA+HuWw5tBqdAGypShZKuAeCt4K05Pch
 wEUe0p6r/y8w9Zp4TJG2sGFS80FuVU6b5F5FWa/IIs76OvmwVzPNGikjDhm5rhv63gJ6
 0qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379443; x=1690971443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBViwVhIYzu532EaMl3x0qE7yvkZKt8huP9izDEd8Mg=;
 b=cEKkWp3J9IZunyEii1271Irh6n4jX/odp3dPs5wWd4oT4O9ess5UO9ajK1jedNZoBe
 NKfD9BH32xvzoNYuO+P6BcvATv0nv5XKF22qX+VPZbSVZZQli/RCBd7F6CpSNGH+fxM5
 Oxo5+AT5mf31jShz1wW4ymd06qj+qreRa6uJ+/hAqsAERgxQU06jCPK1KtpqavQjVDOr
 Nj/DbSYlcy/mwrFRzrwjLDhSGh5Mf124V43STNAO6VP54hYdaiBAoZxwgM+mQ5Tg52g2
 7hQ/wrdsFsqKGVjDrjR+Wsaqta01kN1I1abFZpXOMESXs3qhh8dMWsmb+W4M3HAmiXj0
 cXOQ==
X-Gm-Message-State: AC+VfDxyDLAVLdzrJWYco3kJ55JSE2rSvmFsT5TMoOJzBP2d4MT2eE8I
 akOfcQv7f8xwElJ0/szfgb0=
X-Google-Smtp-Source: ACHHUZ4+nGhPox82F7rSQKFRGvWS0Edahs5qynVxa4CtbWtBGpiNh1oAen63J9vW8+4lMaMN41OzeQ==
X-Received: by 2002:a05:6a20:7d81:b0:11f:4707:7365 with SMTP id
 v1-20020a056a207d8100b0011f47077365mr7046720pzj.38.1688379442719; 
 Mon, 03 Jul 2023 03:17:22 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 o2-20020aa79782000000b006826c9e4397sm3887727pfp.48.2023.07.03.03.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:17:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/ppc: SMT support for the HID SPR
Date: Mon,  3 Jul 2023 20:16:58 +1000
Message-Id: <20230703101700.24064-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703101700.24064-1-npiggin@gmail.com>
References: <20230703101700.24064-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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
index 1f1af21f33..0da335472e 100644
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
index 10598cde40..07c491df62 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -448,6 +448,22 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
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


