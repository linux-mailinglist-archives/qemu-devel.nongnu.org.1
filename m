Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A275D888
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 03:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN19D-0007e0-39; Fri, 21 Jul 2023 21:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qN196-0007dN-FZ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 21:10:56 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qN194-0003vV-QA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 21:10:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4146461DBB;
 Sat, 22 Jul 2023 01:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90B8C433CA;
 Sat, 22 Jul 2023 01:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689988250;
 bh=0jy3DhgLsjglKa3CfNfoSJ9ChE2daVAu+4prkRCdmVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zz9Uzgu1JpyH1cbDaMo8scSTBdrkJjB1YZjvaRJTTmShGvOBY7O9R3KBzFn4xxid6
 7H6HMMud6ZV01BKFA+WeBvOaPS7+Ixi+z8cW21avPtA+Z9ioAdyhMFR4Oygmuczt6Q
 hv3nfVvedWgVEbTchBeKK838OxThp+hj+dvFHC0pzylj9pIZZ+OJerMCeds8VjFtw3
 kKwNFNgCirgms26iA0uo1poEMZ4M98WpYA+MeF6z+7CwKXbYTXlQDS8fzWO1mVVQMc
 Yeaoy5i8TCa+vIGjhUq5CmdU2g0ZoeJw2lb1GWTSvxrSb4vPEpRfXr7jXmYJ7/vBIp
 qOzaTnkpBcmoQ==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PULL 2/2] xen_arm: Initialize RAM and add hi/low memory regions
Date: Fri, 21 Jul 2023 18:10:45 -0700
Message-Id: <20230722011045.3740256-2-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2307211804380.3118466@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2307211804380.3118466@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

In order to use virtio backends we need to initialize RAM for the
xen-mapcache (which is responsible for mapping guest memory using foreign
mapping) to work. Calculate and add hi/low memory regions based on
machine->ram_size.

Use the constants defined in public header arch-arm.h to be aligned with the xen
toolstack.

While using this machine, the toolstack should then pass real ram_size using
"-m" arg. If "-m" is not given, create a QEMU machine without IOREQ and other
emulated devices like TPM and VIRTIO. This is done to keep this QEMU machine
usable for /etc/init.d/xencommons.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index e700829654..ec8de00cf5 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -60,6 +60,8 @@ struct XenArmState {
     } cfg;
 };
 
+static MemoryRegion ram_lo, ram_hi;
+
 /*
  * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
  * repository.
@@ -92,6 +94,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
     }
 }
 
+static void xen_init_ram(MachineState *machine)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
+
+    if (machine->ram_size <= GUEST_RAM0_SIZE) {
+        ram_size[0] = machine->ram_size;
+        ram_size[1] = 0;
+        block_len = GUEST_RAM0_BASE + ram_size[0];
+    } else {
+        ram_size[0] = GUEST_RAM0_SIZE;
+        ram_size[1] = machine->ram_size - GUEST_RAM0_SIZE;
+        block_len = GUEST_RAM1_BASE + ram_size[1];
+    }
+
+    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+                           &error_fatal);
+
+    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
+                             GUEST_RAM0_BASE, ram_size[0]);
+    memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
+    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
+            GUEST_RAM0_BASE, ram_size[0]);
+
+    if (ram_size[1] > 0) {
+        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
+                                 GUEST_RAM1_BASE, ram_size[1]);
+        memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
+        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
+                GUEST_RAM1_BASE, ram_size[1]);
+    }
+}
+
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
@@ -141,6 +176,14 @@ static void xen_arm_init(MachineState *machine)
 
     xam->state =  g_new0(XenIOState, 1);
 
+    if (machine->ram_size == 0) {
+        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
+                "(no emulated devices including Virtio)\n");
+        return;
+    }
+
+    xen_init_ram(machine);
+
     xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
@@ -188,6 +231,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    /* Set explicitly here to make sure that real ram_size is passed */
+    mc->default_ram_size = 0;
 
 #ifdef CONFIG_TPM
     object_class_property_add(oc, "tpm-base-addr", "uint64_t",
-- 
2.25.1


