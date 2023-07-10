Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFA74D5D4
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6Q-0005nn-MH; Mon, 10 Jul 2023 08:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6G-0005Vk-Jx
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6B-0004z4-MP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-668711086f4so2802744b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992478; x=1691584478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pldJ5pO9qAMGUEbfO/US2g1M9keukM+7NVT8bMbSas=;
 b=JZJ1O+A6i8clcIevI1BnAM81upHhbhFS6OqWg69NdwOGa8OrTajlzwaXuJRdOVK26Z
 Qpa3LxOUPAVIeSVQkkDS3BaxscGI7dsNFSfgcRfxKEtbz+izDcCEgVPTQttbnr/MLXCF
 /gVthUVJdik0TMM4HezZI14KQ5EARBKxeTMz+MWs+bZWx/Al9Y4nCHwr6aqbdXzOzhdy
 l5kwRF51UGpd84QZozIxKoY4fd80kpnPK5YFLNe4TGE9BkaTM7hXDKCg8Gfc7axHXVsm
 12QgVUcRtvQdzd4kTs/+IYyMRxI6K2tXhiNeh9LTCeB+vMCDDZU2zvMNUWz0JLpP7rH8
 B9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992478; x=1691584478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pldJ5pO9qAMGUEbfO/US2g1M9keukM+7NVT8bMbSas=;
 b=O94inUEOs3SFe1/XmgRKVrs358pN7YvEGJzT8gmR1va6Utxo83phbmkVR8X1+o8vPt
 Wv6qx3ZAVgRQFk7q0JIO+/c0BBuCamWqMKlAvpv4Rz1srwdMgenbX4twxKsxYwE4rJES
 U5D0D13zOeAB2Nik4IekggP4rXzslNqGvKAdyCelb2mjMSdIpeov4EdP/KiPwfg8p4dS
 m2GfUuJZ2GOmffP8uiuGzRe7FfrPuRmCRC+ZgvpdRKdHpPsEYulSjhHfs5R0C+hSdOPf
 MCoR6axXnFcdWC/v8bTnnn1WAJGnQ+nzVaOsJk4N+cBuu1A1sE3eciz60zM1E2/KWos7
 f+QQ==
X-Gm-Message-State: ABy/qLb1kbGbjPycTRrJ74vo3x8un3XKIcoAH3Tkf/+CHmcmGOI2P3K/
 sab5sC+t9zFHS7pEpHhNl5HkpGTnBKe3IQ==
X-Google-Smtp-Source: APBJJlH+6X2EOCTTPGEJkDfpeETGY6MDGTYniyYAAHXUfq6q6LWxiQhSRGvE1vzfTElHlbRuWZaXoQ==
X-Received: by 2002:a05:6a00:1302:b0:678:11d6:2ad6 with SMTP id
 j2-20020a056a00130200b0067811d62ad6mr23068057pfu.9.1688992478189; 
 Mon, 10 Jul 2023 05:34:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/54] target/riscv: use KVM scratch CPUs to init KVM properties
Date: Mon, 10 Jul 2023 22:31:51 +1000
Message-Id: <20230710123205.2441106-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
Message-Id: <20230706101738.460804-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm_riscv.h |  1 +
 target/riscv/cpu.c       |  6 +++
 target/riscv/kvm.c       | 85 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

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
index c3976a588d..7402bfbfc5 100644
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
-- 
2.40.1


