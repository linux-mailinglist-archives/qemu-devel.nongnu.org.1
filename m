Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5831716E01
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45JU-0006pA-60; Tue, 30 May 2023 15:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45JP-0006kV-Nt
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:19 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45JL-0004Lm-8S
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:47:18 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-557c7ffea48so1924765eaf.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685476033; x=1688068033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXyrX/hWg5SdONVi7pUjZJLGr6l31mwjZu1Biy0qrQU=;
 b=lFccBwVkUHRytZGtblPCdsYVYTkK8Z9CNp7oauRS4ei60GzmpZOmfNhv5t6yKAyBnL
 bKkQXDgoitiGNT4lb2xFBQIcowMV53XF0KsipYFq19LTaPLoA/B+lVt/smVVD9WKGSwT
 wPYaFLOXH7l8S3m3gWJFsRzkO20MjMuREO+jjjpCLsXlg2RQ/wSeZ9XJpEhc3g7GBn+F
 n3d3eR30PixIdVAwRvDKqM1M0RuDbvmHtZqzmCsySpK3NS6+Rk1u3yAz+SsIz2VK7drM
 5DcaOmSirZbFBedWg74/jnfTaKNKwOv5B3NH7enAR/DeYz6MU7gMOUUjcf6Q8o47gVqe
 cK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685476033; x=1688068033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXyrX/hWg5SdONVi7pUjZJLGr6l31mwjZu1Biy0qrQU=;
 b=Ox5v5tth3EkKgUcKODCGyKZMiGKjAml8b9exUcI4KumdQnb7ZwHtesD2+MCJq+URH/
 UsTCkBewXtb61rPs7/OjgcGM2Dr4WIE+cs+CaVz+kHDtUfH57etLY0fbtV0/9neDfrrm
 7pwECx5oJ8fwTxveVNa54nSbBuA/qk8+X13e/B3f8qAuzq3F8F/WT4lNucofoZowLqqo
 MIZuG/nVwLyytArQjv4KkZsuWoNxmmmVbXX7YRpdjrOK1yogBpBgH3Y8eSIqTs+yGIgn
 KkrBRJZWRd2guBwrnE46IUr6S73cKHAIRTYV5IsjNbOyF3r6QOPZ33+PLZ/5WhYWMgs2
 qfpw==
X-Gm-Message-State: AC+VfDyDSwMtCiAHQ+VCHsMfgHzzeMj//W0BS0qL5KV0+yi8lrwIwKqV
 OAfa0y48BUtc5Ap9y+BZqW1a06RpK8qVFg0dDJs=
X-Google-Smtp-Source: ACHHUZ41Ft/IGKNjSq/VjiuKwfHkybXxm52zjEvTcOJzx9UcLCHlgtnMs4KG+FT71mFwIckOpx5DNA==
X-Received: by 2002:a05:6808:1a93:b0:398:29f4:366d with SMTP id
 bm19-20020a0568081a9300b0039829f4366dmr1618956oib.5.1685476032787; 
 Tue, 30 May 2023 12:47:12 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-121.static-corp.ajato.com.br. [200.162.225.121])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056870a48300b0019fa8728b05sm342214oal.39.2023.05.30.12.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:47:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 13/16] target/riscv/kvm.c: add multi-letter extension KVM
 properties
Date: Tue, 30 May 2023 16:46:20 -0300
Message-Id: <20230530194623.272652-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530194623.272652-1-dbarboza@ventanamicro.com>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
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

As with the recently added MISA properties we're also going to add a
'user_set' flag in each of them. The flag will be set only if the user
chose an option that's different from the host and will require extra
handling from the KVM driver.

However, multi-letter CPUs have more cases to cover than MISA
extensions, so we're adding an extra 'supported' flag as well. This flag
will reflect if a given extension is supported by KVM, i.e. KVM knows
how to handle it. This is determined during KVM extension discovery in
kvm_riscv_init_multiext_cfg(), where we test for EINVAL errors. Any
other error different from EINVAL will cause an abort.

The 'supported' flag will then be used later on to give an exception for
users that are disabling multi-letter extensions that are unknown to
KVM.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm.c | 136 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index bb1dafe263..b4193a10d8 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -202,6 +202,99 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
     }
 }
 
+typedef struct RISCVCPUMultiExtConfig {
+    const char *name;
+    int kvm_reg_id;
+    int cpu_cfg_offset;
+    bool supported;
+    bool user_set;
+} RISCVCPUMultiExtConfig;
+
+#define CPUCFG(_prop) offsetof(struct RISCVCPUConfig, _prop)
+
+/*
+ * KVM ISA Multi-letter extensions. We care about the order
+ * since it'll be used to create the ISA string later on.
+ * We follow the same ordering rules of isa_edata_arr[]
+ * from target/riscv/cpu.c.
+ */
+static RISCVCPUMultiExtConfig kvm_multi_ext_cfgs[] = {
+    {.name = "zicbom", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZICBOM,
+     .cpu_cfg_offset = CPUCFG(ext_icbom)},
+    {.name = "zicboz", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZICBOZ,
+     .cpu_cfg_offset = CPUCFG(ext_icboz)},
+    {.name = "zihintpause", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
+     .cpu_cfg_offset = CPUCFG(ext_zihintpause)},
+    {.name = "zbb", .kvm_reg_id = KVM_RISCV_ISA_EXT_ZBB,
+     .cpu_cfg_offset = CPUCFG(ext_zbb)},
+    {.name = "ssaia", .kvm_reg_id = KVM_RISCV_ISA_EXT_SSAIA,
+     .cpu_cfg_offset = CPUCFG(ext_ssaia)},
+    {.name = "sstc", .kvm_reg_id = KVM_RISCV_ISA_EXT_SSTC,
+     .cpu_cfg_offset = CPUCFG(ext_sstc)},
+    {.name = "svinval", .kvm_reg_id = KVM_RISCV_ISA_EXT_SVINVAL,
+     .cpu_cfg_offset = CPUCFG(ext_svinval)},
+    {.name = "svpbmt", .kvm_reg_id = KVM_RISCV_ISA_EXT_SVPBMT,
+     .cpu_cfg_offset = CPUCFG(ext_svpbmt)},
+};
+
+static void kvm_cpu_cfg_set(RISCVCPU *cpu, RISCVCPUMultiExtConfig *multi_ext,
+                            uint32_t val)
+{
+    int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+
+    *ext_enabled = val;
+}
+
+static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
+                                RISCVCPUMultiExtConfig *multi_ext)
+{
+    int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+
+    return *ext_enabled;
+}
+
+static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
+                                      const char *name,
+                                      void *opaque, Error **errp)
+{
+    RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
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
@@ -216,6 +309,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         object_property_set_description(cpu_obj, misa_cfg->name,
                                         misa_cfg->description);
     }
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        RISCVCPUMultiExtConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
+
+        object_property_add(cpu_obj, multi_cfg->name, "bool",
+                            NULL,
+                            kvm_cpu_set_multi_ext_cfg,
+                            NULL, multi_cfg);
+    }
 }
 
 static int kvm_riscv_get_regs_core(CPUState *cs)
@@ -531,6 +633,39 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     env->misa_ext = env->misa_ext_mask;
 }
 
+static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    CPURISCVState *env = &cpu->env;
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
+        RISCVCPUMultiExtConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
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
@@ -543,6 +678,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
     kvm_riscv_add_cpu_user_properties(cpu_obj);
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
+    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.40.1


