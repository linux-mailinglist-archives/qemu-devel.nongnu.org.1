Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1182C089
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:08:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDj-000560-4p; Fri, 12 Jan 2024 08:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHD0-0004Ud-Rj
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCy-00039b-MU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=metDBkUl6dTkUgNCecnTDKJZsWyDSk6gx8iev0W1uCQ=; b=X/WXD1dIpBq8I4F2lg79t7rK3A
 jPucSr27fhhmyUj9T/pTuYno8jGCh1W4yzQoSxGPYRbg8EsJ4R84eRckKdE9bjuEBRDEIEleYptEu
 KPjpx12e9JGanthTLw1+GvZsu6pKXP+yzkiOiktJl2A417SDWf/UX/QTpa3az7/tdrszhErPoSgHa
 fxAGDu837XOdw1Gt3uWwtUpxkO/MhnntxXcUIDk5YYXO+RNbP/0JwKGESR6bQVXJTIzQyLljOfn2L
 agDd/TFE/MLdoIXcWYdtjhHFNnBjRw9pVa/MqnDwUunoOnIa4lr0ZD2kDV2SSJfZA+ocCn2AGwig6
 VbYLQSkevFpkUmWpiyDF/z7tpYZQcFpXqjOXx/OaMivrUbqKMgdR2h/v35UC1qLyp3/AXIf92g0h4
 HdNjqtraq0CbI+Ak7k37Ng7J9E8fO28QaztzTh01UG3+WC422XtsFRGlKw7YSUs+Prb7uKi1RRuAf
 W5wwj2BEQoTzwqTi8jzuAtDmALKivayo0mDVLycJxFxDTwSERtAp+5G53dRpsdYZpH8rCiXGQxq3j
 fP8q2wwC6LRSaqhu3qK9QAh3zYPEzwHPsikJ65FEJKpC7M3FCy6BgFoFmLTyPFjhPaV3OGC63NdPl
 M645jSAAs4LHg3SOdxKoyD5qylcfL8k6Oha+awHL0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5d-0008jM-IZ; Fri, 12 Jan 2024 12:56:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:44 +0000
Message-Id: <20240112125420.514425-53-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 52/88] esp.c: move CMD_SELATNS end of command logic to
 esp_do_dma() and do_dma_pdma_cb()
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

The special logic in satn_stop_pdma_cb() is now no longer required since
esp_do_dma() can be used as a direct replacement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 82 +++++++++++++++++++++----------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3cf8b2b4eb..29e3869173 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -418,54 +418,31 @@ static void handle_s_without_atn(ESPState *s)
     }
 }
 
-static void satn_stop_pdma_cb(ESPState *s)
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
-        trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->cmdfifo_cdb_offset = 1;
-        esp_set_phase(s, STAT_CD);
-        s->rregs[ESP_RSTAT] |= STAT_TC;
-        s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_raise_irq(s);
-    }
-}
-
 static void handle_satn_stop(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn_stop;
         return;
     }
-    esp_set_pdma_cb(s, SATN_STOP_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, 1);
-    if (cmdlen > 0) {
-        trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->cmdfifo_cdb_offset = 1;
-        esp_set_phase(s, STAT_MO);
-        s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_MO;
-        esp_raise_irq(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_MO);
+    s->rregs[ESP_RSEQ] = SEQ_MO;
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, 1)) {
+            trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
+
+            /* Raise command completion interrupt */
+            s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+            s->rregs[ESP_RSEQ] = SEQ_MO;
+            esp_raise_irq(s);
         }
-        /* Target present, switch to message out phase */
-        s->rregs[ESP_RSEQ] = SEQ_MO;
-        esp_set_phase(s, STAT_MO);
     }
 }
 
@@ -554,6 +531,19 @@ static void do_dma_pdma_cb(ESPState *s)
             }
             break;
 
+        case CMD_SELATNS | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) == 1) {
+                /* First byte received, stop in message out phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                /* Raise command completion interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_raise_irq(s);
+            }
+            break;
+
         case CMD_TI | CMD_DMA:
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
@@ -676,6 +666,19 @@ static void esp_do_dma(ESPState *s)
             }
             break;
 
+        case CMD_SELATNS | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) == 1) {
+                /* First byte received, stop in message out phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                /* Raise command completion interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_raise_irq(s);
+            }
+            break;
+
         case CMD_TI | CMD_DMA:
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
@@ -906,9 +909,6 @@ static void esp_do_nodma(ESPState *s)
 static void esp_pdma_cb(ESPState *s)
 {
     switch (s->pdma_cb) {
-    case SATN_STOP_PDMA_CB:
-        satn_stop_pdma_cb(s);
-        break;
     case WRITE_RESPONSE_PDMA_CB:
         write_response_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 9945645837..a4b2ed115c 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -152,7 +152,6 @@ struct SysBusESPState {
 
 /* PDMA callbacks */
 enum pdma_cb {
-    SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
 };
-- 
2.39.2


