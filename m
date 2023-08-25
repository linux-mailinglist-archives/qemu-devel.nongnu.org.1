Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132178881C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:11:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZJ-0001pP-9w; Fri, 25 Aug 2023 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZH-0001mX-BF
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:39 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZE-0006zV-7I
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:39 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c8be41e5efso516307fac.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968975; x=1693573775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpmvM2jW32iQRPwS0jHByT9jcVKIdGa/GUIYBxdH0Xs=;
 b=pY1FJFz3IaiSr9O9r/WrWq2TJ4GZIQx0hzXl8sOniHDY+keNthI4132qD9vQpXrdL7
 XqEJ0g6lc56KOtozBrXNxUE7iicN9ul/xsSItouA8JmpR9dE8KLwixcjvSbCxmdeMRBy
 +g37WZaObVvC8/mcMk4u1KMjuNoKvOu4g8iahpHUhFrRValWT/pXemyFx4ZrF9MgOiRl
 oU+6jMFTkYyKryFtFM7W35k77AUBHD+KLWVGTETkt9gI10tRJxZAfNJ7hUvBrrWjQfRj
 F0LYgEoNr7eJuoIL2Som5d4ukEO9nbYP5H5gIO9O5mAUM5CeaJ60zrpXA7STXQIEC6LG
 njFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968975; x=1693573775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpmvM2jW32iQRPwS0jHByT9jcVKIdGa/GUIYBxdH0Xs=;
 b=lyVInqXeCeCVslNcVfaYlkBRvSVOVJ2dROUEmPA3jRTt6jN6hpPNLE4k2wK+ozr8f5
 /Pj7p3DM1UVuFhYd7TP9HZa7ZcThVXYwi4xrM/olubE1Stdbwmjs/5QyGqRKZ8lwRLmM
 tYlKej8IQ4vV4fHjkNncx4lhnuvm91aFi4x6rPNGAORE6C9InAPh1503gudYm6H8w+OQ
 7Tx+wJFI36C5wy631N7Nw2H6T6EnUGszDbpIQeHpnz2YKSIZKCwLRD5xgi58u1vGIx69
 kSK+7vI0lrmkUpjkLJCyWu6dfy7HPPrLvRk2ssYZZNDmNbgL7EbNYjHvRMisOGJAjqR3
 ut8Q==
X-Gm-Message-State: AOJu0YxQw8lWVB59UHcKIg8zWjzBaWK2ysyWP6qcThLZxKLAY50kEvLf
 I9IHnID1dCZ4PgTj8+aYkuvOBTv+j7rV0n24UmA=
X-Google-Smtp-Source: AGHT+IGLwdTJRLdBrUgCmwFLvvf8TY4GJC/C66qRX6TzKUU+sarGT/3HErPhc2bSdUbbNPrPpoVl7w==
X-Received: by 2002:a05:6870:56a0:b0:1ba:df9e:f2e9 with SMTP id
 p32-20020a05687056a000b001badf9ef2e9mr3078871oao.0.1692968974703; 
 Fri, 25 Aug 2023 06:09:34 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 11/20] target/riscv: introduce KVM AccelCPUClass
Date: Fri, 25 Aug 2023 10:08:44 -0300
Message-ID: <20230825130853.511782-12-dbarboza@ventanamicro.com>
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

Add a KVM accelerator class like we did with TCG. The difference is
that, at least for now, we won't be using a realize() implementation for
this accelerator.

We'll start by assiging kvm_riscv_cpu_add_kvm_properties(), renamed to
kvm_cpu_instance_init(), as a 'cpu_instance_init' implementation. Change
riscv_cpu_post_init() to invoke accel_cpu_instance_init(), which will go
through the 'cpu_instance_init' impl of the current acceleration (if
available) and execute it. The end result is that the KVM initial setup,
i.e. starting registers and adding its specific properties, will be done
via this hook.

riscv_cpu_add_user_properties() is still being called via the common
post_init() function, thus we still need the "if kvm then return" logic
inside it for now. We'll deal with it when TCG accel class get its own
'cpu_instance_init' implementation.

riscv_add_satp_mode_properties() is now being exported from cpu.c since
it's a common helper between KVM and TCG.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c       |  8 ++---
 target/riscv/cpu.h       |  1 +
 target/riscv/kvm.c       | 64 +++++++++++++++++++++++++++-------------
 target/riscv/kvm_riscv.h |  1 -
 4 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 58b0ef2af8..04c6bfaeef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1112,7 +1112,7 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
     satp_map->init |= 1 << satp;
 }
 
-static void riscv_add_satp_mode_properties(Object *obj)
+void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
@@ -1199,6 +1199,8 @@ static void riscv_cpu_post_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
 
+    accel_cpu_instance_init(CPU(obj));
+
     if (rcc->user_extension_properties) {
         riscv_cpu_add_user_properties(obj);
     }
@@ -1561,12 +1563,10 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
 static void riscv_cpu_add_user_properties(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-
     if (kvm_enabled()) {
-        kvm_riscv_cpu_add_kvm_properties(obj);
         return;
     }
+    riscv_add_satp_mode_properties(obj);
 #endif
 
     riscv_cpu_add_misa_properties(obj);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b9c4bea3f7..950c2301f2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -726,6 +726,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern Property riscv_cpu_options[];
 
 void riscv_cpu_add_misa_properties(Object *cpu_obj);
+void riscv_add_satp_mode_properties(Object *obj);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 7e67121456..3c4fa43cee 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -31,6 +31,7 @@
 #include "sysemu/kvm_int.h"
 #include "cpu.h"
 #include "trace.h"
+#include "hw/core/accel-cpu.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
@@ -1262,26 +1263,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
 
-void kvm_riscv_cpu_add_kvm_properties(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-
-    riscv_init_user_properties(obj);
-    riscv_cpu_add_misa_properties(obj);
-
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
-
-    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if KVM created the property already */
-        if (object_property_find(obj, prop->name)) {
-            continue;
-        }
-        qdev_property_add_static(dev, prop);
-    }
-}
-
 static void riscv_host_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -1310,3 +1291,46 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(riscv_kvm_cpu_type_infos)
+
+static void kvm_cpu_instance_init(CPUState *cs)
+{
+    Object *obj = OBJECT(RISCV_CPU(cs));
+    DeviceState *dev = DEVICE(obj);
+
+    riscv_init_user_properties(obj);
+
+    riscv_add_satp_mode_properties(obj);
+    riscv_cpu_add_misa_properties(obj);
+
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
+
+    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
+        /* Check if we have a specific KVM handler for the option */
+        if (object_property_find(obj, prop->name)) {
+            continue;
+        }
+        qdev_property_add_static(dev, prop);
+    }
+}
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = kvm_cpu_instance_init;
+}
+
+static const TypeInfo kvm_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("kvm"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = kvm_cpu_accel_class_init,
+    .abstract = true,
+};
+static void kvm_cpu_accel_register_types(void)
+{
+    type_register_static(&kvm_cpu_accel_type_info);
+}
+type_init(kvm_cpu_accel_register_types);
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 81e08b8359..a0ea1a7505 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -19,7 +19,6 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
-void kvm_riscv_cpu_add_kvm_properties(Object *obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
-- 
2.41.0


