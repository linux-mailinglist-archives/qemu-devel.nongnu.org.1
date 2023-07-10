Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B374D598
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6a-0006vn-3H; Mon, 10 Jul 2023 08:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6W-0006ju-03
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6T-00053B-0V
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2798690b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992495; x=1691584495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pjOzvgjLm8qJ/w0Q13GiZx9lAvw4QAMETAOnWNMd/I=;
 b=c6S0XChGnlPzbBVwjKBF5vjsJMXXCIh//6OsrBNpzUEXMvKC+X7Xy0/Z3o4Q/W+l0u
 JO/dSxW0roUKXwRJM1zl6MtXjEHWjnhzB531PCe5Hv73Vdm9/aeCaHfKm2em0d/ocFEZ
 D985kpNH1GJSZhRgS3GU5aW/0fk4R64xQoy4AjbSkTU4J2BhDYUPBvoNn6yVgZ47U/cS
 tvfVME4TBfqj9T1IE22sSYJzNTLcVNxrvqYdbuhy9+BCJE8ftj89XyqCgcQFW64xQPhT
 OOCr/c1D5TKSEC0gVSeoYYOCMIUvTjJkF9vp7uvWdc4aOXxfZeunvk25CmQlSwq42dZW
 S0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992495; x=1691584495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pjOzvgjLm8qJ/w0Q13GiZx9lAvw4QAMETAOnWNMd/I=;
 b=TQgLGFJzKFWVr6RydLC/xC+bOc+sr+k/jsDNbilPuhHZeLnS1mvRzCcYjArs3nGPd+
 UvpzbnY8CE/y+qdwwUEyU+kghycyQou18OqhFHNPaG4lRH3fjTz96KtwQaKw4x+lbQlf
 BRTIuevNz2UWaiOhuRFF6+dpJnYXIlhkwFsMob4CCVOmDfxbyZnapvQCS6ApWzhw3hLY
 +gsRi63h0v4n4/MPNljjOWtP+EH9ClWwe4TcKPv0eTgf8q6I0tTPhB0/0+MJEBa4dzC8
 +ktYWzTqPV3QgaceWM5pwPveFmftLwhdTGkyWNfqpwzhTsqN8pNsHI47ha5HkkVWGeup
 Yl9Q==
X-Gm-Message-State: ABy/qLaDFn/f0QGpqU+nR3S50VSxN5Id1OTcvLcpt6m9g6uQqdbcAFt7
 yxVBTyIBaBfwF/G9BUp7EdoJ9ULkuOOp0Q==
X-Google-Smtp-Source: APBJJlGBKhw3pG1AsjWJRTugm8ogJCtNtEGbZhpahtAH7MQc9klFpaQIHUdUzrBEw+YJmM9gNSPrzA==
X-Received: by 2002:a05:6a20:7346:b0:125:dd60:957a with SMTP id
 v6-20020a056a20734600b00125dd60957amr23142209pzc.26.1688992495257; 
 Mon, 10 Jul 2023 05:34:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/54] target/riscv: add KVM specific MISA properties
Date: Mon, 10 Jul 2023 22:31:56 +1000
Message-Id: <20230710123205.2441106-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Using all TCG user properties in KVM is tricky. First because KVM
supports only a small subset of what TCG provides, so most of the
cpu->cfg flags do nothing for KVM.

Second, and more important, we don't have a way of telling if any given
value is an user input or not. For TCG this has a small impact since we
just validating everything and error out if needed. But for KVM it would
be good to know if a given value was set by the user or if it's a value
already provided by KVM. Otherwise we don't know how to handle failed
kvm_set_one_regs() when writing the configurations back.

These characteristics make it overly complicated to use the same user
facing flags for both KVM and TCG. A simpler approach is to create KVM
specific properties that have specialized logic, forking KVM and TCG use
cases for those cases only. Fully separating KVM/TCG properties is
unneeded at this point - in fact we want the user experience to be as
equal as possible, regardless of the acceleration chosen.

