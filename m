Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8977D456
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0mc-0006PI-PJ; Tue, 15 Aug 2023 16:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0ma-0006Oa-QV
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:52 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mY-00010E-J5
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:52 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bca3311b4fso4659985a34.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692131809; x=1692736609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMF4Q4ITgWSSf76MEiWmMEnjXUjRJvO71HoFus2BTWE=;
 b=opNIuWC8smOSY5jgBUxGCpm54wQX+YZosRAgvCgXz8pvCg69wxHaRs0KgxyO6WsyTB
 UuvJaV9YPIURuMBHkzae/s7j3omZ3QUN6kh1SDuYUOWDNsyeQIzWzGTMzUvRAyPK3TqZ
 n6OyzGFHaL/M6cg/Gp7bO+Nc3NuywDT+0pW/1x3nAunUHnsFK0SLPWTM5JnNzV7udG1U
 kjh9+NuF0hk+cyIDOXbgod5j+2asoyDloapZ0UYf1bujfJgTg/oyYJ5YQZE0snpNxX4J
 bCInb657YaPgYmTgzXOrv2hhmRP5FnFXZ1VSuuh19nHfkrR5AOcrxqASMH7xYLhJ8yKg
 g3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131809; x=1692736609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMF4Q4ITgWSSf76MEiWmMEnjXUjRJvO71HoFus2BTWE=;
 b=f5WmZtIoBdameJQjzoU//VW5kP6b+uURK8DjlNyHkVCxaR9zCICzo9L9Cfj/5+TVVs
 3q3uRxl8dCpzT7Iyryp+kBPSrEigGF3AxfUlP8ZZqMBnbTlIkKrt6QPj1QOa4fab8YpI
 zEYg+OqPgCS3dRGxNssr/D5YS+HyZTSIvny0+LLmVMgPmHNJrPfOQQk7eP9/TdVgng3S
 0DZarH+BBMaOV5x1wFft8agjVeehMhc6W4nFsSyvxi58bM/dld7oZBZbyjpuqPymg9JL
 umXqW76HxE277yM2CAqB98LzmTTouoPVakjWS3bRoZI5zrGKz0dO4o/+3naWp0yJhA92
 Pisw==
X-Gm-Message-State: AOJu0YxeabiMMz2cd5DsC5fZxP62z1sbvzBSmDwb67SAn1BfFq851tGP
 qQJg81bsUScYhHRxrqWKrJ48jh1COyradAomP8s=
X-Google-Smtp-Source: AGHT+IFw9EeW8MWavW0JOuYCbudQTGG95jr6Fx/C//nTr/PBt7EaGd9zwa3AQV2c/JLAG/iO/yG0Uw==
X-Received: by 2002:a9d:7d91:0:b0:6ba:865b:ca72 with SMTP id
 j17-20020a9d7d91000000b006ba865bca72mr12723246otn.31.1692131809262; 
 Tue, 15 Aug 2023 13:36:49 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a0568301bcf00b006b94fb2762asm5526849ota.23.2023.08.15.13.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:36:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/8] target/riscv/cpu.c: introduce cpu_cfg_ext_auto_update()
Date: Tue, 15 Aug 2023 17:36:30 -0300
Message-ID: <20230815203635.400179-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815203635.400179-1-dbarboza@ventanamicro.com>
References: <20230815203635.400179-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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

During realize() time we're activating a lot of extensions based on some
criteria, e.g.:

    if (cpu->cfg.ext_zk) {
        cpu->cfg.ext_zkn = true;
        cpu->cfg.ext_zkr = true;
        cpu->cfg.ext_zkt = true;
    }

This practice resulted in at least one case where we ended up enabling
something we shouldn't: RVC enabling zca/zcd/zcf when using a CPU that
has priv_spec older than 1.12.0.

We're also not considering user choice. There's no way of doing it now
but this is about to change in the next few patches.

cpu_cfg_ext_auto_update() will check for priv version mismatches before
enabling extensions. If we have a mismatch between the current priv
version and the extension we want to enable, do not enable it. In the
near future, this same function will also consider user choice when
deciding if we're going to enable/disable an extension or not.

For now let's use it to handle zca/zcd/zcf enablement if RVC is enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ca20dc1e96..371317e7cc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -166,6 +166,44 @@ static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
     *ext_enabled = en;
 }
 
+static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
+        if (isa_edata_arr[i].ext_enable_offset != ext_offset) {
+            continue;
+        }
+
+        return isa_edata_arr[i].min_version;
+    }
+
+    /* Default to oldest priv spec if no match found */
+    return PRIV_VERSION_1_10_0;
+}
+
+static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
+                                    bool value)
+{
+    CPURISCVState *env = &cpu->env;
+    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
+    int min_version;
+
+    if (prev_val == value) {
+        return;
+    }
+
+    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
+        /* Do not enable it if priv_ver is older than min_version */
+        min_version = cpu_cfg_ext_get_min_version(ext_offset);
+        if (env->priv_ver < min_version) {
+            return;
+        }
+    }
+
+    isa_ext_update_enabled(cpu, ext_offset, value);
+}
+
 const char * const riscv_int_regnames[] = {
     "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
     "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
@@ -1246,12 +1284,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 
     /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
-        cpu->cfg.ext_zca = true;
+        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
         if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
-            cpu->cfg.ext_zcf = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
         if (riscv_has_ext(env, RVD)) {
-            cpu->cfg.ext_zcd = true;
+            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
         }
     }
 
-- 
2.41.0


