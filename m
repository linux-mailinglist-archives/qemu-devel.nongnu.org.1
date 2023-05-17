Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA123706A55
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHfN-0001rJ-VO; Wed, 17 May 2023 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHfK-0001eH-4T
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:58:06 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHf6-0000Zn-O2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:58:05 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6ab13810da6so344828a34.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684331871; x=1686923871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfSAPgxiMzr1wrf+V+jfCJowiPVIcHPmXy6mTve0Hgw=;
 b=eLirNB4mNDQQrvIO/RU2ENvMWRjIgkYqkRyl0UEQwSeSi6/Rw9ZfHuJJSoK4Ns1MhN
 AZ8FNCS279kj8EkB0+UT4BOEb6CUxJq3jtE8vGHDuQoEEiKhomsHp6QQx4FHreuhHIlU
 XZRvYyMlPL69Oq75O0JSA2byyI5kA9pveTDoPsEVaSimkdXLOKkEmMSc93PJKJk1fswi
 e2VeEiLdpVVO5MuThHJrUmi8wRChQC1KsaIHaq0/8HnzUjl02znCdDfE+5+liY8D115t
 Vrq+jmLl5mCJMW2VdYWprmrueja+SscwNV5hL0Y3Bi8fUv/d6dq0bKKYKVJi4qTGh1pt
 ecJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684331871; x=1686923871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfSAPgxiMzr1wrf+V+jfCJowiPVIcHPmXy6mTve0Hgw=;
 b=aTU1Yputf15K+C0/7XlGxvxP+UAt+ITmCMlOBf1l4JdWQBj1Y78mEfOy8s9h3E6b6i
 zm1sn6WnujwJ4xs6vNoTT7f0NkjT18g5bozZQlrJZpns8JEg5F4ZqwZ5DY+NiHtj7Gl/
 7oYiKOKpcj41yaYNSoM8K4tHdIzyILCtcIZ9Te8jltLR3hypvhuKTWSUcnaPzhXUlIZe
 5K0ML9BIrftTsUXP/q3duMY4DhcBq1zN2b7jcqqjgl408D1iQOfkSbx4Ts/zEwnjLAXq
 OVOgxTLTXTTbHYKwHwBQ7Lkp0W50Ai3paJWumWqoCQd+jdIuTpkEPxO0v7nQTpJjRKvz
 xTLg==
X-Gm-Message-State: AC+VfDz8+y368xOifdDL0WMu48NFN54DXo/0D5yMjqSOGa7pITEQGVCn
 uZTzW40rvtJ6Ed/767TTc+GXyzHLRVfbexsCxZ0=
X-Google-Smtp-Source: ACHHUZ49VZ571ZP+FW+02cRgJus9xHVmFLQbiP0sqOXUV2kMSRwlgsEAkX9tNnTuVqLsnYP4yAvEWw==
X-Received: by 2002:a05:6808:6185:b0:38e:3904:2db9 with SMTP id
 dn5-20020a056808618500b0038e39042db9mr13732956oib.46.1684331871388; 
 Wed, 17 May 2023 06:57:51 -0700 (PDT)
Received: from grind.. (189-46-207-53.dsl.telesp.net.br. [189.46.207.53])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a544815000000b00383d9700294sm9409562oij.40.2023.05.17.06.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 06:57:50 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 10/11] target/riscv/cpu.c: remove cfg setup from
 riscv_cpu_init()
Date: Wed, 17 May 2023 10:57:13 -0300
Message-Id: <20230517135714.211809-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517135714.211809-1-dbarboza@ventanamicro.com>
References: <20230517135714.211809-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

We have 4 config settings being done in riscv_cpu_init(): ext_ifencei,
ext_icsr, mmu and pmp. This is also the constructor of the "riscv-cpu"
device, which happens to be the parent device of every RISC-V cpu.

The result is that these 4 configs are being set every time, and every
other CPU should always account for them. CPUs such as sifive_e need to
disable settings that aren't enabled simply because the parent class
happens to be enabling it.

Moving all configurations from the parent class to each CPU will
centralize the config of each CPU into its own init(), which is clearer
than having to account to whatever happens to be set in the parent
device. These settings are also being set in register_cpu_props() when
no 'misa_ext' is set, so for these CPUs we don't need changes. Named
CPUs will receive all cfgs that the parent were setting into their
init().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 59 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9e33fa4301..52f91ff8cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -332,7 +332,8 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 
 static void riscv_any_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
 #if defined(TARGET_RISCV32)
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
 #elif defined(TARGET_RISCV64)
@@ -346,6 +347,12 @@ static void riscv_any_cpu_init(Object *obj)
 #endif
 
     env->priv_ver = PRIV_VERSION_LATEST;
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 }
 
 #if defined(TARGET_RISCV64)
@@ -364,12 +371,19 @@ static void rv64_base_cpu_init(Object *obj)
 
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
     set_misa(env, MXL_RV64, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 }
 
 static void rv64_sifive_e_cpu_init(Object *obj)
@@ -379,10 +393,14 @@ static void rv64_sifive_e_cpu_init(Object *obj)
 
     set_misa(env, MXL_RV64, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
-    cpu->cfg.mmu = false;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
 }
 
 static void rv64_thead_c906_cpu_init(Object *obj)
@@ -410,6 +428,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.pmp = true;
 }
 
 static void rv64_veyron_v1_cpu_init(Object *obj)
@@ -483,12 +504,19 @@ static void rv32_base_cpu_init(Object *obj)
 
 static void rv32_sifive_u_cpu_init(Object *obj)
 {
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
 }
 
 static void rv32_sifive_e_cpu_init(Object *obj)
@@ -498,10 +526,14 @@ static void rv32_sifive_e_cpu_init(Object *obj)
 
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
-    cpu->cfg.mmu = false;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
 }
 
 static void rv32_ibex_cpu_init(Object *obj)
@@ -511,11 +543,15 @@ static void rv32_ibex_cpu_init(Object *obj)
 
     set_misa(env, MXL_RV32, RVI | RVM | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_11_0;
-    cpu->cfg.mmu = false;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
     cpu->cfg.epmp = true;
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
 }
 
 static void rv32_imafcu_nommu_cpu_init(Object *obj)
@@ -525,10 +561,14 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
 
     set_misa(env, MXL_RV32, RVI | RVM | RVA | RVF | RVC | RVU);
     env->priv_ver = PRIV_VERSION_1_10_0;
-    cpu->cfg.mmu = false;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
+
+    /* inherited from parent obj via riscv_cpu_init() */
+    cpu->cfg.ext_ifencei = true;
+    cpu->cfg.ext_icsr = true;
+    cpu->cfg.pmp = true;
 }
 #endif
 
@@ -1441,11 +1481,6 @@ static void riscv_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    cpu->cfg.ext_ifencei = true;
-    cpu->cfg.ext_icsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
     cpu_set_cpustate_pointers(cpu);
 
 #ifndef CONFIG_USER_ONLY
-- 
2.40.1


