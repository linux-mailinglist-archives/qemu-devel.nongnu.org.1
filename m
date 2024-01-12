Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811982C094
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDh-00051U-Cz; Fri, 12 Jan 2024 08:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCf-0004MS-2G
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCd-0002yj-6t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8B7V1v2+kwT4bDpY+vrvIlSYZpgJoQzndmCv9dP7RxM=; b=DFtAx0eJ3IQfnujuvcP8BSnNJm
 NZfFOV0yKJxzWY8sGmWIY+pHrqyXhk3/nkSKBxwyBXDxnoTwgfZtwyVWcmAj44ysgkFFdmahjjw0X
 Q7PO807Y6AXAXhik2PNJJHdjl2/beMZbpPDrRmZIwdlT7warI+TlBcLSve/RCm0ntAImxKNQMPIwm
 MEgS6kzJIHgISRAP41Sp7iO+TrgGzJNgpG2DwUPxf36f5dL3Xrymlxs7FFUIdAxWFny3zLJhPde0+
 AJ1f+0X+A58jOj5Vmr3B/QZBxo/2uaUL5A4xciOXLpb/ShK/YCDYnNvSB07QkCho8mbFGZCgjX/Eh
 lE2kBJ7+gORuR0XmEvvE056thNa+elyoJuxNsMxBwi0YI3EI3VAht/uzGiGAiZUnuXuKp09jqm4b7
 MUI/nGoAEUJ5KO39n+4q0ynnvC8xsHGnz98XmynIFWLwhoYuIF91jREtm4I2no0/lTvoTnSGtg6w7
 ImW8L7ElQsR0ligBMjOl/TS33GF5XnLIyTeGbOwIWHA7eg4TMpN51thZ0RR2VdjQw1seARJdCm4WO
 jcv9Bn+8srhu8zZdPsMfS06xRj7st2g0KMh8dLJDyNGJKA84mBoSGmIGE2NV04fWX4aAwRjdxfkrG
 1LHTucNvfrpfXm9S0E9/BpY5/BDUxPFutM6i9W5Aw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6Q-0008jM-Db; Fri, 12 Jan 2024 12:57:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:00 +0000
Message-Id: <20240112125420.514425-69-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 68/88] esp.c: move write_response() non-DMA logic to
 esp_do_nodma()
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

This moves the remaining non-DMA STATUS and MESSAGE IN phase logic from
write_response() to esp_do_nodma(). Note that we can also now drop the extra
fifo_reset() which is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 277eb8647b..824ebe9ff0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -392,20 +392,12 @@ static void handle_satn_stop(ESPState *s)
 
 static void write_response(ESPState *s)
 {
-    uint8_t buf[2];
-
     trace_esp_write_response(s->status);
 
     if (s->dma) {
         esp_do_dma(s);
     } else {
-        buf[0] = s->status;
-        buf[1] = 0;
-
-        fifo8_reset(&s->fifo);
-        fifo8_push_all(&s->fifo, buf, 2);
-        s->rregs[ESP_RFLAGS] = 2;
-        esp_raise_irq(s);
+        esp_do_nodma(s);
     }
 }
 
@@ -815,6 +807,28 @@ static void esp_do_nodma(ESPState *s)
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
         break;
+
+    case STAT_ST:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS:
+            fifo8_push(&s->fifo, s->status);
+            esp_set_phase(s, STAT_MI);
+
+            /* Process any message in phase data */
+            esp_do_nodma(s);
+            break;
+        }
+        break;
+
+    case STAT_MI:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS:
+            fifo8_push(&s->fifo, 0);
+
+            esp_raise_irq(s);
+            break;
+        }
+        break;
     }
 }
 
-- 
2.39.2


