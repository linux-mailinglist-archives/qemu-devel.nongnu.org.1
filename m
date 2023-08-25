Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255178882D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZE-0001kO-Vu; Fri, 25 Aug 2023 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ8-0001h3-PM
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:31 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ4-0006xo-FY
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:29 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c4cf775a14so544228fac.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968964; x=1693573764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDur86/hFN6MunBpOuosMi+pkfy+1hOmhDQYc+du5ag=;
 b=SEq7c0LBB5k4Xsc016W7NScyNuHPhLJdQtwHa3O745/isRAq3bx1rjYdoVQNfcVUPv
 GPn1QbKn49RDc0MbxgapOpwO52k8ODXGQ5asR6Ho/pgSAHnYdMJgJdpfhaPP/3xAqqyF
 z0pzeA96SK/VT6BbrqhuT3Bjh4G2tY0dntCWVEyF/6nxrANc0nMVMEYGQvZlqv8Fi7CP
 wt3761tWLtGoQbY6ujT/udn2QStzTE4WcbNds/vy9QfF0Rg8hwwsCwhcw9US9KkjfKPy
 KeWejAz4J/U2o01GpiE80aW++b8uAORL+HWB9h3HtVzY+fJP5P+KKwm5Ze2EJTAeZHc4
 Z12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968964; x=1693573764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDur86/hFN6MunBpOuosMi+pkfy+1hOmhDQYc+du5ag=;
 b=kmne6Ol48AszXAsz/uaPT7awoxiZL/dANaNdE6ia8s+olE1HQapxYc2glRqqKy9amk
 c23EykRE3ELN76kGDa3UL+jtd2FcadJFmaoKlqgTiZAjjZT3s0dT18rMOwiZNr8/DThr
 f0pA0vtVKEhbKBQrlpCetGQc5ch7o6NyXj3gg2MpdQsQ87hJFKNHKDLZSxZzteBtg/Rp
 eIHE5wNc+SOwQDmMZb4um3mPOoVSl38+SUWjub3P85TPdrYEAGPoekD0lUg6HrEMcORc
 JXNwrykuv6tn88+Zbj1Lr8n37PhpMeM4IYWSN8QwxHeJ6NJt22tfefMxDJovreN4+L7p
 O7Yw==
X-Gm-Message-State: AOJu0YxcGwb5s3L8kQ1Rzsu2kXkRPH3tBS1AY9qYB2eCZZ8G/AzhofXF
 PLODrVMQhINg2SiWDU0I5IDgb4/5so2o6zR+f4w=
X-Google-Smtp-Source: AGHT+IFjTuPVc16WEUsZ6jj5wS2kUSankwKNCfBWC9+wq4+ltRgSOWBObAR1FdOh55VnearfLVOOBA==
X-Received: by 2002:a05:6870:8188:b0:1cc:c744:d327 with SMTP id
 k8-20020a056870818800b001ccc744d327mr3230461oae.44.1692968964536; 
 Fri, 25 Aug 2023 06:09:24 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 08/20] target/riscv: move 'host' CPU declaration to kvm.c
Date: Fri, 25 Aug 2023 10:08:41 -0300
Message-ID: <20230825130853.511782-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This CPU only exists if we're compiling with KVM so move it to the kvm
specific file. While we're at it, change its class_init() to enable the
user_extensions_flag class property, sparing us from having to execute
riscv_cpu_add_user_properties() by hand and letting the post_init() hook
do the work.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 23 -----------------------
 target/riscv/kvm.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f67b782675..dbf81796d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -655,19 +655,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
 }
 #endif
 
-#if defined(CONFIG_KVM)
-static void riscv_host_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-#if defined(TARGET_RISCV32)
-    set_misa(env, MXL_RV32, 0);
-#elif defined(TARGET_RISCV64)
-    set_misa(env, MXL_RV64, 0);
-#endif
-    riscv_cpu_add_user_properties(obj);
-}
-#endif /* CONFIG_KVM */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2000,13 +1987,6 @@ static void riscv_vendor_cpu_class_init(ObjectClass *c, void *data)
     rcc->user_extension_properties = false;
 }
 
-#define DEFINE_CPU(type_name, initfn)      \
-    {                                      \
-        .name = type_name,                 \
-        .parent = TYPE_RISCV_CPU,          \
-        .instance_init = initfn            \
-    }
-
 #define DEFINE_DYNAMIC_CPU(type_name, initfn) \
     {                                         \
         .name = type_name,                    \
@@ -2047,9 +2027,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,      riscv_any_cpu_init),
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,      riscv_max_cpu_init),
-#if defined(CONFIG_KVM)
-    DEFINE_CPU(TYPE_RISCV_CPU_HOST,             riscv_host_cpu_init),
-#endif
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,   rv32_base_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 7c6dec05e3..59004caa8e 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -1217,3 +1217,32 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
+
+static void riscv_host_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+
+#if defined(TARGET_RISCV32)
+    env->misa_mxl_max = env->misa_mxl = MXL_RV32;
+#elif defined(TARGET_RISCV64)
+    env->misa_mxl_max = env->misa_mxl = MXL_RV64;
+#endif
+}
+
+static void riscv_kvm_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
+
+    rcc->user_extension_properties = true;
+}
+
+static const TypeInfo riscv_kvm_cpu_type_infos[] = {
+    {
+        .name = TYPE_RISCV_CPU_HOST,
+        .parent = TYPE_RISCV_CPU,
+        .instance_init = riscv_host_cpu_init,
+        .class_init = riscv_kvm_cpu_class_init,
+    }
+};
+
+DEFINE_TYPES(riscv_kvm_cpu_type_infos)
-- 
2.41.0


