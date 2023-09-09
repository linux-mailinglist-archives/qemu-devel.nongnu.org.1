Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413E79984F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexac-00072r-Lu; Sat, 09 Sep 2023 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexaa-000707-E8; Sat, 09 Sep 2023 09:01:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexaX-0002Q4-Ri; Sat, 09 Sep 2023 09:01:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A3232059E;
 Sat,  9 Sep 2023 16:01:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 40E9826E04;
 Sat,  9 Sep 2023 16:00:25 +0300 (MSK)
Received: (nullmailer pid 353102 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 16/43] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto
 all SD controllers
Date: Sat,  9 Sep 2023 15:59:42 +0300
Message-Id: <20230909130020.352951-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Bernhard Beschow <shentey@gmail.com>

Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
interfaces" sdhci_common_realize() forces all SD card controllers to use either
sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.

Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
example. Fix this by defaulting the io_ops to little endian and switch to big
endian in sdhci_common_realize() only if there is a matchig big endian variant
available.

Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
interfaces")

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-Id: <20230709080950.92489-1-shentey@gmail.com>
(cherry picked from commit 3b830790151ff231531ef2595793e387dd154efb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6811f0f1a8..362c2c86aa 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
 
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
+
+    s->io_ops = &sdhci_mmio_le_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
-        s->io_ops = &sdhci_mmio_le_ops;
+        /* s->io_ops is little endian by default */
         break;
     case DEVICE_BIG_ENDIAN:
+        if (s->io_ops != &sdhci_mmio_le_ops) {
+            error_setg(errp, "SD controller doesn't support big endianness");
+            return;
+        }
         s->io_ops = &sdhci_mmio_be_ops;
         break;
     default:
-- 
2.39.2


