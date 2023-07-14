Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DC7539A4
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8q-0000O0-Av; Fri, 14 Jul 2023 07:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8c-0000Ko-1l; Fri, 14 Jul 2023 07:39:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8Z-0004D6-Ig; Fri, 14 Jul 2023 07:39:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 380A713D95;
 Fri, 14 Jul 2023 14:38:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 31F5514BA4;
 Fri, 14 Jul 2023 14:38:40 +0300 (MSK)
Received: (nullmailer pid 1186222 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 09/29] tree-wide spelling fixes in comments and some
 messages: i386
Date: Fri, 14 Jul 2023 14:38:14 +0300
Message-Id: <20230714113834.1186117-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 target/i386/hax/hax-interface.h  | 4 ++--
 target/i386/hax/hax-windows.c    | 2 +-
 target/i386/kvm/kvm.c            | 4 ++--
 target/i386/kvm/xen-emu.c        | 2 +-
 target/i386/machine.c            | 4 ++--
 target/i386/tcg/translate.c      | 8 ++++----
 tests/tcg/i386/system/boot.S     | 2 +-
 tests/tcg/i386/x86.csv           | 2 +-
 18 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..6e46939132 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -2,3 +2,3 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for x86.
+ * Host specific cpu identification for x86.
  */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..eeeeacbfff 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -777,3 +777,3 @@ static Aml *initialize_route(Aml *route, const char *link_name,
  * based on device location.
- * The main goal is to equaly distribute the interrupts
+ * The main goal is to equally distribute the interrupts
  * over the 4 existing ACPI links (works only for i440fx).
@@ -2080,3 +2080,3 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 /*
- * Insert DMAR scope for PCI bridges and endpoint devcie
+ * Insert DMAR scope for PCI bridges and endpoint device
  */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9c77304438..c98a3c6e11 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -261,3 +261,3 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
 }
