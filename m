Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56887E03EF
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyuVk-0001wR-UN; Fri, 03 Nov 2023 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVg-0001tu-Es
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:46:52 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyuVc-0000tQ-42
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 09:46:52 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7d9d357faso24697057b3.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699019207; x=1699624007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHN/TG9tOUYcaVdZFuWyzuuk09MWUr6naCVtgHon0jk=;
 b=XPN60IdJZi9NKkvgDaxtYzRNh6oFWAN6hCowZaLlP4SKgxcQA4tLjaPOLgbQjkrPHX
 /xhOucJEtz/JOrThIkN4hU7f2E5skjSC2RrpRt5VpBMrFGacjT8FV+RKd2LUY5gAEdBl
 y0JWwA3KbOEdExEJzaD7iRR0T0NXKXoHKBx0rOEEY3RXBYGhkTf7bLd2MlZa5K2cfYyW
 lluI0girrhUAPSUKvNgZCWWk2a0rADPyX8M4WJXTAl05UbOOBn0TUN4ka3Vzo5xf0YBV
 rjtja6lEU54oV/jnk0t71PSCYKKNSkkIs1mCKiDTkCgENRexpzVOsvVWDorVVoN8mao4
 dLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699019207; x=1699624007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHN/TG9tOUYcaVdZFuWyzuuk09MWUr6naCVtgHon0jk=;
 b=Os+tLEbfrxTrGc7mePAcCmVyQVWdNfjF8pgFiGAHyUSYhR3qmSiPFFKCgVgF2uh6R1
 +bOXQj1bVo+YKse7J7x7oyWjNhnTq7xq7e5SLP5u8u4OfSCQi5ARLsD6xV7Y4cve/Gha
 rpSFVgu3yugQkpp8fSyxwP8qshtK4tj6VwR0CRhY1Vn0dFGgWGhHaD4iIyYevX2zrYEv
 yLLGB79H9TjTxDY6xtVOOpk62h05Sqh+8NOTN2q5PzcPZqeiFZ/y8chdUq+a8w1bkP36
 DJ0+t8vPZ8NqEyKxtM1xqgvmeUE89aMdvHAf91UM0ZE+ykkp65YbLBdx90srPy+NECIr
 8KEg==
X-Gm-Message-State: AOJu0YxI3r/8QJTmgV7I9+PGljAOdXlNof9sy34n8748tqO6oN03rBkR
 hGNrTTA4y5yfZ6VYufkBQsGzLNaLaWipHcARLVA=
X-Google-Smtp-Source: AGHT+IHtINQxNAK2EPZIoAhhr2v7i93o3SxwqlTSgkgqL9P2iVWrpitAz9xlajW51dZpQeU2jcgn0w==
X-Received: by 2002:a0d:d387:0:b0:5ae:dff7:6148 with SMTP id
 v129-20020a0dd387000000b005aedff76148mr2382204ywd.48.1699019205332; 
 Fri, 03 Nov 2023 06:46:45 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 j68-20020a0df947000000b00582b239674esm935814ywf.129.2023.11.03.06.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:46:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 04/18] target/riscv: add rv64i CPU
Date: Fri,  3 Nov 2023 10:46:15 -0300
Message-ID: <20231103134629.561732-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103134629.561732-1-dbarboza@ventanamicro.com>
References: <20231103134629.561732-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
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

We don't have any form of a 'bare bones' CPU. rv64, our default CPUs,
comes with a lot of defaults. This is fine for most regular uses but
it's not suitable when more control of what is actually loaded in the
CPU is required.

A bare-bones CPU would be annoying to deal with if not by profile
support, a way to load a multitude of extensions with a single flag.
Profile support is going to be implemented shortly, so let's add a CPU
for it.

The new 'rv64i' CPU will have only RVI loaded. It is inspired in the
profile specification that dictates, for RVA22U64 [1]:

"RVA22U64 Mandatory Base
 RV64I is the mandatory base ISA for RVA22U64"

And so it seems that RV64I is the mandatory base ISA for all profiles
listed in [1], making it an ideal CPU to use with profile support.

rv64i is a CPU of type TYPE_RISCV_BARE_CPU. It has a mix of features
from pre-existent CPUs:

- it allows extensions to be enabled, like generic CPUs;
- it will not inherit extension defaults, like vendor CPUs.

This is the minimum extension set to boot OpenSBI and buildroot using
rv64i:

./build/qemu-system-riscv64 -nographic -M virt \
    -cpu rv64i,sv39=true,g=true,c=true,s=true,u=true

Our minimal riscv,isa in this case will be:

 # cat /proc/device-tree/cpus/cpu@0/riscv,isa
rv64imafdc_zicntr_zicsr_zifencei_zihpm_zca_zcd#

[1] https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  2 ++
 target/riscv/cpu.c     | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 7831e86d37..ea9a752280 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -25,6 +25,7 @@
 #define TYPE_RISCV_CPU "riscv-cpu"
 #define TYPE_RISCV_DYNAMIC_CPU "riscv-dynamic-cpu"
 #define TYPE_RISCV_VENDOR_CPU "riscv-vendor-cpu"
+#define TYPE_RISCV_BARE_CPU "riscv-bare-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
@@ -35,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
+#define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4bb677275c..46a5550d72 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -370,6 +370,17 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
 /* Set the satp mode to the max supported */
 static void set_satp_mode_default_map(RISCVCPU *cpu)
 {
+    /*
+     * Bare CPUs do not default to the max available.
+     * Users must set a valid satp_mode in the command
+     * line.
+     */
+    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
+        warn_report("No satp mode set. Defaulting to 'bare'");
+        cpu->cfg.satp_mode.map = (1 << VM_1_10_MBARE);
+        return;
+    }
+
     cpu->cfg.satp_mode.map = cpu->cfg.satp_mode.supported;
 }
 #endif
@@ -552,6 +563,28 @@ static void rv128_base_cpu_init(Object *obj)
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
+
+static void rv64i_bare_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    riscv_cpu_set_misa(env, MXL_RV64, RVI);
+
+    /* Remove the defaults from the parent class */
+    RISCV_CPU(obj)->cfg.ext_zicntr = false;
+    RISCV_CPU(obj)->cfg.ext_zihpm = false;
+
+    /* Set to QEMU's first supported priv version */
+    env->priv_ver = PRIV_VERSION_1_10_0;
+
+    /*
+     * Support all available satp_mode settings. The default
+     * value will be set to MBARE if the user doesn't set
+     * satp_mode manually (see set_satp_mode_default()).
+     */
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
+#endif
+}
 #else
 static void rv32_base_cpu_init(Object *obj)
 {
@@ -1748,6 +1781,13 @@ void riscv_cpu_list(void)
         .instance_init = initfn              \
     }
 
+#define DEFINE_BARE_CPU(type_name, initfn) \
+    {                                      \
+        .name = type_name,                 \
+        .parent = TYPE_RISCV_BARE_CPU,     \
+        .instance_init = initfn            \
+    }
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -1770,6 +1810,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .parent = TYPE_RISCV_CPU,
         .abstract = true,
     },
+    {
+        .name = TYPE_RISCV_BARE_CPU,
+        .parent = TYPE_RISCV_CPU,
+        .abstract = true,
+    },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
 #if defined(TARGET_RISCV32)
@@ -1786,6 +1831,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
+    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
 #endif
 };
 
-- 
2.41.0


