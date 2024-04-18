Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1228AA18B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 19:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVw6-00054E-WA; Thu, 18 Apr 2024 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVve-0004Oj-TU; Thu, 18 Apr 2024 13:52:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVvc-0007kw-Ux; Thu, 18 Apr 2024 13:52:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 446B75FD7B;
 Thu, 18 Apr 2024 20:50:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A1D47B9355;
 Thu, 18 Apr 2024 20:50:03 +0300 (MSK)
Received: (nullmailer pid 947884 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 114/116] hw/pci-host/ppc440_pcix: Do not expose a
 bridge device on PCI bus
Date: Thu, 18 Apr 2024 20:49:44 +0300
Message-Id: <20240418174955.947730-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Real 460EX SoC apparently does not expose a bridge device and having
it appear on PCI bus confuses an AmigaOS file system driver that uses
this to detect which machine it is running on.

Cc: qemu-stable@nongnu.org
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240411192443.B4D644E6026@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 6e4aceba2079e3df42edc89d44f4ee02343bb09e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index df4ee374d0..0468b22080 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -53,7 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
 struct PPC440PCIXState {
     PCIHostState parent_obj;
 
-    PCIDevice *dev;
+    uint8_t config[PCI_CONFIG_SPACE_SIZE];
     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
     uint32_t sts;
@@ -172,7 +172,7 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
     trace_ppc440_pcix_reg_write(addr, val, size);
     switch (addr) {
     case PCI_VENDOR_ID ... PCI_MAX_LAT:
-        stl_le_p(s->dev->config + addr, val);
+        stl_le_p(s->config + addr, val);
         break;
 
     case PCIX0_POM0LAL:
@@ -303,7 +303,7 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
 
     switch (addr) {
     case PCI_VENDOR_ID ... PCI_MAX_LAT:
-        val = ldl_le_p(s->dev->config + addr);
+        val = ldl_le_p(s->config + addr);
         break;
 
     case PCIX0_POM0LAL:
@@ -499,10 +499,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
                          ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
-                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
-
-    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
-                               TYPE_PPC4xx_HOST_BRIDGE);
+                         PCI_DEVFN(1, 0), 1, TYPE_PCI_BUS);
 
     memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
-- 
2.39.2


