Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA36741AFB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:33:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEclZ-0002Qy-EL; Wed, 28 Jun 2023 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclX-0002PO-Qs
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:55 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclU-0008C7-Rb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:31:55 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-563531a3ad2so281279eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987911; x=1690579911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54SMjhElmEAPBbb4xDkMAN8MHf5hY00rShntys3luNo=;
 b=cJqdJJfduGK01tKOtaaxg3/nU6SoltFefWfcmuQjn0bo5KGBpQcdBM7C9HronIlSBL
 GnEpqKGzVkPYf+vGIYNP5qTNcJZH/WNu/s1POiQsVQUmlBpYJlx5PQHWtQn/KKp/Uabs
 iNrAlTdPdZYLCttOtS70uQGPcY3uoGK5LnXDneBgYx117Dd3VxcIVURyBO7FwaaCfEsX
 S+q+LgqW5doigFFXwwsa3wUO6q19DERX4oyVHNhkfYDR1XYU6fj7DYGKRu+5cxiq82TE
 LryQtIg760+NI/MofN4AGamJQscdZay5HyguajdTQVUy9jLx9Llz2sR+s+adplARERb5
 EYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987911; x=1690579911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54SMjhElmEAPBbb4xDkMAN8MHf5hY00rShntys3luNo=;
 b=ajBQ7gcqKByK+YnMkwxNlRyn7npa36ibpLVBWcvVJyCkbLsrUf9Lxa3QJFZz7wYqWg
 eVMCUbr78rHqlOkItYAfHyTadlh0ssP+04nVf0SqwS76Mp1kJKQ7itGij8TTOtqKl3MK
 7KahlyQ+6ejshtSOD6QqZvLj+OfjLFDhXFJeX/DJZhNNiZV2gfJOa5BGWO0JQj9HJNVK
 ifRbZcZywCrz4nfLOAIEZ3uIxOChCiQrYk4yns/R0bdSrO3Wmqqq80urdJIZJRXXVwPy
 rThxNxumg82tV28gge7Rr4xnbsbI4F88m/ufW8rIPlFB8457N7bRGzeoQ3KZDlhy7Ip/
 32UQ==
X-Gm-Message-State: AC+VfDyh41PSAYuqTyD7sF1r8sOj/MUqeEtINDEyNRek5kTPw9TefKbG
 c7PQQqSzDGoiUuBOTHRx8lulPQ2MaJSyKsml9zQ=
X-Google-Smtp-Source: ACHHUZ6MR1L+7sYOzy84wX9d0idx+bdHHhyKNWNgMBeCMsKEruR3mxQo5p1Na3piRTo+Cl1vR8b5jQ==
X-Received: by 2002:a4a:c209:0:b0:565:9028:d034 with SMTP id
 z9-20020a4ac209000000b005659028d034mr4268869oop.4.1687987911550; 
 Wed, 28 Jun 2023 14:31:51 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:31:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 12/20] target/riscv: add KVM specific MISA properties
Date: Wed, 28 Jun 2023 18:30:25 -0300
Message-ID: <20230628213033.170315-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc34.google.com
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
---
 target/riscv/cpu.c | 13 +++++---
 target/riscv/kvm.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 90dd2078ae..f4b1868466 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1617,14 +1617,19 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
         RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        Error *local_err = NULL;
 
         misa_cfg->name = riscv_get_misa_ext_name(misa_cfg->misa_bit);
         misa_cfg->description = riscv_get_misa_ext_descr(misa_cfg->misa_bit);
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool",
-                            cpu_get_misa_ext_cfg,
-                            cpu_set_misa_ext_cfg,
-                            NULL, (void *)misa_cfg);
+        object_property_try_add(cpu_obj, misa_cfg->name, "bool",
+                                cpu_get_misa_ext_cfg, cpu_set_misa_ext_cfg,
+                                NULL, (void *)misa_cfg, &local_err);
+        if (local_err) {
+            /* Someone (KVM) already created the property */
+            continue;
+        }
+
         object_property_set_description(cpu_obj, misa_cfg->name,
                                         misa_cfg->description);
         object_property_set_bool(cpu_obj, misa_cfg->name,
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 4d0808cb9a..0fb63cced3 100644
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
+        misa_cfg->description = riscv_get_misa_ext_descr(bit);
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


