Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A7A72247D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68JU-00078B-DS; Mon, 05 Jun 2023 07:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JR-00077O-2f; Mon, 05 Jun 2023 07:23:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q68JP-00066U-EG; Mon, 05 Jun 2023 07:23:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so3175451a12.0; 
 Mon, 05 Jun 2023 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685964225; x=1688556225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjkZbg9Jxz2kaGuv+trv2y8Cheu0swrBg+6WArpM8KE=;
 b=JLfMDTnj46qff70DtLM7g5RMpU3Q7ZNGGRsXpsNx/79l3+hkw0gPHofHYzjHwPXJlF
 Smtq0bGATTTHNHHRJME+ysHDRBRrIP9hXrTLVB+KQys9ucfTkJl6UgqG0Vzfe7QGbdRE
 g8447mNZsqLN+27K+r63BG9UFgyFKV7IfjJHT0idCX0a63ozMo7xyzelarDnVFkURp7Y
 ouLxjloib0OCyIinvAe4VACJ2ICq2dh6yORvkCONIIudpMqMaW1CvM1mdFMvd0o8Vf7v
 h6umUXr1NRnvR797NdYSapFxTMHLoNPx3KLVmAcT0Pp4dQwNcncDq1CYSbSvnzvKDN0V
 OgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964225; x=1688556225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjkZbg9Jxz2kaGuv+trv2y8Cheu0swrBg+6WArpM8KE=;
 b=eaupug0zwJluOOK9ImnB65Wvg39QehxVjh9J01kL9oYl8Vv+9Io4zMB8xWkyCKP3cA
 Fkc4ks93DUxOlNg3QacKksStb3O4HxqwS7kHT8nAk5maaRtSpejPwXj4hCmdltcHWa0f
 +Lu9f+BJWMUuakPNbD7XQCTO5/lg3vzHtR4bw7g7BQwC9Ojya9eIdPEgr26ehI4mhZxf
 tvremdxlThb4sm7gtkAohef2RPk3V4Klt715k8lngsuTcOjKTIxv8txKzCowRZizbowv
 VlM09XdixgpWAzre8AW2b7TG1CIX2RaiSxg4uRHYzgBP3u8YVl6PAWagQ3yfzGtl9S3M
 JddA==
X-Gm-Message-State: AC+VfDz/QMCMwXJCmKFpViOjphYJ1r3a4ECRtA3HxRdQhngQHrRJzDw+
 53dxGoWSmqgQLdEIac+dx2mFjjoTW4c=
X-Google-Smtp-Source: ACHHUZ4LylF0d2YJTn3mx5y43eyrlq1tMEHAApQhoJQq36yRachsNc1cAZikggigwevZw6dNIxzBqg==
X-Received: by 2002:a17:90a:1197:b0:259:71f6:f82d with SMTP id
 e23-20020a17090a119700b0025971f6f82dmr1450731pja.10.1685964225149; 
 Mon, 05 Jun 2023 04:23:45 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a17090a702300b0024e026444b6sm15953385pjk.2.2023.06.05.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:23:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] target/ppc: Add support for SMT CTRL register
Date: Mon,  5 Jun 2023 21:23:21 +1000
Message-Id: <20230605112323.179259-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605112323.179259-1-npiggin@gmail.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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


