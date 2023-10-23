Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD537D3B2F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:47:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qux7a-0006Iu-4U; Mon, 23 Oct 2023 11:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Fyg7=GF=kaod.org=clg@ozlabs.org>)
 id 1qux7Y-0006GH-7P
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:45:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Fyg7=GF=kaod.org=clg@ozlabs.org>)
 id 1qux7O-0004na-21
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:45:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SDff44kVgz4wbr;
 Tue, 24 Oct 2023 02:45:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDff24L4zz4xPR;
 Tue, 24 Oct 2023 02:45:14 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] igb: Add a VF reset handler
Date: Mon, 23 Oct 2023 17:45:06 +0200
Message-ID: <20231023154507.253641-2-clg@kaod.org>
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

Export the igb_vf_reset() helper routine from the PF model to let the
IGBVF model implement its own device reset.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_common.h |  1 +
 hw/net/igb_core.h   |  3 +++
 hw/net/igb.c        |  6 ++++++
 hw/net/igb_core.c   |  6 ++++--
 hw/net/igbvf.c      | 10 ++++++++++
 hw/net/trace-events |  1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index 5c261ba9d39c..b316a5bcfa5c 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -152,5 +152,6 @@ enum {
 
 uint64_t igb_mmio_read(void *opaque, hwaddr addr, unsigned size);
 void igb_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
+void igb_vf_reset(void *opaque, uint16_t vfn);
 
 #endif
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 9cbbfd516bd5..bf8c46f26b51 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -130,6 +130,9 @@ igb_core_set_link_status(IGBCore *core);
 void
 igb_core_pci_uninit(IGBCore *core);
 
+void
+igb_core_vf_reset(IGBCore *core, uint16_t vfn);
+
 bool
 igb_can_receive(IGBCore *core);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8ff832acfc3b..e70a66ee038e 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -122,6 +122,12 @@ igb_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     igb_core_write(&s->core, addr, val, size);
 }
 
+void igb_vf_reset(void *opaque, uint16_t vfn)
+{
+    IGBState *s = opaque;
+    igb_core_vf_reset(&s->core, vfn);
+}
+
 static bool
 igb_io_get_reg_index(IGBState *s, uint32_t *idx)
 {
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index f6a5e2327b5a..2a7a11aa9ed5 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2477,11 +2477,13 @@ static void igb_set_vfmailbox(IGBCore *core, int index, uint32_t val)
     }
 }
 
-static void igb_vf_reset(IGBCore *core, uint16_t vfn)
+void igb_core_vf_reset(IGBCore *core, uint16_t vfn)
 {
     uint16_t qn0 = vfn;
     uint16_t qn1 = vfn + IGB_NUM_VM_POOLS;
 
+    trace_igb_core_vf_reset(vfn);
+
     /* disable Rx and Tx for the VF*/
     core->mac[RXDCTL0 + (qn0 * 16)] &= ~E1000_RXDCTL_QUEUE_ENABLE;
     core->mac[RXDCTL0 + (qn1 * 16)] &= ~E1000_RXDCTL_QUEUE_ENABLE;
@@ -2560,7 +2562,7 @@ static void igb_set_vtctrl(IGBCore *core, int index, uint32_t val)
 
     if (val & E1000_CTRL_RST) {
         vfn = (index - PVTCTRL0) / 0x40;
-        igb_vf_reset(core, vfn);
+        igb_core_vf_reset(core, vfn);
     }
 }
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index d55e1e8a6abf..07343fa14a89 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -273,6 +273,13 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
     pcie_ari_init(dev, 0x150);
 }
 
+static void igbvf_qdev_reset_hold(Object *obj)
+{
+    PCIDevice *vf = PCI_DEVICE(obj);
+
+    igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
+}
+
 static void igbvf_pci_uninit(PCIDevice *dev)
 {
     IgbVfState *s = IGBVF(dev);
@@ -287,6 +294,7 @@ static void igbvf_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
 
     c->realize = igbvf_pci_realize;
     c->exit = igbvf_pci_uninit;
@@ -295,6 +303,8 @@ static void igbvf_class_init(ObjectClass *class, void *data)
     c->revision = 1;
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
 
+    rc->phases.hold = igbvf_qdev_reset_hold;
+
     dc->desc = "Intel 82576 Virtual Function";
     dc->user_creatable = false;
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 3abfd65e5bf9..2af8f6cacac7 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -274,6 +274,7 @@ igb_core_mdic_read(uint32_t addr, uint32_t data) "MDIC READ: PHY[%u] = 0x%x"
 igb_core_mdic_read_unhandled(uint32_t addr) "MDIC READ: PHY[%u] UNHANDLED"
 igb_core_mdic_write(uint32_t addr, uint32_t data) "MDIC WRITE: PHY[%u] = 0x%x"
 igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
+igb_core_vf_reset(uint16_t vfn) "VF%d"
 
 igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
 
-- 
2.41.0


