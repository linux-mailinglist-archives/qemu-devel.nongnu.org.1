Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7D741AFF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEclm-0003CV-G8; Wed, 28 Jun 2023 17:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclj-0002xH-Rr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:07 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclf-0008KM-RZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:07 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-55e04a83465so272718eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987922; x=1690579922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAadMgIBMzJkDCxfYYnNPQcohvqYRfwBqmdA9oaUIwM=;
 b=O73OGv7kVpE/hrCF65pGbTjilkFH80ZLzP+jupdllWyOhEkwfXBVxiMR/GAoNvHdJi
 TC1qxCfYf8Mj1hNQy4Zq6/8nrSN4bEPAYTB9ccUwNC8FrNRlGSRdw+5Y4jF8Us2w30be
 vgwAjC9u1x0QsNp5RYBcbIUK5l8IxIeDsgBl8CrkP1cvSd31fuJXpK3FgnMeTwZa/XEm
 oh41zzDb59OPdV6FYQSV0NEmpDz/Urw1z5Z86nwappczXBJO9L8Xiz9DrdnytXgac3Rs
 2hM0GdlstPI9DI9OoAWfrpf5b0rAIEGJKERJ/ATqKPS+gbNPK1YuruEZHLW4y5UuGMLQ
 hi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987922; x=1690579922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAadMgIBMzJkDCxfYYnNPQcohvqYRfwBqmdA9oaUIwM=;
 b=cE3tdDIdJs11xX7HUNkY3YNvdUFykAFmzcE+4fzmwJsnVckPTYSJwXe5wQejkoR+Fe
 yIyynnrCLQr7q+y93s93oP5ss1py9fj4Eq7CeQo6Zy+hiV39FGARlKXs08E3V1c2kZVP
 RIdmWO4A/QjpC4798PVSbvpzrqUc4zqGLbtSEYcrS9i3uGI9jCuGFjLScK0TnpKfwog0
 9OWWxMgMVpvLCy6fAfEmBxm0TwZDyL3G3qS4BMWj6qrmOo0Xxq6KRA6u7rqMBF+DLblW
 rV0Uy1UPJiPG2JRnffOjoe/C/D5Q3csUMntF4lKQl2KibSFjaNJLJwDVghArCpo82CEo
 RLVg==
X-Gm-Message-State: AC+VfDyDYNj6q9Unzhrom7dwYiWRhqWmTBPqDj3cuyF37XkATHmDrEx0
 W5Rwqhrzo4calOzc+rht4rHbiDcMmdI0qdxIpKk=
X-Google-Smtp-Source: ACHHUZ5PDW67Qj9WYeRmvWdi3it6mHhlxb14d+I2tq+zjvyE5P/tPlx1xJNsCFGz4MgT0rHhufJCxQ==
X-Received: by 2002:a4a:d6c5:0:b0:565:a8a8:6601 with SMTP id
 j5-20020a4ad6c5000000b00565a8a86601mr2657187oot.8.1687987922564; 
 Wed, 28 Jun 2023 14:32:02 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:32:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 14/20] target/riscv/kvm.c: add multi-letter extension KVM
 properties
Date: Wed, 28 Jun 2023 18:30:27 -0300
Message-ID: <20230628213033.170315-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
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

Let's add KVM user properties for the multi-letter extensions that KVM
currently supports: zicbom, zicboz, zihintpause, zbb, ssaia, sstc,
svinval and svpbmt.

As with MISA extensions, we're using the KVMCPUConfig type to hold
information about the state of each extension. However, multi-letter
extensions have more cases to cover than MISA extensions, so we're
adding an extra 'supported' flag as well. This flag will reflect if a
given extension is supported by KVM, i.e. KVM knows how to handle it.
This is determined during KVM extension discovery in
kvm_riscv_init_multiext_cfg(), where we test for EINVAL errors. Any
other error different from EINVAL will cause an abort.

