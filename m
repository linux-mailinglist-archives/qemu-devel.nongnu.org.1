Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF074E1DD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvc-00089l-Pm; Mon, 10 Jul 2023 19:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvS-0007ss-Q6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvR-0004TN-38
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wwQkhUqHzYSpel71j/LGGzZNtrjeD2cCb2B//2mq/TI=;
 b=WraeWiygY61Qmq+m9QtBWhutJ65pSeTKpIbYXlnvsuhQDBEvfPFligwDBRAdMrU2qk49pY
 CyLmb/ykrA03bejV1q44C8aI7IzpHH+ffotLAy3y0qUx6L27T7TCUi4J8vFX4Slj7Gt8zT
 hF1rg0T1U7xHoAxcmeBVJAs4u5HK+jc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-5sTFlm12NAGM5PXzsXEPTA-1; Mon, 10 Jul 2023 19:04:11 -0400
X-MC-Unique: 5sTFlm12NAGM5PXzsXEPTA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-315935c808bso908793f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030249; x=1691622249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwQkhUqHzYSpel71j/LGGzZNtrjeD2cCb2B//2mq/TI=;
 b=j/9HMh+UunQqShOoYBf6Qilqxdj4QDuKKcNT/iuMXG85G5TxqjDlBIQD17qYuvoCCM
 12mEQ9FGboJvM9VMeNkpm6nBLkFt04JydTwsZucXekNPm4ggse2/gMlufl9vs64AccPM
 aiTU0yQIsKwvzllmcpArwxsrPVbYfT3KizbZZlAQLAtCJEK8TJ9y28hStroOba45mvz6
 U4EdRx0qBLTtD/us13hRLvnoqBHvdJuPHlmINRvcarw/g8NxOdRDgJOifj8pvZT0ysZ7
 J/biJdR6cXzAE8rixTQq2HwgcFRVm88brJc0x0bZFaWqn75KfKhemEksBXeF8TcaSiw5
 mRhw==
X-Gm-Message-State: ABy/qLYrUl7yOHAqLJ+G4BBgQ2eAB1e5RgsVpRu59oONeqttvWjNRpGe
 9mUozQGKKtkZFRiu5ZxWfoXbpGHGamd8918zc1D2M4lfeOHOVzdCzCu+lfPr+9paoRWUJePk+YL
 LKbq+HhFHec7ufq67B59Iot8mP9s3lWNxwu7e38XXxEbcJlvAWZFLbmj0+91W2tvESO/m
X-Received: by 2002:a05:6000:8b:b0:30e:56b3:60fe with SMTP id
 m11-20020a056000008b00b0030e56b360femr12726724wrx.4.1689030249704; 
 Mon, 10 Jul 2023 16:04:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFiNC7qCnAlYOsBpNl23wH8J9eape0FBhDM0sdixtMJjVLzW1f4iv3sUvKkUgt1KiSNfVJZmg==
X-Received: by 2002:a05:6000:8b:b0:30e:56b3:60fe with SMTP id
 m11-20020a056000008b00b0030e56b360femr12726706wrx.4.1689030249415; 
 Mon, 10 Jul 2023 16:04:09 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 g15-20020a5d554f000000b0031411e46af3sm566764wrw.97.2023.07.10.16.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:09 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 35/66] hw/pci/pci: Remove multifunction parameter from
 pci_new_multifunction()
Message-ID: <c925f40a29906355b516bad4c6ef80d30cf971b6.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

There is also pci_new() which creates non-multifunction PCI devices.
Accordingly the parameter is always set to true when a multi function PCI
device is to be created.

The reason for the parameter's existence seems to be that it is used in the
internal PCI code as well which is the only location where it gets set to
false. This one usage can be resolved by factoring out an internal helper
function.

