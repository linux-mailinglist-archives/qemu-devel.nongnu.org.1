Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69459853C08
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 21:10:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0Y-0004f6-Td; Tue, 13 Feb 2024 15:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzj-0003O1-Bl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzf-00028b-7V
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uJXGwrxSXVhXmHfs4lrUdgtZdqpD1CNQpU7RxspzTMQ=; b=kN8fwL0BF26nKu/V9iFgQ4B4UZ
 PgKoEarj5e91t2TlIYsyC1e1W83nf7rI5FqVtlb19wdg+9lIvHQDbNBPCCN2z4KjBzxX+0Z4Icd8m
 hIfjUoiwd9tDB37N+Tr88bb6b06tXB6EwlzV0En2GxnGd1YaAQ56UfRCSta0iUkaORxEw8SoerQ/P
 934bKwY4tTv41oe1OESFKzzqgm50n84V1LsqI9fMlJZp4grHif+1nhatUbFRREZkOj1pJr42U4cpD
 c/9zDNr3tEK9jXYd9mK643rD3ck9fOz7w9mCUhdt8cGsRxMXFLhBARM3bgBPVqw6Yp1hRdOiDA0p5
 hVT+OrGgC8skaTZA/Fvji/WYPLf0XPa+Mu/IYzjqzR+uKHVP1sJjNsNthwcPRkgVnY87rzIPwyq1T
 X2dYMGTkwFZhTLDhuYOqhECTcK236OwPRmgEjcnymki2vi9SKi5oDu8DTjurkPqm39nv5ipcZ2vU4
 Pk9zbsfHVw3Ky8ONO9Z43LTThsxn/K6nSDx3+sytarsOXwa8gzbqdJKbBmMDeWAlvVDY65v/ctuOr
 CSfxvFxPyiNcvgwoEFGo654uCpCEewpdmrheAl43lIRE1fVQuIf2T/P20tZIRv8qqx7lxVay9xhrv
 m/rw20IE3YwEA06Pnp7u8P5rrvNpiAwmWtkO8QNVA=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygO-0008m4-8j; Tue, 13 Feb 2024 19:43:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:14 +0000
Message-Id: <20240213194052.1162753-51-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 50/88] esp.c: move CMD_TI end of message phase detection to
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
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-51-mark.cave-ayland@ilande.co.uk>
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


