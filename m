Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E1770BC53
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1449-0005Pf-Lg; Mon, 22 May 2023 07:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143Z-0005Ap-Fx
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143T-0007TM-P1
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Xjm+tgY5EvSnU5yqhPj0rcCcM7szS3mEd3kc0jDIts=;
 b=a4eQCp2I+TPpPRXKKqfM5Vw6bF9kYPtHaqCRTO/2P6xDLzjVR7MikF2JSaBEul/mi0hOJ6
 quV6l3bjr6zf8DwpHLTwMGw6dY/CXco2iSxF8HQdPgh0NxdaX1OTF/i9YLKhOs+IIldan+
 vDZTbi8RCuBinAV0IMLjYt2IFiyy1XQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-kOaMMHbvMsaaqiy1xghl5g-1; Mon, 22 May 2023 07:50:20 -0400
X-MC-Unique: kOaMMHbvMsaaqiy1xghl5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22C6D3C02B72;
 Mon, 22 May 2023 11:50:20 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FC552166B26;
 Mon, 22 May 2023 11:50:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/20] hw: Move the default NIC machine class setting from the
 x86 to the generic one
Date: Mon, 22 May 2023 13:49:57 +0200
Message-Id: <20230522115014.1110840-4-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

We are going to re-use this setting for other targets, so let's
move this to the main MachineClass.

Message-Id: <20230512124033.502654-4-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h  | 1 +
 include/hw/i386/pc.h | 1 -
 hw/i386/pc.c         | 3 ++-
 hw/i386/pc_piix.c    | 4 ++--
 hw/i386/pc_q35.c     | 6 ++----
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f4117fdb9a..a385010909 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -253,6 +253,7 @@ struct MachineClass {
     const char *default_machine_opts;
     const char *default_boot_order;
     const char *default_display;
+    const char *default_nic;
     GPtrArray *compat_props;
     const char *hw_version;
     ram_addr_t default_ram_size;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 79e755879d..c661e9cc80 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -93,7 +93,6 @@ struct PCMachineClass {
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
-    const char *default_nic_model;
 
     /* Compat options: */
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b3d826a83a..bb62c994fa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1364,12 +1364,13 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
 {
+    MachineClass *mc = MACHINE_CLASS(pcmc);
     int i;
 
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
-        const char *model = nd->model ? nd->model : pcmc->default_nic_model;
+        const char *model = nd->model ? nd->model : mc->default_nic;
 
         if (g_str_equal(model, "ne2k_isa")) {
             pc_init_ne2k_isa(isa_bus, nd);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 10070ea9a5..17892ad580 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -450,7 +450,6 @@ static void pc_xen_hvm_init(MachineState *machine)
 static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pcmc->default_nic_model = "e1000";
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -458,6 +457,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->default_nic = "e1000";
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
@@ -884,7 +884,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->gigabyte_align = false;
     pcmc->smbios_legacy_mode = true;
     pcmc->has_reserved_memory = false;
-    pcmc->default_nic_model = "ne2k_isa";
+    m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8030d53da6..7e0f354edd 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -356,7 +356,6 @@ static void pc_q35_init(MachineState *machine)
 static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pcmc->default_nic_model = "e1000e";
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -365,6 +364,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
@@ -577,10 +577,8 @@ DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
 
 static void pc_q35_2_11_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
     pc_q35_2_12_machine_options(m);
-    pcmc->default_nic_model = "e1000";
+    m->default_nic = "e1000";
     compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
-- 
2.31.1


