Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EDC7EA8F1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 04:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2joL-0001pF-6O; Mon, 13 Nov 2023 22:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joH-0001oh-Q0
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joF-0001jT-Ej
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699931390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orXRzHDIRCvpFIc7QJB2Jh5VhPPFE08CCclo6f2LkpY=;
 b=ieOvqQweZbWQ3LADwGSSrnlHzNnq52XGgQgCVHtCRbI5OtVho0xBVy9OkwVlQrn6qcEd/E
 hlx0CY6y5z/bzPuXFWpTx0qWN7FMhF0RNv94U4CwIDE+sao6sRQNGHYkqKivXxmFE2wD3K
 y2pHVjdBzbZxS6FOhy43hHWojhB7pGQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-jg_08FfOMS-v5p9MzMgD8g-1; Mon,
 13 Nov 2023 22:09:48 -0500
X-MC-Unique: jg_08FfOMS-v5p9MzMgD8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DCFB3806623;
 Tue, 14 Nov 2023 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7971FC1596F;
 Tue, 14 Nov 2023 03:09:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/2] igb: Add a VF reset handler
Date: Tue, 14 Nov 2023 11:09:36 +0800
Message-ID: <20231114030937.5461-2-jasowang@redhat.com>
In-Reply-To: <20231114030937.5461-1-jasowang@redhat.com>
References: <20231114030937.5461-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Export the igb_vf_reset() helper routine from the PF model to let the
IGBVF model implement its own device reset.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/igb.c        |  6 ++++++
 hw/net/igb_common.h |  1 +
 hw/net/igb_core.c   |  6 ++++--
 hw/net/igb_core.h   |  3 +++
 hw/net/igbvf.c      | 10 ++++++++++
 hw/net/trace-events |  1 +
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8ff832a..e70a66e 100644
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
diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index 5c261ba..b316a5b 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -152,5 +152,6 @@ enum {
 
 uint64_t igb_mmio_read(void *opaque, hwaddr addr, unsigned size);
 void igb_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
+void igb_vf_reset(void *opaque, uint16_t vfn);
 
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index f6a5e23..2a7a11a 100644
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
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 9cbbfd5..bf8c46f 100644
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
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index d55e1e8..07343fa 100644
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
index 3097742..387e32e 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -274,6 +274,7 @@ igb_core_mdic_read(uint32_t addr, uint32_t data) "MDIC READ: PHY[%u] = 0x%x"
 igb_core_mdic_read_unhandled(uint32_t addr) "MDIC READ: PHY[%u] UNHANDLED"
 igb_core_mdic_write(uint32_t addr, uint32_t data) "MDIC WRITE: PHY[%u] = 0x%x"
 igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
+igb_core_vf_reset(uint16_t vfn) "VF%d"
 
 igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
 
-- 
2.7.4