Remove this redundant, error-prone parameter.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230304114043.121024-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h |  3 +--
 hw/i386/pc_q35.c     |  6 +++---
 hw/pci-host/sabre.c  |  6 ++----
 hw/pci/pci.c         | 13 +++++++++----
 hw/sparc64/sun4u.c   |  5 ++---
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 18c35b64db..ab2bd65a3a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -577,8 +577,7 @@ pci_set_quad_by_mask(uint8_t *config, uint64_t mask, uint64_t reg)
     pci_set_quad(config, (~mask & val) | (mask & rval));
 }
 
-PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
-                                    const char *name);
+PCIDevice *pci_new_multifunction(int devfn, const char *name);
 PCIDevice *pci_new(int devfn, const char *name);
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index fdab1f6a56..dc27a9e223 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -100,12 +100,12 @@ static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
         return -1;
     }
 
-    ehci = pci_new_multifunction(PCI_DEVFN(slot, 7), true, name);
+    ehci = pci_new_multifunction(PCI_DEVFN(slot, 7), name);
     pci_realize_and_unref(ehci, bus, &error_fatal);
     usbbus = QLIST_FIRST(&ehci->qdev.child_bus);
 
     for (i = 0; i < 3; i++) {
-        uhci = pci_new_multifunction(PCI_DEVFN(slot, comp[i].func), true,
+        uhci = pci_new_multifunction(PCI_DEVFN(slot, comp[i].func),
                                      comp[i].name);
         qdev_prop_set_string(&uhci->qdev, "masterbus", usbbus->name);
         qdev_prop_set_uint32(&uhci->qdev, "firstport", comp[i].port);
@@ -239,7 +239,7 @@ static void pc_q35_init(MachineState *machine)
     pcms->bus = host_bus;
 
     /* create ISA bus */
-    lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
+    lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 949ecc21f2..dcb2e230b6 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -387,14 +387,12 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
 
     /* APB secondary busses */
-    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), true,
-                                    TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeB = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
 
-    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), true,
-                                    TYPE_SIMBA_PCI_BRIDGE);
+    pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), TYPE_SIMBA_PCI_BRIDGE);
     s->bridgeA = PCI_BRIDGE(pci_dev);
     pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
     pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5152989c10..fb17138f7d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2164,8 +2164,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     pci_dev->msi_trigger = pci_msi_trigger;
 }
 
-PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
-                                 const char *name)
+static PCIDevice *pci_new_internal(int devfn, bool multifunction,
+                                   const char *name)
 {
     DeviceState *dev;
 
@@ -2175,9 +2175,14 @@ PCIDevice *pci_new_multifunction(int devfn, bool multifunction,
     return PCI_DEVICE(dev);
 }
 
+PCIDevice *pci_new_multifunction(int devfn, const char *name)
+{
+    return pci_new_internal(devfn, true, name);
+}
+
 PCIDevice *pci_new(int devfn, const char *name)
 {
-    return pci_new_multifunction(devfn, false, name);
+    return pci_new_internal(devfn, false, name);
 }
 
 bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
@@ -2188,7 +2193,7 @@ bool pci_realize_and_unref(PCIDevice *dev, PCIBus *bus, Error **errp)
 PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
                                            const char *name)
 {
-    PCIDevice *dev = pci_new_multifunction(devfn, true, name);
+    PCIDevice *dev = pci_new_multifunction(devfn, name);
     pci_realize_and_unref(dev, bus, &error_fatal);
     return dev;
 }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 29e9b6cc26..d908a38f73 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -612,7 +612,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
     pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
 
-    ebus = pci_new_multifunction(PCI_DEVFN(1, 0), true, TYPE_EBUS);
+    ebus = pci_new_multifunction(PCI_DEVFN(1, 0), TYPE_EBUS);
     qdev_prop_set_uint64(DEVICE(ebus), "console-serial-base",
                          hwdef->console_serial_base);
     pci_realize_and_unref(ebus, pci_busA, &error_fatal);
@@ -648,8 +648,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
         if (!nd->model || strcmp(nd->model, mc->default_nic) == 0) {
             if (!onboard_nic) {
-                pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1),
-                                                   true, mc->default_nic);
+                pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), mc->default_nic);
                 bus = pci_busA;
                 memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
                 onboard_nic = true;
-- 
MST


