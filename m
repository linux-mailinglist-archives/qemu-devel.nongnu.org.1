Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8C8389A1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:51:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCT7-0001bJ-SI; Tue, 23 Jan 2024 03:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCT5-0001b2-I0; Tue, 23 Jan 2024 03:49:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCT3-00051b-8a; Tue, 23 Jan 2024 03:49:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4BC9546678;
 Tue, 23 Jan 2024 11:49:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 02C90699F6;
 Tue, 23 Jan 2024 11:48:32 +0300 (MSK)
Received: (nullmailer pid 3828133 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.9 19/20] hw/scsi/esp-pci: synchronise setting of
 DMA_STAT_DONE with ESP completion interrupt
Date: Tue, 23 Jan 2024 11:48:29 +0300
Message-Id: <20240123084831.3828060-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20240112131529.515642-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 1e8e6644e063b20ad391140fae13d00ad7750b33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 59ce14f843..e9e94070ec 100644
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


