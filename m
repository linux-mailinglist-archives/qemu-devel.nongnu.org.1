Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1074E1E0
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvc-000886-I0; Mon, 10 Jul 2023 19:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvQ-0007gV-Hh
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvO-0004Sd-O8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LemduFqhY2MXG8M8oqW3BXS0GMz2e3CJYcqD9/6gSoI=;
 b=C8O0hpS3xq5BIbqili8yusIQLKJKlXplIfLnfRD7vt/N6LGQHw7iIcbO1D9rh3a4a5yitQ
 4i7eGm5x1ICKIBNKB/5DmpFMWWCsINjOwvmFZceUXKcX2wGWnEQzcmFaZap0AR7gllGexk
 thYmnCTFeKMsSoUEwCSQNcdp/8iFMFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-RmrG_VaFPy-tGAlxH3ZxeA-1; Mon, 10 Jul 2023 19:04:08 -0400
X-MC-Unique: RmrG_VaFPy-tGAlxH3ZxeA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so2831853f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030246; x=1691622246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LemduFqhY2MXG8M8oqW3BXS0GMz2e3CJYcqD9/6gSoI=;
 b=STz6MC/i50XbGvaJycy4t52GmdBpo1lEPSc3ZM6jsJ8gQVXnwrb+I4gGvqab/NtozW
 C4LYhD/8CFkMwd7R2PH+FnuGEcoGuD/zCAGJdnU1qI69GVqVs1foxwnF09hym80SAr/l
 lNUdpmnRGZ09fC+fJa+IBLrOgBPSr6ghltXAymqrTyxkLIJR22vx1l8mJsSeulTPkvIW
 7v93FCPV1MxCaYrHRAIqwIAnikLJgZCqjHMFt4B1+8ThpHvWxSM0bHczvMKUF3WR5VpS
 2YG9C2GSrDdwWcNezN4p/z7p4BOT6IQuv4RAdVC2iBdMJyfGckQpH3iXlgIEVL0zkP0f
 u+1A==
X-Gm-Message-State: ABy/qLacg6iNoaY0R3kUlZEJn3IthtuWtM7rD5ot7fmZvM4IocNF+ptG
 ozIVamO1mLk9oU55UvZ7k7VrD57V9fb5QvP56iMY7Fn/8bEazUvZ+lcsDiQXMG40hHWHLOiTzfl
 vRhoC/4q1VMBl/0o1kcucmETho0nBO8NDuHaUdRsj5OMoF8M6vx8zf8lai8ieNf7yEbX8
X-Received: by 2002:a05:6000:1103:b0:315:83d4:7dd6 with SMTP id
 z3-20020a056000110300b0031583d47dd6mr9621462wrw.5.1689030246676; 
 Mon, 10 Jul 2023 16:04:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYwZmkQO8D3LXX0CcdAd2ab6kzgYtYH+OdS57kxOcneZpMNK1nii2I8kzT0yqfr7yUkIG0Aw==
X-Received: by 2002:a05:6000:1103:b0:315:83d4:7dd6 with SMTP id
 z3-20020a056000110300b0031583d47dd6mr9621439wrw.5.1689030246402; 
 Mon, 10 Jul 2023 16:04:06 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 d2-20020adfe842000000b003143c06135bsm587526wrn.50.2023.07.10.16.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:05 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org
Subject: [PULL 34/66] hw/pci/pci: Remove multifunction parameter from
 pci_create_simple_multifunction()
Message-ID: <e052944a966ca4eb0131121646fa0ef047c25e52.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

There is also pci_create_simple() which creates non-multifunction PCI
devices. Accordingly the parameter is always set to true when a multi
function PCI device is to be created.

The reason for the parameter's existence seems to be that it is used in the
internal PCI code as well which is the only location where it gets set to
false. This one usage can be replaced by trivial code.

