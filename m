Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E182C030
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:57:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5X-0002gN-BY; Fri, 12 Jan 2024 07:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5T-0002S7-Rw
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:39 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5I-0007S2-TZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vhGa8G/D4xOpLPY1j1zK4i3OsOVDrN1vRe9nfcMuvuk=; b=irMYkNFD1YCImcRzKqyziekCMS
 6NAstoZ6Eyx7UixR/2AnbfjQD1f0K8EEwGN6SRWbuw1kPd51f/3cwXDiETR1FQQtdaoTF0PABqFCY
 tqvqkAaJ65FkjYjsjyhZgL5zNnX1P0veA9sWr5zAk/ignfPI3W9ZwAVZVGtut9etFSz4zj51tJg/g
 3d/Hepp56TlAcI7nS6DYsgjSH4OIGpSKq2tZd8lCSXmZVK3WEnaU6U0EGXQrMHvz8cv/AB72syMHN
 cfj2crqP4ufwE0z+r6Bxbslnp05j+aFyOeK5KZtjVV1GIqV432FVv4JeECkAGC0NYF34DkAXYg6+D
 apvXd80uz9phEM6K+6P3T+DlnbZhCslQGB13OQ7oR+LxVnLZBAmUj/EA7b7sDCyoit8bRHJ95LEr8
 Cxi/qep1r9bdOmv3UGJKbqZkH+Nl9RkDrB3lswyPC4h8UKNikyic13hoRJ4c4FeFDBbqK25A0KJgf
 J9QeJ+PGg2fEFgNTojY4oyct/sYo/XS2kuG/JdYL/qZmkYjjxjKZsUthIB8kYwuhgAT0dH3oNncNe
 42nid4bjwyDTdI7bHp+9EzOE7q6lD0n0LCAeiVCINFUViqeiBy1QNfRA+k42hS4N/hbmsDgGIIdGd
 FPum+4kzBs9Y+JhbF937nldJ2UaH1HhMzgPCLZZt4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4U-0008jM-Ry; Fri, 12 Jan 2024 12:55:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:20 +0000
Message-Id: <20240112125420.514425-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 28/88] esp.c: consolidate async_len and TC == 0 checks in
 do_dma_pdma_cb() and esp_do_dma()
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

Ensure that the async_len checks for requesting data from the SCSI layer and
the TC == 0 checks to detect the end of the DMA transfer are consistent in both
do_dma_pdma_cb() and esp_do_dma(). In particular this involves adding the check
to see if the FIFO is at its low threshold since PDMA and mixed DMA and non-DMA
requests can leave data remaining in the FIFO.

At the same time update all the comments so that they are also consistent between
all similar code paths.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6b0811d3ce..f20026c3dc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -604,12 +604,13 @@ static void do_dma_pdma_cb(ESPState *s)
         s->async_len -= n;
         s->ti_size += n;
 
-        if (s->async_len == 0) {
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
             scsi_req_continue(s->current_req);
             return;
         }
 
-        if (esp_get_tc(s) == 0) {
+        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
             esp_lower_drq(s);
             esp_dma_done(s);
         }
@@ -706,24 +707,30 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size += len;
 
-            if (s->async_len == 0) {
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
-                /*
-                 * If there is still data to be read from the device then
-                 * complete the DMA operation immediately.  Otherwise defer
-                 * until the scsi layer has completed.
-                 */
                 return;
             }
 
-            if (esp_get_tc(s) == 0) {
-                /* Partially filled a scsi buffer. Complete immediately.  */
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
                 esp_dma_done(s);
                 esp_lower_drq(s);
             }
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
+
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+                esp_dma_done(s);
+                esp_lower_drq(s);
+            }
         }
     } else {
         if (s->dma_memory_write) {
@@ -734,13 +741,13 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
 
-            if (s->async_len == 0) {
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
                 return;
             }
 
-            if (esp_get_tc(s) == 0) {
-                /* Partially filled a scsi buffer. Complete immediately.  */
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
                 esp_dma_done(s);
                 esp_lower_drq(s);
             }
@@ -754,6 +761,17 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
+
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+                esp_lower_drq(s);
+                esp_dma_done(s);
+            }
         }
     }
 }
-- 
2.39.2


