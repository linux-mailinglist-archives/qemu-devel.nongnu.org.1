Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FE7262A8
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0t-0002tl-L7; Wed, 07 Jun 2023 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0r-0002sm-8H
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:49 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0l-0003Qf-1L
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi+pXjYLr7c/PD1ARVNoBjdszGk9MJ2cyLncx8Kx/aE=;
 b=QwU/wMOoCL3iIMVbZFcugMj3hbBbs2sESxkNDxPopX9BD1qHicpJJNZ1
 vHg2rDz7fOENdVTk+EJtZHccITGxcP8wjeO8CqHYHG527hp7268iUhBeY
 ekaCllwAMuLONiP9j6mQugPv+ZPVHjDhk+m7JSC3quuXVo0w1WJ6HglIQ 4=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111246604
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:oF+lKKvH9fnUAy2sdvpfXWaCr+fnVFBeMUV32f8akzHdYApBsoF/q
 tZmKW+Gbq7bMWOgfdF/Poq+pEgD65SHxtVhQAc6rShkES4Q+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Fv0gnRkPaoQ5AGGyCFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwJg0rUEjYoe6P56+GUtJtpOMBAfbZBdZK0p1g5Wmx4fcORJnCR+PB5MNC3Sd2jcdLdRrcT
 5NHM3w1Nk2GOkARfA5NU/rSn8/x7pX7WzRetFKSo7tx+2XJxRZ9+LPsLMDUapqBQsA9ckOw/
 zufpTinXElGXDCZ4WWsqV3rmvKUpxvUe58NDKyG6KUth2TGkwT/DzVJDADm8JFVkHWWQt9aN
 gkY9zQjqYA080qkSMS7WAe3yFafvhMaR9dBO+I/4QCJjKHT5m6k6nMsF2AbLoZ87YlvGGJsj
 wXS9z/0OdBxmLOob0zFrZGYlBSvBDAuLE0lRwI7fzJQtrEPv7oPph7IS99iFou8gdv0BSz8z
 li2kcQuu1kApZVVjvvmpDgrlxrp/8GUFVBtum07S0r/tmtEiJiZi5tEALQxxdJJN86nQ1aIp
 xDocODOvblVXflheMFgKdjh/Y1FBd7faFUwYnY1RfHNEghBHFb9Fb28GBkkeC9U3j8sIFcFm
 nP7twJL/4N0N3C3d6JxaI/ZI510nfa4Soq/CquFMoMmjn1NmOmvpnkGiam4hTmFraTRuftnZ
 cfznTiEUx729piLPBLpHrxAgNfHNwg1xH/JRICT8vhU+eP2WZJhcp9caAHmRrlgvMu5TPD9r
 4432z2il08OD4UTo0D/reYuELz9BSZjWMGo8ZENL4Zu4GNOQQkcNhMY+pt5E6QNokifvr2gE
 q2VMqOA9GfCuA==
IronPort-HdrOrdr: A9a23:uhKy36HRGXrdKIyYpLqE2seALOsnbusQ8zAXPiFKJiC9F/byqy
 nApoV/6faZslcssQgb6LO90cq7L080i6QFg7X5VI3KNGOK1FdASrsSibcKqAeBJ8SRzJ8l6Y
 5QN4R4Fd3sHRxboK/BkXGF+g8bsb66GXaT9IHj80s=
X-Talos-CUID: 9a23:ZkEqf2O2+nw6Xu5DVhRByhZPPMwcVWDg1EzRAWiaJFlbcejA
X-Talos-MUID: 9a23:P4M0pwT13xN0gTHNRXSzrWpNc9t1uJ6WJ2MQjo0XhdffcitJbmI=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111246604"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 05/12] include/hw/xen/xen: Rename xen_piix3_set_irq() to
 xen_intx_set_irq()
Date: Wed, 7 Jun 2023 15:18:32 +0100
Message-ID: <20230607141839.48422-6-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

xen_piix3_set_irq() isn't PIIX specific: PIIX is a single PCI device
while xen_piix3_set_irq() maps multiple PCI devices to their respective
IRQs, which is board-specific. Rename xen_piix3_set_irq() to communicate
this.

Also rename XEN_PIIX_NUM_PIRQS to XEN_IOAPIC_NUM_PIRQS since the Xen's
IOAPIC rather than PIIX has this many interrupt routes.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-2-shentey@gmail.com>
Message-Id: <20230403074124.3925-2-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 2 +-
 hw/isa/piix3.c        | 4 ++--
 include/hw/xen/xen.h  | 2 +-
 stubs/xen-hw-stub.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 56641a550e..ab8f1b61ee 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -143,7 +143,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
     return irq_num + (PCI_SLOT(pci_dev->devfn) << 2);
 }
 
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+void xen_intx_set_irq(void *opaque, int irq_num, int level)
 {
     xen_set_pci_intx_level(xen_domid, 0, 0, irq_num >> 2,
                            irq_num & 3, level);
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index f9103ea45a..6651521a46 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -35,7 +35,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-#define XEN_PIIX_NUM_PIRQS      128ULL
+#define XEN_IOAPIC_NUM_PIRQS    128ULL
 
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
@@ -420,7 +420,7 @@ static void piix3_xen_realize(PCIDevice *dev, Error **errp)
      * connected to the IOAPIC directly.
      * These additional routes can be discovered through ACPI.
      */
-    pci_bus_irqs(pci_bus, xen_piix3_set_irq, piix3, XEN_PIIX_NUM_PIRQS);
+    pci_bus_irqs(pci_bus, xen_intx_set_irq, piix3, XEN_IOAPIC_NUM_PIRQS);
 }
 
 static void piix3_xen_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 2bd8ec742d..37ecc91fc3 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -39,7 +39,7 @@ extern bool xen_domid_restrict;
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 int xen_set_pci_link_route(uint8_t link, uint8_t irq);
-void xen_piix3_set_irq(void *opaque, int irq_num, int level);
+void xen_intx_set_irq(void *opaque, int irq_num, int level);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
 int xen_is_pirq_msi(uint32_t msi_data);
 
diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 34a22f2ad7..7d7ffe83a9 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -15,7 +15,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
     return -1;
 }
 
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+void xen_intx_set_irq(void *opaque, int irq_num, int level)
 {
 }
 
-- 
Anthony PERARD


