Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB947AF31E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlCz7-0007HI-EF; Tue, 26 Sep 2023 14:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCz3-0007Gl-1L
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qlCz0-0006TW-Ho
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:40:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso7452204b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695753629; x=1696358429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m97eKcYhxutpzHRkswwj8gKLRsf806rl8f4MNHOdJoo=;
 b=VM22isqibD3M7ipeJ43G018GHAXPGIB038YFswArYpRkbenpPWI/wHJictqjCBm/nU
 1bwg+v/N8usXw/zpYvn08zgR7X0XRkxQxKIcibXmRUF/sZVISDDKRCdMRGtmw+0XxMuy
 Um1yY4WEs6Tk4bkEgkmKvzdwmQK0W0tBfj3AYo5xicd8xosIXNtevedRERWIzvIyPwK9
 I/fVjSmsGw94DG09aoWmBRO+zJfZtEqQPC9vkaiHkIPYrJY0BEhLNcMJ0lynq4XRt07P
 ON+9+0gKfdjGpiTV+WOElCjJ1DfCtzmPo6sevjAY11sve0xAv732u7xdNcdQGfWrB7Bk
 ia+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695753629; x=1696358429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m97eKcYhxutpzHRkswwj8gKLRsf806rl8f4MNHOdJoo=;
 b=uhlB7MNsnS8qqFNii0bUaYClD0bVON3TpsN3/zUt06ZdDF6CJFGTDyaa4F+kymQcst
 lUff8CLYrL+djcoH1BNL7esqiUtQHVP1qLCmC/0GhBIBy/TfEhkcCkEFjon2IKCO5RLz
 feDRwBQT9p1RQkIIaKqXPNl44unzsSD4F+8AA3DwLRpa/aPJQR+7ag1Vnfvro7CdNRlE
 fuIWE5mLIEb1PU4CpVs+PZ2kva44iawkIupbPF1GpFoBfMTMdwetYEJEM2OrHgflVmjv
 T3Nktc6n/I4OZxJ8Q00Roci4H0tpXOJW4t2y+VXQkbJb/21JvcXppdjvG9FycdUaxgsc
 qMUw==
X-Gm-Message-State: AOJu0Yy6Q45xLhdTtpbvlyRXwnlglIcYW+yApoYHqvLSjlFi8dphwslG
 qQexTYUig1g+BZubi0TrCIjPJuMEjCQZsQjCEcI=
X-Google-Smtp-Source: AGHT+IEH3O+jkvdvcQC1uzmxYNz7XPeDslme7LZRsVwO+ANFZwJd3pZkdodSunhzuuC2bBF4HbtEnA==
X-Received: by 2002:a05:6a21:a584:b0:15e:556:bc26 with SMTP id
 gd4-20020a056a21a58400b0015e0556bc26mr11344429pzc.62.1695753628681; 
 Tue, 26 Sep 2023 11:40:28 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001b9cdf11764sm11268306plh.31.2023.09.26.11.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 11:40:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/6] target/riscv/kvm/kvm-cpu.c: add missing property
 getters()
Date: Tue, 26 Sep 2023 15:40:14 -0300
Message-ID: <20230926184019.166352-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926184019.166352-1-dbarboza@ventanamicro.com>
References: <20230926184019.166352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

We got along without property getters in the KVM driver because we never
needed them. But the incoming query-cpu-model-expansion API will use
property getters and setters to retrieve the CPU characteristics.

Add the missing getters for the KVM driver for both MISA and
multi-letter extension properties. We're also adding an special getter
for absent multi-letter properties that KVM doesn't implement that
always return false.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 40 +++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c6615cb807..b4c231f231 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -140,6 +140,19 @@ static KVMCPUConfig kvm_misa_ext_cfgs[] = {
     KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
 };
 
+static void kvm_cpu_get_misa_ext_cfg(Object *obj, Visitor *v,
+                                     const char *name,
+                                     void *opaque, Error **errp)
+{
+    KVMCPUConfig *misa_ext_cfg = opaque;
+    target_ulong misa_bit = misa_ext_cfg->offset;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    bool value = env->misa_ext_mask & misa_bit;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
                                      const char *name,
                                      void *opaque, Error **errp)
@@ -244,6 +257,17 @@ static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
     return *ext_enabled;
 }
 
+static void kvm_cpu_get_multi_ext_cfg(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque, Error **errp)
+{
+    KVMCPUConfig *multi_ext_cfg = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
                                       const char *name,
                                       void *opaque, Error **errp)
@@ -346,6 +370,15 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+static void cpu_get_cfg_unavailable(Object *obj, Visitor *v,
+                                    const char *name,
+                                    void *opaque, Error **errp)
+{
+    bool value = false;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
                                     void *opaque, Error **errp)
@@ -376,7 +409,8 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
      * to enable any of them.
      */
     object_property_add(obj, prop_name, "bool",
-                        NULL, cpu_set_cfg_unavailable,
+                        cpu_get_cfg_unavailable,
+                        cpu_set_cfg_unavailable,
                         NULL, (void *)prop_name);
 }
 
@@ -406,7 +440,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
         object_property_add(cpu_obj, misa_cfg->name, "bool",
-                            NULL,
+                            kvm_cpu_get_misa_ext_cfg,
                             kvm_cpu_set_misa_ext_cfg,
                             NULL, misa_cfg);
         object_property_set_description(cpu_obj, misa_cfg->name,
@@ -422,7 +456,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
         object_property_add(cpu_obj, multi_cfg->name, "bool",
-                            NULL,
+                            kvm_cpu_get_multi_ext_cfg,
                             kvm_cpu_set_multi_ext_cfg,
                             NULL, multi_cfg);
     }
-- 
2.41.0


