Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD87CF4D1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPzg-0005uz-EH; Thu, 19 Oct 2023 06:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzX-0005oV-Hn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzU-00084N-TK
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso466616b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697710255; x=1698315055;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT7e719cG6606seq7x8Hjcp0DA6bkh1sBm8gJX/swqI=;
 b=tFwIf7ONm0FCxEsVssE7v96aTxmO7OY5sYhbm/yqFqxUFeZ1R+ydvXabnrZJ2XuAYq
 QtuT3fgJ5EMVbX69Zmd7wX3LX82O4QuVLXXMXY4WAQ+KYYD+4FO7GUop71r6CFkBgmwc
 VQTvVg/kT/DY2Kmz9TMvefdzVWQF+YouhDtIhrbOUa3gSIRTEAtpJb6VjsrBwHxN2GqP
 EcTS0n3jDqExjn3saN60MXsReDFWOTb+/UBhBQY2W8fQydNDKpbRUEgXJuBK/NUTCyL+
 BiEIX9Fwcy8TTBmIjlshJZhW+VuQGkGZuFoj4CkPT3uPLnFeSuwFuO43rWj6VQf1kIPb
 Aplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710255; x=1698315055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yT7e719cG6606seq7x8Hjcp0DA6bkh1sBm8gJX/swqI=;
 b=pb87N0Ugd95qj6vzjQvL7FoEB3sTfTI5I+bCgNv7nsELszH0ROcUWGyC05YM/wRZcM
 unf7l2GA4H+81CLRMzRbncbjRjN4vTMayv1wthrGEpKtXajkHmUbehyJJmzzIzCIr2yj
 z0HhU4/JF36cpCRshU3NrFA25EQXWbhhxRni0JAVR4KMOfGSHNJXiikxxWjPljKunFGV
 Ok+j50cPBPiPrUwAJtCxGX6jKcKmFwAE+j6WpwkmkCbfHkKbM66E0rN7Mg63KC3E+Z4v
 ckdzzW2tWKmWrMJlOY1HTHQuyohclqtgVoY3vG4JQcuR22K48xAfzrsAAB+IALJ2nHb7
 mlBA==
X-Gm-Message-State: AOJu0YyxEYjA/BuR0aDM9M+/xTtY1Zdm6axdOCQ8zvKOj47wo8jNH9fS
 O4MIS2QRAKOAh4UguSJ2nSa1MQ==
X-Google-Smtp-Source: AGHT+IHfUtyCnOoGseyPkRr13H+/lhPoEqcqxy10Q48rdblZkN6/rDaSin+cHs9ME1a3kOSOX7oEfg==
X-Received: by 2002:a05:6a00:2314:b0:68c:44ed:fb6 with SMTP id
 h20-20020a056a00231400b0068c44ed0fb6mr2158077pfh.16.1697710255346; 
 Thu, 19 Oct 2023 03:10:55 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y30-20020aa79e1e000000b0068c10187dc3sm4717587pfq.168.2023.10.19.03.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:10:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 4/6] target/riscv: Move misa_mxl_max to class
Date: Thu, 19 Oct 2023 19:10:26 +0900
Message-ID: <20231019101030.128431-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019101030.128431-1-akihiko.odaki@daynix.com>
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

misa_mxl_max is common for all instances of a RISC-V CPU class so they
are better put into class.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/riscv/cpu-qom.h     |   1 +
 target/riscv/cpu.h         |   3 +-
 target/riscv/cpu.c         | 118 +++++++++++++++++++------------------
 target/riscv/gdbstub.c     |  12 ++--
 target/riscv/kvm/kvm-cpu.c |  10 ++--
 target/riscv/machine.c     |   7 +--
 target/riscv/tcg/tcg-cpu.c |  12 ++--
 target/riscv/translate.c   |   3 +-
 8 files changed, 87 insertions(+), 79 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index f3fbe37a2c..33b6d52c90 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -68,5 +68,6 @@ struct RISCVCPUClass {
     /*< public >*/
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+    uint32_t misa_mxl_max;  /* max mxl for this cpu */
 };
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f8ffa5ee38..ef10efd1e7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -159,7 +159,6 @@ struct CPUArchState {
 
     /* RISCVMXL, but uint32_t for vmstate migration */
     uint32_t misa_mxl;      /* current mxl */
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
     uint32_t misa_ext;      /* current extensions */
     uint32_t misa_ext_mask; /* max ext for this cpu */
     uint32_t xl;            /* current xlen */
@@ -711,7 +710,7 @@ enum riscv_pmu_event_idx {
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
-void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext);
+void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 
 typedef struct RISCVCPUMultiExtConfig {
     const char *name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ac4a6c7eec..1fb5747f00 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -263,9 +263,8 @@ const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
     }
 }
 
