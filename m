Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3819825D0A
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 00:09:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLtGr-0002PE-HB; Fri, 05 Jan 2024 18:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGo-0002O3-NH
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:30 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLtGj-0002KV-UJ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 18:06:30 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9e62ff056so98076b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704495984; x=1705100784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL2XvnZ+VL7Gnef96AYgruQ2CK2f0IPzyKyaL7kZzSI=;
 b=gMjctoJiQ5Z9eErBRgMdrlkCugYKtfz9FHUxus8frVlQjwOAoqHJVe25CSQkBfMmG+
 Z1DwMtDo3F+LLmRO6oFbKNy+JVOZAj1g89uuktoPswrxWrg1UHX8pFn63K+FfBi2EPlX
 FfH1UKwaXW8CUuki7Gfv8zzizKQEMX1voleBwhQqHz192cA37DZwo4YlpGjmkoaLiz/o
 ztXgTfCKtIVIpskS+NSHvf+FQdpkC802VcROosfmXOHmLFGGwSTHHjcht+HgvCT8e4C3
 a0LGIhOHIekNFfFjaIbO25lfk67qXJJMh+1YGn6+PSzDmdCa3im7B+nPn+seDGjVf4si
 7ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704495984; x=1705100784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL2XvnZ+VL7Gnef96AYgruQ2CK2f0IPzyKyaL7kZzSI=;
 b=UhvkzGs4YnxZz1LOfG3DTyHsOnTscT5bZ7DBQeS7Ccu2UoOYysms7yGC8NNGwe60nc
 81QsE1frUUYh6p4bkF+ht2ybQ4R90/REj3bLTBZfg14Ig+8z998k73YQBWD8GdT2vRFC
 R/7LJYkNiGffDm0riHiKiWTW9w+s4yDcpfA0xSkznVXPhn9NPWVVt27tlJUyoepHGWXN
 Dn8ndPnZF6+8uBV4fzbs8pf6qYuhMcEHfzqlayZOx+v48mrci45z7AF4QLYw1MCOGxDn
 vuwX1HEJvdmrftF0xcq5hJVBtLH3vjXC5QxfqApbEgJRsUmqJj+gzdKgxpG4mOl/uscc
 Gf/A==
X-Gm-Message-State: AOJu0Yxl9X6W7TBtNGHjJziYK5mGe2PAXR1S6wWH9R/69eTR+dk93LbS
 JkNqxMpb4WMR0xDYs1fbch2AkEH8I0r2DTbX5tW7+SWPWbCQow==
X-Google-Smtp-Source: AGHT+IE8kpsr07nVJJ7DCnBKx7SrnxgJrXRlZxgmirHEQs0DqdHHE0+Xe1hENZWZ2dzMyue4kb9guA==
X-Received: by 2002:a05:6a21:3387:b0:197:34c4:a650 with SMTP id
 yy7-20020a056a21338700b0019734c4a650mr112415pzb.13.1704495984133; 
 Fri, 05 Jan 2024 15:06:24 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006dacfab07b6sm1849249pfd.121.2024.01.05.15.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 15:06:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 10/17] target/riscv: create finalize_features() for KVM
Date: Fri,  5 Jan 2024 20:05:39 -0300
Message-ID: <20240105230546.265053-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105230546.265053-1-dbarboza@ventanamicro.com>
References: <20240105230546.265053-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

To turn cbom_blocksize and cboz_blocksize into class properties we need
KVM specific changes.

KVM is creating its own version of these options with a customized
setter() that prevents users from picking an invalid value during init()
time. This comes at the cost of duplicating each option that KVM
supports. This will keep happening for each new shared option KVM
implements in the future.

We can avoid that by using the same property TCG uses and adding
specific KVM handling during finalize() time, like TCG already does with
riscv_tcg_cpu_finalize_features(). To do that, the common CPU property
offers a way of knowing if an option was user set or not, sparing us
from doing unneeded syscalls.

riscv_kvm_cpu_finalize_features() is then created using the same
KVMScratch CPU we already use during init() time, since finalize() time
is still too early to use the official KVM CPU for it. cbom_blocksize
and cboz_blocksize are then handled during finalize() in the same way
they're handled by their KVM specific setter.

With this change we can proceed with the blocksize changes in the common
code without breaking the KVM driver.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c           | 16 +++++++---
 target/riscv/cpu.h           |  1 +
 target/riscv/kvm/kvm-cpu.c   | 59 ++++++++++++++++++++++++++++++++++++
 target/riscv/kvm/kvm_riscv.h |  1 +
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2bb4828324..cd91966ea7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -68,6 +68,11 @@ static void cpu_option_add_user_setting(const char *optname, uint32_t value)
                         GUINT_TO_POINTER(value));
 }
 
+bool riscv_cpu_option_set(const char *optname)
+{
+    return g_hash_table_contains(general_user_opts, optname);
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -1104,17 +1109,18 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     }
 #endif
 
-    /*
-     * KVM accel does not have a specialized finalize()
-     * callback because its extensions are validated
-     * in the get()/set() callbacks of each property.
-     */
     if (tcg_enabled()) {
         riscv_tcg_cpu_finalize_features(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (kvm_enabled()) {
+        riscv_kvm_cpu_finalize_features(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3cec85069f..1c19fa84bb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -510,6 +510,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
+bool riscv_cpu_option_set(const char *optname);
 
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 2c5217102c..2713f4b2ba 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1493,6 +1493,65 @@ static void kvm_cpu_instance_init(CPUState *cs)
     }
 }
 
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
+{
+    CPURISCVState *env = &cpu->env;
+    KVMScratchCPU kvmcpu;
+    struct kvm_one_reg reg;
+    uint64_t val;
+    int ret;
+
+    /* short-circuit without spinning the scratch CPU */
+    if (!cpu->cfg.ext_zicbom && !cpu->cfg.ext_zicboz) {
+        return;
+    }
+
+    if (!kvm_riscv_create_scratch_vcpu(&kvmcpu)) {
+        error_setg(errp, "Unable to create scratch KVM cpu");
+        return;
+    }
+
+    if (cpu->cfg.ext_zicbom &&
+        riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
+
+        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+                                        kvm_cbom_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read cbom_blocksize, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.cbom_blocksize != val) {
+            error_setg(errp, "Unable to set cbom_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
+    if (cpu->cfg.ext_zicboz &&
+        riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
+
+        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+                                        kvm_cboz_blocksize.kvm_reg_id);
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            error_setg(errp, "Unable to read cboz_blocksize, error %d", errno);
+            return;
+        }
+
+        if (cpu->cfg.cboz_blocksize != val) {
+            error_setg(errp, "Unable to set cboz_blocksize to a different "
+                       "value than the host (%lu)", val);
+            return;
+        }
+    }
+
+    kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
+}
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 8329cfab82..4bd98fddc7 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -27,5 +27,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
+void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 
 #endif
-- 
2.43.0


