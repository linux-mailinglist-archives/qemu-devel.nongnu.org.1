Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED8706A48
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHep-0000x5-NJ; Wed, 17 May 2023 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHek-0000wg-TU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:30 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHei-0000UB-Ma
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:30 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3941c3ba226so558911b6e.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684331847; x=1686923847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/REJdOy6wXsH3mtIDXTGps7VFdkDX4BIyrwNm0mndU=;
 b=GNxPOLSCBpYmSC1jnYicd+yKlWg/bOxCwS3rJrbruocnHujrB+Ufkdc+Ql8KaZl01E
 40myg8kdnaRrd64iTE41sKUMMN9lGJ8eZTC1cs23tGj+LgZbfSnLtpgQms8pGbohUo6Q
 Fv/YkkWjqXyM2euUXFB8s7hOWm6x6yGGm7bnTun4nrT0G7fCIExwP537q/asjZgjiioa
 AhB7l13eENIVC/eTduaVn+o2EcPggbH7UtmlhUUFi2/Tx8wwMMEE1z1odeZYBZLen/nJ
 dac6u7ATTkfuSsF14769yscPKNSJaiAsHH1NwUYhWRQVRt+vgTxVge+xtX7k+YEZoEG4
 SUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684331847; x=1686923847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/REJdOy6wXsH3mtIDXTGps7VFdkDX4BIyrwNm0mndU=;
 b=cqofPFb+MoXyHP61zlyBU5A54nzvoKz7zx3K6/ngrn0MIy4vmN6MCKLsLkhGDl0SrO
 by+hjpF38LWKsUpwGQHBnycTQtXLp2vYOSWzjU3aTmOzIHYv1iB80Mm1CYdnVOe3d6JS
 GczmqVLNnvNC9HKkEaxihzavUj/g9G6hSsRp99xGkkcvcMJks9zk6qzXzPxWuMJezyRv
 +sYA5SB+E4+RyasutIEHCV+Ag0pPQiM2+LHDE3S/ByivVVcErJ7zwfR201lvKT0AydhD
 pAwsdOHbd74twznXEqnJFZpqSpRMU1DgVb7kVrP53I+YMYzIIZhWzWlWRBV8NHuqsGSO
 xw9g==
X-Gm-Message-State: AC+VfDyMSTi610BsxtsCJcfLVePvD+Eau7aY/x1XyoplTfzJpfScPiuI
 /UibvZS1cwCPuvmUqepPiIL4nT7OgyeirD/4c8g=
X-Google-Smtp-Source: ACHHUZ6MtgtoV5z9OXhkDo8wMsGY9JZM3wam0fMR/sliK3N7iP9pCuE5jixm7IfllCbuGzisKFhqzA==
X-Received: by 2002:a05:6808:140b:b0:396:4890:adc9 with SMTP id
 w11-20020a056808140b00b003964890adc9mr780432oiv.6.1684331847293; 
 Wed, 17 May 2023 06:57:27 -0700 (PDT)
Received: from grind.. (189-46-207-53.dsl.telesp.net.br. [189.46.207.53])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a544815000000b00383d9700294sm9409562oij.40.2023.05.17.06.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 06:57:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 01/11] target/riscv/cpu.c: add riscv_cpu_validate_v()
Date: Wed, 17 May 2023 10:57:04 -0300
Message-Id: <20230517135714.211809-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517135714.211809-1-dbarboza@ventanamicro.com>
References: <20230517135714.211809-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The RVV verification will error out if fails and it's being done at the
end of riscv_cpu_validate_set_extensions(), after we've already set some
extensions that are dependent on RVV.  Let's put it in its own function
and do it earlier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 89 +++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..4e6de82afa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -834,6 +834,46 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     }
 }
 
+static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
+                                 Error **errp)
+{
+    int vext_version = VEXT_VERSION_1_00_0;
+
+    if (!is_power_of_2(cfg->vlen)) {
+        error_setg(errp, "Vector extension VLEN must be power of 2");
+        return;
+    }
+    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
+        error_setg(errp,
+                   "Vector extension implementation only supports VLEN "
+                   "in the range [128, %d]", RV_VLEN_MAX);
+        return;
+    }
+    if (!is_power_of_2(cfg->elen)) {
+        error_setg(errp, "Vector extension ELEN must be power of 2");
+        return;
+    }
+    if (cfg->elen > 64 || cfg->elen < 8) {
+        error_setg(errp,
+                   "Vector extension implementation only supports ELEN "
+                   "in the range [8, 64]");
+        return;
+    }
+    if (cfg->vext_spec) {
+        if (!g_strcmp0(cfg->vext_spec, "v1.0")) {
+            vext_version = VEXT_VERSION_1_00_0;
+        } else {
+            error_setg(errp, "Unsupported vector spec version '%s'",
+                       cfg->vext_spec);
+            return;
+        }
+    } else {
+        qemu_log("vector version is not specified, "
+                 "use the default value v1.0\n");
+    }
+    set_vext_version(env, vext_version);
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -841,6 +881,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     /* Do some ISA extension error checking */
     if (riscv_has_ext(env, RVG) &&
@@ -909,8 +950,14 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    /* The V vector extension depends on the Zve64d extension */
     if (riscv_has_ext(env, RVV)) {
+        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        /* The V vector extension depends on the Zve64d extension */
         cpu->cfg.ext_zve64d = true;
     }
 
@@ -1045,46 +1092,6 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zksed = true;
         cpu->cfg.ext_zksh = true;
     }
-
-    if (riscv_has_ext(env, RVV)) {
-        int vext_version = VEXT_VERSION_1_00_0;
-        if (!is_power_of_2(cpu->cfg.vlen)) {
-            error_setg(errp,
-                       "Vector extension VLEN must be power of 2");
-            return;
-        }
-        if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
-            error_setg(errp,
-                       "Vector extension implementation only supports VLEN "
-                       "in the range [128, %d]", RV_VLEN_MAX);
-            return;
-        }
-        if (!is_power_of_2(cpu->cfg.elen)) {
-            error_setg(errp,
-                       "Vector extension ELEN must be power of 2");
-            return;
-        }
-        if (cpu->cfg.elen > 64 || cpu->cfg.elen < 8) {
-            error_setg(errp,
-                       "Vector extension implementation only supports ELEN "
-                       "in the range [8, 64]");
-            return;
-        }
-        if (cpu->cfg.vext_spec) {
-            if (!g_strcmp0(cpu->cfg.vext_spec, "v1.0")) {
-                vext_version = VEXT_VERSION_1_00_0;
-            } else {
-                error_setg(errp,
-                           "Unsupported vector spec version '%s'",
-                           cpu->cfg.vext_spec);
-                return;
-            }
-        } else {
-            qemu_log("vector version is not specified, "
-                     "use the default value v1.0\n");
-        }
-        set_vext_version(env, vext_version);
-    }
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.40.1


