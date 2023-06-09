Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66C72A29F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hDC-0000zk-6H; Fri, 09 Jun 2023 14:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD8-0000yI-FV; Fri, 09 Jun 2023 14:51:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD7-0002tS-2i; Fri, 09 Jun 2023 14:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jJPUSGdC7j79yHmzcXbbAXe4Xq0aaoRGjYGvLAai0eM=; b=kw20TYxeOAzRwVi7O22fPIldDQ
 H3F1DNqqEQ12PzcPT76hMd8HzsPSuuVuYSOWO4U/o2QVNv462YJFvReMi0HbV5uxvlMyRzyviUszD
 UKIctjBwVQYOg5l9uHBPxwb02tC2n8Z7htrdQ3CydbWxmVxjHOqd5DYO+PgQxMbw7aNqZr90isvOF
 g8lgqNz67aFz/DFY6JzCQBhu3GI7mKH2IpCGokDpnamLPH0dG9+h7Ok9hzlEUbsD/sVbmbfgj+vMZ
 Scuqww3RxiUhXvRbNz553HKLKIL6DhokP4Sl0wCwvyho0XgpTeT4vPPPME0zLSg73/PUtPSXqKUa7
 nyKlgvtfNkwi5H9cTcZo1a046At+xnVMp+aMO166EhzwYKy1GuVKBt3Q2jg6jSBmYOZyZA1Q+HP5q
 JYfngjq3uQa+7gw8lj4HURaDOmZpkhdVqznGkH3zPLYjBokeh88tLEYzgqVI1x0XjyeykKIWEXuvd
 eJCAVIMwG417rf0itDmOiaMSaFvU9dTtiXHLdQuTpjdG/DvvnIC0lVseTeyO499Not7uaKRqKX+qw
 zM7LAQ0ap3EJDvajQCHydcnwTT+OP8z0SNrkyqzAf35lAVWYX21YIXBhGz2VuLkTck5rC1oLIN7bU
 0e56sDAPF1W7Lh+RR9ZxI16EPs1Ab8O/Fg+Eoh0rA=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hCy-0000p5-G4; Fri, 09 Jun 2023 19:51:40 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:17 +0100
Message-Id: <20230609185119.691152-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/5] cmd646: use TYPE_CMD646_IDE instead of hardcoded
 "cmd646-ide" string
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/alpha/dp264.c   | 4 ++--
 hw/sparc64/sun4u.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 03495e1e60..f2affecad9 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -13,7 +13,7 @@
 #include "alpha_sys.h"
 #include "qemu/error-report.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/ide/pci.h"
+#include "hw/ide/cmd646.h"
 #include "hw/isa/superio.h"
 #include "net/net.h"
 #include "qemu/cutils.h"
@@ -132,7 +132,7 @@ static void clipper_init(MachineState *machine)
     isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
 
     /* IDE disk setup.  */
-    pci_dev = pci_create_simple(pci_bus, -1, "cmd646-ide");
+    pci_dev = pci_create_simple(pci_bus, -1, TYPE_CMD646_IDE);
     pci_ide_create_devs(pci_dev);
 
     /* Load PALcode.  Given that this is not "real" cpu palcode,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e2858a0331..66b55eabd1 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -50,7 +50,7 @@
 #include "hw/sparc/sparc64.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "hw/ide/pci.h"
+#include "hw/ide/cmd646.h"
 #include "hw/loader.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
@@ -673,7 +673,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qemu_macaddr_default_if_unset(&macaddr);
     }
 
-    pci_dev = pci_new(PCI_DEVFN(3, 0), "cmd646-ide");
+    pci_dev = pci_new(PCI_DEVFN(3, 0), TYPE_CMD646_IDE);
     qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
     pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
     pci_ide_create_devs(pci_dev);
-- 
2.30.2


