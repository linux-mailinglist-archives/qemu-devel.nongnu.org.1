Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB83740158
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBcm-0003zF-Vx; Tue, 27 Jun 2023 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcb-0003eZ-IV
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:54 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcX-0004tw-Ux
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:32:51 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1aa30191d08so26046fac.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883568; x=1690475568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8VqpGFPSGeVpgOJnRllgdcIk6EK894TdQ7CcFzt6AI=;
 b=EEQ7mKWfZnFZFA17ruie+kY3VfE5DATEMAGRVXiTy93ScxW1AMQ2j+2gHLt3cG8R6w
 40pfopYCRB+C1E+lfsOApGS/vyz24XZ9m8zKftrDMW/1fme+aZIPFNktZHmBCEnsFtZD
 V4w6gIS1xxgwOn5DvpBGDYcMqFV6KrWC5mn8ZV29pNl+xgCZqSyYNI71j7SF0n1eth2a
 C8LUtZgDTPEmQEM8Es8nJJhOuBxGz+IbiJtq+4puPBrakW4VgS7mko5KOMeKb6Z7X6NT
 fwFTd5fCEltvT5G+ZnF2FHRsxReO6ZXXcVWefDB0QneTcDzGobUQBIVoAQ1eujkN7JlX
 dBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883568; x=1690475568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8VqpGFPSGeVpgOJnRllgdcIk6EK894TdQ7CcFzt6AI=;
 b=AlDcxlRqzgkEcNn/LED1VU9zUsdiuKKM1JsXi2idAnlXq3G72f/OHUWlpV5ZV0fzKe
 J8Nac04MuubHClc31ld9tGFyb+boi+TEazt1VR7+WA8afUbyjKnlE4FMkFtuc0XHvtsO
 euAc+8OuJ5oh0YJMUnsioAjHMQqffmxljpVt/mOQxgzaERFO7hWKiKfXoi6iETGpcVXL
 v8vX9Jh9mgchAJXPVB4aDmQJxxlA/mm69k61yHgr7IBiuDv1xtZhyH/ZsX9pj2dW0hMh
 ditwd0jDRoMFeD1f5c68LxRYryagQiV30MvEvajzko2tUbW003nBmv1zeg0cyOIaFSIG
 qEkg==
X-Gm-Message-State: AC+VfDwy0o+mT+/b83dr5t74t+qXR/qQrdOG9RRxuVdpaoTv0YjiWvG+
 kPM7hGLjB5AqN8M93sx0v/n8I5B+c1zMpALD5vw=
X-Google-Smtp-Source: ACHHUZ7QMPcsT/SbP9OAkI/yGtSyZfwF2wtFu699XrfLLPkWkEaDm1UMRw3jm32sjpsQgDFR7iY+9g==
X-Received: by 2002:a05:6870:172c:b0:1b0:73e5:514f with SMTP id
 h44-20020a056870172c00b001b073e5514fmr112443oae.24.1687883568570; 
 Tue, 27 Jun 2023 09:32:48 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:32:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 12/19] target/riscv: add KVM specific MISA properties
Date: Tue, 27 Jun 2023 13:31:56 -0300
Message-ID: <20230627163203.49422-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627163203.49422-1-dbarboza@ventanamicro.com>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
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
extensions we're going to use the newly created misa_ext_infos[] to
populate their name and description. 'offset' holds the MISA bit (RVA,
RVC, ...). We're calling it 'offset' instead of 'misa_bit' because this
same KVMCPUConfig struct will be used to multi-letter extensions later
on.

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
---
 target/riscv/cpu.c | 10 ++++++
 target/riscv/kvm.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0e5d8b05a2..5a50cb1d0b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1610,6 +1610,11 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
         const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
 
+        /* Check if KVM didn't create the property already */
+        if (object_property_find(cpu_obj, misa_cfg->name)) {
+            continue;
+        }
+
         object_property_add(cpu_obj, misa_cfg->name, "bool",
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
@@ -1733,6 +1738,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+        /* Check if KVM didn't create the property already */
+        if (object_property_find(obj, prop->name)) {
+            continue;
+        }
+
         qdev_property_add_static(dev, prop);
     }
 
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 4d0808cb9a..fb5c5d4bfc 100644
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
+        misa_cfg->name = misa_ext_info_arr[bit].name;
+        misa_cfg->description = misa_ext_info_arr[bit].description;
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
2.41.0


