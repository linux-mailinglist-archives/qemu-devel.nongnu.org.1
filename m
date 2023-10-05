Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06127B9A4F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFG1-00019p-DH; Wed, 04 Oct 2023 23:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFFz-00019a-Aw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFFx-0007wj-P7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UJkiTw8U/nk2edqHVe6dUwNUdcRD7I2JmYKj4vEBhwM=;
 b=GAM2KVdqgKsqgFXNcL6YSA9sKRyu8/1rBJYzrIgzyb3Iksk3oXDFtTsoLD0iTRchDEXgTt
 ZGxsL9Zd3WpUlzIUCH3UFzdM0woxLphJEAHQL5omIZFdQV8TMe6hT3Brh6L67pY+4R7enK
 dyvgveKRIClmJAMGtdM+dDPTJN76I0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-85p8N_1uPheITn2gAEQjgQ-1; Wed, 04 Oct 2023 23:42:29 -0400
X-MC-Unique: 85p8N_1uPheITn2gAEQjgQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40540179bcdso3382605e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477348; x=1697082148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJkiTw8U/nk2edqHVe6dUwNUdcRD7I2JmYKj4vEBhwM=;
 b=PM8KrGKU3QXZ9nebzI1p3ryO9OvhYRkJqEepMeooKpbKbKCBc55KJtw4VXCKVAyNrJ
 H360KH11Bi+9HGCebOrbKFG+Wft0CWkVoI2soAN1FEtQ+NXRBiuza9h0s4WFZz24GtzU
 Iwx6C7O+ryxhDE5EJRh6B/S1pNAvXWlVpK8Z9cRfoPMTN4uZSCMA+rOSPeFENwqtsUXF
 oee29g0TON0I6NeiV22jQq7HtK1OIfPkLqZ3q+9uC/upivWUx7T1SvLBIw1I9I1l1+mL
 FmS2OhSz5+3wsr7HjEtuQe5942osAcAWk106v7SJ3Q9L7HQd46hfTF25LyhtAbs9KgIw
 iEoQ==
X-Gm-Message-State: AOJu0YwPRrbcMH+5FchnZiKAV4rdfHwJyE5L9K8PtuQj4QlNmy85zG3B
 J4bb8MOwg3NlyjSbuxUsBoiZwj3Tl9fedoZOMecVe662ilwQjIDD1YlRujXbjyoh68TeLB2XYm+
 rKbpNc6GEDyNtr6AWrS+wJWBzR/55VsGiLNmFebC/g66HU2knj9Nv4RlnUj4/V8pVmYpf
X-Received: by 2002:a05:600c:ac1:b0:402:f501:447c with SMTP id
 c1-20020a05600c0ac100b00402f501447cmr3992978wmr.0.1696477347981; 
 Wed, 04 Oct 2023 20:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLT5fZnCd1dFYei8gXoiRZdCXg/s3Yc51U+iE7EdRXJzKyHChgfOxtL3dlFb6ep0EvbJ8QUg==
X-Received: by 2002:a05:600c:ac1:b0:402:f501:447c with SMTP id
 c1-20020a05600c0ac100b00402f501447cmr3992962wmr.0.1696477347594; 
 Wed, 04 Oct 2023 20:42:27 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 v5-20020a05600c214500b003fbe791a0e8sm565825wml.0.2023.10.04.20.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:42:26 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:42:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL v2 01/53] pci: SLT must be RO
Message-ID: <4565917bb034479a29c04f0b44124e7f61585ccf.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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


