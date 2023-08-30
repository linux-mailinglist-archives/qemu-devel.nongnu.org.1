Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7F78E19D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 23:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbT2t-00080U-4D; Wed, 30 Aug 2023 17:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbT2q-000802-O8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbT2o-0006C2-9e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693432088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=8fs3hPB5X2ITCdZ7xzWYsJNVG3NRk6gEjz43Vk2WDME=;
 b=PW7XBDWE5XeTmZ7N8oULc0f9cLyiODXX7NooN4zQFUUEjnZmhPhGEF8ooDdaukmvdjzNeM
 Joqn/zPsajXb6ioR/rcSNdfH2f/gvTtIC694Wf9ezWBefp9m+Ku4kTKARrdnVYgVUf6BlG
 kqfoVR14PUjK5HA/3OQNwFcudH6rvtY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-f-ekgi0-M127u2qEHuLgog-1; Wed, 30 Aug 2023 17:48:07 -0400
X-MC-Unique: f-ekgi0-M127u2qEHuLgog-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bcf6ae8e1so6274066b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 14:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693432086; x=1694036886;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fs3hPB5X2ITCdZ7xzWYsJNVG3NRk6gEjz43Vk2WDME=;
 b=NhDC3jSdHNVssCMcRc9tK4pQXVMBwaMFM8z/Z2XqNu7yfWoMhloTcDLAqntcYU8YgU
 R2hY8Inqj84RtctCTtpGirgvoJPJXcre/9UwYliwOZZNcmcHf8jyd+AXJ5jh0OSdJBGE
 Yg0Q6jOYvHQ/FlImGSZL9CZG7lDVvELpnDPUJM01R9OU34GvOCPC0JOlx1au/qpAXL65
 AbBNeQOqMuQBEAAKW/GCgQ2BB1exvzC3I5I03m4u6EcOJ6LcJwZlAPudCFFHeGZGEP5z
 EBYuyFVIyyyO7pvVr0qy08BDGv0b3+xE/z4Ykv5jngwP4uxj+VmoU2aeWYtL6cAtnkdr
 Omkw==
X-Gm-Message-State: AOJu0YzYdW68BL4f3vz86EujUne0pw9L4MpKZ9SqBWkh5Md05vzvJnum
 ZXMCsCQFmZsjYv9SoQ33Tz8L+iFy2CvZx+8CHS/efCJfQvpGmkhpdUM5vOizbSf9NI8QYniRrBb
 /FNwPy6v3GTPaItGkXIwkJtrtoBZxzvZXdCS3t2qWYl107tgHpRlx5O0CaiCxx7IQijQ1
X-Received: by 2002:a17:906:5181:b0:9a1:e8c0:7e30 with SMTP id
 y1-20020a170906518100b009a1e8c07e30mr2243388ejk.7.1693432085746; 
 Wed, 30 Aug 2023 14:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmne+4Bxki8JvfMbo3Y9jpbx9SrWSLjPoeontI7osQvnHfSkM3OuQTDZNhqmG76aPiCjDJMg==
X-Received: by 2002:a17:906:5181:b0:9a1:e8c0:7e30 with SMTP id
 y1-20020a170906518100b009a1e8c07e30mr2243374ejk.7.1693432085268; 
 Wed, 30 Aug 2023 14:48:05 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 lt20-20020a170906fa9400b009a193a5acffsm15069ejb.121.2023.08.30.14.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:48:04 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:48:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] pci: SLT must be RO
Message-ID: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

current code sets PCI_SEC_LATENCY_TIMER to WO, but for
pcie to pcie bridges it must be RO 0 according to
pci express spec which says:
    This register does not apply to PCI Express. It must be read-only
    and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer to the
    [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.

also, fix typo in comment where it's make writeable - this typo
is likely what prevented us noticing we violate this requirement
in the 1st place.

Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Marcin, could you pls test this patch with virt-8.1 and latest?
Thanks a lot!


 include/hw/pci/pci_bridge.h |  3 +++
 hw/core/machine.c           |  5 ++++-
 hw/pci/pci.c                |  2 +-
 hw/pci/pci_bridge.c         | 14 ++++++++++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index ea54a81a15..5cd452115a 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -77,6 +77,9 @@ struct PCIBridge {
 
     pci_map_irq_fn map_irq;
     const char *bus_name;
+
+    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
+    bool pcie_writeable_slt_bug;
 };
 
 #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e1..76743e3b31 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
@@ -39,7 +40,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
 
-GlobalProperty hw_compat_8_1[] = {};
+GlobalProperty hw_compat_8_1[] = {
+    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
+};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
 GlobalProperty hw_compat_8_0[] = {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 881d774fb6..b0d21bf43a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -893,7 +893,7 @@ static void pci_init_w1cmask(PCIDevice *dev)
 static void pci_init_mask_bridge(PCIDevice *d)
 {
     /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
-       PCI_SEC_LETENCY_TIMER */
+       PCI_SEC_LATENCY_TIMER */
     memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
 
     /* base and limit */
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index e7b9345615..6a4e38856d 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -38,6 +38,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/acpi/pci.h"
+#include "hw/qdev-properties.h"
 
 /* PCI bridge subsystem vendor ID helper functions */
 #define PCI_SSVID_SIZEOF        8
@@ -385,6 +386,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
+
+    /* For express secondary buses, secondary latency timer is RO 0 */
+    if (pci_bus_is_express(sec_bus) && !br->pcie_writeable_slt_bug) {
+        dev->wmask[PCI_SEC_LATENCY_TIMER] = 0;
+    }
 }
 
 /* default qdev clean up function for PCI-to-PCI bridge */
@@ -466,10 +472,18 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     return 0;
 }
 
+static Property pci_bridge_properties[] = {
+    DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
+                     pcie_writeable_slt_bug, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_bridge_class_init(ObjectClass *klass, void *data)
 {
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+    DeviceClass *k = DEVICE_CLASS(klass);
 
+    device_class_set_props(k, pci_bridge_properties);
     adevc->build_dev_aml = build_pci_bridge_aml;
 }
 
-- 
MST


