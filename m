Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D628175BECA
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 08:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMjZ3-0006Eu-39; Fri, 21 Jul 2023 02:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMjZ1-0006EW-3a
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:24:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMjYz-0005Vv-4o
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:24:30 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b89114266dso12273165ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689920667; x=1690525467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=It+/Ia/9D13w5jiL9WD0ew4nsP/hfmMWdDncq/Y53N0=;
 b=mm/vDjx/GY+rhtpH8Ld+Hul0wlAS0ORLaKCBuBH491s1hOz554hYt0UmGl4h2xQbvn
 hc4VA5rw9kICl5m1sYyqdmJFnEw1UxVePht6bbqi5K3XjhW9AAQ39mHj+nL+ZyfAntyr
 ZWkxnUlzL0ZyvS93NFiDRiukP8982+ri2ALyt/l1/t3E/kTHtgKDgHuaEhd5Haxwabtq
 2lj4dNA6BWrlVJ9mWFxFsAYnFLWXOsuo5aKags/6b6fS10eJLeOcyecGYzijI68CHecE
 k8ikgPTstcahW20RhwSBToYMibKfyCif6gjpd/Qfxve8YRGmULYeN01J6Y+8qWrt1KSz
 0gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689920667; x=1690525467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=It+/Ia/9D13w5jiL9WD0ew4nsP/hfmMWdDncq/Y53N0=;
 b=PQZSedjzef3jzEa+zgcNdJf7t0eF3J7cM+olPWAYUfqTX74L08eYotfFlr/wiSEIER
 LXOeh1Hm4RZBef4ZX3s8dR4kkiLNYcw9jM/RP/kj6BKqL8LyiTAw7KXxxe4XQqbEILjy
 EJM9jOp840iVghtKfnxMQUgsqCNv5RvVls6fiy0chanvuNNmX5zhaFYgR8RIjhncnjDx
 iZE2JPV0VRcO4G8XxNLQeTrlFnojApNT5KErc6hEjqjJy/Sixky0f9Xagn0QHV793KiT
 pkPVCIV4tF6yXYIQEj/csBTpRr2jtWxZnzAUXGgtFqhJHQyLiBZxOUmF27YwrdT/TMIx
 B98Q==
X-Gm-Message-State: ABy/qLYBqiWlv+2fRDrr7uUOXiXSdKSt5ugsh54cC9xIS2RIDLR//jpc
 oKR5mRVvH21IxaAk9993W+bWmcCDwDTOtUPMdwA=
X-Google-Smtp-Source: APBJJlG0oKLkfohAOAP9pKsMEO0NroVlXSjjQYNcw7uV4Z87v1XEAsxzXN2Ag/OZ4lKa1V1sdgoRGQ==
X-Received: by 2002:a17:902:c3c3:b0:1b6:b829:7065 with SMTP id
 j3-20020a170902c3c300b001b6b8297065mr1081317plj.63.1689920667147; 
 Thu, 20 Jul 2023 23:24:27 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a170902e84500b001b51b3e84cesm2535148plg.166.2023.07.20.23.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 23:24:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2] accel/kvm: Specify default IPA size for arm64
Date: Fri, 21 Jul 2023 15:24:20 +0900
Message-ID: <20230721062421.12017-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

libvirt uses "none" machine type to test KVM availability. Before this
change, QEMU used to pass 0 as machine type when calling KVM_CREATE_VM.

The kernel documentation says:
> On arm64, the physical address size for a VM (IPA Size limit) is
> limited to 40bits by default. The limit can be configured if the host
> supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
> identifier, where IPA_Bits is the maximum width of any physical
> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
> machine type identifier.
>
> e.g, to configure a guest to use 48bit physical address size::
>
>     vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>
> The requested size (IPA_Bits) must be:
>
>  ==   =========================================================
>   0   Implies default size, 40bits (for backward compatibility)
>   N   Implies N bits, where N is a positive integer such that,
>       32 <= N <= Host_IPA_Limit
>  ==   =========================================================

> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
> and is dependent on the CPU capability and the kernel configuration.
> The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
> KVM_CHECK_EXTENSION ioctl() at run-time.
>
> Creation of the VM will fail if the requested IPA size (whether it is
> implicit or explicit) is unsupported on the host.
https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm

So if Host_IPA_Limit < 40, such KVM_CREATE_VM will fail, and libvirt
incorrectly thinks KVM is not available. This actually happened on M2
MacBook Air.

Fix this by specifying 32 for IPA_Bits as any arm64 system should
support the value according to the documentation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2: Introduced an arch hook

 include/sysemu/kvm.h   | 1 +
 accel/kvm/kvm-all.c    | 2 +-
 target/arm/kvm.c       | 2 ++
 target/i386/kvm/kvm.c  | 2 ++
 target/mips/kvm.c      | 2 ++
 target/ppc/kvm.c       | 2 ++
 target/riscv/kvm.c     | 2 ++
 target/s390x/kvm/kvm.c | 2 ++
 8 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79..7cc2eb1a8c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -347,6 +347,7 @@ bool kvm_device_supported(int vmfd, uint64_t type);
 
 /* Arch specific hooks */
 
+extern const int kvm_arch_default_type;
 extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
 
 void kvm_arch_accel_class_init(ObjectClass *oc);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..914ade3ec3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2458,7 +2458,7 @@ static int kvm_init(MachineState *ms)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
-    int type = 0;
+    int type = kvm_arch_default_type;
     uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f49..f8203b9915 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -32,6 +32,8 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 
+const int kvm_arch_default_type = 32;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..00bccffdfc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -87,6 +87,8 @@
 
 static void kvm_init_msrs(X86CPU *cpu);
 
+const int kvm_arch_default_type;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index c14e8f550f..754366874e 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -33,6 +33,8 @@
 static int kvm_mips_fpu_cap;
 static int kvm_mips_msa_cap;
 
+const int kvm_arch_default_type;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a8a935e267..86f8b645a5 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -54,6 +54,8 @@
 #define DEBUG_RETURN_GUEST 0
 #define DEBUG_RETURN_GDB   1
 
+const int kvm_arch_default_type;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 9d8a8982f9..fbe56ec3bb 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -764,6 +764,8 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
+const int kvm_arch_default_type;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..4b9347ffc8 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -144,6 +144,8 @@ static CPUWatchpoint hw_watchpoint;
 static struct kvm_hw_breakpoint *hw_breakpoints;
 static int nb_hw_breakpoints;
 
+const int kvm_arch_default_type;
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
-- 
2.41.0


