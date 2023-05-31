Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B9717320
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYs-0004X4-Oc; Tue, 30 May 2023 21:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYq-0004Vr-BR; Tue, 30 May 2023 21:23:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYo-0005GL-Iz; Tue, 30 May 2023 21:23:35 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b011cffef2so45547075ad.3; 
 Tue, 30 May 2023 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496212; x=1688088212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7THcHMeqIyfPDBU+S2ZRpKhWMc/+eotNl8S7aVC4rm4=;
 b=ZslYyHF33StMioJuRIC07q8xcLeoD5lw1ixs2bCQFj2ptub8T2g+87eujDG1M43t0R
 SH4Uqx/KOJYarUY27VYO1PZrC3bvEf5WufiNN2LashOQ3Mm0xBjI3ANtW6DyX2EvmUXv
 +0ZYpeBSdSRBKSQJdSwb/wj2sl8BHhR5r0EVkeI8n/qwb4olfSrVmz/AdhrUxU/y6vGT
 mPHkssGF4kkV9zz9E2l+VBbnJrzPEjcIh3pYhXig1oTMY2z8EbW774uSML73DvZW67XU
 4YnipRdYOGA2qDOjZxBU8n29F/75VBXcxbDA0dfCOYyV7NKwKXBjQtn1hgtXEhY7II7a
 Lx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496212; x=1688088212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7THcHMeqIyfPDBU+S2ZRpKhWMc/+eotNl8S7aVC4rm4=;
 b=ibr6B3B2BLks9pNYt6xbhKant6s3KrHyE5nz71BIv/g5JfAgXkBX8cFtb0AmWmhJb4
 /ACyE8Zrhk8dBe3iCN16QPmXaXMGR6Dpc8/Pv90g5JIBVBXZjzTQxSARMNNQTlkZ2qTj
 0KFWV1QmPKDHDtZtQv0eXqNY24IWr6tP7EUzP9TQM8eSaw/I08XO990sWhVXCio5jkya
 6kthbzlLRreTffFLQJcL0huRfjWnRjd9DpB3nKT3mWZjg+vi5GG0CHCFHLiPAJq8Vfgi
 cJjgtYldPMudUblfNdW0/CFckEDweIdllJ92h8jsAOC4UTwbkgO1zB1Ku+VqDCRRAd5K
 hgAQ==
X-Gm-Message-State: AC+VfDwBMksSF8W13IIxnGj18GFFLymlamQE85RMkLHMUa/bAxxmoxVE
 kOT/evgyjCU+UGLbHj/bLg8SU5EnVKQ=
X-Google-Smtp-Source: ACHHUZ4R2l0HMqF1lGJOzt9qUolOColSV0oHUROpvBLFihSUzIzYbtpGEu97Ogyyi7Hjd2G0iyz6FA==
X-Received: by 2002:a17:903:22c2:b0:1b0:5a41:db40 with SMTP id
 y2-20020a17090322c200b001b05a41db40mr4579380plg.50.1685496212074; 
 Tue, 30 May 2023 18:23:32 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 3/5] target/ppc: Add support for SMT CTRL register
Date: Wed, 31 May 2023 11:23:11 +1000
Message-Id: <20230531012313.19891-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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
 target/ppc/misc_helper.c | 33 +++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 18 +++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

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
index 40ddc5c08c..ffe54a4310 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -43,6 +43,39 @@ void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
              env->spr[sprn]);
 }
 
+void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
+                           target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
+    uint32_t run = val & 1;
+    uint32_t ts, ts_mask;
+
+    assert(sprn == SPR_CTRL);
+    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
+
+    env->spr[sprn] &= ~1U;
+    env->spr[sprn] |= run;
+
+    ts_mask = ~(1U << (8 + env->spr[SPR_TIR]));
+    ts = run << (8 + env->spr[SPR_TIR]);
+
+    CPU_FOREACH(ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        uint32_t ccore_id = cenv->spr[SPR_PIR] & ~(nr_threads - 1);
+
+        assert(ccore_id == cenv->spr[SPR_PIR] - cenv->spr[SPR_TIR]);
+
+        if (ccore_id == core_id) {
+            cenv->spr[sprn] &= ts_mask;
+            cenv->spr[sprn] |= ts;
+        }
+    }
+}
+
+
 #ifdef TARGET_PPC64
 static void raise_hv_fu_exception(CPUPPCState *env, uint32_t bit,
                                   const char *caller, uint32_t cause,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 72270c2163..31821f92f5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -443,7 +443,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
-void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+static void spr_write_CTRL_ST(DisasContext *ctx, int sprn, int gprn)
 {
     /* This does not implement >1 thread */
     TCGv t0 = tcg_temp_new();
@@ -452,6 +452,22 @@ void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
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


