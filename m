Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D01741E1F
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhDQ-000315-Ey; Wed, 28 Jun 2023 22:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDM-00030X-8L; Wed, 28 Jun 2023 22:16:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDK-0003vv-JA; Wed, 28 Jun 2023 22:16:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-666e64e97e2so137694b3a.1; 
 Wed, 28 Jun 2023 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688005012; x=1690597012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rkGdZzz8N4Sv2AShwYiATwcYhKmifYVckbvYFgsHAI=;
 b=jNByoFUGurheJIs4m3/3b2yU8OCDtIIjz/++GcqMWtra6+a7Ekua+enK69gEFaszO3
 0qWCOZtkT5jRxrPnwoj8gkMqbwXlJT4Apa4YH+mjkZQhkhCGXAUaoZaXpNMe49tIyoPT
 2hMsC7Gz+6q9rTrAbEwv+MHGJkJwQj/Q528q/BLOQwCrK2BO4b0HrnoHD896KwoE8ZK1
 4dC9mNg6DtWB4+XI1li2CjCB8KdUuj7PowIFnzQmYdiORUb+bFnf+fs0ARAZXIfpbIh5
 OJtj5Uci7azaRbPlbFEqDPSwvjj2aGfg6xkx7vetgUB7ZS4OjAZRZWHJzgd/ovUsYTpF
 bApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688005012; x=1690597012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rkGdZzz8N4Sv2AShwYiATwcYhKmifYVckbvYFgsHAI=;
 b=kmA+LymvMoLo6/DUIREoeMT/zBY8FWw0YE/sPJn0QWbS8YfxmeywHsfun6dm78toVy
 grAgsj7IWC8PxwgQTnzkfZE2op6AcP1zCtbcxwGCMuIGl71lJMil1hWRQ8Dq9jc77SHO
 kSoQkids48L5cKxObfKoAp6h+bugL57GaAHJUC96Mg33armkOzW8nurOc+qp/0Y7n7mH
 cnmsa02E+VqAsNouuQ/Dm6u7Jx1d+IkdXG8ZAHSi6v/rpbJpylJs8AIw6Ty1x/HkfqjD
 5WwXV2giri5YgEMBdDX34VbJcnJ5Mm8Dm4576JNbQWJFyoBEBIEhDBkMF7PC6r77+5f4
 Jvmg==
X-Gm-Message-State: AC+VfDxh5mhLh2SO3lHDNEQ28tCAMdSvtTZSJJNtT3GHn+7CS9DVDyf+
 DTLy/EqhbQ7opFDNfmdKt1XJ+mTePnU=
X-Google-Smtp-Source: ACHHUZ7cQymr/Xd4OMSIUaWIIpkHk2e7s7HcmYNXhae95fJsRLt5T6fJmqxbEAidQyTpuRA+EcgB+g==
X-Received: by 2002:a05:6a20:1053:b0:127:824b:a71 with SMTP id
 gt19-20020a056a20105300b00127824b0a71mr7530564pzc.61.1688005012633; 
 Wed, 28 Jun 2023 19:16:52 -0700 (PDT)
Received: from wheely.local0.net ([125.254.1.121])
 by smtp.gmail.com with ESMTPSA id
 5-20020aa79145000000b0063b96574b8bsm7480123pfi.220.2023.06.28.19.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 19:16:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH 2/3] target/ppc: SMT support for the HID SPR
Date: Thu, 29 Jun 2023 12:16:32 +1000
Message-Id: <20230629021633.328916-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629021633.328916-1-npiggin@gmail.com>
References: <20230629021633.328916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c    |  2 +-
 target/ppc/helper.h      |  1 +
 target/ppc/misc_helper.c | 21 +++++++++++++++++++++
 target/ppc/spr_common.h  |  1 +
 target/ppc/translate.c   | 16 ++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index dc3a65a575..a1b01dc479 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5373,7 +5373,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fda40b8a60..719752b38a 100644
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
index 4c0f2bed77..aae66ee966 100644
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
index ef186396b4..f7a5ecc0c1 100644
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


