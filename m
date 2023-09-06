Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0A7937EC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdof2-0003G9-Ti; Wed, 06 Sep 2023 05:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdoey-0002xs-5H
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:16 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdoev-0005iL-Ob
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:15 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c0828c3c2dso1898851a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991832; x=1694596632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Aph7QVhozHi4LSu/mXzyfv/k3iUkG4CIBstH4LTFwg=;
 b=n9wCXa9UCLMfixHfBakVD7KBaIQnFcbM2MblZJiFcUQvl+ojYYgT6o+ChtQjfOVOKD
 DCXV1qcGKaJUF819B1HfFIbQhRJM/N5zICxBrEP2Wh9p0A45oHA1gxjRvkKeaBJT81eY
 gcgVxprWI2YBeFiO1SW951EWRzqM518gmwdC7y+PUDdyLAPcczWaGZDIKsZaBibU/52i
 Y5m68NWiHzTqDO0xaYk+nrTMwfOimUN7YcXptu+a/aY18Ecl1qiVbuW2udOzFUsQV1db
 rDct+NmBbkiYO1A52Qzgjq340ZBHaGj0ofO/fR3BnotsjRk0E3AYK377ymCQlkYNHeIS
 L+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991832; x=1694596632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Aph7QVhozHi4LSu/mXzyfv/k3iUkG4CIBstH4LTFwg=;
 b=GLYbHaV8kuUhe4TmIRU0YDz7PlnYfhNUPFvlidibfGL9GRw1LrGJqGwRiipia8FNZm
 ZzYxHSY2N54H6avF77PFC2Kmm6l1ifh/WY0lGh/PNl26+jij7Xn8T/2852UkmMuKkpr5
 yidieZiOA9EH9l3SdB4wp6rKDCwEGEKkn2tBEazzDF50UM98/IsJ3HgOyX60JMOdhDP+
 RCI/fKwSyN9eL9qgxqyKlhZLYH+w3yOLcM6cD/epdYNE9IvMM628MPCcFggUhC5EK9tp
 QOxBn6aSo3H/PF5kvwsKd+/Y4ZGXtDwwI1lYRnUl0z+x8262dYOE7y9Ym0mDNfrI+oER
 2Miw==
X-Gm-Message-State: AOJu0YyjH90bJg0pVEnAqB5sTULv0AljdhuhVHjxoECm01l/rkxqx3pp
 Dm0ZSZtYOvUGvvNv+bPJRualt/E6h18I4tbzRa0=
X-Google-Smtp-Source: AGHT+IHKxmgrNfmpepUmySox/c9ApSJFaMlwm/EFoaLiGDxSRSLxkE/xFvSjzIP9ff3Sk0ZzDO77EQ==
X-Received: by 2002:a9d:7d94:0:b0:6bd:9fa:34ff with SMTP id
 j20-20020a9d7d94000000b006bd09fa34ffmr16249958otn.9.1693991832251; 
 Wed, 06 Sep 2023 02:17:12 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/19] target/riscv/cpu.c: add .instance_post_init()
Date: Wed,  6 Sep 2023 06:16:32 -0300
Message-ID: <20230906091647.1667171-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
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
---
 target/riscv/cpu.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7569955c7e..4c6d595067 100644
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
@@ -1215,6 +1210,37 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
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
@@ -1770,11 +1796,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
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
@@ -2011,6 +2032,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof__(RISCVCPU),
         .instance_init = riscv_cpu_init,
+        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_class_init,
-- 
2.41.0


