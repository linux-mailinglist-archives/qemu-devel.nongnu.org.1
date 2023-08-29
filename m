Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E3D78C0F9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaufj-0005lH-Ez; Tue, 29 Aug 2023 05:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qaufh-0005kz-Du
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:06:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qaufY-0006Be-Rt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:06:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZhNT21j6z4wy3;
 Tue, 29 Aug 2023 19:05:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZhNQ4y2Nz4wd0;
 Tue, 29 Aug 2023 19:05:42 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Date: Tue, 29 Aug 2023 11:05:29 +0200
Message-ID: <20230829090529.184438-3-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829090529.184438-1-clg@kaod.org>
References: <20230829090529.184438-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=bkLz=EO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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
Functions support Function Level Reset. Add the capability to each
device model.

Cc:  Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb.c   | 3 +++
 hw/net/igbvf.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index e70a66ee038e..b8c170ad9b1a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -101,6 +101,7 @@ static void igb_write_config(PCIDevice *dev, uint32_t addr,
 
     trace_igb_write_config(addr, val, len);
     pci_default_write_config(dev, addr, val, len);
+    pcie_cap_flr_write_config(dev, addr, val, len);
 
     if (range_covers_byte(addr, len, PCI_COMMAND) &&
         (dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
@@ -433,6 +434,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* PCIe extended capabilities (in order) */
+    pcie_cap_flr_init(pci_dev);
+
     if (pcie_aer_init(pci_dev, 1, 0x100, 0x40, errp) < 0) {
         hw_error("Failed to initialize AER capability");
     }
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 07343fa14a89..55e321e4ec20 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -204,6 +204,7 @@ static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t val,
 {
     trace_igbvf_write_config(addr, val, len);
     pci_default_write_config(dev, addr, val, len);
+    pcie_cap_flr_write_config(dev, addr, val, len);
 }
 
 static uint64_t igbvf_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -266,6 +267,8 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         hw_error("Failed to initialize PCIe capability");
     }
 
+    pcie_cap_flr_init(dev);
+
     if (pcie_aer_init(dev, 1, 0x100, 0x40, errp) < 0) {
         hw_error("Failed to initialize AER capability");
     }
-- 
2.41.0