-void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext)
+void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 {
-    env->misa_mxl_max = env->misa_mxl = mxl;
     env->misa_ext_mask = env->misa_ext = ext;
 }
 
@@ -367,11 +366,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-#if defined(TARGET_RISCV32)
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-#elif defined(TARGET_RISCV64)
-    riscv_cpu_set_misa(env, MXL_RV64, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-#endif
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
 
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj),
@@ -392,16 +387,14 @@ static void riscv_max_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    RISCVMXL mlx = MXL_RV64;
 
-#ifdef TARGET_RISCV32
-    mlx = MXL_RV32;
-#endif
-    riscv_cpu_set_misa(env, mlx, 0);
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
-                                VM_1_10_SV32 : VM_1_10_SV57);
+#ifdef TARGET_RISCV32
+    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
+#else
+    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
+#endif
 #endif
 }
 
@@ -409,8 +402,6 @@ static void riscv_max_cpu_init(Object *obj)
 static void rv64_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV64, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -422,8 +413,7 @@ static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa(env, MXL_RV64,
-                       RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
@@ -441,7 +431,7 @@ static void rv64_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVI | RVM | RVA | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -458,7 +448,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVG | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_11_0;
 
     cpu->cfg.ext_zfa = true;
@@ -489,7 +479,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV64, RVG | RVC | RVS | RVU | RVH);
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
     env->priv_ver = PRIV_VERSION_1_12_0;
 
     /* Enable ISA extensions */
@@ -533,8 +523,6 @@ static void rv128_base_cpu_init(Object *obj)
         exit(EXIT_FAILURE);
     }
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV128, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -545,8 +533,6 @@ static void rv128_base_cpu_init(Object *obj)
 static void rv32_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    /* We set this in the realise function */
-    riscv_cpu_set_misa(env, MXL_RV32, 0);
     /* Set latest version of privileged specification */
     env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
@@ -558,8 +544,7 @@ static void rv32_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa(env, MXL_RV32,
-                       RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
@@ -577,7 +562,7 @@ static void rv32_sifive_e_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -594,7 +579,7 @@ static void rv32_ibex_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_11_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -612,7 +597,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVC | RVU);
+    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
@@ -834,7 +819,7 @@ static void riscv_cpu_reset_hold(Object *obj)
         mcc->parent_phases.hold(obj);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = env->misa_mxl_max;
+    env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1169,6 +1154,12 @@ static void riscv_cpu_post_init(Object *obj)
 
 static void riscv_cpu_init(Object *obj)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+
+    env->misa_mxl = mcc->misa_mxl_max;
+
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
@@ -1555,7 +1546,7 @@ static void cpu_get_marchid(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
+static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     CPUClass *cc = CPU_CLASS(c);
@@ -1597,6 +1588,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+
+    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+}
+
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
                                  int max_str_len)
 {
@@ -1662,18 +1660,22 @@ void riscv_cpu_list(void)
     g_slist_free(list);
 }
 
