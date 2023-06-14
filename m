Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30272F1D7
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCI-0004iN-MW; Tue, 13 Jun 2023 21:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCF-0004hs-SA
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCE-0004Ve-23
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so6201860b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705672; x=1689297672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFtv0eonpae4ybQ/RQvPpuIYbe2J3nMJEQYdMUSx6EY=;
 b=nuHgxfnZIU/RKiGn1OTjeklsrWQaY9NR4N/h1c+2UL76UChVf4Eod21S7z5Ol58o20
 pljay86y8e/Y8VJfCf0IpnVd68CdQ6jcxzqfuvbrg1+tKYKYG6UsRZ1XHG1BLvuwkHfC
 PNOD8jxgyla5oHbOwPoZCP9RflUKJTJO8MPXF61+WjrrdToPs+tHL16xb6YxeGEiLjdz
 rb06PwULcUxWnFtlJM9NZ9UdBpKTJjnifYki3IXBNBUhapGKwDs+jCDofvEGWI4v5uCM
 6xOYjN7kR4HFewzkSgHaz+ZzTFurh/Z8VURnLakL4sftOiVL53Rzg6V9+NGSZwifw4Ng
 aiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705672; x=1689297672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFtv0eonpae4ybQ/RQvPpuIYbe2J3nMJEQYdMUSx6EY=;
 b=fGwxhfpK+rOqmiYSePsTjZ8PlOIWP94VCP+3ogwFeErOSEv5jSiLzI75dpsyJza+V1
 VPvU0NLmLHsMaq2qpLzBJmb+OKE43UufYwTIPE6oAR3AgbnlsSX4vePxsTdlQlEn06E/
 zivD7XBFe8j73EbawSk3UCQ74JlnGk89qmzJEfv9poN0jYeODuDbIG9ILi2bePH0OUI7
 3jjoSWzOkZRnglF2JnFDzvDWz+zQdo/WGMeB0ZVvgCVJSvj81g0iuXIqm7wt0l24SfEW
 1Z7lulp/ZPQYhlvxtzi3ZD/2zLt6GLI3U+BZ/ZClI+uYv36BcSRyU2Nls4P3wXWDVqnR
 n1gg==
X-Gm-Message-State: AC+VfDytmkSFrvZxXmt1dfDKZ46cYHmIH9a01gRAhyymIMXICcC84tDA
 tFS25UTRJ/UXu5KPhXkLQe5ZVRywVmCq0Q==
X-Google-Smtp-Source: ACHHUZ513YkBfp6Tx6KwneLvgrBUN30uhyjY25HmN6/QpKtOLhLeLbHFhg/wuyPt7RUZRnS0AiYUrg==
X-Received: by 2002:a05:6a00:1148:b0:64f:e997:5107 with SMTP id
 b8-20020a056a00114800b0064fe9975107mr627653pfm.1.1686705672458; 
 Tue, 13 Jun 2023 18:21:12 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/60] target/riscv/cpu.c: add priv_spec validate/disable_exts
 helpers
Date: Wed, 14 Jun 2023 11:19:26 +1000
Message-Id: <20230614012017.3100663-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're doing env->priv_spec validation and assignment at the start of
riscv_cpu_realize(), which is fine, but then we're doing a force disable
on extensions that aren't compatible with the priv version.

This second step is being done too early. The disabled extensions might be
re-enabled again in riscv_cpu_validate_set_extensions() by accident. A
better place to put this code is at the end of
riscv_cpu_validate_set_extensions() after all the validations are
completed.

Add a new helper, riscv_cpu_disable_priv_spec_isa_exts(), to disable the
extesions after the validation is done. While we're at it, create a
riscv_cpu_validate_priv_spec() helper to host all env->priv_spec related
validation to unclog riscv_cpu_realize a bit.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 91 ++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 81a785d525..a0589abb16 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -864,6 +864,52 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     env->vext_ver = vext_version;
 }
 
+static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    int priv_version = -1;
+
+    if (cpu->cfg.priv_spec) {
+        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
+            priv_version = PRIV_VERSION_1_12_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
+            priv_version = PRIV_VERSION_1_11_0;
+        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
+            priv_version = PRIV_VERSION_1_10_0;
+        } else {
+            error_setg(errp,
+                       "Unsupported privilege spec version '%s'",
+                       cpu->cfg.priv_spec);
+            return;
+        }
+
+        env->priv_ver = priv_version;
+    }
+}
+
+static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    int i;
+
+    /* Force disable extensions if priv spec version does not match */
+    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
+        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i]) &&
+            (env->priv_ver < isa_edata_arr[i].min_version)) {
+            isa_ext_update_enabled(cpu, &isa_edata_arr[i], false);
+#ifndef CONFIG_USER_ONLY
+            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+                        " because privilege spec version does not match",
+                        isa_edata_arr[i].name, env->mhartid);
+#else
+            warn_report("disabling %s extension because "
+                        "privilege spec version does not match",
+                        isa_edata_arr[i].name);
+#endif
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -1082,6 +1128,12 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zksed = true;
         cpu->cfg.ext_zksh = true;
     }
+
+    /*
+     * Disable isa extensions based on priv spec after we
+     * validated and set everything we need.
+     */
+    riscv_cpu_disable_priv_spec_isa_exts(cpu);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1181,7 +1233,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     CPUClass *cc = CPU_CLASS(mcc);
-    int i, priv_version = -1;
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -1190,23 +1241,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (cpu->cfg.priv_spec) {
-        if (!g_strcmp0(cpu->cfg.priv_spec, "v1.12.0")) {
-            priv_version = PRIV_VERSION_1_12_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.11.0")) {
-            priv_version = PRIV_VERSION_1_11_0;
-        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
-            priv_version = PRIV_VERSION_1_10_0;
-        } else {
-            error_setg(errp,
-                       "Unsupported privilege spec version '%s'",
-                       cpu->cfg.priv_spec);
-            return;
-        }
-    }
-
-    if (priv_version >= PRIV_VERSION_1_10_0) {
-        env->priv_ver = priv_version;
+    riscv_cpu_validate_priv_spec(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
     }
 
     riscv_cpu_validate_misa_priv(env, &local_err);
@@ -1215,23 +1253,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* Force disable extensions if priv spec version does not match */
-    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i]) &&
-            (env->priv_ver < isa_edata_arr[i].min_version)) {
-            isa_ext_update_enabled(cpu, &isa_edata_arr[i], false);
-#ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
-                        " because privilege spec version does not match",
-                        isa_edata_arr[i].name, env->mhartid);
-#else
-            warn_report("disabling %s extension because "
-                        "privilege spec version does not match",
-                        isa_edata_arr[i].name);
-#endif
-        }
-    }
-
     if (cpu->cfg.epmp && !cpu->cfg.pmp) {
         /*
          * Enhanced PMP should only be available
-- 
2.40.1


