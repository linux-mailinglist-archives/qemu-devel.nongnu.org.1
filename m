Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13382C098
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH6N-0005tW-Lt; Fri, 12 Jan 2024 07:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6D-0005MK-Sm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6B-00081C-1K
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2giIfY8yPqy5lAkB/Z0OCqmxwdcZs/C6aYH/9//6JF8=; b=JX4kz/GMfEoGixp9f61rzicn/u
 PvuPG1r5yuXksC9tH1mL/HJU028DLRNA/kVuV8qdtSkswF3SI+pt/SYgwUFQ/7TcJNi9Xy9MVaGeo
 TfKopLnfExTjR3axT0k10r/juNcqDMJOksDD14BLEmF3JC0fGA86GtfoiyqPWhUVKq9IgOpw44yO/
 ojg42wBKOMOWwA5V3p0B0SH3yKO0WR8uplMuhO6Tr12h1vwvKs9C8gfyOzyAOwXZTY8QATI9qUbie
 Zet5cRVqlOgYDx3bk0iPmjwF68VsSo771YonNRg+A/nTOQ0l11BNFc5+RfcU/qkXZf1/HWs4rRTxX
 0ko8sr2PXVUchXJ9MseT8AvRlNyxV1F56ImiO2AoExy2bRwoT//mwfP33RvIzSA0Dwaw5EMrcViXb
 7pQatIcHwKrkVLUukZXy8V0u7Z1gJT8BraE8avPAwiB+5AnrdbWMA1Rp0obyfe1Ywu+zDaWFjw1Ci
 jZdfv576+T5pij5+MJxOpA21JpexbFhMX3uokDXzR+XdWv9AehpRkdkpIwf/IWXWWUaIu2sjjynID
 L3pDTI60MOitDkrv+SNej+f64gR3747NpnObopqm5xsMq9lCtVZFxtRaISg2VaPPC9SW2QDozkQmQ
 7ANmx+ngyVwDY6MRH7GBg53Qj0XVZN8fy1OyprqBs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5L-0008jM-Le; Fri, 12 Jan 2024 12:56:35 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:38 +0000
Message-Id: <20240112125420.514425-47-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 46/88] esp.c: untangle MESSAGE OUT and COMMAND phase logic in
 esp_do_dma()
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

This makes it clearer that ATN is asserted until the end of the next TI command
in the MESSAGE OUT phase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1f7dff4ca6..2f54fd1285 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -629,6 +629,31 @@ static void esp_do_dma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
+        if (s->dma_memory_read) {
+            len = MIN(len, fifo8_num_free(&s->cmdfifo));
+            s->dma_memory_read(s->dma_opaque, buf, len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->cmdfifo_cdb_offset += len;
+        } else {
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+            s->cmdfifo_cdb_offset += n;
+        }
+
+        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+        esp_raise_drq(s);
+
+        /* ATN remains asserted until TC == 0 */
+        if (esp_get_tc(s) == 0) {
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSEQ] = SEQ_CD;
+            s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
+        }
+        break;
+
     case STAT_CD:
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_do_dma(cmdlen, len);
@@ -641,36 +666,15 @@ static void esp_do_dma(ESPState *s)
             n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
             n = MIN(fifo8_num_free(&s->cmdfifo), n);
             fifo8_push_all(&s->cmdfifo, buf, n);
-            esp_set_tc(s, esp_get_tc(s) - n);
 
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-
-            /* Ensure we have received complete command after SATN and stop */
-            if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
-                return;
-            }
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if (esp_get_phase(s) == STAT_CD) {
-            /* No command received */
-            if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-                return;
-            }
-
+        if (esp_get_tc(s) == 0) {
             /* Command has been received */
             do_cmd(s);
-        } else {
-            /*
-             * Extra message out bytes received: update cmdfifo_cdb_offset
-             * and then switch to command phase
-             */
-            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
         }
         break;
 
-- 
2.39.2


