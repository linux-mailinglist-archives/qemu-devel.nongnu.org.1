Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0367D6DB2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:52:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHb-0001op-Ql; Wed, 25 Oct 2023 09:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHP-0001jV-Rk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveHM-00032l-49
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:39 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so38923695ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241833; x=1698846633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBSzGzcwpLiKb2w8/jCxaC2XkVgR4UUW7W4yRQDeZNU=;
 b=YIKcYm20ES1L9PM2yqA2KOqz+mMFqhs+M2ex0ZON5FgewomPvHoZTtgdSIOoMCdBXu
 u6s/nzhmZpmOOxxAJIiwcJxeE9HZEAEM1HGpy+6J3CESmP32UfEkjvGTOgnRJYrMxGBm
 F1iO4qJ4kkKa80wJLwHtP5mkgea1UNLSla333HUIQQcQImE+qgOOsrKlzdrzinvnJAqZ
 KIC4SkxXhiimFtCSRcSVYJF2jApTd72zZHTiT8yeCZASbR5onjgdxYtJP+pCrgq1Hoxg
 O3LK053QUOT4QHZDM9e4z0b3DUf6CG0FeF9j21weLG1PCoxhOLs0b2NZby13x90IhWkt
 xTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241833; x=1698846633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBSzGzcwpLiKb2w8/jCxaC2XkVgR4UUW7W4yRQDeZNU=;
 b=m6duaCDm5OJ/lTtPmCzyngRhubN/rx5xXtUk7Zrs9ae1Oq5IpCZxJmu+JGdfcp+jPO
 GpQLRRS+AdQlcxhX00+mA4417jNQ3pJXmccFvL9kvaFp8DB2zuuMXIMDQkT/JuzfL66M
 inRpsoNg5QgjqY7TqGhcHZIFY5pexdOmgtENViLeZkH4MhKOzfR8fnapENiOFQ1XclcN
 QmK9VWxCiBpIr4MdsRytG7o260pIR8ae/Shrlfi5CvvKcf9u0nKUruD2yn86oQ9o9SsR
 jGe5AQ3B6WBRiwoGQfXCcGYoJ7YosF++6i6CH/iqsJzzXwtD1/MVnuFFuygI4NflBEO4
 mQcA==
X-Gm-Message-State: AOJu0Ywc4rnGQ5d+KygHOd+mWLAXij1k03W/c1SBGiERtfT+md6FkRXu
 2yHSoVOvellG0D49zXIc+wos8IdV9+wjk8xvt0s=
X-Google-Smtp-Source: AGHT+IEV41L2k+8M2oK+0AaPMJQMmzEhwqJ1rFHm+WQor7Quk2HQoC1en8shUIAoIgEagype4j3UHw==
X-Received: by 2002:a17:902:e848:b0:1ca:35cb:dbb with SMTP id
 t8-20020a170902e84800b001ca35cb0dbbmr15635993plg.46.1698241832973; 
 Wed, 25 Oct 2023 06:50:32 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 8/9] target/riscv/tcg: honor user choice for G MISA bits
Date: Wed, 25 Oct 2023 10:50:00 -0300
Message-ID: <20231025135001.531224-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025135001.531224-1-dbarboza@ventanamicro.com>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 73 +++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cc7266b903..4e90c726e9 100644
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
@@ -291,6 +297,46 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
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
@@ -300,31 +346,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


