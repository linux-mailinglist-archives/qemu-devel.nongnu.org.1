Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB07749939
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM3w-0004sC-Lf; Thu, 06 Jul 2023 06:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3u-0004rJ-Ow
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:10 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM3q-0006Zw-Lu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:10 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b723aedd3dso366147a34.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638685; x=1691230685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33KLGr0PYPhXh2aqp4GGNqlAtjUXgfgNTsUYRUiF5eg=;
 b=V3MC60ndOaZ9Tqi28FJgLGBShhbhfwwYHEzZ9n702v0nQBToHaf4yiymcnpa3y8nb1
 sgw+DNQSCtH/SPwq5wIH5ZMluWC6B0CAl6i24k4GhDGO+RG8VacU+olOWymhq/e5qVip
 CMg+MN0/BInM3CdvD2VpkFwhwWoIsSXUwkPD91XEEWF8M/w1BwulfftWMnmHBD1kzbuk
 jUP/l9rt5WZ0pbe0S7JwJUtyHYQzd5t48Z+32gGqIF7GSaMJu26Lw1T8Zf/sTBiXe+x2
 UPo9G8EeXJhsgivud/f8qIjjOZdq4HJTndh1FprlB7l7+XCz7aub6+7uWyhyfsSQV0Mm
 whiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638685; x=1691230685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33KLGr0PYPhXh2aqp4GGNqlAtjUXgfgNTsUYRUiF5eg=;
 b=NuVn+mtHciLjHQA4k1o+0+p18+Xw9fwlJlJncRK+zMCRDwKRXFdrBnyDXMFpZKl3G0
 vRF8uAuib7aMqvcUkUg/59tA0wlbS3LAFGAs2a7Rd2evKJoQKBI0M+SO1NIhXLZWjU8e
 AYG2AU698AOMdvcXZBkF2BR0za1xM84MDMHHpI7fUx4uECikTVqr5x2jZUyl+Sv40xku
 cuhsQG+k7cTPWDjqIlnj04xgNMO1voTXAL7zXlFdhC+r1YKslEhTwdAFTo2NJtXoUhzW
 du2Cb1QUvQXiio3y6AQEeZBJ8AZkDF7KUoccfDIOBFxRdE4zMIJ0QA1s6Cile9+LCphU
 530A==
X-Gm-Message-State: ABy/qLaYNFAQWFRuA2+ckJdPdM+ELpibdHEQ1rnyDdTkgmp87+Mg3O0n
 80KDmUnDNRkOpQg00b2c9t66LOoHT68NNzbbNI4=
X-Google-Smtp-Source: APBJJlHlqNgjyfOuGHVHLVe8dP0n6KQTKZ2KFAqF64m8vk98S/gaTKZS8GAZAa1pvB/bokdIdH3yRw==
X-Received: by 2002:a9d:77cc:0:b0:6ab:280b:252a with SMTP id
 w12-20020a9d77cc000000b006ab280b252amr1242404otl.17.1688638685304; 
 Thu, 06 Jul 2023 03:18:05 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:18:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 06/20] target/riscv: use KVM scratch CPUs to init KVM
 properties
Date: Thu,  6 Jul 2023 07:17:24 -0300
Message-ID: <20230706101738.460804-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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

Certain validations, such as the validations done for the machine IDs
(mvendorid/marchid/mimpid), are done before starting the CPU.
Non-dynamic (named) CPUs tries to match user input with a preset
default. As it is today we can't prefetch a KVM default for these cases
because we're only able to read/write KVM regs after the vcpu is
spinning.

Our target/arm friends use a concept called "scratch CPU", which
consists of creating a vcpu for doing queries and validations and so on,
which is discarded shortly after use [1]. This is a suitable solution
for what we need so let's implement it in target/riscv as well.

kvm_riscv_init_machine_ids() will be used to do any pre-launch setup for
KVM CPUs, via riscv_cpu_add_user_properties(). The function will create
a KVM scratch CPU, fetch KVM regs that work as default values for user
properties, and then discard the scratch CPU afterwards.

We're starting by initializing 'mvendorid'. This concept will be used to
init other KVM specific properties in the next patches as well.

[1] target/arm/kvm.c, kvm_arm_create_scratch_host_vcpu()

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |  6 +++
 target/riscv/kvm.c       | 85 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h |  1 +
 3 files changed, 92 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9080d021fa..0e1265bb17 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1792,6 +1792,12 @@ static void riscv_cpu_add_user_properties(Object *obj)
     Property *prop;
     DeviceState *dev = DEVICE(obj);
 
+#ifndef CONFIG_USER_ONLY
+    if (kvm_enabled()) {
+        kvm_riscv_init_user_properties(obj);
+    }
+#endif
+
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f932a5b96..37f0f70794 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -309,6 +309,91 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
+typedef struct KVMScratchCPU {
+    int kvmfd;
+    int vmfd;
+    int cpufd;
+} KVMScratchCPU;
+
+/*
+ * Heavily inspired by kvm_arm_create_scratch_host_vcpu()
+ * from target/arm/kvm.c.
+ */
+static bool kvm_riscv_create_scratch_vcpu(KVMScratchCPU *scratch)
+{
+    int kvmfd = -1, vmfd = -1, cpufd = -1;
+
+    kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
+    if (kvmfd < 0) {
+        goto err;
+    }
+    do {
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, 0);
+    } while (vmfd == -1 && errno == EINTR);
+    if (vmfd < 0) {
+        goto err;
+    }
+    cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
+    if (cpufd < 0) {
+        goto err;
+    }
+
+    scratch->kvmfd =  kvmfd;
+    scratch->vmfd = vmfd;
+    scratch->cpufd = cpufd;
+
+    return true;
+
+ err:
+    if (cpufd >= 0) {
+        close(cpufd);
+    }
+    if (vmfd >= 0) {
+        close(vmfd);
+    }
+    if (kvmfd >= 0) {
+        close(kvmfd);
+    }
+
+    return false;
+}
+
+static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
+{
+    close(scratch->cpufd);
+    close(scratch->vmfd);
+    close(scratch->kvmfd);
+}
+
+static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    CPURISCVState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    int ret;
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    reg.addr = (uint64_t)&cpu->cfg.mvendorid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve mvendorid from host, error %d", ret);
+    }
+}
+
+void kvm_riscv_init_user_properties(Object *cpu_obj)
+{
+    RISCVCPU *cpu = RISCV_CPU(cpu_obj);
+    KVMScratchCPU kvmcpu;
+
+    if (!kvm_riscv_create_scratch_vcpu(&kvmcpu)) {
+        return;
+    }
+
+    kvm_riscv_init_machine_ids(cpu, &kvmcpu);
+
+    kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
+}
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index ed281bdce0..e3ba935808 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -19,6 +19,7 @@
 #ifndef QEMU_KVM_RISCV_H
 #define QEMU_KVM_RISCV_H
 
+void kvm_riscv_init_user_properties(Object *cpu_obj);
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 
-- 
2.41.0