Remove this redundant, error-prone parameter.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230304114043.121024-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 1 -
 hw/i386/pc_piix.c    | 3 +--
 hw/i386/pc_q35.c     | 4 ++--
 hw/mips/boston.c     | 3 +--
 hw/mips/fuloong2e.c  | 2 +-
 hw/mips/malta.c      | 2 +-
 hw/pci/pci.c         | 7 ++++---
 hw/ppc/pegasos2.c    | 2 +-
 8 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a29..18c35b64db 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -583,7 +583,6 @@ PCIDevice *pci_new(int devfn, const char *name);
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
 
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
-                                           bool multifunction,
                                            const char *name);
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b18443d3df..ac72e8f5be 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -263,8 +263,7 @@ static void pc_init1(MachineState *machine,
         PIIX3State *piix3;
         PCIDevice *pci_dev;
 
-        pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
-                                                  TYPE_PIIX3_DEVICE);
+        pci_dev = pci_create_simple_multifunction(pci_bus, -1, TYPE_PIIX3_DEVICE);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 02dd274276..fdab1f6a56 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -304,7 +304,7 @@ static void pc_q35_init(MachineState *machine)
         ahci = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
-                                               true, "ich9-ahci");
+                                               "ich9-ahci");
         idebus[0] = qdev_get_child_bus(&ahci->qdev, "ide.0");
         idebus[1] = qdev_get_child_bus(&ahci->qdev, "ide.1");
         g_assert(MAX_SATA_PORTS == ahci_get_num_ports(ahci));
@@ -326,7 +326,7 @@ static void pc_q35_init(MachineState *machine)
         smb = pci_create_simple_multifunction(host_bus,
                                               PCI_DEVFN(ICH9_SMB_DEV,
                                                         ICH9_SMB_FUNC),
-                                              true, TYPE_ICH9_SMB_DEVICE);
+                                              TYPE_ICH9_SMB_DEVICE);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(smb), "i2c"));
 
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 21ad844519..4e11ff6cd6 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -770,8 +770,7 @@ static void boston_mach_init(MachineState *machine)
                              boston_lcd_event, NULL, s, NULL, true);
 
     ahci = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
-                                           PCI_DEVFN(0, 0),
-                                           true, TYPE_ICH9_AHCI);
+                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
     g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(ahci));
     ide_drive_get(hd, ahci_get_num_ports(ahci));
     ahci_ide_create_devs(ahci, hd);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index cfc8ca6ae4..c827f615f3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -297,7 +297,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     /* South bridge -> IP5 */
     pci_dev = pci_create_simple_multifunction(pci_bus,
                                               PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
-                                              true, TYPE_VT82C686B_ISA);
+                                              TYPE_VT82C686B_ISA);
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 47cb49f691..f9618fa5f5 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1251,7 +1251,7 @@ void mips_malta_init(MachineState *machine)
     pci_bus_map_irqs(pci_bus, malta_pci_slot_get_pirq);
 
     /* Southbridge */
-    piix4 = pci_create_simple_multifunction(pci_bus, PIIX4_PCI_DEVFN, true,
+    piix4 = pci_create_simple_multifunction(pci_bus, PIIX4_PCI_DEVFN,
                                             TYPE_PIIX4_PCI_DEVICE);
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix4), "isa.0"));
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..5152989c10 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2186,17 +2186,18 @@ bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
 }
 
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
-                                           bool multifunction,
                                            const char *name)
 {
-    PCIDevice *dev = pci_new_multifunction(devfn, multifunction, name);
+    PCIDevice *dev = pci_new_multifunction(devfn, true, name);
     pci_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
 
 PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
 {
-    return pci_create_simple_multifunction(bus, devfn, false, name);
+    PCIDevice *dev = pci_new(devfn, name);
+    pci_realize_and_unref(dev, bus, &error_fatal);
+    return dev;
 }
 
 static uint8_t pci_find_space(PCIDevice *pdev, uint8_t size)
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 9c9944188b..4447bbe8ec 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -180,7 +180,7 @@ static void pegasos2_init(MachineState *machine)
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12, 0),
-                                                 true, TYPE_VT8231_ISA));
+                                                 TYPE_VT8231_ISA));
     for (i = 0; i < PCI_NUM_PINS; i++) {
         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
     }
-- 
MST


