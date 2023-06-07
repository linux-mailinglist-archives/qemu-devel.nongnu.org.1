Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2272629C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0t-0002tH-43; Wed, 07 Jun 2023 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0q-0002sF-MN
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:48 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0o-0003SV-IB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147586;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TqcufpbSnrTVN9hQiM1OlG/594iES3q/eUlxOWH9DnI=;
 b=FRjugmCU07DajdPSmA4/iFafkiLhfxRZBPevu+8gculxlfjUp8Xw0nTk
 Auy2kvcKmy5mp5VqbGiA1c5PSh8DZzyUsc7lmlRORG47vpcQMxEsOxA/F
 LfkIy5MI6vNe5GgN5JXGs7sZAYDpV1kZXr/CsZjSEHoGVgc/b0czRE56+ Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 114430941
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:zpduE6LPQkQm6xO5FE+R15UlxSXFcZb7ZxGr2PjKsXjdYENS0WMFx
 zYaXjzVaK3ZZWWgKd0jaIjg/UsPv5WBmtNmTQBlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrbwP9TlK6q4mhA4ARhPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5OBEZeq
 78kJAwSYy6hnbux4oOXbuJV05FLwMnDZOvzu1llxDDdS/0nXYrCU+PB4towMDUY354UW6yEP
 oxANGQpNU6bC/FMEg5/5JYWleG0hn75YntApUicv6Yf6GnP1g1hlrPqNbI5f/TTHJkJxR7J+
 juuE2LRLz84HsS1yhC81neKntfftzjkaN0LLejtnhJtqALKnTFCYPEMbnOirPykz0KzRd9bA
 0oT/CUosO417kPDZsL9UhukrW+ssRsVWt4WGOo/gDxh0YKNvVzfXDJdCGccNpp/7pReqSEWO
 kGhptbOFWIsjLGpVn+j1K3NqhGDFQweFDpXDcMbdjct797mqYA1qxvASNd/DaK45uHI9SHML
 yOi93Zn2ehK5SIf/+DipA2c3WrwznTcZlRtjjg7SF5J+e+QiGSNQ4WzoWbW4v9bRGpyZgnQ5
 SNU8yRyAQ1nMH1sqMBvaL9VdF1Kz6zfWNE5vbKIN8dJythV0yT/Fb28GRknTKuTDu4KeCXyf
 GjYsh5L6ZlYMROCNPEnPdruVZ52lvm8TLwJs8w4iPIUOvCdkyfdpUlTibO4hTixwCDAb4lhU
 XtkTSpcJSlDUvk2pNZHb+wczaUq1kgDKZD7HPjGI+Cc+ePGPha9EO5VWGZim8hltMtoVi2Jq
 YcAXyZLoj0DONDDjt7/r9ZOfA5QcCJibX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJQ4w9ej/0w
 0yA
IronPort-HdrOrdr: A9a23:e71CkqCUlCBuJXLlHeme55DYdb4zR+YMi2TDtnofdfUxSKelfq
 +V7ZEmPHPP6Qr5IUtQ+uxoW5PvfZqjz+8W3WB5B97LNmSLhILPFvAH0WKI+V3d8kPFh5dg/J
 YlX69iCMDhSXhW5PyKmDVQyuxQp+VvJprY49vj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3AXrwokWpTeXjvM9ufRhh4U6jmUfkgVW2Dj0vcH1C?=
 =?us-ascii?q?1N0RzEbq3eHO085oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A0A9x0QxqsZQ5Dk6ZvU/RWensTKiaqImAKmoVu5Y?=
 =?us-ascii?q?sgu2BEzRIKx2GkwToW7Zyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="114430941"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 09/12] hw/isa/piix3: Avoid Xen-specific variant of
 piix3_write_config()
Date: Wed, 7 Jun 2023 15:18:36 +0100
Message-ID: <20230607141839.48422-10-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
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

Subscribe to pci_bus_fire_intx_routing_notifier() instead which allows for
having a common piix3_write_config() for the PIIX3 device models.

While at it, move the subscription into machine code to facilitate resolving
TYPE_PIIX3_XEN_DEVICE.

In a possible future followup, pci_bus_fire_intx_routing_notifier() could
be adjusted in such a way that subscribing to it doesn't require
knowledge of the device firing it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-5-shentey@gmail.com>
Message-Id: <20230403074124.3925-6-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_piix.c | 18 ++++++++++++++++++
 hw/isa/piix3.c    | 22 +---------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 11af191513..2ed2b3f3c6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -90,6 +90,21 @@ static int pc_pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
     return (pci_intx + slot_addend) & 3;
 }
 
+static void piix_intx_routing_notifier_xen(PCIDevice *dev)
+{
+    int i;
+
+    /* Scan for updates to PCI link routes (0x60-0x63). */
+    for (i = 0; i < PIIX_NUM_PIRQS; i++) {
+        uint8_t v = dev->config_read(dev, PIIX_PIRQCA + i, 1);
+        if (v & 0x80) {
+            v = 0;
+        }
+        v &= 0xf;
+        xen_set_pci_link_route(i, v);
+    }
+}
+
 /* PC hardware initialisation */
 static void pc_init1(MachineState *machine,
                      const char *host_type, const char *pci_type)
@@ -241,6 +256,9 @@ static void pc_init1(MachineState *machine,
         pci_dev = pci_create_simple_multifunction(pci_bus, -1, true, type);
 
         if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
             /*
              * Xen supports additional interrupt routes from the PCI devices to
              * the IOAPIC: the four pins of each PCI device on the bus are also
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 0b7e9ade0d..5e8ac98ae0 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -122,26 +122,6 @@ static void piix3_write_config(PCIDevice *dev,
     }
 }
 
-static void piix3_write_config_xen(PCIDevice *dev,
-                                   uint32_t address, uint32_t val, int len)
-{
-    int i;
-
-    /* Scan for updates to PCI link routes (0x60-0x63). */
-    for (i = 0; i < len; i++) {
-        uint8_t v = (val >> (8 * i)) & 0xff;
-        if (v & 0x80) {
-            v = 0;
-        }
-        v &= 0xf;
-        if (((address + i) >= PIIX_PIRQCA) && ((address + i) <= PIIX_PIRQCD)) {
-            xen_set_pci_link_route(address + i - PIIX_PIRQCA, v);
-        }
-    }
-
-    piix3_write_config(dev, address, val, len);
-}
-
 static void piix3_reset(DeviceState *dev)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(dev);
@@ -405,7 +385,7 @@ static void piix3_xen_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix3_write_config_xen;
+    k->config_write = piix3_write_config;
     k->realize = piix3_realize;
 }
 
-- 
Anthony PERARD


