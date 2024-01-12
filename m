Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08B82C059
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:02:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBG-0004cb-9C; Fri, 12 Jan 2024 08:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9v-00031T-9s
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9t-0001bX-Rr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/UjXNQaHvk0LV04fdzty+43sk89fo6UkY63C3wA0Aos=; b=Jt4ZBooXB9TBCWPDX5iOPuEMKZ
 vllPsbRFO7vlCJtVa4T7sUHqXQd89uJUnRNCrrETl6giPwQ6z6ldXZ1VUfZ9wNzK+wS/T9bl7zxg1
 fBvgdjb6bz+9EDEPTDzdUHe9Nmf4BSKAKG1iPxQJ2EyoscRpJj0Vl0VLN1SuWYspV/eM/g/JQ9HlW
 bIf7q4mg7NdDhUkh8yP1RmImBRRNBZ12MeUkfYW/pAnTSzFQRLODPNNFB7dxOaDFT1G021zRxpVmc
 PWwMZjr8D03w5jXNhKK7JSriR+tKt1JeTj9u0W6pdHYKiTgBosGhgTO0oKZjsHqyq3d7vMqj6Ixlg
 9ECVHu7Si6fNugK0QTcELEjB0mt3WLForP0zF3AvAVF8kdmaFYsmXQuwSBoKYQLzzyM7lGj4H1N8J
 K+WSveDnHa2BtUYLMZgEUIiKe97tu2l2Fyw+GD7DodoWEFQ57Sb0Skp65t1wrIilUif546uml8Etw
 aFXO06YI7NJZvG9UUDV0gHszGPJVSsPKqG+6b+jm4uFz4M8Tj5HU3WeNMkvtPDiDRydjLaQBt1p0c
 6z/xBn2i85FzlVbE+3rmVeJNyuAcW/8LynfzBpej1fgOyl3jC5acjgTw1/Rx7n8/Mky7h2AMPPAhl
 AdeqJpRi0nhcAQLFdIOy8jDIHnIo8M4bl85AagrWA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5Y-0008jM-Ry; Fri, 12 Jan 2024 12:56:48 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:42 +0000
Message-Id: <20240112125420.514425-51-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 50/88] esp.c: move CMD_TI end of message phase detection to
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

The existing check for TC == 0 is only valid during a TI command.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f8c20d0584..9f787d12a8 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -555,14 +555,16 @@ static void do_dma_pdma_cb(ESPState *s)
                 }
             }
             break;
-        }
 
-        /* ATN remains asserted until TC == 0 */
-        if (esp_get_tc(s) == 0) {
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
+        case CMD_TI | CMD_DMA:
+            /* ATN remains asserted until TC == 0 */
+            if (esp_get_tc(s) == 0) {
+                esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                s->rregs[ESP_RINTR] |= INTR_BS;
+                esp_raise_irq(s);
+            }
+            break;
         }
         break;
 
@@ -675,14 +677,16 @@ static void esp_do_dma(ESPState *s)
                 }
             }
             break;
-        }
 
-        /* ATN remains asserted until TC == 0 */
-        if (esp_get_tc(s) == 0) {
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
+        case CMD_TI | CMD_DMA:
+            /* ATN remains asserted until TC == 0 */
+            if (esp_get_tc(s) == 0) {
+                esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                s->rregs[ESP_RINTR] |= INTR_BS;
+                esp_raise_irq(s);
+            }
+            break;
         }
         break;
 
-- 
2.39.2


