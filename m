Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE377DD72C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:41:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvXG-0005i0-Os; Tue, 31 Oct 2023 16:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvXF-0005fT-Cc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:40:25 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvWv-0007qG-CX
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:40:24 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5afbdbf3a19so48359707b3.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698784803; x=1699389603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1Aw/s1mLGFE+aoFUjR/zC1aJeCADint+2JxRStn8Gw=;
 b=OLR04Lq/9HyEp12bhaGDK5+S+mBmrA7WgH89AxpP/ohPJFiKzU0FXYfyMf2zzo7mpE
 pvOMTnsX2aOLTzjb9CdULf5QAju9fTctYpNyOfJv12nAqD92jku2+iYFpZ8RZAFDKAGw
 SStop8/t4zyBz0yHg7JU758244PKXQXMSJ4C6euDL4FOjJ/15ysRIJ5hp2HQclibOsJ2
 Js8M+8DF/x8Jq6slhvAHJxT3z7F0AdUykUQI2zAStG+LVfHCBvfApKJ146H45cAfQviw
 xRcYk6mJ3Z0H5VQHgWdnucRAIySu0a1vDHT5RfmCh4bEIIjz2qw5ssphqtK/y6sSL0vD
 65yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698784803; x=1699389603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1Aw/s1mLGFE+aoFUjR/zC1aJeCADint+2JxRStn8Gw=;
 b=MpJX0xgbSiRzoG+KBvieSPqk9JgqA2XGgakwqkWAk3pHh4uAczA/PBsPsHAZZrOcCX
 QKaNapT4+m1bTTuCIgDWTaeuKQFobP7jUPCwOQCnRqxHNcuBCq6ExAs6Xcm8oHiCGu+7
 oJuUCLPWn7SPSOBKFPF+BqOY/wEhZ455xUKNvoTgz0bg8ksRHDUezV+xeKxu5g7PKYxb
 TpIwpZkT998naqA2hD7uPn/c1oMTgClfd2mBg5YkwcfIAi+08t95cPZHKB1rMiI208dK
 4oDvTDUquawbvTtIx1Et9AGtV3ja2ffavsg4xQwgNsXHclXRGjwWVdTCay63B5l6FF0Y
 cOcg==
X-Gm-Message-State: AOJu0Yz/S5puRDKANggP6Rzq1VR0OgUel4PDOeXSCqjtFDghhI8M2znH
 pPIAlNxD/hESd+4tzhbWQS/I7yvWyvCoVf3/kD8=
X-Google-Smtp-Source: AGHT+IGnSBisuexZDEblnmJChYFM54JitLnLlWIJkGCa/i0PXBG6YgG/Z5o3Wk+LDMgGVxrRugSu1w==
X-Received: by 2002:a05:690c:6:b0:59b:ce0b:7829 with SMTP id
 bc6-20020a05690c000600b0059bce0b7829mr16170094ywb.35.1698784803510; 
 Tue, 31 Oct 2023 13:40:03 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 k1-20020a81ff01000000b005add997ae53sm1272802ywn.81.2023.10.31.13.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 13:40:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 14/16] target/riscv/tcg: honor user choice for G MISA bits
Date: Tue, 31 Oct 2023 17:39:14 -0300
Message-ID: <20231031203916.197332-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031203916.197332-1-dbarboza@ventanamicro.com>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

RVG behaves like a profile: a single flag enables a set of bits. Right
now we're considering user choice when handling RVG and zicsr/zifencei
and ignoring user choice on MISA bits.

We'll add user warnings for profiles when the user disables its
mandatory extensions in the next patch. We'll do the same thing with RVG
now to keep consistency between RVG and profile handling.

First and foremost, create a new RVG only helper to avoid clogging
riscv_cpu_validate_set_extensions(). We do not want to annoy users with
RVG warnings like we did in the past (see 9b9741c38f), thus we'll only
warn if RVG was user set and the user disabled a RVG extension in the
command line.

For every RVG MISA bit (IMAFD), zicsr and zifencei, the logic then
becomes:

- if enabled, do nothing;
- if disabled and not user set, enable it;
- if disabled and user set, throw a warning that it's a RVG mandatory
  extension.

This same logic will be used for profiles in the next patch.

Note that this is a behavior change, where we would error out if the
user disabled either zicsr or zifencei. As long as users are explicitly
disabling things in the command line we'll let them have a go at it, at
least in this step. We'll error out later in the validation if needed.

Other notable changes from the previous RVG code:

- use riscv_cpu_write_misa_bit() instead of manually updating both
  env->misa_ext and env->misa_ext_mask;

- set zicsr and zifencei directly. We're already checking if they
  were user set and priv version will never fail for these
  extensions, making cpu_cfg_ext_auto_update() redundant.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 73 +++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9127249f85..544f6dd01d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,12 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static bool cpu_misa_ext_is_user_set(uint32_t misa_bit)
+{
+    return g_hash_table_contains(misa_ext_user_opts,
+                                 GUINT_TO_POINTER(misa_bit));
+}
+
 static void cpu_cfg_ext_add_user_opt(uint32_t ext_offset, bool value)
 {
     g_hash_table_insert(multi_ext_user_opts, GUINT_TO_POINTER(ext_offset),
@@ -303,6 +309,46 @@ static void riscv_cpu_validate_named_features(RISCVCPU *cpu)
     riscv_cpu_validate_zic64b(cpu);
 }
 
+static void riscv_cpu_validate_g(RISCVCPU *cpu)
+{
+    const char *warn_msg = "RVG mandates disabled extension %s";
+    uint32_t g_misa_bits[] = {RVI, RVM, RVA, RVF, RVD};
+    bool send_warn = cpu_misa_ext_is_user_set(RVG);
+
+    for (int i = 0; i < ARRAY_SIZE(g_misa_bits); i++) {
+        uint32_t bit = g_misa_bits[i];
+
+        if (riscv_has_ext(&cpu->env, bit)) {
+            continue;
+        }
+
+        if (!cpu_misa_ext_is_user_set(bit)) {
+            riscv_cpu_write_misa_bit(cpu, bit, true);
+            continue;
+        }
+
+        if (send_warn) {
+            warn_report(warn_msg, riscv_get_misa_ext_name(bit));
+        }
+    }
+
+    if (!cpu->cfg.ext_zicsr) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
+            cpu->cfg.ext_zicsr = true;
+        } else if (send_warn) {
+            warn_report(warn_msg, "zicsr");
+        }
+    }
+
+    if (!cpu->cfg.ext_zifencei) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
+            cpu->cfg.ext_zifencei = true;
+        } else if (send_warn) {
+            warn_report(warn_msg, "zifencei");
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -312,31 +358,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    /* Do some ISA extension error checking */
-    if (riscv_has_ext(env, RVG) &&
-        !(riscv_has_ext(env, RVI) && riscv_has_ext(env, RVM) &&
-          riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
-          riscv_has_ext(env, RVD) &&
-          cpu->cfg.ext_zicsr && cpu->cfg.ext_zifencei)) {
-
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr)) &&
-            !cpu->cfg.ext_zicsr) {
-            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
-            return;
-        }
-
-        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei)) &&
-            !cpu->cfg.ext_zifencei) {
-            error_setg(errp, "RVG requires Zifencei but user set "
-                       "Zifencei to false");
-            return;
-        }
-
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zicsr), true);
-        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zifencei), true);
-
-        env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
-        env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
+    if (riscv_has_ext(env, RVG)) {
+        riscv_cpu_validate_g(cpu);
     }
 
     if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
-- 
2.41.0


