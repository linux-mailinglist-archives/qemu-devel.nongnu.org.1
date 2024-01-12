Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE882C0B3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHOh-0004zv-4D; Fri, 12 Jan 2024 08:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHOF-0004VW-RI
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:16:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHOE-00006I-29
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FRkn+/5vqEfPb5/vhvhcQRjljumahQtc+h05lqCfuTU=; b=hNuxj+2zbcqSho1v7eVZE9JV/t
 CGWUgKwcMdlLV7m8ICJkzZMNXQWPp6PJj2KAxF1I87ZuO73f5xfs06D3KSEFHRG7Ht7QfxIm4wZZT
 XV7qhz4yIVEkTyhIoirQqjgUCNoKwULr2tJC3NeWEH0bRRtyMzBTPfvasP7ghRScqRcfKXEqvO6IM
 iYjFqw7wMpGForvUcnWr53tLUoelPW3bN1cohfUJ9j3noCTZ4gBsSa43nNcsYWk5aulU2amP2laBi
 XNso3EaT+F0H5GYZCZnXoJ8jz07FdNYN9+byulYvBxJ7Lpqzwgr7lobfRdVm3/goysqaySSwxNaiv
 3MqyJ63HtXp907VnlKz49MI0nqqBByLHGIqBC/gLaFyLskPlbalmv30C9lOsbxd+5fYtY6K7orpDs
 tzWKJq2Ag5dRLSjeK9M+HVPietuFu72KMD65K4kfX7CWQSH72OyVVubowrLVRO5x353oOxn21hxNv
 RxvsRVHhF3SVrfj+kkJFlRuNZiUwDXgQsG5+R2JOVk/RjPKx+YZrAQiJR6+N8miKa+x1UiWoVkvr8
 rKjdeEswb+heefOgc2nNd7z5AmtnVdKJYI1gb46YaijjKdihMrkGxQLGw+6RjAihRZvBzkgORSOJE
 5auBT5swekYD6OkmUNTiWNEN2U3vVmEldLdcOyMyo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHNL-0009Gy-3i; Fri, 12 Jan 2024 13:15:08 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org, deller@gmx.de,
 linux@roeck-us.net, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 13:15:26 +0000
Message-Id: <20240112131529.515642-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/4] esp-pci.c: use correct address register for PCI DMA
 transfers
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
---
 hw/scsi/esp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 93b3429e0f..7117725371 100644
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


