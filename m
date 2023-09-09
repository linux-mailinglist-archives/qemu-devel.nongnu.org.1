Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0079987D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexmc-0000b2-5o; Sat, 09 Sep 2023 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexlx-0008JG-HI; Sat, 09 Sep 2023 09:13:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexlt-0005Ho-Dg; Sat, 09 Sep 2023 09:13:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A6102062B;
 Sat,  9 Sep 2023 16:13:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 53AAC26E4B;
 Sat,  9 Sep 2023 16:13:00 +0300 (MSK)
Received: (nullmailer pid 354711 invoked by uid 1000);
 Sat, 09 Sep 2023 13:12:59 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/7] i386: spelling fixes
Date: Sat,  9 Sep 2023 16:12:53 +0300
Message-Id: <20230909131258.354675-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909131258.354675-1-mjt@tls.msk.ru>
References: <20230909131258.354675-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 host/include/i386/host/cpuinfo.h | 2 +-
 hw/i386/acpi-build.c             | 4 ++--
 hw/i386/amd_iommu.c              | 4 ++--
 hw/i386/intel_iommu.c            | 4 ++--
 hw/i386/kvm/xen_xenstore.c       | 2 +-
 hw/i386/kvm/xenstore_impl.c      | 2 +-
 hw/i386/pc.c                     | 4 ++--
 include/hw/i386/topology.h       | 2 +-
 target/i386/cpu.c                | 4 ++--
 target/i386/cpu.h                | 4 ++--
 target/i386/kvm/kvm.c            | 4 ++--
 target/i386/kvm/xen-emu.c        | 2 +-
 target/i386/machine.c            | 4 ++--
 target/i386/tcg/translate.c      | 8 ++++----
 tests/tcg/i386/system/boot.S     | 2 +-
 tests/tcg/i386/x86.csv           | 2 +-
 16 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..6e46939132 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for x86.
+ * Host specific cpu identification for x86.
  */
 
 #ifndef HOST_CPUINFO_H
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index bb12b0ad43..1afcef5937 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -779,7 +779,7 @@ static Aml *initialize_route(Aml *route, const char *link_name,
  *
  * Returns an array of 128 routes, one for each device,
  * based on device location.
- * The main goal is to equaly distribute the interrupts
+ * The main goal is to equally distribute the interrupts
  * over the 4 existing ACPI links (works only for i440fx).
  * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
  *
@@ -2079,7 +2079,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 }
 
 /*
- * Insert DMAR scope for PCI bridges and endpoint devcie
+ * Insert DMAR scope for PCI bridges and endpoint device
  */
 static void
 insert_scope(PCIBus *bus, PCIDevice *dev, void *opaque)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9c77304438..c98a3c6e11 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -259,7 +259,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
     pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
