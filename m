Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3297ADE44
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpqH-0000mZ-Dm; Mon, 25 Sep 2023 13:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqF-0000lr-TB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qkpqA-0002Du-Uw
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:57:55 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-578d0d94986so5032146a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695664669; x=1696269469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDVkCr5LYXxfDA6GCy65wJeT7zywjPXlKXx4Zd0pAI8=;
 b=I2IGWpQIWX14A3FIm9Q+qQMqxvupae3+XlwwGko9LnFjNey0YqwwDySR97xRvgOVYj
 s2wZU+dLTaB2DRfe6yQuctlspxg1iBUetdHLEouEoadZMOOD9ZRWCbLE1W2ioMwyM0Sc
 JkpX1BjQdbU6nHIDGvQHv3QlILjexT1fXwKtHaZY946h/AS7HmIgNDkFgCJ1f1mtMpZ3
 ZiDGOrJsANLehkMojReBYzgyG0FD2+JgJrL1NvI7vQHAWBnK1TgWq9wtjWPCO7/Z4zcF
 TZNtHRjYlmNLahu/0sFDVwJziiiZkEY0hpHea5cnLAQgXGTaE8CSrDHp9rIMg5HUUgmA
 oqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695664669; x=1696269469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDVkCr5LYXxfDA6GCy65wJeT7zywjPXlKXx4Zd0pAI8=;
 b=EeU/hPcYlcXrBYouTwWPJ2T6UxhWftl+U+y4DalxGr5gVeWOq1KLQJaB0THF98LVyB
 epg3yffa8APtNMTcuJMP8zjF21jUffuEIbkKszQigyeyxyiUWi8ULmtewYaCfwWTnbp3
 Yy4abtsGNUyYEQhyyXun0Vrs9pcEYX+uSqM+W3y3xmW6iFsgIUA+7o59xgFpFbF0dyyR
 S2T9Sb5ghT/A7BuRvcRK9i1LmhxkTvqrZwVJi+9idFtzoKQA5UQdeChjvyTu9J6BwChT
 OtsgSpkIn2ktU445QP3+bhBvzM+QVZ3GFLEoWc3xA+p9Ns2Hteg2QH8iF3S2i7iUfzaT
 IKgQ==
X-Gm-Message-State: AOJu0Yyd7/WwT1Lh0AAiTpQcyX5Fwg11O1YFpbiP8LjZzQGFpPnVbmIA
 IZ8og1rIWflFi3WNt/VSUXyC4Dwf3a0+Xbe6yB4=
X-Google-Smtp-Source: AGHT+IGxzZSztogBu83hK4+jrL94X0bUoVdEM9JjYCU3cP4hU6tG3wYT+MW5JphU2GDmbP7S8VFRvQ==
X-Received: by 2002:a17:90a:bf11:b0:26b:534e:234 with SMTP id
 c17-20020a17090abf1100b0026b534e0234mr6474257pjs.35.1695664669326; 
 Mon, 25 Sep 2023 10:57:49 -0700 (PDT)
Received: from grind.. ([177.94.42.59]) by smtp.gmail.com with ESMTPSA id
 i3-20020a17090a65c300b00262ca945cecsm3312722pjs.54.2023.09.25.10.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:57:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 11/19] target/riscv: introduce KVM AccelCPUClass
Date: Mon, 25 Sep 2023 14:57:01 -0300
Message-ID: <20230925175709.35696-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925175709.35696-1-dbarboza@ventanamicro.com>
References: <20230925175709.35696-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add a 'tcg_enabled()' condition in riscv_cpu_post_init() to avoid
calling riscv_cpu_add_user_properties() when running KVM. We'll remove
this condition when the TCG accel class get its own 'cpu_instance_init'
implementation.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |  8 +++-----
 target/riscv/kvm.c       | 26 ++++++++++++++++++++++++--
 target/riscv/kvm_riscv.h |  1 -
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 50be127f36..c8a19be1af 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1219,7 +1219,9 @@ static bool riscv_cpu_has_user_properties(Object *cpu_obj)
 
 static void riscv_cpu_post_init(Object *obj)
 {
-    if (riscv_cpu_has_user_properties(obj)) {
+    accel_cpu_instance_init(CPU(obj));
+
+    if (tcg_enabled() && riscv_cpu_has_user_properties(obj)) {
         riscv_cpu_add_user_properties(obj);
     }
 
@@ -1589,10 +1591,6 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
 static void riscv_cpu_add_user_properties(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
-    if (kvm_enabled()) {
-        kvm_riscv_cpu_add_kvm_properties(obj);
-        return;
-    }
     riscv_add_satp_mode_properties(obj);
 #endif
 
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index e5e957121f..606fdab223 100644
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
@@ -1318,8 +1319,9 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
 
-void kvm_riscv_cpu_add_kvm_properties(Object *obj)
+static void kvm_cpu_instance_init(CPUState *cs)
 {
+    Object *obj = OBJECT(RISCV_CPU(cs));
     DeviceState *dev = DEVICE(obj);
 
     riscv_init_user_properties(obj);
@@ -1331,7 +1333,7 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
     riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
 
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
-        /* Check if KVM created the property already */
+        /* Check if we have a specific KVM handler for the option */
         if (object_property_find(obj, prop->name)) {
             continue;
         }
@@ -1339,6 +1341,26 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
     }
 }
 
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
+
 static void riscv_host_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index da9630c4af..8329cfab82 100644
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


