Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA282C077
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHC3-0001Xm-C0; Fri, 12 Jan 2024 08:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBl-0001AL-Um
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBj-0002Mi-PZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zOa5eaUY2Xcg6LheQdT49DvzHXEXfxC3Fr2RtZvTfNc=; b=Ac0ZSsnQcqTVVadlb/8GF4zPKT
 fXU/qQObiBy+TwzP7KHxBpb1KPzvkqRWM6zDjfSV4Wp5TB+bqZZFQNG/sJJCOYJ2EXJhWdnBgW8nC
 wbkJ4497jrM/iLXW1RSM9fhj5XVTD994ABuNzhMy8zZcx8fTWQDvj2zzM8X2TAfA2lm8BQuPoQEpu
 3J77jSZ+jBb1DFCURUI9NBKLKV7DXzOlpBEqiI3sq8Mm1yzq31TlV09lW2yw8gz3aIV26cye7Y1K4
 Kv+Hu/bAEMhi4nege1kaWJ7Vo2IsvDV6C7thnzgPIFijIcRvEJ2TzSp5ZwabRL32X/xbvYIE+XT6l
 LhYGSrL2mRHJc+g39Fpp8MkKVzsmyHBg4+guDHLVT53DYjOfMYSSKR9Tihh7NdV3c8jStIR/3Hq7u
 8szlbZohldWZZvfU4oW/dcJb+sfe6LThxHLoclHwFl9i9EhR/n3K2xpYQcj/dG1dOMmz4JKjCi+DZ
 7PI38StoBE8sUQiR4kN6qGT/2w/uMzdxE5HT0j51HxrBNr6Urt2Xqg5d7fOGRzxUZTqBFj/0B3csU
 eEBwzqERMHQLN/DuW+Xc8NYtqf1pPOi6WLKkGGq5vSyERj77JEFRI3x3FriIoN5P7vxa7iUjoLiFZ
 yzHMeG9+5Fq3Bu0fS8YA3saqEc+93SMjpKoeDfOhg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5h-0008jM-SM; Fri, 12 Jan 2024 12:56:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:45 +0000
Message-Id: <20240112125420.514425-54-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 53/88] esp.c: replace do_dma_pdma_cb() with esp_do_dma()
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

Now that the DMA logic is identical between do_dma_pdma_cb() and esp_do_dma()
we can replace do_dma_pdma_cb() with esp_do_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 138 +-------------------------------------------------
 1 file changed, 1 insertion(+), 137 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 29e3869173..f69b2709fc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -491,141 +491,6 @@ static void esp_dma_ti_check(ESPState *s)
     }
 }
 
-static void do_dma_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_CMDFIFO_SZ];
-    int len;
-    uint32_t n, cmdlen;
-
-    len = esp_get_tc(s);
-
-    switch (esp_get_phase(s)) {
-    case STAT_MO:
-        if (s->dma_memory_read) {
-            len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-            s->cmdfifo_cdb_offset += len;
-        } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-            s->cmdfifo_cdb_offset += n;
-        }
-
-        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
-        esp_raise_drq(s);
-
-        switch (s->rregs[ESP_CMD]) {
-        case CMD_SELATN | CMD_DMA:
-            if (fifo8_num_used(&s->cmdfifo) >= 1) {
-                /* First byte received, switch to command phase */
-                esp_set_phase(s, STAT_CD);
-                s->cmdfifo_cdb_offset = 1;
-
-                if (fifo8_num_used(&s->cmdfifo) > 1) {
-                    /* Process any additional command phase data */
-                    esp_do_dma(s);
-                }
-            }
-            break;
-
-        case CMD_SELATNS | CMD_DMA:
-            if (fifo8_num_used(&s->cmdfifo) == 1) {
-                /* First byte received, stop in message out phase */
-                esp_set_phase(s, STAT_CD);
-                s->cmdfifo_cdb_offset = 1;
-
-                /* Raise command completion interrupt */
-                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
-                esp_raise_irq(s);
-            }
-            break;
-
-        case CMD_TI | CMD_DMA:
-            /* ATN remains asserted until TC == 0 */
-            if (esp_get_tc(s) == 0) {
-                esp_set_phase(s, STAT_CD);
-                s->rregs[ESP_RSEQ] = SEQ_CD;
-                s->rregs[ESP_RINTR] |= INTR_BS;
-                esp_raise_irq(s);
-            }
-            break;
-        }
-        break;
-
-    case STAT_CD:
-        cmdlen = fifo8_num_used(&s->cmdfifo);
-        trace_esp_do_dma(cmdlen, len);
-        if (s->dma_memory_read) {
-            len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-        } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-
-            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
-            esp_raise_drq(s);
-        }
-        trace_esp_handle_ti_cmd(cmdlen);
-        s->ti_size = 0;
-        if (esp_get_tc(s) == 0) {
-            /* Command has been received */
-            do_cmd(s);
-        }
-        break;
-
-    case STAT_DO:
-        if (!s->current_req) {
-            return;
-        }
-        /* Copy FIFO data to device */
-        len = MIN(s->async_len, ESP_FIFO_SZ);
-        len = MIN(len, fifo8_num_used(&s->fifo));
-        n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-        s->async_buf += n;
-        s->async_len -= n;
-        s->ti_size += n;
-
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            return;
-        }
-
-        esp_dma_ti_check(s);
-        break;
-
-    case STAT_DI:
-        if (!s->current_req) {
-            return;
-        }
-        /* Copy device data to FIFO */
-        len = MIN(s->async_len, esp_get_tc(s));
-        len = MIN(len, fifo8_num_free(&s->fifo));
-        fifo8_push_all(&s->fifo, s->async_buf, len);
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size -= len;
-        esp_set_tc(s, esp_get_tc(s) - len);
-
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            s->data_in_ready = false;
-            return;
-        }
-
-        esp_dma_ti_check(s);
-        break;
-    }
-}
-
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
@@ -669,7 +534,6 @@ static void esp_do_dma(ESPState *s)
         case CMD_SELATNS | CMD_DMA:
             if (fifo8_num_used(&s->cmdfifo) == 1) {
                 /* First byte received, stop in message out phase */
-                esp_set_phase(s, STAT_CD);
                 s->cmdfifo_cdb_offset = 1;
 
                 /* Raise command completion interrupt */
@@ -913,7 +777,7 @@ static void esp_pdma_cb(ESPState *s)
         write_response_pdma_cb(s);
         break;
     case DO_DMA_PDMA_CB:
-        do_dma_pdma_cb(s);
+        esp_do_dma(s);
         break;
     default:
         g_assert_not_reached();
-- 
2.39.2


