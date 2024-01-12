Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50782C08C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:09:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5j-0003mW-UG; Fri, 12 Jan 2024 07:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5g-0003WO-VJ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:52 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5e-0007UP-QB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NzEKvboNhYJQisWsPCRE6C2WgN0Zmo1yRngmU4ZE8u0=; b=oFeUKSFSFkxaJZGOSNnA8LBsip
 kXM0OyptPzN4RLx28N61h+7pc+BlVnybWXoYqcarUPCcq5wd2XOTWjZZBkwHOrmydUK8L27hMPTiU
 fVyWknUUk1lfVHaSxL6haZYaIsP9OJT/AnjdawVdrGx3Ykxft1tVPQ8GaNVPGxVX+occRo8lec6WF
 ueThLLcM/f19PzKymjEgppSRDpui9QaemwHeMs22uMc5nYIb/qdiDnRQm+ZyXdR4dilUrmkhP+sAp
 PdTP0lgQmk4IWhfw0TEbU6BrQoaQU0zLdjEOIRp8cY2GKAnwW4q9+N5ARrHHCJscNEusLvoUQktP2
 PGwj5+wYgBhbnXMoUJI2PYGMfSv+kddNyxg8pVlz7/8gecA6Zi6EoCETPaPWXcTW2cWZNYuOaimSP
 NsOKAI7Z9LSaVzDBR86Orppf/+8pqivjZUd9hRFUXbiKAtYG5qCJg8bodAh0VMjF1ndVEaEiHCa05
 oKUsDI8ywboicPYT6NKHi6QOqyEV7cbP8he6nCIDC6mvxB8B3Tq1/xAgTHEkHeEymhfG/tNKzmDwa
 DoiTgAMNsgpfhCpvsukw11j6sVuZKplYcvgUvWWSeXggDWjcVJTXqxHu+7uTHuDT5R1xKGU2etW7w
 mTh2apcxeCb8o7tPWgsvv0xQo0U2ueImJM//luBZQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4d-0008jM-U7; Fri, 12 Jan 2024 12:55:52 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:23 +0000
Message-Id: <20240112125420.514425-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 31/88] esp.c: rename esp_dma_done() to esp_dma_ti_check()
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

This is because a single DMA request can be transferred using multiple TI
commands, and so a TC equal to zero may not represent the completion of
the SCSI DMA command.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4d58a49c73..14c6d05253 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -543,7 +543,7 @@ static void write_response(ESPState *s)
     esp_raise_irq(s);
 }
 
-static void esp_dma_done(ESPState *s)
+static void esp_dma_ti_check(ESPState *s)
 {
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
         s->rregs[ESP_RINTR] |= INTR_BS;
@@ -613,7 +613,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
     } else {
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -622,7 +622,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
 
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
@@ -708,7 +708,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
@@ -719,7 +719,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         }
     } else {
         if (s->dma_memory_write) {
@@ -736,7 +736,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
@@ -754,7 +754,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         }
     }
 }
@@ -890,7 +890,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
          * this)
          */
         esp_set_tc(s, 0);
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
     } else {
         /*
          * Transfer truncated: raise INTR_BS to indicate early change of
@@ -939,7 +939,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
         /* When the SCSI layer returns more data, raise deferred INTR_BS */
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
 
         esp_do_dma(s);
     } else if (s->ti_cmd == CMD_TI) {
-- 
2.39.2


