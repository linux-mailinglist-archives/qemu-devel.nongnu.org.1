Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B970BC69
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144H-0005c1-UI; Mon, 22 May 2023 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143b-0005BH-Eb
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143Z-0007YK-6S
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9ZCTFF/NM2e1SLnCvV9JUPDKoXwZ90Q4A/ClJj8yBw=;
 b=TBLAiMDP/Oq4MNNAe0ZQzc8035kQy1WO7Gbf/epgXA4Z1E+Lssql1K8QdGA7uxsSRlF8bz
 7B1daZ/vExqfX+/bjk76+fAqTPX4vdls+kMTcbIen0xg5mMaVSxPIYMWseh9DLnyrfGdoF
 5QtMVRIHAYh9nfsInuAI5GLTFKTWFCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-X1wkD3fqNsWgble6pKNguw-1; Mon, 22 May 2023 07:50:23 -0400
X-MC-Unique: X1wkD3fqNsWgble6pKNguw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91FBC800159;
 Mon, 22 May 2023 11:50:22 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 912B32166B26;
 Mon, 22 May 2023 11:50:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/20] hw/ppc: Use MachineClass->default_nic in the ppc machines
Date: Mon, 22 May 2023 13:49:59 +0200
Message-Id: <20230522115014.1110840-6-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Message-Id: <20230512124033.502654-6-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/e500.c          | 3 ++-
 hw/ppc/e500plat.c      | 1 +
 hw/ppc/mac_newworld.c  | 4 +++-
 hw/ppc/mac_oldworld.c  | 4 +++-
 hw/ppc/mpc8544ds.c     | 1 +
 hw/ppc/ppc440_bamboo.c | 4 +++-
 hw/ppc/prep.c          | 4 +++-
 7 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 117c9c08ed..b6eb599751 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -898,6 +898,7 @@ void ppce500_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     PPCE500MachineState *pms = PPCE500_MACHINE(machine);
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
+    MachineClass *mc = MACHINE_CLASS(pmc);
     PCIBus *pci_bus;
     CPUPPCState *env = NULL;
     uint64_t loadaddr;
@@ -1073,7 +1074,7 @@ void ppce500_init(MachineState *machine)
     if (pci_bus) {
         /* Register network interfaces. */
         for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio-net-pci", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
         }
     }
 
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 3032bd3f6d..7aa2f2107a 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -99,6 +99,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
+    mc->default_nic = "virtio-net-pci";
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 460c14b5e3..535710314a 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -132,6 +132,7 @@ static void ppc_core99_reset(void *opaque)
 static void ppc_core99_init(MachineState *machine)
 {
     Core99MachineState *core99_machine = CORE99_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
@@ -444,7 +445,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "sungem", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
     }
 
     /* The NewWorld NVRAM is not located in the MacIO device */
@@ -577,6 +578,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_boot_order = "cd";
     mc->default_display = "std";
+    mc->default_nic = "sungem";
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 2e4cc3fe0b..510ff0eaaf 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -87,6 +87,7 @@ static void ppc_heathrow_reset(void *opaque)
 static void ppc_heathrow_init(MachineState *machine)
 {
     const char *bios_name = machine->firmware ?: PROM_FILENAME;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
@@ -276,7 +277,7 @@ static void ppc_heathrow_init(MachineState *machine)
     pci_vga_init(pci_bus);
 
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
     }
 
     /* MacIO IDE */
@@ -424,6 +425,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = heathrow_kvm_type;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750_v3.1");
     mc->default_display = "std";
+    mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
     fwc->get_dev_path = heathrow_fw_dev_path;
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 7dd5219736..b7130903d6 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -61,6 +61,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 15;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
+    mc->default_nic = "virtio-net-pci";
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2880c81cb1..f969fa3c29 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -161,6 +161,7 @@ static void bamboo_init(MachineState *machine)
 {
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     unsigned int pci_irq_nrs[4] = { 28, 27, 26, 25 };
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
@@ -246,7 +247,7 @@ static void bamboo_init(MachineState *machine)
              * There are no PCI NICs on the Bamboo board, but there are
              * PCI slots, so we can pick whatever default model we want.
              */
-            pci_nic_init_nofail(&nd_table[i], pcibus, "e1000", NULL);
+            pci_nic_init_nofail(&nd_table[i], pcibus, mc->default_nic, NULL);
         }
     }
 
@@ -296,6 +297,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->init = bamboo_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
+    mc->default_nic = "e1000";
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d00280c0f8..4610abddbd 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -229,6 +229,7 @@ static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
 static void ibm_40p_init(MachineState *machine)
 {
     const char *bios_name = machine->firmware ?: "openbios-ppc";
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUPPCState *env = NULL;
     uint16_t cmos_checksum;
     PowerPCCPU *cpu;
@@ -323,7 +324,7 @@ static void ibm_40p_init(MachineState *machine)
         pci_vga_init(pci_bus);
 
         for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "pcnet",
+            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic,
                                 i == 0 ? "3" : NULL);
         }
     }
@@ -427,6 +428,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_boot_order = "c";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
+    mc->default_nic = "pcnet";
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.31.1


