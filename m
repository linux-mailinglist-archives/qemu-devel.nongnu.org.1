Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D210D82C0BA
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHOw-0005H3-0D; Fri, 12 Jan 2024 08:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHO8-00048A-HX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:58 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHO5-0008Ot-Kq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rtIL/xArmXp0Q2gT0KvSPBmNZgN/sj4zdhvxT3nWGFo=; b=iuMlAdohPt7IeAlMiye9mGGKCk
 swW3dSKndKr2yO4OyKjxkOAt9yiq1rkbwDlFoyouIVSkz2DaovzBTOADks5ORr9FY8tvTgfyxYPhn
 brvpbCq+SOGTtJgoSddL4SRemnh8ii5npwpxXEQqvAqyR2XopkJU6hQ752Zqc7n9CBpL9hVfDDF9m
 dvnbYKdpBXtItV9LZLIf2tuvxi8Wd9WURYxBj3sgt29QIsT7HI7fRvg9mQKxS6OW+QYr1WXyZjLA/
 IKaHvsJq068+0Ck8CZO9Cd2g6sGYb6GYQXRJnKBHY3rx0MKPdtRXYwbl4OHeZfh+CLJT/rpsHTcMW
 41BAXizVqswoN13mS5n6AekSTkqgDqVcNTM19GCrU2h2wJG2X2rAF30MntVQDVpTuH2TEcu8FxXUR
 zCbWfdaX5T8Kv7zRQaAGz7SEL+raUh8UXlHTawGzhCGkVjzoa3+Wy3U7D+CLKWXMcZg+I2AlWIk0K
 mAV3EQqSaZBtw6UMhTFrwcbGUohv5LVOkpX0oyrPuM4VYZN0YeP8a/sg/YRbXrsP6tP1MmmX10+ea
 cTS0oZMWBqqeBn0oBFZOk8T0DgsCaGFl7E1w+2Uo9HssquPi09F+RcOKeYu72Mht9d064ix2Bxfyo
 XDE+r0hxByBasdLIac49TIjbTpqBEpPVqOf1alVYI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHNR-0009Gy-BX; Fri, 12 Jan 2024 13:15:13 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org, deller@gmx.de,
 linux@roeck-us.net, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 13:15:28 +0000
Message-Id: <20240112131529.515642-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/4] esp-pci.c: synchronise setting of DMA_STAT_DONE with ESP
 completion interrupt
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

The setting of DMA_STAT_DONE at the end of a DMA transfer can be configured to
generate an interrupt, however the Linux driver manually checks for DMA_STAT_DONE
being set and if it is, considers that a DMA transfer has completed.

If DMA_STAT_DONE is set but the ESP device isn't indicating an interrupt then
the Linux driver considers this to be a spurious interrupt. However this can
occur in QEMU as there is a delay between the end of DMA transfer where
DMA_STAT_DONE is set, and the ESP device raising its completion interrupt.

This appears to be an incorrect assumption in the Linux driver as the ESP and
PCI DMA interrupt sources are separate (and may not be raised exactly
together), however we can work around this by synchronising the setting of
DMA_STAT_DONE at the end of a DMA transfer with the ESP completion interrupt.

In conjunction with the previous commit Linux is now able to correctly boot
from an am53c974 PCI SCSI device on the hppa C3700 machine without emitting
"iget: checksum invalid" and "Spurious irq, sreg=10" errors.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp-pci.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 15dc3c004d..875a49199d 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -93,6 +93,18 @@ static void esp_irq_handler(void *opaque, int irq_num, int level)
 
     if (level) {
         pci->dma_regs[DMA_STAT] |= DMA_STAT_SCSIINT;
+
+        /*
+         * If raising the ESP IRQ to indicate end of DMA transfer, set
+         * DMA_STAT_DONE at the same time. In theory this should be done in
+         * esp_pci_dma_memory_rw(), however there is a delay between setting
+         * DMA_STAT_DONE and the ESP IRQ arriving which is visible to the
+         * guest that can cause confusion e.g. Linux
+         */
+        if ((pci->dma_regs[DMA_CMD] & DMA_CMD_MASK) == 0x3 &&
+            pci->dma_regs[DMA_WBC] == 0) {
+                pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
+        }
     } else {
         pci->dma_regs[DMA_STAT] &= ~DMA_STAT_SCSIINT;
     }
@@ -306,9 +318,6 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
     /* update status registers */
     pci->dma_regs[DMA_WBC] -= len;
     pci->dma_regs[DMA_WAC] += len;
-    if (pci->dma_regs[DMA_WBC] == 0) {
-        pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
-    }
 }
 
 static void esp_pci_dma_memory_read(void *opaque, uint8_t *buf, int len)
@@ -363,24 +372,13 @@ static const VMStateDescription vmstate_esp_pci_scsi = {
     }
 };
 
-static void esp_pci_command_complete(SCSIRequest *req, size_t resid)
-{
-    ESPState *s = req->hba_private;
-    PCIESPState *pci = container_of(s, PCIESPState, esp);
-
-    esp_command_complete(req, resid);
-    pci->dma_regs[DMA_WBC] = 0;
-    pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
-    esp_pci_update_irq(pci);
-}
-
 static const struct SCSIBusInfo esp_pci_scsi_info = {
     .tcq = false,
     .max_target = ESP_MAX_DEVS,
     .max_lun = 7,
 
     .transfer_data = esp_transfer_data,
-    .complete = esp_pci_command_complete,
+    .complete = esp_command_complete,
     .cancel = esp_request_cancelled,
 };
 
-- 
2.39.2


