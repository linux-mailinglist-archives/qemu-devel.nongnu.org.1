Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E082C02C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH49-0007jY-Pq; Fri, 12 Jan 2024 07:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH47-0007jC-Ld
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:15 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH45-0006nO-Pe
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dduij/1KHNbwQV3V0mAVvsaSDJf7TLad9xOYWtTXP10=; b=Vapt6Xe2zL+Z31KTreVMzM54XA
 rD96adoMm6S4KVsIqc0isksrG5+m+OChxltpGjO6VjA6DnxPAsA45GF8eiczBr+J8XkfA+fDorByq
 CSbT9Nw69ihbOEYeMe4I+JUv6OYse20twaQqXoS5aznZpiNQs8blFqznRFQ6/QD1pWaVCgWVM2MdK
 IT/c2BsNZ4zs/0NA6wtoNbmAbATLVvD/RoXSNKc1SU7X6y0z6sU9nA3G3XESK8AqRNTKRTVqlXu5N
 ueB0Wxw9sJgZuvw5iOQiXTzCV5Rp8JQnjIJvv9Bu5UbpeT6G4Lqtw8IHwk+tct5zXtXJNoUPWJhsl
 WzwLte30My8K++CeYGwsqRuDnaJd6SHuFNpkot5ObH70cWk/GmLw9m9317sarVWnVf9LXb9KIsdnH
 TfKb5sCC0cWHRkXodXFNwk45wzLdDqFbbBfR15pU6mtnm04l/st6iQnprL7tKmz41UNvI/ZATbUiy
 YaZXyRlxOCx1X0aliLopu9K2QSXi7rPjANEkl9AccbQkScI3r2cLM8g11oy/M74FqA/Cj2YrnSd6f
 wKpOVR32thkQKs5tZjiFXoQAU6LYxQ95wJZK73UhNK+IiQJMYr7fvejAMJCwfSoxLFdxVQW6QQEiW
 EGFcM3R485wcoj7b1N4VN3rJfLJYNj63HogVCzcAs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3R-0008jM-FW; Fri, 12 Jan 2024 12:54:37 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:02 +0000
Message-Id: <20240112125420.514425-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/88] esp: move buffer and TC logic into separate to/from
 device paths in esp_do_dma()
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

The ultimate aim is to for esp_do_dma() behaviour to be determined by the SCSI
bus phase, in which case it is necessary to have separate to/from device paths.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 65 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 63c828c1b2..9893840255 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -678,14 +678,53 @@ static void esp_do_dma(ESPState *s)
     if (to_device) {
         if (s->dma_memory_read) {
             s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+
+            if (s->async_len == 0) {
+                scsi_req_continue(s->current_req);
+                /*
+                 * If there is still data to be read from the device then
+                 * complete the DMA operation immediately.  Otherwise defer
+                 * until the scsi layer has completed.
+                 */
+                return;
+            }
+
+            /* Partially filled a scsi buffer. Complete immediately.  */
+            esp_dma_done(s);
+            esp_lower_drq(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
         }
     } else {
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+
+            if (s->async_len == 0) {
+                scsi_req_continue(s->current_req);
+                /*
+                 * If there is still data to be read from the device then
+                 * complete the DMA operation immediately.  Otherwise defer
+                 * until the scsi layer has completed.
+                 */
+                if (esp_get_tc(s) != 0 || s->ti_size == 0) {
+                    return;
+                }
+            }
+
+            /* Partially filled a scsi buffer. Complete immediately.  */
+            esp_dma_done(s);
+            esp_lower_drq(s);
         } else {
             /* Adjust TC for any leftover data in the FIFO */
             if (!fifo8_is_empty(&s->fifo)) {
@@ -713,32 +752,8 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
         }
     }
-    esp_set_tc(s, esp_get_tc(s) - len);
-    s->async_buf += len;
-    s->async_len -= len;
-    if (to_device) {
-        s->ti_size += len;
-    } else {
-        s->ti_size -= len;
-    }
-    if (s->async_len == 0) {
-        scsi_req_continue(s->current_req);
-        /*
-         * If there is still data to be read from the device then
-         * complete the DMA operation immediately.  Otherwise defer
-         * until the scsi layer has completed.
-         */
-        if (to_device || esp_get_tc(s) != 0 || s->ti_size == 0) {
-            return;
-        }
-    }
-
-    /* Partially filled a scsi buffer. Complete immediately.  */
-    esp_dma_done(s);
-    esp_lower_drq(s);
 }
 
 static void esp_do_nodma(ESPState *s)
-- 
2.39.2