-/* log an illegal comand event
+/* log an illegal command event
  *   @addr : address of illegal command
  */
 static void amdvi_log_illegalcom_error(AMDVIState *s, uint16_t info,
@@ -767,7 +767,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         break;
     case AMDVI_MMIO_COMMAND_BASE:
         amdvi_mmio_reg_write(s, size, val, addr);
-        /* FIXME - make sure System Software has finished writing incase
+        /* FIXME - make sure System Software has finished writing in case
          * it writes in chucks less than 8 bytes in a robust way.As for
          * now, this hacks works for the linux driver
          */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c9961ef752..c0ce896668 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -52,7 +52,7 @@
 
 /*
  * PCI bus number (or SID) is not reliable since the device is usaully
- * initalized before guest can configure the PCI bridge
+ * initialized before guest can configure the PCI bridge
  * (SECONDARY_BUS_NUMBER).
  */
 struct vtd_as_key {
@@ -1694,7 +1694,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * """
      *
      * We enable per as memory region (iommu_ir_fault) for catching
-     * the tranlsation for interrupt range through PASID + PT.
+     * the translation for interrupt range through PASID + PT.
      */
     if (pt && as->pasid != PCI_NO_PASID) {
         memory_region_set_enabled(&as->iommu_ir_fault, true);
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 133d89e953..660d0b72f9 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1156,7 +1156,7 @@ static unsigned int copy_to_ring(XenXenstoreState *s, uint8_t *ptr,
 
     /*
      * This matches the barrier in copy_to_ring() (or the guest's
-     * equivalent) betweem writing the data to the ring and updating
+     * equivalent) between writing the data to the ring and updating
      * rsp_prod. It protects against the pathological case (which
      * again I think never happened except on Alpha) where our
      * subsequent writes to the ring could *cross* the read of
diff --git a/hw/i386/kvm/xenstore_impl.c b/hw/i386/kvm/xenstore_impl.c
index d9732b567e..1d134a6866 100644
--- a/hw/i386/kvm/xenstore_impl.c
+++ b/hw/i386/kvm/xenstore_impl.c
@@ -1436,7 +1436,7 @@ static void save_node(gpointer key, gpointer value, gpointer opaque)
     /*
      * If we already wrote this node, refer to the previous copy.
      * There's no rename/move in XenStore, so all we need to find
-     * it is the tx_id of the transation in which it exists. Which
+     * it is the tx_id of the transaction in which it exists. Which
      * may be the root tx.
      */
     if (n->serialized_tx != XBT_NULL) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..2872f60cdf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -436,7 +436,7 @@ static uint64_t ioport80_read(void *opaque, hwaddr addr, unsigned size)
     return 0xffffffffffffffffULL;
 }
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
@@ -1755,7 +1755,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     if (value > 16 * MiB) {
         error_setg(errp,
                    "User specified max allowed firmware size %" PRIu64 " is "
-                   "greater than 16MiB. If combined firwmare size exceeds "
+                   "greater than 16MiB. If combined firmware size exceeds "
                    "16MiB the system may not boot, or experience intermittent"
                    "stability issues.",
                    value);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 81573f6cfd..380cb27ded 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -31,7 +31,7 @@
  *
  * This code should be compatible with AMD's "Extended Method" described at:
  *   AMD CPUID Specification (Publication #25481)
- *   Section 3: Multiple Core Calcuation
+ *   Section 3: Multiple Core Calculation
  * as long as:
  *  nr_threads is set to 1;
  *  OFFSET_IDX is assumed to be 0;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..7033fa3496 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5340,7 +5340,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     return name;
 }
 
-/* Compatibily hack to maintain legacy +-feat semantic,
+/* Compatibility hack to maintain legacy +-feat semantic,
  * where +-feat overwrites any feature set by
  * feat=on|feat even if the later is parsed after +-feat
  * (i.e. "-x2apic,x2apic=on" will result in x2apic disabled)
@@ -6304,7 +6304,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * The initial value of xcr0 and ebx == 0, On host without kvm
              * commit 412a3c41(e.g., CentOS 6), the ebx's value always == 0
              * even through guest update xcr0, this will crash some legacy guest
-             * (e.g., CentOS 6), So set ebx == ecx to workaroud it.
+             * (e.g., CentOS 6), So set ebx == ecx to workaround it.
              */
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0, false);
         } else if (count == 1) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fbb05eace5..fe06a1b286 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -728,7 +728,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_EXT2_3DNOWEXT (1U << 30)
 #define CPUID_EXT2_3DNOW   (1U << 31)
 
-/* CPUID[8000_0001].EDX bits that are aliase of CPUID[1].EDX bits on AMD CPUs */
+/* CPUID[8000_0001].EDX bits that are aliases of CPUID[1].EDX bits on AMD CPUs */
 #define CPUID_EXT2_AMD_ALIASES (CPUID_EXT2_FPU | CPUID_EXT2_VME | \
                                 CPUID_EXT2_DE | CPUID_EXT2_PSE | \
                                 CPUID_EXT2_TSC | CPUID_EXT2_MSR | \
@@ -2071,7 +2071,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 int cpu_get_pic_interrupt(CPUX86State *s);
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 void x86_register_ferr_irq(qemu_irq irq);
 void fpu_check_raise_ferr_irq(CPUX86State *s);
 void cpu_set_ignne(void);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e5cd7cc806..05dd08b318 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4729,7 +4729,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     /*
      * Put MSR_IA32_FEATURE_CONTROL first, this ensures the VM gets out of VMX
      * root operation upon vCPU reset. kvm_put_msr_feature_control() should also
-     * preceed kvm_put_nested_state() when 'real' nested state is set.
+     * proceed kvm_put_nested_state() when 'real' nested state is set.
      */
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
@@ -5653,7 +5653,7 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
             }
 
             /*
-             * Handled untranslated compatibilty format interrupt with
+             * Handled untranslated compatibility format interrupt with
              * extended destination ID in the low bits 11-5. */
             dst.address = kvm_swizzle_msi_ext_dest_id(dst.address);
 
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index a8146115f0..76348f9d5d 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1033,7 +1033,7 @@ static int do_set_periodic_timer(CPUState *target, uint64_t period_ns)
 #define MILLISECS(_ms)  ((int64_t)((_ms) * 1000000ULL))
 #define MICROSECS(_us)  ((int64_t)((_us) * 1000ULL))
 #define STIME_MAX ((time_t)((int64_t)~0ull >> 1))
-/* Chosen so (NOW() + delta) wont overflow without an uptime of 200 years */
+/* Chosen so (NOW() + delta) won't overflow without an uptime of 200 years */
 #define STIME_DELTA_MAX ((int64_t)((uint64_t)~0ull >> 2))
 
 static int vcpuop_set_periodic_timer(CPUState *cs, CPUState *target,
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c7ac8084b2..a1041ef828 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -282,12 +282,12 @@ static int cpu_pre_save(void *opaque)
      * hypervisor, its exception payload (CR2/DR6 on #PF/#DB)
      * should not be set yet in the respective vCPU register.
      * Thus, in case an exception is pending, it is
-     * important to save the exception payload seperately.
+     * important to save the exception payload separately.
      *
      * Therefore, if an exception is not in a pending state
      * or vCPU is not in guest-mode, it is not important to
      * distinguish between a pending and injected exception
-     * and we don't need to store seperately the exception payload.
+     * and we don't need to store separately the exception payload.
      *
      * In order to preserve better backwards-compatible migration,
      * convert a pending exception to an injected exception in
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e0a622941c..c98e42f17a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1069,7 +1069,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 }
 
 /* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
@@ -1202,7 +1202,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 }
 
 /* generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, s->T0);
@@ -1219,7 +1219,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 }
 
 /* Generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used.
+   value 'b'. In the fast case, T0 is guaranteed not to be used.
    A translation block must end soon.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
@@ -5355,7 +5355,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (s->prefix & PREFIX_LOCK) {
             switch (op) {
             case 0: /* bt */
-                /* Needs no atomic ops; we surpressed the normal
+                /* Needs no atomic ops; we suppressed the normal
                    memory load for LOCK above so do it now.  */
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 break;
diff --git a/tests/tcg/i386/system/boot.S b/tests/tcg/i386/system/boot.S
index 794c2cb0ad..9e8920cbfe 100644
--- a/tests/tcg/i386/system/boot.S
+++ b/tests/tcg/i386/system/boot.S
@@ -71,7 +71,7 @@ _start:
         add $8,%esp
 
         /*
-         * Don't worry about stack frame, assume everthing
+         * Don't worry about stack frame, assume everything
          * is garbage when we return, we won't need it.
          */
         call main
diff --git a/tests/tcg/i386/x86.csv b/tests/tcg/i386/x86.csv
index c43bf42dd3..5c0f628e35 100644
--- a/tests/tcg/i386/x86.csv
+++ b/tests/tcg/i386/x86.csv
@@ -19,7 +19,7 @@
 #
 # 4. The instruction encoding. For example, "C1 /4 ib".
 #
-# 5. The validity of the instruction in 32-bit (aka compatiblity, legacy) mode.
+# 5. The validity of the instruction in 32-bit (aka compatibility, legacy) mode.
 #
 # 6. The validity of the instruction in 64-bit mode.
 #
-- 
2.39.2