We'll start this fork with the MISA properties, adding the MISA bits
that the KVM driver currently supports. A new KVMCPUConfig type is
introduced. It'll hold general information about an extension. For MISA
extensions we're going to use the newly created getters of
misa_ext_infos[] to populate their name and description. 'offset' holds
the MISA bit (RVA, RVC, ...). We're calling it 'offset' instead of
'misa_bit' because this same KVMCPUConfig struct will be used to
multi-letter extensions later on.

This new type also holds a 'user_set' flag. This flag will be set when
the user set an option that's different than what is already configured
in the host, requiring KVM intervention to write the regs back during
kvm_arch_init_vcpu(). Similar mechanics will be implemented for
multi-letter extensions as well.

There is no need to duplicate more code than necessary, so we're going
to use the existing kvm_riscv_init_user_properties() to add the KVM
specific properties. Any code that is adding a TCG user prop is then
changed slightly to verify first if there's a KVM prop with the same
name already added.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c |  5 +++
 target/riscv/kvm.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 35ba220c8f..5c8832a030 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1726,6 +1726,11 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
         misa_cfg->name = riscv_get_misa_ext_name(bit);
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
+        /* Check if KVM already created the property */
+        if (object_property_find(cpu_obj, misa_cfg->name)) {
+            continue;
+        }
+
         object_property_add(cpu_obj, misa_cfg->name, "bool",
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0d19267010..8cd08f4396 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -22,8 +22,10 @@
 #include <linux/kvm.h>
 
 #include "qemu/timer.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
@@ -105,6 +107,81 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
         } \
     } while (0)
 
+typedef struct KVMCPUConfig {
+    const char *name;
+    const char *description;
+    target_ulong offset;
+    int kvm_reg_id;
+    bool user_set;
+} KVMCPUConfig;
+
+#define KVM_MISA_CFG(_bit, _reg_id) \
+    {.offset = _bit, .kvm_reg_id = _reg_id}
+
+/* KVM ISA extensions */
+static KVMCPUConfig kvm_misa_ext_cfgs[] = {
+    KVM_MISA_CFG(RVA, KVM_RISCV_ISA_EXT_A),
+    KVM_MISA_CFG(RVC, KVM_RISCV_ISA_EXT_C),
+    KVM_MISA_CFG(RVD, KVM_RISCV_ISA_EXT_D),
+    KVM_MISA_CFG(RVF, KVM_RISCV_ISA_EXT_F),
+    KVM_MISA_CFG(RVH, KVM_RISCV_ISA_EXT_H),
+    KVM_MISA_CFG(RVI, KVM_RISCV_ISA_EXT_I),
+    KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
+};
+
+static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
+                                     const char *name,
+                                     void *opaque, Error **errp)
+{
+    KVMCPUConfig *misa_ext_cfg = opaque;
+    target_ulong misa_bit = misa_ext_cfg->offset;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    CPURISCVState *env = &cpu->env;
+    bool value, host_bit;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    host_bit = env->misa_ext_mask & misa_bit;
+
+    if (value == host_bit) {
+        return;
+    }
+
+    if (!value) {
+        misa_ext_cfg->user_set = true;
+        return;
+    }
+
+    /*
+     * Forbid users to enable extensions that aren't
+     * available in the hart.
+     */
+    error_setg(errp, "Enabling MISA bit '%s' is not allowed: it's not "
+               "enabled in the host", misa_ext_cfg->name);
+}
+
+static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
+        KVMCPUConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
+        int bit = misa_cfg->offset;
+
+        misa_cfg->name = riscv_get_misa_ext_name(bit);
+        misa_cfg->description = riscv_get_misa_ext_description(bit);
+
+        object_property_add(cpu_obj, misa_cfg->name, "bool",
+                            NULL,
+                            kvm_cpu_set_misa_ext_cfg,
+                            NULL, misa_cfg);
+        object_property_set_description(cpu_obj, misa_cfg->name,
+                                        misa_cfg->description);
+    }
+}
+
 static int kvm_riscv_get_regs_core(CPUState *cs)
 {
     int ret = 0;
@@ -427,6 +504,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
         return;
     }
 
+    kvm_riscv_add_cpu_user_properties(cpu_obj);
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
 
-- 
2.40.1


