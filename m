Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80F887EA1
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:19:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLv-0007QO-St; Sun, 24 Mar 2024 15:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLu-0007QE-Bi
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLs-0005LW-NB
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QP1JO0PKDjAYT77GyhO+6yB/U03uQz1C5NmIQkapnE=; b=Ow4uPnmtJug8YK8Uol8iOinYS7
 ir5yOpJk6IYhhMRBYrVoOJsDRQqm3gd0iyM7k7BNH/Otf20TOB9Gu6GybWK4V1Mg89vz5jB2/aBQo
 CvnVC058PllpfsOQjb4pqI4jCl/n1woDnfJvuXswf9OwqBAuV6/sKVWdABfrZmcQSRhk+jCjyL1yq
 zwK8HcYiTitZ9tLDdjMLsAjs+qNy8+YWPTUYo/WSa+qhPJjx8OIVz/zHOVQ2z847vBndL4gTnXRsb
 Y2//Rc3eacOChoJewlYjoMGDvm/p/Q8swe3rNTi0uK0iH1W6llmSMlbDG08/KMJojM5LGIH2HGfVu
 BzC3J94vIdHC95i42Uq0PeUjD4kcK477f3kuPkHuARadXFLzNSpZtkBHvWLoyGEfKE0XcRDZjH27u
 CniCR9s7iqaagYqUxL8KZI18Yw0Npyl+ogv0plAon20vEUYVYpX+Tm5OlHV8Ac149q+HEgDVdVHx+
 Ozd7aRlFlWxPM7aA8YStTJuUUNhtPNqMBSwP+d4vaxUziBpi/yz9xlBt4ieWJfPC/cUqAd2yASUcL
 yqIW17pDGd/2nkTFljS/nO96UeHfK6QA4tidvDv0dfZXFGP6Lg3P7K9TTcOHkAJpH89wQEM8WFHer
 Qa4ytnI3uc4v9mqr0ymu7ry0NRDHnJncAN2+BEZLM=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKt-0000dj-Eb; Sun, 24 Mar 2024 19:16:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:57 +0000
Message-Id: <20240324191707.623175-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 08/17] esp.c: change esp_fifo_pop_buf() to take ESPState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that all users of esp_fifo_pop_buf() operate on the main FIFO there is no
need to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8d2d36d56c..83b621ee0f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -155,9 +155,9 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     return n;
 }
 
-static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
 {
-    return esp_fifo8_pop_buf(fifo, dest, maxlen);
+    return esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
 }
 
 static uint32_t esp_get_tc(ESPState *s)
@@ -459,7 +459,7 @@ static void esp_do_dma(ESPState *s)
             s->dma_memory_read(s->dma_opaque, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             esp_raise_drq(s);
         }
@@ -515,7 +515,7 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_raise_drq(s);
@@ -549,7 +549,7 @@ static void esp_do_dma(ESPState *s)
                 /* Copy FIFO data to device */
                 len = MIN(s->async_len, ESP_FIFO_SZ);
                 len = MIN(len, fifo8_num_used(&s->fifo));
-                len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+                len = esp_fifo_pop_buf(s, s->async_buf, len);
                 esp_raise_drq(s);
             }
 
@@ -713,7 +713,7 @@ static void esp_nodma_ti_dataout(ESPState *s)
     }
     len = MIN(s->async_len, ESP_FIFO_SZ);
     len = MIN(len, fifo8_num_used(&s->fifo));
-    esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+    esp_fifo_pop_buf(s, s->async_buf, len);
     s->async_buf += len;
     s->async_len -= len;
     s->ti_size += len;
@@ -738,7 +738,7 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -757,7 +757,7 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            len = esp_fifo_pop_buf(s, buf, 1);
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -774,7 +774,7 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -792,7 +792,7 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -821,7 +821,7 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -836,7 +836,7 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB: copy to cmdfifo and execute */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
-- 
2.39.2


