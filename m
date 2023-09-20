Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBF7A7A66
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivH1-0006nj-6O; Wed, 20 Sep 2023 07:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGu-0006ml-9t
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:33 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGs-0002Je-Oi
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:32 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1d544a4a315so4274639fac.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208889; x=1695813689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sZfZHqt2jnUylehekGfpy+3Is34Ky+f68MpC7nUPlE=;
 b=nVBYR1suCo40nUHlyvQbmrv5NPxxoUzOUtvIWJWMW+UYdeX7wm0xVsNa7gFGgDXhXJ
 bAxfk4wu/WwKwK3ixbov+lUb2EYA+eh49dpCk7tiSmY0SF+ypwlgqtPuge5aHQ/bDV/Y
 hYYcu947ZfGGCeKMd2vTCIKweRhQpPC/i3Ca3gHm97YjOC9q4hYz3TvpXfDLTPGJaVLv
 933PhLBswchH0sz5A6hApUEN98Dll3HDsERTa3CSJufIyEcM9nNTMLFcMWU9R/bNklDO
 1JpZP1NrQw9zJJDBnNgMWUgfpbzCuPTYRIFaMTVp1QGeMmApdKv2SeoGi1T59tPG8sIj
 DijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208889; x=1695813689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sZfZHqt2jnUylehekGfpy+3Is34Ky+f68MpC7nUPlE=;
 b=Rorg1/SdlEzuejS33RPD2p2pRxyKsVPxJwrVmpR8uPNAIp5mk+onWaAWMpxFu7YOQN
 9mzcPl4qhuy456xUym6WTO/Y36MAyMld0Jmnp86gCHO+2AEE6/X0LypZ7rXSCwAGoyha
 4nnl/uygQsYIDOa9Mw4VVILcwkYApVsQQKofHaxLxnQll8G4/WlLJYhmrrT+ogKiz94e
 lM3NiqkBmSio5ox4d8//FzmbEKDypj4u7xSO06bhJEqGSizKzV0Tcc/ON8hgEmlTJSkI
 X3DKMMqFxse/lGzJ14kC2gemjtSYZN8trtuUIltzf+CzNMiGjyhf0uggvT3RJI/E4rhK
 M4aw==
X-Gm-Message-State: AOJu0Yz8v0T8oQlRJHZ/8zglEyb+dgiMlMLyCUTc4svmoX9qV1149wZJ
 mLRppq3T1ZQIFLn3fjr7o9T5BgPAl/jL7Aw6WYQ=
X-Google-Smtp-Source: AGHT+IFSU3C1ewkYbQO7Jb9I++mfmHjae7FRnEHtkjjXwJw0ZDFVrCXnzupXoraRmqqGmP4BYDqbww==
X-Received: by 2002:a05:6870:4189:b0:1db:71b9:419c with SMTP id
 y9-20020a056870418900b001db71b9419cmr2423712oac.58.1695208889332; 
 Wed, 20 Sep 2023 04:21:29 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:21:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 19/19] target/riscv/cpu: move priv spec functions to
 tcg-cpu.c
Date: Wed, 20 Sep 2023 08:20:20 -0300
Message-ID: <20230920112020.651006-20-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Priv spec validation is TCG specific. Move it to the TCG accel class.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         | 38 --------------------------------------
 target/riscv/cpu.h         |  2 --
 target/riscv/tcg/tcg-cpu.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e97ba3df93..eeeb08a35a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -172,21 +172,6 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en)
     *ext_enabled = en;
 }
 
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
-{
-    const RISCVIsaExtData *edata;
-
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (edata->ext_enable_offset != ext_offset) {
-            continue;
-        }
-
-        return edata->min_version;
-    }
-
-    g_assert_not_reached();
-}
-
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -925,29 +910,6 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-{
-    CPURISCVState *env = &cpu->env;
-    const RISCVIsaExtData *edata;
-
-    /* Force disable extensions if priv spec version does not match */
-    for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
-            (env->priv_ver < edata->min_version)) {
-            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-#ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
-                        " because privilege spec version does not match",
-                        edata->name, env->mhartid);
-#else
-            warn_report("disabling %s extension because "
-                        "privilege spec version does not match",
-                        edata->name);
-#endif
-        }
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3dfcd0732f..219fe2e9b5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -711,9 +711,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-int cpu_cfg_ext_get_min_version(uint32_t ext_offset);
 void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
-void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu);
 
 typedef struct RISCVCPUMultiExtConfig {
     const char *name;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c326ab37a2..8c052d6fcd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -99,6 +99,21 @@ static const struct TCGCPUOps riscv_tcg_ops = {
 #endif /* !CONFIG_USER_ONLY */
 };
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    const RISCVIsaExtData *edata;
+
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return edata->min_version;
+    }
+
+    g_assert_not_reached();
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -226,6 +241,29 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVIsaExtData *edata;
+
+    /* Force disable extensions if priv spec version does not match */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
+            (env->priv_ver < edata->min_version)) {
+            isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+#ifndef CONFIG_USER_ONLY
+            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+                        " because privilege spec version does not match",
+                        edata->name, env->mhartid);
+#else
+            warn_report("disabling %s extension because "
+                        "privilege spec version does not match",
+                        edata->name);
+#endif
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
-- 
2.41.0


