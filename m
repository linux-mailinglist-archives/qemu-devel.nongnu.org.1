Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC682C09A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:12:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHB9-00047H-Ma; Fri, 12 Jan 2024 08:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9o-0002zT-2n
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH9l-0001Z0-8c
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1DRhYIdoW/MiCzFiz4koo8gjIUUvdeds73MY7nMAx+E=; b=mrHaBnHSsI+khuqULi2Gf6P0vE
 yhJTCnbP7qGxStodg/1BtReKKvHX/Bs/Wb4atQRMaoSN0Q7RtT5l/prd3LsyM+6l7MXV3rSFWP+Ye
 4/Ab0tl/T1FSxUknT3UDBuFhW86Liy6oosY6eb2Z/HecawLOCRzEIo7tk2skQ7LdCQ48WleCT+3Um
 Je1ZdR4C2VmzEbQ36SNSkX7JInWswNn35hWYeFW51eBghnMRiGaYoTnja3FEkpjIto+tp2+RflHYE
 WZMRVm8lxVrzgloX9Zdbw90u5rPL1mA3XVTmFCQVbAdNOl1wTffz11hUCFLX8xZQkL22JXZ1bv2Ag
 62fM8R6i0hFXRgY/L/M0ruB+LwCK0zX4wi/IUUyrUgjzv0SdmwpewgjAm7lGQlKwcFGvZxmCLJNOR
 AP9vRVGLQ1Zq339/qigfQtp35cqw6NTpI3TF8IRifWEC5IC1ZSWrudwo9BIEtyCiA70KixsARIEP3
 zFTrD9OC2Kss4lquaKy7FR0FHmtQBgTJmBK+ObjCpzHKLFV/Nf5Y7rmKLZwn5nI35wW2bdDSZNJvv
 Bsamz1218ei68V3c0rIjrD8BYULVgmfeua1FJBuu6L6RSZ410NDIaS1DyK+e3H1OjKzlxfNVGcP9M
 uBTIqtBF4SfO/qNAp1eMR1qCMlqn8wdJLU/HkkDuk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6O-0008jM-FS; Fri, 12 Jan 2024 12:57:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:58 +0000
Message-Id: <20240112125420.514425-67-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 66/88] esp.c: process non-DMA FIFO writes in esp_do_nodma()
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

Currently any write to the ESP FIFO in the MESSAGE OUT or COMMAND phases will
manually raise the bus service interrupt. Instead of duplicating the interrupt
logic in esp_reg_write(), update esp_do_nodma() to correctly process incoming
FIFO data during the MESSAGE OUT and COMMAND phases. Part of this change is to
call esp_nodma_ti_dataout() from handle_ti() to ensure that the DATA OUT phase
FIFO transfer only occurs when executing a non-DMA TI command instead of for
each byte entering the FIFO.

One slight complication is that NextSTEP uses multiple TI commands to transfer
the CDB one byte at a time (as opposed to loading the FIFO and using a single
TI command), so it is necessary to determine the expected length of the SCSI
CDB being received. This is handled by the introduction of a new
esp_cdb_length() function which returns the expected SCSI CDB length based
upon the first command byte.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 121 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 35 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 97e48e9526..5bb8cc4ea7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -420,6 +420,7 @@ static void handle_satn_stop(ESPState *s)
 
     esp_set_phase(s, STAT_MO);
     s->rregs[ESP_RSEQ] = SEQ_MO;
+    s->cmdfifo_cdb_offset = 0;
 
     if (s->dma) {
         esp_do_dma(s);
@@ -454,6 +455,22 @@ static void write_response(ESPState *s)
     }
 }
 
