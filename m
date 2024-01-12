Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B482C0A1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:14:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBh-0000K1-Uq; Fri, 12 Jan 2024 08:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBe-0008PE-7T
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHBa-0002J3-VX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dqtNfmH/y5LEFl4e5Sf22fl1pgdCOZPPeZCqeQS8/KE=; b=mF2aN2mlhh7zDSZ0ZXm9uez0xf
 39+xpj5cZ4hwZzy6sVRezvlDOtn/9deDqS6E0tNMXJN+LV4cWqdmDjH87qC6+gz68yfXqCCjtsWzF
 e2jUzrulaGSW63wCxTDo0HTrG1+qM+XyEhNGG7B7VFirVBOEm2Qj+btFhgWPhzmF9B4XjHT7gCbwp
 Olpx22uVF0TQSXBDgMoHVhWYKWohBMWUF6gcR+HEPqlZDc1vSpPUvALG232faCH/K6bv+ROeNT8jp
 pTpl0c1B8bJ4omt/KOnRfj72GkD2dB1RXrhu5gr5ysWgROtvHatiVruAkMYv4v7hOs6j94uigKlJS
 ZOakryoiiW1Sd1yrmAMJz7ZsTpz+sJ8oL7J7ACzKuS1GrYoVaTTx158y9WTevmGHu/lFl59fQSffi
 3uJ9hz7NvD7tKhisUuiZz7zH3oBXpFDtwc67I6A1QeZYt73tjA4mnmugNZpRcaydfcnKNiI1NHCjz
 VEPsydGcRW3cQQP4bEQK7bFJAN25C7OZoyXa+zm31IEjIFuo8xONN2oT2bfLvKfVxLdo0i8vt9Ssj
 3r7plBvRnvoQr7dSrxokrWe4cPlg6c/IeIh9Tin/557B4l1R63UWe3QDQ5UG85+3OBziD7oYEnxIJ
 oyPV3HaI9bqCYDrTRDRDMpEB1H0p8vubhuFJUqJq4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7H-0008jM-Eu; Fri, 12 Jan 2024 12:58:35 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:16 +0000
Message-Id: <20240112125420.514425-85-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 84/88] esp.c: implement DMA Transfer Pad command for DATA
 phases
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

The Transfer Pad command is used to either drop incoming FIFO data during the
DATA IN phase or generate a series of zero bytes in the FIFO during the DATA
OUT phase.

Implement the DMA Transfer Pad command for the DATA phases which is used by
the NeXTCube firmware in the DATA IN phase to ignore part of the incoming SCSI
data as it is copied into memory.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 97 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 73379a3c65..5583b3eb56 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -387,6 +387,15 @@ static void handle_satn_stop(ESPState *s)
     }
 }
 
+static void handle_pad(ESPState *s)
+{
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        esp_do_nodma(s);
+    }
+}
+
 static void write_response(ESPState *s)
 {
     trace_esp_write_response(s->status);
@@ -518,20 +527,38 @@ static void esp_do_dma(ESPState *s)
             len = s->async_len;
         }
 
-        if (s->dma_memory_read) {
-            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-        } else {
-            /* Copy FIFO data to device */
-            len = MIN(s->async_len, ESP_FIFO_SZ);
-            len = MIN(len, fifo8_num_used(&s->fifo));
-            len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-            esp_raise_drq(s);
-        }
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_TI | CMD_DMA:
+            if (s->dma_memory_read) {
+                s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            } else {
+                /* Copy FIFO data to device */
+                len = MIN(s->async_len, ESP_FIFO_SZ);
+                len = MIN(len, fifo8_num_used(&s->fifo));
+                len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+                esp_raise_drq(s);
+            }
 
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size += len;
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+            break;
+
+        case CMD_PAD | CMD_DMA:
+            /* Copy TC zero bytes into the incoming stream */
+            if (!s->dma_memory_read) {
+                len = MIN(s->async_len, ESP_FIFO_SZ);
+                len = MIN(len, fifo8_num_free(&s->fifo));
+            }
+
+            memset(s->async_buf, 0, len);
+
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+            break;
+        }
 
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -554,19 +581,35 @@ static void esp_do_dma(ESPState *s)
             len = s->async_len;
         }
 
-        if (s->dma_memory_write) {
-            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
-        } else {
-            /* Copy device data to FIFO */
-            len = MIN(len, fifo8_num_free(&s->fifo));
-            fifo8_push_all(&s->fifo, s->async_buf, len);
-            esp_raise_drq(s);
-        }
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_TI | CMD_DMA:
+            if (s->dma_memory_write) {
+                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+            } else {
+                /* Copy device data to FIFO */
+                len = MIN(len, fifo8_num_free(&s->fifo));
+                fifo8_push_all(&s->fifo, s->async_buf, len);
+                esp_raise_drq(s);
+            }
+
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+            esp_set_tc(s, esp_get_tc(s) - len);
+            break;
+
+        case CMD_PAD | CMD_DMA:
+            /* Drop TC bytes from the incoming stream */
+            if (!s->dma_memory_write) {
+                len = MIN(len, fifo8_num_free(&s->fifo));
+            }
 
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size -= len;
-        esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+            esp_set_tc(s, esp_get_tc(s) - len);
+            break;
+        }
 
         if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
             /* If the guest underflows TC then terminate SCSI request */
@@ -1087,9 +1130,7 @@ static void esp_run_cmd(ESPState *s)
         break;
     case CMD_PAD:
         trace_esp_mem_writeb_cmd_pad(cmd);
-        s->rregs[ESP_RSTAT] = STAT_TC;
-        s->rregs[ESP_RINTR] |= INTR_FC;
-        s->rregs[ESP_RSEQ] = 0;
+        handle_pad(s);
         break;
     case CMD_SATN:
         trace_esp_mem_writeb_cmd_satn(cmd);
-- 
2.39.2


