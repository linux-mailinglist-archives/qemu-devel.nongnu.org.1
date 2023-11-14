Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE127EA8F2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 04:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2joM-0001q7-Hd; Mon, 13 Nov 2023 22:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joK-0001pT-8V
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joI-0001ju-PN
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699931393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAvT16XO+YxY7M6B/Ytiwt9SDHWAlr5QWhKe+kjfvuc=;
 b=X4xHSD/rKCQUCkFyPwsnKqo7OmyRWMreZ0Va3+E9SWtT/xXQuvuDN1K7sOBoWVFOOA7Udy
 uy59Z1mJUVXH82WYJBhmtCAS/SriD8eyEsA6PMOKx/D33moIDWofhYXyEKFzuaJH0qVjKz
 CgOL57kTzMBc9osFrqLQj2isIdsGXBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-CbtqXFrtPxmKmQMKWpEUcw-1; Mon, 13 Nov 2023 22:09:51 -0500
X-MC-Unique: CbtqXFrtPxmKmQMKWpEUcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C9D782B9D6;
 Tue, 14 Nov 2023 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0096BC1596F;
 Tue, 14 Nov 2023 03:09:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 2/2] igb: Add Function Level Reset to PF and VF
Date: Tue, 14 Nov 2023 11:09:37 +0800
Message-ID: <20231114030937.5461-3-jasowang@redhat.com>
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

The Intel 82576EB GbE Controller say that the Physical and Virtual
Functions support Function Level Reset. Add the capability to the PF
device model using device property "x-pcie-flr-init" which is "on" by
default and "off" for machines <= 8.1 to preserve compatibility.

The FLR capability of the VF model is defined according to the FLR
property of the PF, this to avoid adding an extra compatibility
property.

Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/core/machine.c | 3 ++-
 hw/net/igb.c      | 9 +++++++++
 hw/net/igbvf.c    | 9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 50edaab..0c17398 100644
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
index e70a66e..dfb722b 100644
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
index 07343fa..94a4e88 100644
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
2.7.4