-/* log an illegal comand event
+/* log an illegal command event
  *   @addr : address of illegal command
@@ -769,3 +769,3 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
-        /* FIXME - make sure System Software has finished writing incase
+        /* FIXME - make sure System Software has finished writing in case
          * it writes in chucks less than 8 bytes in a robust way.As for
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..09b19a43ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -54,3 +54,3 @@
  * PCI bus number (or SID) is not reliable since the device is usaully
- * initalized before guest can configure the PCI bridge
+ * initialized before guest can configure the PCI bridge
  * (SECONDARY_BUS_NUMBER).
@@ -1691,3 +1691,3 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * We enable per as memory region (iommu_ir_fault) for catching
-     * the tranlsation for interrupt range through PASID + PT.
+     * the translation for interrupt range through PASID + PT.
      */
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 133d89e953..660d0b72f9 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1158,3 +1158,3 @@ static unsigned int copy_to_ring(XenXenstoreState *s, uint8_t *ptr,
      * This matches the barrier in copy_to_ring() (or the guest's
-     * equivalent) betweem writing the data to the ring and updating
+     * equivalent) between writing the data to the ring and updating
      * rsp_prod. It protects against the pathological case (which
diff --git a/hw/i386/kvm/xenstore_impl.c b/hw/i386/kvm/xenstore_impl.c
index 305fe75519..36595fdb45 100644
--- a/hw/i386/kvm/xenstore_impl.c
+++ b/hw/i386/kvm/xenstore_impl.c
@@ -1428,3 +1428,3 @@ static void save_node(gpointer key, gpointer value, gpointer opaque)
      * There's no rename/move in XenStore, so all we need to find
-     * it is the tx_id of the transation in which it exists. Which
+     * it is the tx_id of the transaction in which it exists. Which
      * may be the root tx.
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3109d5e0e0..405db3aef9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -435,3 +435,3 @@ static uint64_t ioport80_read(void *opaque, hwaddr addr, unsigned size)
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 static void ioportF0_write(void *opaque, hwaddr addr, uint64_t data,
@@ -1754,3 +1754,3 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
                    "User specified max allowed firmware size %" PRIu64 " is "
-                   "greater than 16MiB. If combined firwmare size exceeds "
+                   "greater than 16MiB. If combined firmware size exceeds "
                    "16MiB the system may not boot, or experience intermittent"
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 81573f6cfd..380cb27ded 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -33,3 +33,3 @@
  *   AMD CPUID Specification (Publication #25481)
- *   Section 3: Multiple Core Calcuation
+ *   Section 3: Multiple Core Calculation
  * as long as:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..fd2afd4b3c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5338,3 +5338,3 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 
-/* Compatibily hack to maintain legacy +-feat semantic,
+/* Compatibility hack to maintain legacy +-feat semantic,
  * where +-feat overwrites any feature set by
@@ -6302,3 +6302,3 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * even through guest update xcr0, this will crash some legacy guest
-             * (e.g., CentOS 6), So set ebx == ecx to workaroud it.
+             * (e.g., CentOS 6), So set ebx == ecx to workaround it.
              */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..b3fbcae52f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -730,3 +730,3 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 
-/* CPUID[8000_0001].EDX bits that are aliase of CPUID[1].EDX bits on AMD CPUs */
+/* CPUID[8000_0001].EDX bits that are aliases of CPUID[1].EDX bits on AMD CPUs */
 #define CPUID_EXT2_AMD_ALIASES (CPUID_EXT2_FPU | CPUID_EXT2_VME | \
@@ -2070,3 +2070,3 @@ int cpu_get_pic_interrupt(CPUX86State *s);
 
-/* MSDOS compatibility mode FPU exception support */
+/* MS-DOS compatibility mode FPU exception support */
 void x86_register_ferr_irq(qemu_irq irq);
diff --git a/target/i386/hax/hax-interface.h b/target/i386/hax/hax-interface.h
index 537ae084e9..edef4fdf5d 100644
--- a/target/i386/hax/hax-interface.h
+++ b/target/i386/hax/hax-interface.h
@@ -240,3 +240,3 @@ enum exit_status {
     HAX_EXIT_HLT,
-    /* Reboot request, like because of tripple fault in guest */
+    /* Reboot request, like because of triple fault in guest */
     HAX_EXIT_STATECHANGE,
@@ -297,3 +297,3 @@ struct hax_qemu_version {
 
-/* The mac specfic interface to qemu, mostly is ioctl related */
+/* The mac specific interface to qemu, mostly is ioctl related */
 struct hax_tunnel_info {
diff --git a/target/i386/hax/hax-windows.c b/target/i386/hax/hax-windows.c
index 4bf6cc08d2..58cf3f1a9f 100644
--- a/target/i386/hax/hax-windows.c
+++ b/target/i386/hax/hax-windows.c
@@ -176,3 +176,3 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
         if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
-            fprintf(stderr, "hax module verion is too long to hold.\n");
+            fprintf(stderr, "hax module version is too long to hold.\n");
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..9d18d3336f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4726,3 +4726,3 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
      * root operation upon vCPU reset. kvm_put_msr_feature_control() should also
-     * preceed kvm_put_nested_state() when 'real' nested state is set.
+     * proceed kvm_put_nested_state() when 'real' nested state is set.
      */
@@ -5652,3 +5652,3 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
             /*
-             * Handled untranslated compatibilty format interrupt with
+             * Handled untranslated compatibility format interrupt with
              * extended destination ID in the low bits 11-5. */
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index d7c7eb8d9c..6695f2a0c6 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1028,3 +1028,3 @@ static int do_set_periodic_timer(CPUState *target, uint64_t period_ns)
 #define STIME_MAX ((time_t)((int64_t)~0ull >> 1))
-/* Chosen so (NOW() + delta) wont overflow without an uptime of 200 years */
+/* Chosen so (NOW() + delta) won't overflow without an uptime of 200 years */
 #define STIME_DELTA_MAX ((int64_t)((uint64_t)~0ull >> 2))
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c7ac8084b2..a1041ef828 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -284,3 +284,3 @@ static int cpu_pre_save(void *opaque)
      * Thus, in case an exception is pending, it is
-     * important to save the exception payload seperately.
+     * important to save the exception payload separately.
      *
@@ -289,3 +289,3 @@ static int cpu_pre_save(void *opaque)
      * distinguish between a pending and injected exception
-     * and we don't need to store seperately the exception payload.
+     * and we don't need to store separately the exception payload.
      *
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f36..c1ab3efba9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1071,3 +1071,3 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 /* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
@@ -1204,3 +1204,3 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 /* generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used. */
+   value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
@@ -1221,3 +1221,3 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 /* Generate a conditional jump to label 'l1' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranted not to be used.
+   value 'b'. In the fast case, T0 is guaranteed not to be used.
    A translation block must end soon.  */
@@ -5353,3 +5353,3 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             case 0: /* bt */
-                /* Needs no atomic ops; we surpressed the normal
+                /* Needs no atomic ops; we suppressed the normal
                    memory load for LOCK above so do it now.  */
diff --git a/tests/tcg/i386/system/boot.S b/tests/tcg/i386/system/boot.S
index 794c2cb0ad..9e8920cbfe 100644
--- a/tests/tcg/i386/system/boot.S
+++ b/tests/tcg/i386/system/boot.S
@@ -73,3 +73,3 @@ _start:
         /*
-         * Don't worry about stack frame, assume everthing
+         * Don't worry about stack frame, assume everything
          * is garbage when we return, we won't need it.
diff --git a/tests/tcg/i386/x86.csv b/tests/tcg/i386/x86.csv
index c43bf42dd3..5c0f628e35 100644
--- a/tests/tcg/i386/x86.csv
+++ b/tests/tcg/i386/x86.csv
@@ -21,3 +21,3 @@
 #
-# 5. The validity of the instruction in 32-bit (aka compatiblity, legacy) mode.
+# 5. The validity of the instruction in 32-bit (aka compatibility, legacy) mode.
 #
-- 
2.39.2


