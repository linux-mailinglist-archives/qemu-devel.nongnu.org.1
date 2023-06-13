Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452A72ED7D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B74-00023e-Vt; Tue, 13 Jun 2023 16:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B73-00023I-Dg
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:37 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B70-0006ig-4Y
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:37 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-392116b8f31so3107810b6e.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689973; x=1689281973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhHRKSGEbq+mW0830UHFoCdz0qHGycuAYRPV+WamFZQ=;
 b=eMF7JVUyBvh/d7YjOTAPY0z9V+1z4lVqpwgzcnK9mhBMGangZOW08LRZ8wJYP0bGgg
 8T1ueY39ldvuon4qcbg76dlOe7TjHMiyO22h9B5vrBO/kwHKwHy5zxDwL756ao/gKfzu
 U/3WGjOz8IuJTHDdbUTQN8p9h5XBoYhhxR8W1Vc+WzHFu8w+SaYg1vnH9YEbfZQGFcP1
 WzkHrdt6nYkLE0vs3vJsJeoCJPYy1reAWEo7fufTIlshf1cFEX4H7VWDFO6ZEAZltFU0
 QTuQHzxvOnJ4TXIQ6hBRm32x87MkSNUjpCpc9YQM3FWw4CXvkhV45dLkKV79j7LhQjj7
 dflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689973; x=1689281973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhHRKSGEbq+mW0830UHFoCdz0qHGycuAYRPV+WamFZQ=;
 b=aY5+U4yE9dIJpaOizYNgRX8vfhLBee3LkQY4VAFBezbgm/LoPUAbF4wNtu1YRPj6up
 cppbYb/L87kdKc26LjDWOVxJWpzGlXNLi0n8o83hD4B+P5CT2eILFmXBzEZvk9mNFgtc
 Wo0aw5liTXoAP9g9VrgftXkYyh856ZnJS/kgIEVXSUrPQSnUxD1HgN/gCLJIbvOdGl24
 Nuqwbvf9qpiuJ3Ko2pxHustgNWhNazkbUzXMMXmtiRU5VO30f8RCVHxNSOIPJlgEwv5I
 6jRZWDgp2vqL2A38chyNtd2Tb5ZLL4DxBPmXGtuYrz3PaKVulVJuUbvmT1J0aLcvuiZX
 e44w==
X-Gm-Message-State: AC+VfDzD/9OCobQW5coIEK7a2DHDGKRgaziE4kdsepUYc0ROcPW9qA+w
 fqjD1wIWvpYJ92IEVVF58k9oxuPZJ3Bhbrpkh+g=
X-Google-Smtp-Source: ACHHUZ5lgt/cmLaYBcN3W0k8gk2ILQ28jRMTaKWqs2Hz7tcyGM0eaTuaVmwokkMEvL7nvJzBmVPOQg==
X-Received: by 2002:a05:6808:3020:b0:398:34da:daad with SMTP id
 ay32-20020a056808302000b0039834dadaadmr9336460oib.51.1686689972803; 
 Tue, 13 Jun 2023 13:59:32 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 06/18] target/riscv: use KVM scratch CPUs to init KVM
 properties
Date: Tue, 13 Jun 2023 17:58:45 -0300
Message-Id: <20230613205857.495165-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
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
 target/riscv/cpu.c       |  4 ++
 target/riscv/kvm.c       | 85 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h |  1 +
 3 files changed, 90 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2eb793188c..0b25d53bbe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1714,6 +1714,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     Property *prop;
     DeviceState *dev = DEVICE(obj);
 
+    if (riscv_running_kvm()) {
+        kvm_riscv_init_user_properties(obj);
+    }
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
2.40.1


