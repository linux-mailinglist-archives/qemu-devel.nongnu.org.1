Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9282C04E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:00:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5a-0002tt-RN; Fri, 12 Jan 2024 07:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5W-0002hk-Ge
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5N-0007Sx-Q7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bfcsiNmXe9IZUms/qdM/I60bFpo0q1GAd6mI+r/EQcM=; b=ORsMb+kAEoDqN7hOxa3U0uNEK9
 gtH4U1liJexngw8/n+DcyZbAkjm2EhVl74ZlpXsRH3JxlJ1sEIBJ7kmD/h+A/MAwB0yujDEE0rYY9
 3hn8lkJ/PuJi91xqq2/1QSgACExtwDo753B5zuZta8Y8vmCPcz0sO6dSqF9Tgz+tNfC+h3ovzZhZA
 mBIWgf9XquqbmfUxqkh+53ZgiIKvKdJ5hkuSzwksXOOgUcNd+YNQzIpSxymWCq4dpFkr7ZSjYOHux
 yvFNkfvFMJBh1k7DjRiCFcDzB1XeUqY6YLPWMc4MOlPQaax3mapiqx0s+QWMvL+53YhqTOuG/g0M+
 JsNvT+tzIdCQ7+mqGQ0aZyJ6/fDd9CIKxWjLXQ60Ua7M+6Tlxs9sWP9OH8ioGaXvcQDY8ChkJ+Nas
 YAJdIqckfx3RxDX3I2F5+dDt1+dMPOuwNWg+V6BkQDrEOC1N9B0pyRVEubUOY4XuxGm0zFZBvsMI7
 yJJm+CR2JmFYmpjL15jnoNQFtu2JL3Kpizi+zG2/xPQ2BTpOSNU+zgOZoL/iKcnFlQZhgPwLNqoFR
 h3dbd0lu15mQ/jCt9S+XjxDdhAa43nypXe5s5FltKtsVprHfsjJqKogwjhtRlochdxsvkES7A89Es
 bjWYNdyKEbDKBuKYY3z5EvLPn+d5jiLFA4jivRYnM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4d-0008jM-Gu; Fri, 12 Jan 2024 12:55:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:22 +0000
Message-Id: <20240112125420.514425-31-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 30/88] esp.c: move TC and FIFO check logic into esp_dma_done()
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

This helps simplify the existing implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c6151d306e..4d58a49c73 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -545,8 +545,11 @@ static void write_response(ESPState *s)
 
 static void esp_dma_done(ESPState *s)
 {
-    s->rregs[ESP_RINTR] |= INTR_BS;
-    esp_raise_irq(s);
+    if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        esp_lower_drq(s);
+    }
 }
 
 static void do_dma_pdma_cb(ESPState *s)
@@ -610,12 +613,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-            esp_lower_drq(s);
-            esp_dma_done(s);
-        }
-
-        return;
+        esp_dma_done(s);
     } else {
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -624,10 +622,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-            esp_lower_drq(s);
-            esp_dma_done(s);
-        }
+        esp_dma_done(s);
 
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
@@ -713,10 +708,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
@@ -727,10 +719,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         }
     } else {
         if (s->dma_memory_write) {
@@ -747,10 +736,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
@@ -768,10 +754,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_lower_drq(s);
-                esp_dma_done(s);
-            }
+            esp_dma_done(s);
         }
     }
 }
-- 
2.39.2


