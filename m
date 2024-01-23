Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7962838BFC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:30:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSE1q-0006vB-2k; Tue, 23 Jan 2024 05:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1n-0006t2-O2; Tue, 23 Jan 2024 05:29:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSE1m-0005Nm-2t; Tue, 23 Jan 2024 05:29:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF88C46754;
 Tue, 23 Jan 2024 13:29:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4ECEE69AF0;
 Tue, 23 Jan 2024 13:28:44 +0300 (MSK)
Received: (nullmailer pid 3831732 invoked by uid 1000);
 Tue, 23 Jan 2024 10:28:43 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 21/24] hw/scsi/esp-pci: use correct address register
 for PCI DMA transfers
Date: Tue, 23 Jan 2024 13:28:35 +0300
Message-Id: <20240123102843.3831660-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240123123057@cover.tls.msk.ru>
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The current code in esp_pci_dma_memory_rw() sets the DMA address to the value
of the DMA_SPA (Starting Physical Address) register which is incorrect: this
means that for each callback from the SCSI layer the DMA address is set back
to the starting address.

In the case where only a single SCSI callback occurs (currently for transfer
lengths < 128kB) this works fine, however for larger transfers the DMA address
wraps back to the initial starting address, corrupting the buffer holding the
data transferred to the guest.

Fix esp_pci_dma_memory_rw() to use the DMA_WAC (Working Address Counter) for
the DMA address which is correctly incremented across multiple SCSI layer
transfers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20240112131529.515642-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 84a6835e004c257037492167d4f266dbb54dc33e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 4e890db0e2..ac5d752876 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -275,7 +275,7 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
         qemu_log_mask(LOG_UNIMP, "am53c974: MDL transfer not implemented\n");
     }
 
-    addr = pci->dma_regs[DMA_SPA];
+    addr = pci->dma_regs[DMA_WAC];
     if (pci->dma_regs[DMA_WBC] < len) {
         len = pci->dma_regs[DMA_WBC];
     }
-- 
2.39.2


