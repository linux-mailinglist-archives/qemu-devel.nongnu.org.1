Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85876785104
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhlV-0004D1-Qj; Wed, 23 Aug 2023 02:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhkw-000459-AV
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:54:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhkt-000176-Fk
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:54:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 435051C403
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:54:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4B5E8212A5;
 Wed, 23 Aug 2023 09:54:01 +0300 (MSK)
Received: (nullmailer pid 1919460 invoked by uid 1000);
 Wed, 23 Aug 2023 06:54:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 09/24] ppc: spelling fixes
Date: Wed, 23 Aug 2023 09:53:20 +0300
Message-Id: <20230823065335.1919380-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
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
 host/include/ppc/host/cpuinfo.h     |  2 +-
 hw/ppc/ppc.c                        |  2 +-
 hw/ppc/prep_systemio.c              |  2 +-
 hw/ppc/spapr.c                      |  8 ++++----
 hw/ppc/spapr_hcall.c                |  2 +-
 hw/ppc/spapr_nvdimm.c               |  4 ++--
 hw/ppc/spapr_pci_vfio.c             |  2 +-
 include/hw/ppc/openpic.h            |  2 +-
 include/hw/ppc/spapr.h              |  2 +-
 target/ppc/cpu-models.h             |  4 ++--
 target/ppc/cpu.h                    |  2 +-
 target/ppc/cpu_init.c               |  4 ++--
 target/ppc/excp_helper.c            | 14 +++++++-------
 target/ppc/power8-pmu-regs.c.inc    |  4 ++--
 target/ppc/translate/vmx-impl.c.inc |  6 +++---
 15 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/host/include/ppc/host/cpuinfo.h b/host/include/ppc/host/cpuinfo.h
index 29ee7f9ef8..38b8eabe2a 100644
--- a/host/include/ppc/host/cpuinfo.h
+++ b/host/include/ppc/host/cpuinfo.h
@@ -1,5 +1,5 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for ppc.
+ * Host specific cpu identification for ppc.
  */
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3..6c46204428 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -714,5 +714,5 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
 
     /*
-     * If large decrementer is enabled then the decrementer is signed extened
+     * If large decrementer is enabled then the decrementer is signed extended
      * to 64 bits, otherwise it is a 32 bit value.
      */
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 5a56f155f5..c96cefb13d 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -40,5 +40,5 @@
 OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
 
-/* Bit as defined in PowerPC Reference Plaform v1.1, sect. 6.1.5, p. 132 */
+/* Bit as defined in PowerPC Reference Platform v1.1, sect. 6.1.5, p. 132 */
 #define PREP_BIT(n) (1 << (7 - (n)))
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a7..298b4cebf0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2552,5 +2552,5 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     }
 
