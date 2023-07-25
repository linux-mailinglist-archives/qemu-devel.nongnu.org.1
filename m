Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC10761B16
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIjz-0003M4-8U; Tue, 25 Jul 2023 10:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIjx-0003LM-DF; Tue, 25 Jul 2023 10:10:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIjv-0007Rq-FS; Tue, 25 Jul 2023 10:10:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4AECA16163;
 Tue, 25 Jul 2023 17:10:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 072C0194FB;
 Tue, 25 Jul 2023 17:10:11 +0300 (MSK)
Received: (nullmailer pid 3372571 invoked by uid 1000);
 Tue, 25 Jul 2023 14:10:10 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Olaf Hering <olaf@aepfle.de>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 01/14] hw/ide/piix: properly initialize the BMIBA
 register
Date: Tue, 25 Jul 2023 17:09:55 +0300
Message-Id: <20230725141009.3372529-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230725170615@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Olaf Hering <olaf@aepfle.de>

According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA-BUS
MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
32bit wide. To properly reset it to default values, all 32bit need to be
cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.

The initial change wrote just the lower 8 bit, leaving parts of the "Bus
Master Interface Base Address" address at bit 15:4 unchanged.

Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved support for 82371SB (Function 1)")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230712074721.14728-1-olaf@aepfle.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 230dfd9257e92259876c113e58b5f0d22b056d2e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 267dbf37db..066be77c8e 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -123,7 +123,7 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
+    pci_set_long(pci_conf + 0x20, 0x1);  /* BMIBA: 20-23h */
 }
 
 static int pci_piix_init_ports(PCIIDEState *d)
-- 
2.39.2