+static int esp_cdb_length(ESPState *s)
+{
+    const uint8_t *pbuf;
+    int cmdlen, len;
+
+    cmdlen = fifo8_num_used(&s->cmdfifo);
+    if (cmdlen < s->cmdfifo_cdb_offset) {
+        return 0;
+    }
+
+    pbuf = fifo8_peek_buf(&s->cmdfifo, cmdlen, NULL);
+    len = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
+
+    return len;
+}
+
 static void esp_dma_ti_check(ESPState *s)
 {
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
@@ -738,16 +755,40 @@ static void esp_do_nodma(ESPState *s)
         fifo8_push_all(&s->cmdfifo, buf, n);
         s->cmdfifo_cdb_offset += n;
 
-        /*
-         * Extra message out bytes received: update cmdfifo_cdb_offset
-         * and then switch to command phase
-         */
-        s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-        esp_set_phase(s, STAT_CD);
-        s->rregs[ESP_CMD] = 0;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SELATN:
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
+                /* First byte received, switch to command phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                if (fifo8_num_used(&s->cmdfifo) > 1) {
+                    /* Process any additional command phase data */
+                    esp_do_nodma(s);
+                }
+            }
+            break;
+
+        case CMD_SELATNS:
+            if (fifo8_num_used(&s->cmdfifo) == 1) {
+                /* First byte received, stop in message out phase */
+                s->cmdfifo_cdb_offset = 1;
+
+                /* Raise command completion interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                esp_raise_irq(s);
+            }
+            break;
+
+        case CMD_TI:
+            /* ATN remains asserted until FIFO empty */
+            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_CMD] = 0;
+            s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
+            break;
+        }
         break;
 
     case STAT_CD:
@@ -756,21 +797,40 @@ static void esp_do_nodma(ESPState *s)
         n = MIN(fifo8_num_free(&s->cmdfifo), n);
         fifo8_push_all(&s->cmdfifo, buf, n);
 
-        cmdlen = fifo8_num_used(&s->cmdfifo);
-        trace_esp_handle_ti_cmd(cmdlen);
-        s->ti_size = 0;
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_TI:
+            cmdlen = fifo8_num_used(&s->cmdfifo);
+            trace_esp_handle_ti_cmd(cmdlen);
+
+            /* CDB may be transferred in one or more TI commands */
+            if (esp_cdb_length(s) && esp_cdb_length(s) ==
+                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
+                    /* Command has been received */
+                    do_cmd(s);
+            } else {
+                /*
+                 * If data was transferred from the FIFO then raise bus
+                 * service interrupt to indicate transfer complete. Otherwise
+                 * defer until the next FIFO write.
+                 */
+                if (n) {
+                    /* Raise interrupt to indicate transfer complete */
+                    s->rregs[ESP_RINTR] |= INTR_BS;
+                    esp_raise_irq(s);
+                }
+            }
+            break;
 
-        /* No command received */
-        if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-            return;
+        case CMD_SEL:
+        case CMD_SELATN:
+            /* FIFO already contain entire CDB */
+            do_cmd(s);
+            break;
         }
-
-        /* Command has been received */
-        do_cmd(s);
         break;
 
     case STAT_DO:
-        esp_nodma_ti_dataout(s);
+        /* Accumulate data in FIFO until non-DMA TI is executed */
         break;
 
     case STAT_DI:
@@ -945,6 +1005,10 @@ static void handle_ti(ESPState *s)
     } else {
         trace_esp_handle_ti(s->ti_size);
         esp_do_nodma(s);
+
+        if (esp_get_phase(s) == STAT_DO) {
+            esp_nodma_ti_dataout(s);
+        }
     }
 }
 
@@ -1141,23 +1205,10 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         break;
     case ESP_FIFO:
-        if (esp_get_phase(s) == STAT_MO || esp_get_phase(s) == STAT_CD) {
-            if (!fifo8_is_full(&s->fifo)) {
-                esp_fifo_push(&s->fifo, val);
-                esp_fifo_push(&s->cmdfifo, fifo8_pop(&s->fifo));
-            }
-
-            /*
-             * If any unexpected message out/command phase data is
-             * transferred using non-DMA, raise the interrupt
-             */
-            if (s->rregs[ESP_CMD] == CMD_TI) {
-                s->rregs[ESP_RINTR] |= INTR_BS;
-                esp_raise_irq(s);
-            }
-        } else {
+        if (!fifo8_is_full(&s->fifo)) {
             esp_fifo_push(&s->fifo, val);
         }
+        esp_do_nodma(s);
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
-- 
2.39.2