-    /* Detemine the VSMT mode to use: */
+    /* Determine the VSMT mode to use: */
     if (vsmt_user) {
         if (spapr->vsmt < smp_threads) {
@@ -3088,5 +3088,5 @@ static int spapr_kvm_type(MachineState *machine, const char *vm_type)
     /*
      * The use of g_ascii_strcasecmp() for 'hv' and 'pr' is to
-     * accomodate the 'HV' and 'PV' formats that exists in the
+     * accommodate the 'HV' and 'PV' formats that exists in the
      * wild. The 'auto' mode is being introduced already as
      * lower-case, thus we don't need to bother checking for
@@ -4322,5 +4322,5 @@ spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    /* make sure possible_cpu are intialized */
+    /* make sure possible_cpu are initialized */
     mc->possible_cpu_arch_ids(machine);
     /* get CPU core slot containing thread that matches cpu_index */
@@ -5013,5 +5013,5 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
     /* We depend on kvm_enabled() to choose a default value for the
      * hpt-max-page-size capability. Of course we can't do it here
-     * because this is too early and the HW accelerator isn't initialzed
+     * because this is too early and the HW accelerator isn't initialized
      * yet. Postpone this to machine init (see default_caps_with_cpu()).
      */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9b1f225d4a..d69867583d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1559,5 +1559,5 @@ static void hypercall_register_types(void)
                              h_get_cpu_characteristics);
 
-    /* "debugger" hcalls (also used by SLOF). Note: We do -not- differenciate
+    /* "debugger" hcalls (also used by SLOF). Note: We do -not- differentiate
      * here between the "CI" and the "CACHE" variants, they will use whatever
      * mapping attributes qemu is using. When using KVM, the kernel will
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index a8688243a6..4e34545dcf 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -378,5 +378,5 @@ static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
     /*
      * Currently continue token should be zero qemu has already bound
-     * everything and this hcall doesnt return H_BUSY.
+     * everything and this hcall doesn't return H_BUSY.
      */
     if (continue_token > 0) {
@@ -589,5 +589,5 @@ void spapr_nvdimm_finish_flushes(void)
      * the pending BHs has gotten out running in the reset path,
      * finally reaching here. Other code path being guest
-     * h_client_architecture_support, thats early boot up.
+     * h_client_architecture_support, that's early boot up.
      */
     nvdimms = nvdimm_get_device_list();
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index d8aeee0b7e..9016720547 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -79,5 +79,5 @@ int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
          * pass-through devices (vfio-pci) under this sphb bus.
          * We have already validated that all the devices under this sphb
-         * are from same iommu group (within same PE) before comming here.
+         * are from same iommu group (within same PE) before coming here.
          *
          * Prior to linux commit 98ba956f6a389 ("powerpc/pseries/eeh:
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index bae8dafe16..9c6af8e207 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -15,5 +15,5 @@ enum {
     OPENPIC_OUTPUT_CINT,    /* critical IRQ              */
     OPENPIC_OUTPUT_MCK,     /* Machine check event       */
-    OPENPIC_OUTPUT_DEBUG,   /* Inconditional debug event */
+    OPENPIC_OUTPUT_DEBUG,   /* Unconditional debug event */
     OPENPIC_OUTPUT_RESET,   /* Core reset event          */
     OPENPIC_OUTPUT_NB,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 538b2dfb89..658f9daaa1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -198,5 +198,5 @@ struct SpaprMachineState {
     void *htab;
     uint32_t htab_shift;
-    uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROC_TBL */
+    uint64_t patb_entry; /* Process tbl registered in H_REGISTER_PROC_TBL */
     SpaprPendingHpt *pending_hpt; /* in-progress resize */
 
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 572b5e553a..0229ef3a9a 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -45,5 +45,5 @@ enum {
     CPU_POWERPC_405D2              = 0x20010000,
     CPU_POWERPC_405D4              = 0x41810000,
-    /* PowerPC 405 microcontrolers */
+    /* PowerPC 405 microcontrollers */
     /* XXX: missing 0x200108a0 */
     CPU_POWERPC_405CRa             = 0x40110041,
@@ -75,5 +75,5 @@ enum {
     /* PowerPC 440 cores */
     CPU_POWERPC_440_XILINX         = 0x7ff21910,
-    /* PowerPC 440 microcontrolers */
+    /* PowerPC 440 microcontrollers */
     CPU_POWERPC_440EPa             = 0x42221850,
     CPU_POWERPC_440EPb             = 0x422218D3,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..fbaf41828a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -429,5 +429,5 @@ FIELD(MSR, LE, MSR_LE, 1)
 /* PMU bits */
 #define MMCR0_FC     PPC_BIT(32)         /* Freeze Counters  */
-#define MMCR0_PMAO   PPC_BIT(56)         /* Perf Monitor Alert Ocurred */
+#define MMCR0_PMAO   PPC_BIT(56)         /* Perf Monitor Alert Occurred */
 #define MMCR0_PMAE   PPC_BIT(37)         /* Perf Monitor Alert Enable */
 #define MMCR0_EBE    PPC_BIT(43)         /* Perf Monitor EBB Enable */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0..22355f862d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5348,5 +5348,5 @@ static void register_power5p_lpar_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    /* Logical partitionning */
+    /* Logical partitioning */
     spr_register_kvm_hv(env, SPR_LPCR, "LPCR",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -5751,5 +5751,5 @@ static void register_power10_hash_sprs(CPUPPCState *env)
 {
     /*
-     * it's the OS responsability to generate a random value for the registers
+     * it's the OS responsibility to generate a random value for the registers
      * in each process' context. So, initialize it with 0 here.
      */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9aa8e46566..0373839c1d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -456,5 +456,5 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden.
+     * explicitly overridden.
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME));
@@ -579,5 +579,5 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
@@ -740,5 +740,5 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
@@ -911,5 +911,5 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
@@ -1074,5 +1074,5 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & ((target_ulong)1 << MSR_ME);
@@ -1287,5 +1287,5 @@ static bool books_vhyp_handles_hcall(PowerPCCPU *cpu)
  * When running a nested KVM HV guest under vhyp, HV exceptions are not
  * delivered to the guest (because there is no concept of HV support), but
- * rather they are sent tothe vhyp to exit from the L2 back to the L1 and
+ * rather they are sent to the vhyp to exit from the L2 back to the L1 and
  * return from the H_ENTER_NESTED hypercall.
  */
@@ -1376,5 +1376,5 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     /*
      * new interrupt handler msr preserves existing HV and ME unless
-     * explicitly overriden
+     * explicitly overridden
      */
     new_msr = env->msr & (((target_ulong)1 << MSR_ME) | MSR_HVB);
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index c82feedaff..75513db894 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -17,5 +17,5 @@
  * PMCs) has problem state read access.
  *
- * Read acccess is granted for all PMCC values but 0b01, where a
+ * Read access is granted for all PMCC values but 0b01, where a
  * Facility Unavailable Interrupt will occur.
  */
@@ -34,5 +34,5 @@ static bool spr_groupA_read_allowed(DisasContext *ctx)
  * PMCs) has problem state write access.
  *
- * Write acccess is granted for PMCC values 0b10 and 0b11. Userspace
+ * Write access is granted for PMCC values 0b10 and 0b11. Userspace
  * writing with PMCC 0b00 will generate a Hypervisor Emulation
  * Assistance Interrupt. Userspace writing with PMCC 0b01 will
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index c8712dd7d8..28b31298f1 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -120,5 +120,5 @@ static void gen_stve##name(DisasContext *ctx)                           \
 
 GEN_VR_LDX(lvx, 0x07, 0x03);
-/* As we don't emulate the cache, lvxl is stricly equivalent to lvx */
+/* As we don't emulate the cache, lvxl is strictly equivalent to lvx */
 GEN_VR_LDX(lvxl, 0x07, 0x0B);
 
@@ -128,5 +128,5 @@ GEN_VR_LVE(wx, 0x07, 0x02, 4);
 
 GEN_VR_STX(svx, 0x07, 0x07);
-/* As we don't emulate the cache, stvxl is stricly equivalent to stvx */
+/* As we don't emulate the cache, stvxl is strictly equivalent to stvx */
 GEN_VR_STX(svxl, 0x07, 0x0F);
 
@@ -1529,5 +1529,5 @@ static void gen_vprtyb_vec(unsigned vece, TCGv_vec t, TCGv_vec b)
     int i;
     TCGv_vec tmp = tcg_temp_new_vec_matching(b);
-    /* MO_32 is 2, so 2 iteractions for MO_32 and 3 for MO_64 */
+    /* MO_32 is 2, so 2 iterations for MO_32 and 3 for MO_64 */
     for (i = 0; i < vece; i++) {
         tcg_gen_shri_vec(vece, tmp, b, (4 << (vece - i)));
-- 
2.39.2