The use of the 'user_set' is similar to what we already do with MISA
extensions: the flag set only if the user is changing the extension
state.

The 'supported' flag will be used later on to make an exception for
users that are disabling multi-letter extensions that are unknown to
KVM.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c |   8 +++
 target/riscv/kvm.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f4b1868466..5428402cfa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1751,6 +1751,14 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
+#ifndef CONFIG_USER_ONLY
+        if (kvm_enabled()) {
+            /* Check if KVM created the property already */
+            if (object_property_find(obj, prop->name)) {
+                continue;
+            }
+        }
+#endif
         qdev_property_add_static(dev, prop);
     }
 
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index ba97b0cbed..68f6538b04 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -113,6 +113,7 @@ typedef struct KVMCPUConfig {
     target_ulong offset;
     int kvm_reg_id;
     bool user_set;
+    bool supported;
 } KVMCPUConfig;
 
 #define KVM_MISA_CFG(_bit, _reg_id) \
@@ -197,6 +198,81 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
+
+#define KVM_EXT_CFG(_name, _prop, _reg_id) \
+    {.name = _name, .offset = CPUCFG(_prop), \
+     .kvm_reg_id = _reg_id}
+
+static KVMCPUConfig kvm_multi_ext_cfgs[] = {
+    KVM_EXT_CFG("zicbom", ext_icbom, KVM_RISCV_ISA_EXT_ZICBOM),
+    KVM_EXT_CFG("zicboz", ext_icboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
+    KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
+    KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
+    KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
+    KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
+    KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
+};
+
+static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
+                            uint32_t val)
+{
+    int cpu_cfg_offset = multi_ext->offset;
+    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+
+    *ext_enabled = val;
+}
+
+static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
+                                KVMCPUConfig *multi_ext)
+{
+    int cpu_cfg_offset = multi_ext->offset;
+    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+
+    return *ext_enabled;
+}
+
+static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque, Error **errp)
+{
+    KVMCPUConfig *multi_ext_cfg = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value, host_val;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    host_val = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
+
+    /*
+     * Ignore if the user is setting the same value
+     * as the host.
+     */
+    if (value == host_val) {
+        return;
+    }
+
+    if (!multi_ext_cfg->supported) {
+        /*
+         * Error out if the user is trying to enable an
+         * extension that KVM doesn't support. Ignore
+         * option otherwise.
+         */
+        if (value) {
+            error_setg(errp, "KVM does not support disabling extension %s",
+                       multi_ext_cfg->name);
+        }
+
+        return;
+    }
+
+    multi_ext_cfg->user_set = true;
+    kvm_cpu_cfg_set(cpu, multi_ext_cfg, value);
+}
+
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
     int i;
@@ -215,6 +291,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         object_property_set_description(cpu_obj, misa_cfg->name,
                                         misa_cfg->description);
     }
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
+
+        object_property_add(cpu_obj, multi_cfg->name, "bool",
+                            NULL,
+                            kvm_cpu_set_multi_ext_cfg,
+                            NULL, multi_cfg);
+    }
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
@@ -530,6 +615,39 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     env->misa_ext = env->misa_ext_mask;
 }
 
+static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
+        struct kvm_one_reg reg;
+
+        reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
+                                  multi_ext_cfg->kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            if (ret == -EINVAL) {
+                /* Silently default to 'false' if KVM does not support it. */
+                multi_ext_cfg->supported = false;
+                val = false;
+            } else {
+                error_report("Unable to read ISA_EXT KVM register %s, "
+                             "error %d", multi_ext_cfg->name, ret);
+                kvm_riscv_destroy_scratch_vcpu(kvmcpu);
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            multi_ext_cfg->supported = true;
+        }
+
+        kvm_cpu_cfg_set(cpu, multi_ext_cfg, val);
+    }
+}
+
 void kvm_riscv_init_user_properties(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
@@ -542,6 +660,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
     kvm_riscv_add_cpu_user_properties(cpu_obj);
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
+    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.41.0


