Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D748282C075
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH9b-0002FO-Cv; Fri, 12 Jan 2024 08:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9R-0001ya-AJ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9N-0001Gj-9H
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xI8vflAYA1yRD6nzOMwUkXrNNBU14YuiIIZilCh/3E=; b=lCypg7INoZMSHcEd7uuNemxwoT
 6LpWivSzldzTjCDHPpp7QDyF/bVCiHpwlQ7vc/7wTTFej1p84Rr3Mp4x564bJJs6fSF5Rq5nFmB6F
 DPHLAzcAEcdKjXdcTR4HrayqQ+vzO9DUhFVbCDmHmmTKTZok6e3sN8zkclSh/e0GALnKNWXANRgCM
 um8VIOSGbijuzE6QLMBPCFc9sEhtz0TixTw+WfAcOiTYXvBLX1JncuDU2RX/V2W8FeNLWBgKDcH8k
 L5nyi5b1oEbiMQ6Fa8/0YHABVjd77X0bahEyKfp9qg9S1PwfBXJi6k64sZOu4SGWs6eEHQp3ktPnq
 4wFJtv4B8hHk4YCWR4qxzaktGdWOdFqIFi4qPw7Pxg1K63yDXrttld+9wmULIVQjN+diR8Q/GpNaw
 7zB9aNLVpducY4VjYvKYxOZ26gXuhK8+Wrc5ncpmgW+dW2YFbAg72QIZDRE6vLHFMNYF0UrKkuwCC
 mzoj6wTO/hgUvOz1Zn+g0p7/m3HLU83ndQVpXwabK6ug3PF/r77qqS8TbtP6Xi6nDhSpRzEwDvzV+
 eNuZR/yHsLom1TtBWQ66dJ2k/oo8owTHNTz7Qv8w1f+GylBSNPSsoqNPuPhgCzl5AXkzuYqlPisTH
 XF75JBewCSbsR8vZJYrq1j2gFYPyTHv5BMCWi4Wls=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5i-0008jM-CU; Fri, 12 Jan 2024 12:56:58 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:46 +0000
Message-Id: <20240112125420.514425-55-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 54/88] esp.c: move CMD_ICCS command logic to esp_do_dma()
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

The special logic in write_response_pdma_cb() is now no longer required since
esp_do_dma() can be used as a direct replacement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 82 ++++++++++++++++++++++++++++++-------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f69b2709fc..c6e5ddd537 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -446,40 +446,23 @@ static void handle_satn_stop(ESPState *s)
     }
 }
 
-static void write_response_pdma_cb(ESPState *s)
-{
-    esp_set_phase(s, STAT_ST);
-    s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-    s->rregs[ESP_RSEQ] = SEQ_CD;
-    esp_raise_irq(s);
-}
-
 static void write_response(ESPState *s)
 {
     uint8_t buf[2];
 
     trace_esp_write_response(s->status);
 
-    buf[0] = s->status;
-    buf[1] = 0;
-
     if (s->dma) {
-        if (s->dma_memory_write) {
-            s->dma_memory_write(s->dma_opaque, buf, 2);
-            esp_set_phase(s, STAT_ST);
-            s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-        } else {
-            esp_set_pdma_cb(s, WRITE_RESPONSE_PDMA_CB);
-            esp_raise_drq(s);
-            return;
-        }
+        esp_do_dma(s);
     } else {
+        buf[0] = s->status;
+        buf[1] = 0;
+
         fifo8_reset(&s->fifo);
         fifo8_push_all(&s->fifo, buf, 2);
         s->rregs[ESP_RFLAGS] = 2;
+        esp_raise_irq(s);
     }
-    esp_raise_irq(s);
 }
 
 static void esp_dma_ti_check(ESPState *s)
@@ -673,6 +656,58 @@ static void esp_do_dma(ESPState *s)
             esp_dma_ti_check(s);
         }
         break;
+
+    case STAT_ST:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS | CMD_DMA:
+            len = MIN(len, 1);
+
+            if (len) {
+                buf[0] = s->status;
+
+                if (s->dma_memory_write) {
+                    s->dma_memory_write(s->dma_opaque, buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                } else {
+                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                }
+
+                esp_set_phase(s, STAT_MI);
+
+                if (esp_get_tc(s) > 0) {
+                    /* Process any message in phase data */
+                    esp_do_dma(s);
+                }
+            }
+            break;
+        }
+        break;
+
+    case STAT_MI:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS | CMD_DMA:
+            len = MIN(len, 1);
+
+            if (len) {
+                buf[0] = 0;
+
+                if (s->dma_memory_write) {
+                    s->dma_memory_write(s->dma_opaque, buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                } else {
+                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                }
+
+                /* Raise end of command interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_raise_irq(s);
+            }
+            break;
+        }
+        break;
     }
 }
 
@@ -773,9 +808,6 @@ static void esp_do_nodma(ESPState *s)
 static void esp_pdma_cb(ESPState *s)
 {
     switch (s->pdma_cb) {
-    case WRITE_RESPONSE_PDMA_CB:
-        write_response_pdma_cb(s);
-        break;
     case DO_DMA_PDMA_CB:
         esp_do_dma(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index a4b2ed115c..0207fdd7a6 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -152,7 +152,6 @@ struct SysBusESPState {
 
 /* PDMA callbacks */
 enum pdma_cb {
-    WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
 };
 
-- 
2.39.2


