Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F372629E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u1K-0003UV-Ve; Wed, 07 Jun 2023 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u1H-0003RH-1x
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:20:15 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u1F-0003g5-6Q
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TMH5QUPRgSRXgIgg+Vv+HD7E9mqCFGyN0i1wUw3junY=;
 b=TZKIMtyczIgDCG/wsT08Iu87xgMMSiN47xXU5m+J605mOstfeV9yrW4A
 s1eNCmpTjstg70+Qi3ddgpQt5S/SnFyUxNbGV41L+Y8a4k4Mxe8mNLY/Z
 DqGDDkweAYw9ERtgKbbwMoMHkTHlQsqrhesre3CQKEotk6dpg6uVw8nQ9 E=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111938282
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:bqOxIqM9wnucMsvvrR2kl8FynXyQoLVcMsEvi/4bfWQNrUon1zEOz
 WUWXm6DO66OZDP1L90gPYWypBhTvJLdxtRmSgto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/rrRC9H5qyo42tG5gNmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0vhlWk9fz
 vpAFCEiayiYoPu627OFcfY506zPLOGzVG8eknRpzDWfBvc6W5HTBa7N4Le03h9p2JoIR6yHI
 ZNEN3w2Nk+ojx5nYz/7DLo3mvuogX/uNSVVsluPqYI84nTJzRw327/oWDbQUoXTHJQOzhzI/
 Aoq+Uy+CSkfb92Q0AaB606Il+7WlgjLSacNQejQGvlC3wTImz175ActfUK2pOT8hkOgVtZ3L
 UsS9Swz668o+ySDVdnwWQG1sVaLuxcdX5xbFOhS1e2W4vOKuUDDXDFCF2MfLoV876faWADGy
 HeXjYjHFAdp6IGEZnel7ZCNoSizBxMKeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsuAZCQ0c0
 BjR8nFg2ux7YdojkvzioAuZ227ESo3hFFZd2+nBYo6yAuqVjqaBbpfg11XU5O0owG2xHgjY5
 yhsdyRzAYkz4XCxeM6lGr1l8FKBvazt3NjgbblHQfEcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzM/8pO93vUZhxnPS5fTgAahwyRoAWCnSWXFXelByCmGbKhzy9+KTSuf9X1
 WinnTaEUi9BVPUPIMueTOYBy747rh3SNkuKLa0XOy+PiOLEDFbMEOdtDbd7RrxhhE9yiFmPo
 ok32grj40k3bdASlQGJqdNCcwpXdyFT6FKfg5U/S9Nv6zFOQAkJY8I9C5t8J+SJQ4w9ej/0w
 0yA
IronPort-HdrOrdr: A9a23:wquQ9aGq2J1yVWz9pLqE2seALOsnbusQ8zAXPiFKJiC9F/byqy
 nApoV/6faZslcssQgb6LO90cq7L080i6QFg7X5VI3KNGOK1FdASrsSibcKqAeBJ8SRzJ8l6Y
 5QN4R4Fd3sHRxboK/BkXGF+g8bsb66GXaT9IHj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AmJT6wmjpd0loLPrOlwS23tdggDJubG+G4mbrJRe?=
 =?us-ascii?q?EGElscKayUFOL+Z1fjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AdxAnbQ1mE3tbSPcwOjr1yMWv5DUjpK+WDRsMnow?=
 =?us-ascii?q?6v9C4ET1xIjy2vCWSXdpy?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111938282"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 10/12] hw/isa/piix3: Resolve redundant k->config_write
 assignments
Date: Wed, 7 Jun 2023 15:18:37 +0100
Message-ID: <20230607141839.48422-11-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
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

The previous patch unified handling of piix3_write_config() accross the
PIIX3 device models which allows for assigning k->config_write once in the
base class.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-6-shentey@gmail.com>
Message-Id: <20230403074124.3925-7-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/isa/piix3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 5e8ac98ae0..0549e043ca 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -322,6 +322,7 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    k->config_write = piix3_write_config;
     dc->reset       = piix3_reset;
     dc->desc        = "ISA bridge";
     dc->vmsd        = &vmstate_piix3;
@@ -371,7 +372,6 @@ static void piix3_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix3_write_config;
     k->realize = piix3_realize;
 }
 
@@ -385,7 +385,6 @@ static void piix3_xen_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix3_write_config;
     k->realize = piix3_realize;
 }
 
-- 
Anthony PERARD


