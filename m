Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7E7A7A54
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivGD-0005ZZ-CJ; Wed, 20 Sep 2023 07:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivG9-0005XY-V1
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:45 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivG8-0002AT-AH
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:45 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c09d760cb9so4186862a34.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208843; x=1695813643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYZpogAnNMvf9lHAyK1WoXxa37bMCFKb0Dk4AIyTLEU=;
 b=QpqUn9w53NbzNxB3SYEgVX/sVb64uW2UxBAg4FgZXSjyn6Li4CYhntjA87d7jNc3DY
 DDfZGZ7PF09III6nnOBnegg3GVV2c0iBQil/UAq6ype4HMgiYegW61qFkt2rPl6V1SHF
 y8djLTm2LiT2E8+pFGEZsBD8sphsWp6BVkOV6WC4BiD04aV/5htKu5kSOM/DRmBuLZN/
 9lGBzO3wvw1iPsMoEoDpUrAx3o3dMn1oZctBnTg16izq3hO6SqTU+ldEdcDgR+morrif
 VUd6BXY0pYAI+X1iyaazUeYZDd5EQOBG4I41dg5Dhyq1IRNaOaDQPrkGbCbwvRBoTRC1
 lubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208843; x=1695813643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYZpogAnNMvf9lHAyK1WoXxa37bMCFKb0Dk4AIyTLEU=;
 b=F+vxhXFL1rNcA03Phc1713y9RX+UjNiygoSLGQB9AvEqNL0X7LinfDWawEiXOryaHK
 gJgKe6M4k1cCNJglyD5Ztw0H5OLnD8ppeQQOiAC9mxgA+9U/NR4ybiaREVrPiPU5IGbI
 SVTRVSUTze1yq118P5exQPRsOJmE4pvjj1FP978wJAC5Q4UHs1bDdVKeeQfhBjYJY6v3
 X4B4vcyQ40dESzUwpXikA1LESQDKJpn8mXa52x6wrWtr4zAnaEuivQFKMybNfVjG2LT6
 Iu0lDhfdnfL8MUrMIRyofE7ycBnkrKbqeyDlCPxgTFX0v0nXfbs4vs37PwBx8b2HXP55
 XR6g==
X-Gm-Message-State: AOJu0Yz48gOOVph8pGhP5d+gJcz35fUGiiHUgYiHN/jl3ajMrj+G4VD0
 i8zttEO2o3iC/tfPua3Nk2vZJt5wHFNs7KAIlHE=
X-Google-Smtp-Source: AGHT+IEe0/oLvsl9Z8OEZQmqAZ1Qt6gJXlIvMAf+hoVTQpL+lj3HqXPheTPLySaQvg48hI6x8dR5qw==
X-Received: by 2002:a05:6830:11c7:b0:6b9:414e:dc7d with SMTP id
 v7-20020a05683011c700b006b9414edc7dmr2029366otq.35.1695208842986; 
 Wed, 20 Sep 2023 04:20:42 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 05/19] target/riscv/cpu.c: add .instance_post_init()
Date: Wed, 20 Sep 2023 08:20:06 -0300
Message-ID: <20230920112020.651006-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
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


