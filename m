Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B47357ADE45
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpq0-0000cG-CT; Mon, 25 Sep 2023 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkppu-0000bc-CI
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpps-0002BL-RS
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:34 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-564af0ac494so4423100a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664651; x=1696269451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCxYR3NTkKbBCe79icU57Lpo0FuaiVGO/o6EjtNcge0=;
 b=Dr9zYjGuZSGU2KXLOmtB/tU1eOr9qcIICHi6odIxJBR+9/lSZHukvYf2aGMVkqWBbx
 De9U0pkgqMcZ+xizfwSNkqpBh9dVdvn6q/4zw0zIO+eos0K/PoAAWtdhnGS01Y9UTVcr
 YZvF+XgobWvaGTnirgn93P0zvWyIRnXC0/T76TU2R56D9VkkHcuEcbXo9Wqd4pR51Nos
 946VH/gjOubtjNUn+KiTUnNbEyAntibLxWANPTz+Cyz2muNGeAvHBrW5scwQWnUMhSS8
 VhPTx/A62/1bNpOFJ3KMl9jKT7JptDqC9YEWXQqApY7LHV30nq0yWWlEsW7Ez+GuzhDZ
 BQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664651; x=1696269451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCxYR3NTkKbBCe79icU57Lpo0FuaiVGO/o6EjtNcge0=;
 b=vxqrECDBvdf1dqI92x9o1EEFNPuVXrdmkYovWytyJ0GfPRnNx1CF/tIhExSjka7E5e
 l+JQ19JghJCcEV249PNWNJEmd9Vu9AQFZjYNVGVnuon90o0g1MTYuu+qbwN+TR1mkPON
 Jb7w46AKJgueexO9SxEiTZOJL0b5JS0VB4WPIKo/eQ5PfjGK+IBCd1N9/suuBCxYI2r6
 Y9g23cpXH0Iyzdp8bpWPfK2V2J9GO/94s7uww1+5ukDMa2ICiN/5nf8D1/FbGwOxHz3e
 jfXrSM5o1bfcd1ZrULnxS0qEhm08egZgI7j0JhuUGw03/+AZocgrSY/whSGar7LHE1rp
 SUZg==
X-Gm-Message-State: AOJu0YzsKHBJ8+8RfFn3IeiAVzxgTB3po5eDpThbVJuEWZdCaNptTZJB
 iYMpCwdANv5DeMmCJXK2XuCT4FrdCBegXjBGrBg=
X-Google-Smtp-Source: AGHT+IE1LPj0kQTrXwlmEAvzb1RB0Tl4btUpYg7oLpEX0/WIIDFuM+NOYkFsdv2gFIyWKpQmWXJ7tQ==
X-Received: by 2002:a17:90a:7786:b0:274:8041:94c with SMTP id
 v6-20020a17090a778600b002748041094cmr4736259pjk.13.1695664651138; 
 Mon, 25 Sep 2023 10:57:31 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 05/19] target/riscv/cpu.c: add .instance_post_init()
Date: Mon, 25 Sep 2023 14:56:55 -0300
Message-ID: <20230925175709.35696-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
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

All generic CPUs call riscv_cpu_add_user_properties(). The 'max' CPU
calls riscv_init_max_cpu_extensions(). Both can be moved to a common
instance_post_init() callback, implemented in riscv_cpu_post_init(),
called by all CPUs. The call order then becomes:

riscv_cpu_init() -> cpu_init() of each CPU -> .instance_post_init()

In the near future riscv_cpu_post_init() will call the init() function
of the current accelerator, providing a hook for KVM and TCG accel
classes to change the init() process of the CPU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9426b3b9d6..848b58e7c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -427,8 +427,6 @@ static void riscv_max_cpu_init(Object *obj)
     mlx = MXL_RV32;
 #endif
     set_misa(env, mlx, 0);
-    riscv_cpu_add_user_properties(obj);
-    riscv_init_max_cpu_extensions(obj);
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
@@ -442,7 +440,6 @@ static void rv64_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV64, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -566,7 +563,6 @@ static void rv128_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV128, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -579,7 +575,6 @@ static void rv32_base_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, MXL_RV32, 0);
-    riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -666,7 +661,6 @@ static void riscv_host_cpu_init(Object *obj)
 #elif defined(TARGET_RISCV64)
     set_misa(env, MXL_RV64, 0);
 #endif
-    riscv_cpu_add_user_properties(obj);
 }
 #endif /* CONFIG_KVM */
 
@@ -1215,6 +1209,37 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
 }
 #endif /* CONFIG_USER_ONLY */
 
+static bool riscv_cpu_is_dynamic(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
+}
+
+static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
+{
+    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
+}
+
+static bool riscv_cpu_has_user_properties(Object *cpu_obj)
+{
+    if (kvm_enabled() &&
+        object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_HOST) != NULL) {
+        return true;
+    }
+
+    return riscv_cpu_is_dynamic(cpu_obj);
+}
+
+static void riscv_cpu_post_init(Object *obj)
+{
+    if (riscv_cpu_has_user_properties(obj)) {
+        riscv_cpu_add_user_properties(obj);
+    }
+
+    if (riscv_cpu_has_max_extensions(obj)) {
+        riscv_init_max_cpu_extensions(obj);
+    }
+}
+
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -1768,11 +1793,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static bool riscv_cpu_is_dynamic(Object *cpu_obj)
-{
-    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
-}
-
 static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -2009,6 +2029,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof__(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_class_init,
-- 
2.41.0


