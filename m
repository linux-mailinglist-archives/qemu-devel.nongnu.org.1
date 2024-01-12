Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9187682C0A8
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:16:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBR-0006FP-94; Fri, 12 Jan 2024 08:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBG-0004uP-3L
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:38 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBD-00024w-UJ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hTiBIvU/chvkJ/J+N/HUIfIavZdoB7wH/zpxm8f4Qg4=; b=ILoyHtdnUx2n6icda/tuzDmpZE
 wBv0z32BK5HqlD1IqDktRNW17d6N7sryFOGTPQLzRNTndBzzmPTjkhVnpvmoy0EBFnrlcaP4nsWXi
 53jMknWjV9o/aOGh8BSuXEjRSjQQRcH8E1qVfP5Nctdvga8onvC3XFJhjqdltfSNUJn6337mQ8cme
 Bl6yyYgri2jsre4aJ/90bi4Hpy6kmrTc4py4Nh+/tJwcn+UE2I3OL1RGc3KXqIyKBKThUXa0/ye2a
 Kqvygh2rYfyHMErnMAk1XK3AvAp1wcdxXyaK4gW7XKzUKuuHPinN1e0wiR9BgHSmtdR89XV5tSjKy
 sX4a0KAV5Gc4vp2SC6jczgMFOpCFI9yM1EbLfHQD7Q7g7eTjFnhEnK1qMti+NRPDtyGQlcjjz1GcN
 tyx2GH3dGsDcMosHktWA75keEemCXKLu3TBH4H4fUxhJfKyRVVhlBCvL2hdL9DdeYZ3AKotbwdGnO
 T8tvqqrqbXZLMiafrg2/9LDw7BR5B8xHBdhUjvtiImlsyzwNGfsDZ1+NnS6xvY9TMJnwz2onjGwmy
 PID0aHiCfvuPfJthzmwOP4gOkKrxk7KtjH4KVUztL7qsXl4/QpBrKhArOEFS7gixvufQzqsR1ta7V
 SEg0QkYHr2Pcg44ItOVt/ZtxJAfKPu70fjdRc5Sho=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6v-0008jM-L1; Fri, 12 Jan 2024 12:58:13 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:10 +0000
Message-Id: <20240112125420.514425-79-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 78/88] esp.c: consolidate DMA and PDMA logic in DATA OUT phase
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
 hw/scsi/esp.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d63039af89..394774c379 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -521,40 +521,29 @@ static void esp_do_dma(ESPState *s)
         if (len > s->async_len) {
             len = s->async_len;
         }
+
         if (s->dma_memory_read) {
             s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-
             esp_set_tc(s, esp_get_tc(s) - len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size += len;
-
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            esp_dma_ti_check(s);
         } else {
             /* Copy FIFO data to device */
             len = MIN(s->async_len, ESP_FIFO_SZ);
             len = MIN(len, fifo8_num_used(&s->fifo));
-            n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-            s->async_buf += n;
-            s->async_len -= n;
-            s->ti_size += n;
-
+            len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
             esp_raise_drq(s);
+        }
 
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size += len;
 
-            esp_dma_ti_check(s);
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            return;
         }
+
+        esp_dma_ti_check(s);
         break;
 
     case STAT_DI:
-- 
2.39.2