-#define DEFINE_CPU(type_name, initfn)      \
-    {                                      \
-        .name = type_name,                 \
-        .parent = TYPE_RISCV_CPU,          \
-        .instance_init = initfn            \
+#define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_CPU,                           \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
-#define DEFINE_DYNAMIC_CPU(type_name, initfn) \
-    {                                         \
-        .name = type_name,                    \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,     \
-        .instance_init = initfn               \
+#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
+        .instance_init = (initfn),                          \
+        .class_init = riscv_cpu_class_init,                 \
+        .class_data = (void *)(misa_mxl_max)                \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
@@ -1686,29 +1688,31 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
-        .class_init = riscv_cpu_class_init,
+        .class_init = riscv_cpu_common_class_init,
     },
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
         .parent = TYPE_RISCV_CPU,
         .abstract = true,
     },
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,     MXL_RV32,  riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,     MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,  MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,            MXL_RV32,  rv32_ibex_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,      MXL_RV32,  rv32_sifive_e_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,      MXL_RV32,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,      MXL_RV32,  rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,   rv64_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,     MXL_RV64,  riscv_any_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,     MXL_RV64,  riscv_max_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,  MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,      MXL_RV64,  rv64_sifive_e_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,      MXL_RV64,  rv64_sifive_u_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,        MXL_RV64,  rv64_sifive_u_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,      MXL_RV64,  rv64_thead_c906_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,       MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128, MXL_RV128, rv128_base_cpu_init),
 #endif
 };
 
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 524bede865..b9528cef5b 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -49,6 +49,7 @@ static const struct TypeSize vec_lanes[] = {
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong tmp;
@@ -61,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return 0;
     }
 
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         return gdb_get_reg32(mem_buf, tmp);
     case MXL_RV64:
@@ -75,12 +76,13 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     int length = 0;
     target_ulong tmp;
 
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         tmp = (int32_t)ldl_p(mem_buf);
         length = 4;
@@ -214,11 +216,12 @@ static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
 
 static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     GString *s = g_string_new(NULL);
     riscv_csr_predicate_fn predicate;
-    int bitsize = 16 << env->misa_mxl_max;
+    int bitsize = 16 << mcc->misa_mxl_max;
     int i;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -310,6 +313,7 @@ static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
@@ -326,7 +330,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  ricsv_gen_dynamic_vector_xml(cs, base_reg),
                                  "riscv-vector.xml", 0);
     }
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 090d617627..186ca6e45c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1461,14 +1461,14 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_init(Object *obj)
+static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
 #if defined(TARGET_RISCV32)
-    env->misa_mxl_max = env->misa_mxl = MXL_RV32;
+    mcc->misa_mxl_max = MXL_RV32;
 #elif defined(TARGET_RISCV64)
-    env->misa_mxl_max = env->misa_mxl = MXL_RV64;
+    mcc->misa_mxl_max = MXL_RV64;
 #endif
 }
 
@@ -1476,7 +1476,7 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU_HOST,
         .parent = TYPE_RISCV_CPU,
-        .instance_init = riscv_host_cpu_init,
+        .class_init = riscv_host_cpu_class_init,
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c7c862cdd3..c7124a068c 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -175,10 +175,9 @@ static const VMStateDescription vmstate_pointermasking = {
 
 static bool rv128_needed(void *opaque)
 {
-    RISCVCPU *cpu = opaque;
-    CPURISCVState *env = &cpu->env;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
 
-    return env->misa_mxl_max == MXL_RV128;
+    return mcc->misa_mxl_max == MXL_RV128;
 }
 
 static const VMStateDescription vmstate_rv128 = {
@@ -369,7 +368,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
         VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
-        VMSTATE_UINT32(env.misa_mxl_max, RISCVCPU),
+        VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
         VMSTATE_UINTTL(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7f45e42000..5bf9d31f7c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -152,10 +152,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
-    CPURISCVState *env = &cpu->env;
 
     /* Validate that MISA_MXL is set properly. */
-    switch (env->misa_mxl_max) {
+    switch (mcc->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -265,6 +264,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
  */
 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 {
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
@@ -445,7 +445,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcb), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -453,7 +453,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
-        if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
         if (riscv_has_ext(env, RVD)) {
@@ -461,7 +461,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    if (env->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -861,7 +861,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..7e383c5eeb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1167,6 +1167,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu_env(cs);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
@@ -1188,7 +1189,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->misa_mxl_max = env->misa_mxl_max;
+    ctx->misa_mxl_max = mcc->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-- 
2.42.0


