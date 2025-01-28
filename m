Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03FA20623
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:26:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgde-0000fh-3F; Tue, 28 Jan 2025 03:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZz-0000gY-AG; Tue, 28 Jan 2025 03:04:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZx-0002fA-J3; Tue, 28 Jan 2025 03:04:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FED6E1B69;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7FF2C1A631C;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 216B2520C9; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 34/58] target/i386: Reset TSCs of parked vCPUs too on
 VM reset
Date: Mon, 27 Jan 2025 23:25:20 +0300
Message-Id: <20250127202547.3723716-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since commit 5286c3662294 ("target/i386: properly reset TSC on reset")
QEMU writes the special value of "1" to each online vCPU TSC on VM reset
to reset it.

However parked vCPUs don't get that handling and due to that their TSCs
get desynchronized when the VM gets reset.
This in turn causes KVM to turn off PVCLOCK_TSC_STABLE_BIT in its exported
PV clock.
Note that KVM has no understanding of vCPU being currently parked.

Without PVCLOCK_TSC_STABLE_BIT the sched clock is marked unstable in
the guest's kvm_sched_clock_init().
This causes a performance regressions to show in some tests.

Fix this issue by writing the special value of "1" also to TSCs of parked
vCPUs on VM reset.

Reproducing the issue:
1) Boot a VM with "-smp 2,maxcpus=3" or similar

2) device_add host-x86_64-cpu,id=vcpu,node-id=0,socket-id=0,core-id=2,thread-id=0

3) Wait a few seconds

4) device_del vcpu

5) Inside the VM run:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is 1.

6) Reboot the VM

7) Once the VM boots once again run inside it:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is now 0.

Fixes: 5286c3662294 ("target/i386: properly reset TSC on reset")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3f2a05b31ee9ce2ddb6c75a9bc3f5e7f7af9a76f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8c5e71f20c..056a9c63b7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -435,6 +435,16 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_fd;
 }
 
+static void kvm_reset_parked_vcpus(void *param)
+{
+    KVMState *s = param;
+    struct KVMParkedVcpu *cpu;
+
+    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
+        kvm_arch_reset_parked_vcpu(cpu->vcpu_id, cpu->kvm_fd);
+    }
+}
+
 int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
@@ -2699,6 +2709,7 @@ static int kvm_init(MachineState *ms)
     }
 
     qemu_register_reset(kvm_unpoison_all, NULL);
+    qemu_register_reset(kvm_reset_parked_vcpus, s);
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 2ac69d5ba3..2eb0e86250 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index e12ac3dc59..920e9a4200 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9cf14ca3d5..7035b46a89 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -377,6 +377,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
+#ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
+#else
+static inline void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+}
+#endif
+
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e3..a45d2510e6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2382,6 +2382,21 @@ void kvm_arch_after_reset_vcpu(X86CPU *cpu)
     }
 }
 
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+    g_autofree struct kvm_msrs *msrs = NULL;
+
+    msrs = g_malloc0(sizeof(*msrs) + sizeof(msrs->entries[0]));
+    msrs->entries[0].index = MSR_IA32_TSC;
+    msrs->entries[0].data = 1; /* match the value in x86_cpu_reset() */
+    msrs->nmsrs++;
+
+    if (ioctl(kvm_fd, KVM_SET_MSRS, msrs) != 1) {
+        warn_report("parked vCPU %lu TSC reset failed: %d",
+                    vcpu_id, errno);
+    }
+}
+
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
-- 
2.39.5


