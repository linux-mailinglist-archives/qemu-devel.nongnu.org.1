Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C07B7A70
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:45:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxTq-0002Qe-Cb; Wed, 04 Oct 2023 04:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTk-0002Ia-W3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxTi-0000un-Jq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJkiTw8U/nk2edqHVe6dUwNUdcRD7I2JmYKj4vEBhwM=;
 b=SQTXHWC91XVX66cE1rVF7oGZS6BLWGJ5dZFNmEgJHy96AnbTyCJQr86g/6951ui9Opl2Iz
 qdoZI+UN55f5glVu7yldg85j8cW13JnXb0B5bTVwlHEkmjW9zBSr22fo/fhZoQECwc8M6o
 gTfipQubJ2A4d3nhsayvaoYNCjB5G/k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-aOJjjzw7NgexeobiJlurrg-1; Wed, 04 Oct 2023 04:43:18 -0400
X-MC-Unique: aOJjjzw7NgexeobiJlurrg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503343a850aso1689736e87.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696408996; x=1697013796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJkiTw8U/nk2edqHVe6dUwNUdcRD7I2JmYKj4vEBhwM=;
 b=aPO8MbrXfwVJ1ulGW6fswuSANvjCLOban5uvt+pC3u/ANB7GOrzhQ6vJD8cROJVHMX
 TGGppGw7mwb9zQPgBYdKIwGe0qnwR45khdNmd5l05y/y97KVIFacyne1te9umgVcpfHU
 EG6FyHe1lOCBWWqMX2L4h2V8Slvz58nHTOrea+x9XC9LFeKTeORpKTmTXAc0m9LsN7IL
 JO5qeYKs0elIM1wNaUHhaprytkQuzuNwzLb8U9vctp+4DVUD6NcgOmR0tALa3EKkkOvu
 /EdibPUBSOTubaN974MW/FyvhPxa0Os98YMBiNoVTNYNLxo7Z3I3FRl+r6+/Bu08xDDT
 8PHw==
X-Gm-Message-State: AOJu0YyVLX0VoBFKJu6Rgh60xwfcNDcwaTjJqADqQ3HM8Tapwp9WEFo5
 km+bJqS3vKEr/eHhAcO/vnIcfJd4dY51ZNZ/Sp8YvuVp7+N6TZJnnabHBzsDvf2P5Rl9hrRhqR5
 MVf7Te6eJe2wMgY8y3Lfp4uh39lOA93/5Ta9Sxwvi8ynE/UcdotNzk2a8exB0Dcu+rHlx
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id
 t21-20020a056512069500b0050328cbc087mr2307413lfe.29.1696408996341; 
 Wed, 04 Oct 2023 01:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIwwbLUnNBE2fJNz5ibVOk3hdFFQ4R4QdK+kBQM11ObRX7EnbD0I2ynwUVe7AdKG/BllwZUg==
X-Received: by 2002:a05:6512:695:b0:503:28cb:c087 with SMTP id
 t21-20020a056512069500b0050328cbc087mr2307385lfe.29.1696408995965; 
 Wed, 04 Oct 2023 01:43:15 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c280700b004047ac770d1sm950199wmb.8.2023.10.04.01.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:43:15 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:43:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 01/63] pci: SLT must be RO
Message-ID: <971c71a2dd22b9cde228a2a74f2a65622d037a9b.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

current code sets PCI_SEC_LATENCY_TIMER to RW, but for
pcie to pcie bridges it must be RO 0 according to
pci express spec which says:
    This register does not apply to PCI Express. It must be read-only
    and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer to the
    [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.

also, fix typo in comment where it's made writeable - this typo
is likely what prevented us noticing we violate this requirement
in the 1st place.

Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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
index cb38b8cf4c..9ae8f793ae 100644
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
@@ -40,7 +41,9 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 
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


