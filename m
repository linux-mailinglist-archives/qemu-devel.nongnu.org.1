Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A182C0B7
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDr-0006O8-26; Fri, 12 Jan 2024 08:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDm-0005yP-Ds
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDk-0003a6-Bj
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IL7dkV0KEoDsJkhEOTP7/jzlgKLuLvovOal0c7WQ+LQ=; b=TDlCV48hixLjSrS4Y4bnBHGUpW
 Lz6BQbhXYNntHoAcYxgFlwGJqXcG28B+xkr/miZB05leMIMj0TZyj62moGyNQ6QdMrPguEU56BmmH
 lR7KWfKmltM3jmCUfcan/cj6uUDZMHh+12EzSJ5N2xlXSzzU2MowIf5GgEmiQ0a7M1JW0MYqzDpcF
 YiKciJt6PJIkHMNGe3q3vfd3yTEKbcUBYXR0n716irfaXN4aAB5ByK3B9gc/iJYw1wdzYetv+Fh6T
 G5OaMcmruxyomPVWTZpfZBcUF9TqPFMaDgxk5mB1gop7NRL8k+RjPn6OiBXKiww8+RnBw0X6hneEd
 mOO6lYBBuFyFnNtk2ET1z9uABDN121ywyJC3ZYqfTJstFV5zyoV+T5pSaBfMTAD7S9WzUFIqO443w
 JihRQ1jGhcgaKTzAZn14uGTNuw+ettAXHnqvrgnWsh/Zyvestsmslhvpe+UGVx2kV3hIB66b2cPE6
 YvS/NfsbGp2L2KjAOFnR7/44bFNdkNyw575/P8Y4jVNDKA/F/Xww1FR/6F+U6zzLm1/LnM/QGv00T
 ekl/8qSn2vVINBMovrdUXjvkjoB6v65QsMTy9rszg+iSJaWezt2WDk17HgtWCt9+jNhA+zyJOx36E
 EHBTN0rnLxGKofyu3/i+i/WZc3yKPiwuphbb07Hgk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7D-0008jM-5x; Fri, 12 Jan 2024 12:58:31 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:15 +0000
Message-Id: <20240112125420.514425-84-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 83/88] esp.c: replace n variable with len in esp_do_nodma()
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

This brings esp_do_nodma() in line with esp_do_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 879e311bc4..73379a3c65 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -675,16 +675,16 @@ static void esp_do_nodma(ESPState *s)
 {
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
-    int n;
+    int len;
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
@@ -701,9 +701,9 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, 1);
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
@@ -718,9 +718,9 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* ATN remains asserted until FIFO empty */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
@@ -736,9 +736,9 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             cmdlen = fifo8_num_used(&s->cmdfifo);
             trace_esp_handle_ti_cmd(cmdlen);
@@ -754,7 +754,7 @@ static void esp_do_nodma(ESPState *s)
                  * service interrupt to indicate transfer complete. Otherwise
                  * defer until the next FIFO write.
                  */
-                if (n) {
+                if (len) {
                     /* Raise interrupt to indicate transfer complete */
                     s->rregs[ESP_RINTR] |= INTR_BS;
                     esp_raise_irq(s);
@@ -765,9 +765,9 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
             if (esp_cdb_length(s) && esp_cdb_length(s) ==
@@ -780,9 +780,9 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB: copy to cmdfifo and execute */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             do_cmd(s);
             break;
-- 
2.39.2


