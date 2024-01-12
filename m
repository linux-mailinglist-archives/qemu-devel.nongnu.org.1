Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D288382C03E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:59:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH6O-0005vN-7L; Fri, 12 Jan 2024 07:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6L-0005e9-Bh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6I-00085B-Mv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZHwF1e1qETj/0627t2GqtCtKN96y497BGAjGZGqqNA=; b=sJvPTiqgAU+7+vPt+8PhLIhZgh
 ZeO/QYcsmCyG8TgOl7ttTfMmBLayfDN7II75DJ3LPzvBTZyWb9pFlbZ9VIgg/UdZnGnZQNE1hS4WO
 T9zfbkd5paIYuabwjf6havBRGyzjxcJmjFDTqw64mHjC2RMzbn9cBCbEBT6OSGAdjJFB0r5V5BcB0
 JHTQFzGV2y19047atdDmta4ENUcqqC+5zVRH42IH2a7EivCrYbunHyoEYEoVykxH7bZySyk4xOtFa
 m6MFjfWeZvKcALlJZBSoIiYYnX1tfDjoyRygffeF6qRaRnZJRhJ4VHYHCYRhP/Wt8iupS0MaUzI5L
 1go6CJ3RrxA4b1wOz/hygTMWBBkLMLVMy431bJsY6pB7HHOowHJKsmfQ0aH6hPWuG6CEDik4WLI2U
 TcUdIQsLs2EtNkcWN2IJ5z/S1D/RVM6yCb6IWwJKl6G7A9/uf+harWSf7qNbKCZAdHfKOOgLQDSS/
 axj9vs8Se8BuSz9QIjSoBKaRGDNoFMDXXr/YuDyiHTjiU8JZbebH5pNOD6LzIuApMNzqyaRAQfEwl
 AvidDQElLhBRmlB7Ya5aALjNMjND4jHMIQ/97aN59+ZfYk+72CBktVl+Zb2jE7xUVqLiVoQ5slztR
 EjTMKHW7BQMjJjnsHXgppcHi/onWWxNGE46v7mHME=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5Y-0008jM-BP; Fri, 12 Jan 2024 12:56:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:41 +0000
Message-Id: <20240112125420.514425-50-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 49/88] esp.c: move CMD_SELATN end of message phase detection
 to esp_do_dma() and do_dma_pdma_cb()
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

The special logic in satn_pdma_cb() is now no longer required since esp_do_dma()
can be used as a direct replacement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 75 +++++++++++++++++++++++++------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 81144ace83..f8c20d0584 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -261,6 +261,9 @@ static int esp_select(ESPState *s)
     return 0;
 }
 
+static void esp_do_dma(ESPState *s);
+static void esp_do_nodma(ESPState *s);
+
 static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
 {
     uint8_t buf[ESP_CMDFIFO_SZ];
@@ -368,45 +371,26 @@ static void do_cmd(ESPState *s)
     do_command_phase(s);
 }
 
-static void satn_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_FIFO_SZ];
-    int n;
-
-    /* Copy FIFO into cmdfifo */
-    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-    n = MIN(fifo8_num_free(&s->cmdfifo), n);
-    fifo8_push_all(&s->cmdfifo, buf, n);
-
-    if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
-        s->cmdfifo_cdb_offset = 1;
-        do_cmd(s);
-    }
-}
-
 static void handle_satn(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn;
         return;
     }
-    esp_set_pdma_cb(s, SATN_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
-    if (cmdlen > 0) {
-        s->cmdfifo_cdb_offset = 1;
-        do_cmd(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_MO);
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
+            s->cmdfifo_cdb_offset = 1;
+            do_cmd(s);
         }
-        /* Target present, but no cmd yet - switch to command phase */
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -558,6 +542,21 @@ static void do_dma_pdma_cb(ESPState *s)
         esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
         esp_raise_drq(s);
 
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SELATN | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
+                /* First byte received, switch to command phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                if (fifo8_num_used(&s->cmdfifo) > 1) {
+                    /* Process any additional command phase data */
+                    esp_do_dma(s);
+                }
+            }
+            break;
+        }
+
         /* ATN remains asserted until TC == 0 */
         if (esp_get_tc(s) == 0) {
             esp_set_phase(s, STAT_CD);
@@ -663,6 +662,21 @@ static void esp_do_dma(ESPState *s)
         esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
         esp_raise_drq(s);
 
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SELATN | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
+                /* First byte received, switch to command phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                if (fifo8_num_used(&s->cmdfifo) > 1) {
+                    /* Process any additional command phase data */
+                    esp_do_dma(s);
+                }
+            }
+            break;
+        }
+
         /* ATN remains asserted until TC == 0 */
         if (esp_get_tc(s) == 0) {
             esp_set_phase(s, STAT_CD);
@@ -890,9 +904,6 @@ static void esp_do_nodma(ESPState *s)
 static void esp_pdma_cb(ESPState *s)
 {
     switch (s->pdma_cb) {
-    case SATN_PDMA_CB:
-        satn_pdma_cb(s);
-        break;
     case SATN_STOP_PDMA_CB:
         satn_stop_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index b727181da9..9945645837 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -152,7 +152,6 @@ struct SysBusESPState {
 
 /* PDMA callbacks */
 enum pdma_cb {
-    SATN_PDMA_CB = 0,
     SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
-- 
2.39.2


