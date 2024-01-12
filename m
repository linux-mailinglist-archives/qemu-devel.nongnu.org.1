Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1F82C062
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:03:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBJ-00057O-3k; Fri, 12 Jan 2024 08:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHA9-0003B5-LZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHA7-0001iJ-OS
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c/x5L4qSUT7C+ztN0bhREfCYFtPG3NyJ8o4FL3Ik+aQ=; b=J1odOXDL+vEi5mcrgPKsP7q4EC
 CXm7XgdOKYLFkZ1bm5StSRc9gNz7xa72qglL06fPVTPU+5Q4F7bfFvFtayIm5z2n9dN5tgdhFoNuj
 72GuzyLL/PeCbrv3g8yhfmJoG2gbTjtqPIBOdf00tv8geXnqNKvDcgX/qFURjbs+GLLCufLvEfCgj
 VvOEjronnD1gIT0ad2VJnF6r22OElwVvSegQw0GQsjd6vmt3DQFZe0LB5NTncXL3333ywczahgRTA
 TGiN5wS/f3jTOBZsHEzHrd0XdsUj/Fja+nvm7HFlFNfYkNmkKJJcNpGQYSgxN6sq9x6O6Gi6bLpaD
 tstbHCxlnFlgWdwuxm3QzaIwzPMm8XZbsozj8TP0TOZNLPH8+wRFLz6hVGolyr+cAvYUk/3wQfnMp
 gpN9q+3VbkJWP/3Py4Q2sDYC0fuHcx3+syMPCA2v1ekjetY1AfLdp4F8tU1+jHP6Ef8W2tnsQCZEH
 vH7HFhdpPe3a8d+jJj5VI+8QZUjKTkgzcq9MQji3X0mhuDLDVvysBL429Eg3z+yTrzOBjRdPflITM
 ImI0xHEiPCDCgr9jVl60bVHmx90q/N7O7Ixr6U88OqsYVQJOLoRTDcYzPNxhSXg3BzMwiJTVkluP7
 3QRYEcPruTV/fWr3eJBfoVYMi6YJWCPrH9zal5ddE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6z-0008jM-VP; Fri, 12 Jan 2024 12:58:18 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:11 +0000
Message-Id: <20240112125420.514425-80-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 79/88] esp.c: consolidate DMA and PDMA logic in DATA IN phase
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 51 +++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 394774c379..49fc059eaa 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -557,51 +557,34 @@ static void esp_do_dma(ESPState *s)
         if (len > s->async_len) {
             len = s->async_len;
         }
+
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, s->async_buf, len);
-
-            esp_set_tc(s, esp_get_tc(s) - len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-
-            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
-                /* If the guest underflows TC then terminate SCSI request */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            esp_dma_ti_check(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
             fifo8_push_all(&s->fifo, s->async_buf, len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-            esp_set_tc(s, esp_get_tc(s) - len);
             esp_raise_drq(s);
+        }
 
-            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
-                /* If the guest underflows TC then terminate SCSI request */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size -= len;
+        esp_set_tc(s, esp_get_tc(s) - len);
 
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+            /* If the guest underflows TC then terminate SCSI request */
+            scsi_req_continue(s->current_req);
+            return;
+        }
 
-            esp_dma_ti_check(s);
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            return;
         }
+
+        esp_dma_ti_check(s);
         break;
 
     case STAT_ST:
-- 
2.39.2


