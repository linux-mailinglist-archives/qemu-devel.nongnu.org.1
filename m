Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16B799884
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexfW-0006rz-V3; Sat, 09 Sep 2023 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexfU-0006r8-9l; Sat, 09 Sep 2023 09:06:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexfR-0003fB-ND; Sat, 09 Sep 2023 09:06:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A82C5205DD;
 Sat,  9 Sep 2023 16:06:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D32626E30;
 Sat,  9 Sep 2023 16:05:15 +0300 (MSK)
Received: (nullmailer pid 354308 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 16/37] kvm: Introduce kvm_arch_get_default_type hook
Date: Sat,  9 Sep 2023 16:04:46 +0300
Message-Id: <20230909130511.354171-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

kvm_arch_get_default_type() returns the default KVM type. This hook is
particularly useful to derive a KVM type that is valid for "none"
machine model, which is used by libvirt to probe the availability of
KVM.

For MIPS, the existing mips_kvm_type() is reused. This function ensures
the availability of VZ which is mandatory to use KVM on the current
QEMU.

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-2-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added doc comment for new function]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 5e0d65909c6f335d578b90491e165440c99adf81)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f99b0becd8..0a127ece11 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2294,7 +2294,7 @@ static int kvm_init(MachineState *ms)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
-    int type = 0;
+    int type;
     uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
@@ -2358,6 +2358,8 @@ static int kvm_init(MachineState *ms)
         type = mc->kvm_type(ms, kvm_type);
     } else if (mc->kvm_type) {
         type = mc->kvm_type(ms, NULL);
+    } else {
+        type = kvm_arch_get_default_type(ms);
     }
 
     do {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 25534288dd..b4f6bff1b8 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -29,7 +29,6 @@
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "elf.h"
-#include "kvm_mips.h"
 #include "hw/char/serial.h"
 #include "hw/intc/loongson_liointc.h"
 #include "hw/mips/mips.h"
@@ -617,7 +616,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->kvm_type = mips_kvm_type;
     mc->minimum_page_bits = 14;
 }
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index e9a97eda8c..c4ff7d9a4c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -369,6 +369,8 @@ int kvm_arch_get_registers(CPUState *cpu);
 
 int kvm_arch_put_registers(CPUState *cpu, int level);
 
+int kvm_arch_get_default_type(MachineState *ms);
+
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
 int kvm_arch_init_vcpu(CPUState *cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 84da49332c..34bc329b5b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -247,6 +247,11 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
     return ret > 0 ? ret : 40;
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a213209379..002b699030 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2455,6 +2455,11 @@ static void register_smram_listener(Notifier *n, void *unused)
                                  &smram_address_space, 1, "kvm-smram");
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     uint64_t identity_base = 0xfffbc000;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index bcb8e06b2c..27cf4e8c1b 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1266,7 +1266,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     abort();
 }
 
-int mips_kvm_type(MachineState *machine, const char *vm_type)
+int kvm_arch_get_default_type(MachineState *machine)
 {
 #if defined(KVM_CAP_MIPS_VZ) || defined(KVM_CAP_MIPS_TE)
     int r;
diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
index 171d53dbe1..c711269d0a 100644
--- a/target/mips/kvm_mips.h
+++ b/target/mips/kvm_mips.h
@@ -25,13 +25,4 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu);
 int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
 int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
 
-#ifdef CONFIG_KVM
-int mips_kvm_type(MachineState *machine, const char *vm_type);
-#else
-static inline int mips_kvm_type(MachineState *machine, const char *vm_type)
-{
-    return 0;
-}
-#endif
-
 #endif /* KVM_MIPS_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7c25348b7b..4bcda6e2dc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -108,6 +108,11 @@ static int kvm_ppc_register_host_cpu_type(void);
 static void kvmppc_get_cpu_characteristics(KVMState *s);
 static int kvmppc_get_dec_bits(void);
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 30f21453d6..d28d5241f9 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -426,6 +426,11 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
     return 0;
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     return 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 3ac7ec9acf..8ffe140513 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -340,6 +340,11 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
-- 
2.39.2


