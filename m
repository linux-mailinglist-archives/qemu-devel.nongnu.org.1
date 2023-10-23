Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B497D3B31
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qux7c-0006M7-2g; Mon, 23 Oct 2023 11:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Fyg7=GF=kaod.org=clg@ozlabs.org>)
 id 1qux7X-0006FZ-Nt
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:45:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Fyg7=GF=kaod.org=clg@ozlabs.org>)
 id 1qux7L-0004pf-Qe
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:45:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SDff732bqz4xQM;
 Tue, 24 Oct 2023 02:45:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDff518h5z4xPR;
 Tue, 24 Oct 2023 02:45:16 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/2] igb: Add Function Level Reset to PF and VF
Date: Mon, 23 Oct 2023 17:45:07 +0200
Message-ID: <20231023154507.253641-3-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023154507.253641-1-clg@kaod.org>
References: <20231023154507.253641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Fyg7=GF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The Intel 82576EB GbE Controller say that the Physical and Virtual
Functions support Function Level Reset. Add the capability to the PF
device model using device property "x-pcie-flr-init" which is "on" by
default and "off" for machines <= 8.1 to preserve compatibility.

The FLR capability of the VF model is defined according to the FLR
property of the PF, this to avoid adding an extra compatibility
property.

Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 v2: add a "x-pcie-flr-init" compat property for pre 8.2 machines

hw/core/machine.c | 3 ++-
 hw/net/igb.c      | 9 +++++++++
 hw/net/igbvf.c    | 9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 50edaab7375d..0c1739814124 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,7 +35,8 @@
 GlobalProperty hw_compat_8_1[] = {
     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
     { "ramfb", "x-migrate", "off" },
-    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
+    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
+    { "igb", "x-pcie-flr-init", "off" },
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index e70a66ee038e..dfb722b69599 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -78,6 +78,7 @@ struct IGBState {
     uint32_t ioaddr;
 
     IGBCore core;
+    bool has_flr;
 };
 
 #define IGB_CAP_SRIOV_OFFSET    (0x160)
@@ -101,6 +102,9 @@ static void igb_write_config(PCIDevice *dev, uint32_t addr,
 
     trace_igb_write_config(addr, val, len);
     pci_default_write_config(dev, addr, val, len);
+    if (s->has_flr) {
+        pcie_cap_flr_write_config(dev, addr, val, len);
+    }
 
     if (range_covers_byte(addr, len, PCI_COMMAND) &&
         (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
@@ -433,6 +437,10 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* PCIe extended capabilities (in order) */
+    if (s->has_flr) {
+        pcie_cap_flr_init(pci_dev);
+    }
+
     if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
         hw_error("Failed to initialize AER capability");
     }
@@ -588,6 +596,7 @@ static const VMStateDescription igb_vmstate = {
 
 static Property igb_properties[] = {
     DEFINE_NIC_PROPERTIES(IGBState, conf),
+    DEFINE_PROP_BOOL("x-pcie-flr-init", IGBState, has_flr, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 07343fa14a89..94a4e885f20f 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -204,6 +204,10 @@ static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
 {
     trace_igbvf_write_config(addr, val, len);
     pci_default_write_config(dev, addr, val, len);
+    if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
+                                 "x-pcie-flr-init", &error_abort)) {
+        pcie_cap_flr_write_config(dev, addr, val, len);
+    }
 }
 
 static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -266,6 +270,11 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         hw_error("Failed to initialize PCIe capability");
     }
 
+    if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
+                                 "x-pcie-flr-init", &error_abort)) {
+        pcie_cap_flr_init(dev);
+    }
+
     if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
         hw_error("Failed to initialize AER capability");
     }
-- 
2.41.0


