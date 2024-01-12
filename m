Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150482C0BC
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHBP-0005uP-DV; Fri, 12 Jan 2024 08:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHB2-0004IY-5d
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHB0-00023a-5O
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=loJm3RrZyp7pgJavwhQcogirW54ozY6kkT80o70H/ps=; b=TaZTcrKLRK3zfHLqdGkRR8LHE9
 M298xCk5Wadssq+CTdM/kynI2xHLhyRUJuDIEVmvWr5sPoT1CwAZVUr34z1x6w2IFRWH/gUdwRWO5
 ko2+647jIv/1/zhEQZetPnSDGqwikNdNDl1IOj7Nz+xsyaM2hMTmimlR6vaVWju2eVSOxHHAOF906
 PFUzhCxJz1qavghJTIrGWO/xx2z6N8jIasqw6qHcEHtaLwu52Tx/3lUkkA++gnVrO2cZQY6onnPEL
 OQvRHdns3/CxirWZ+D9xWI3sQEt2vWGEn8wa24g2X8hAme1eD5T7Qs/fVoRl05G+MsZ8GCs/ptAWp
 GwG3vcBcAjwH/v0tFu3nj/or4gRQVxk7CWMMk+PP832Luxc28KmlVywk7PBSzuYEShcSCQjto1wAm
 oUYcG65MOPbw4Ac6PWzFM2bcEK+IqqOU9hnCebllugqgWsbFJVuscH8hwROFUmz6juqb1eRs8k9B/
 eTn5MVBevliXR6jioQZKh6+ay6j8i2smRxLHhGoRmin1Et5vIhsoI5xudZcsCAxulgywjFLF0gzUw
 8fF0akZcpUf2WeFm7yjNQeoRE3gNsBrK4L8C2JUdcGFy94U4zHKTG+FWTs3oQp1DVR5C1Z0b9or/T
 hxUbcA19Mnsc51L5H8NuOwp57QOKwiL+mFUE591rs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6K-0008jM-6O; Fri, 12 Jan 2024 12:57:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:57 +0000
Message-Id: <20240112125420.514425-66-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 65/88] esp.c: move non-DMA TI logic to separate
 esp_nodma_ti_dataout() function
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

This is to allow the logic to be moved during the next commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index dd6bf6f033..97e48e9526 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -697,11 +697,38 @@ static void esp_do_dma(ESPState *s)
     }
 }
 
+static void esp_nodma_ti_dataout(ESPState *s)
+{
+    int len;
+
+    if (!s->current_req) {
+        return;
+    }
+    if (s->async_len == 0) {
+        /* Defer until data is available.  */
+        return;
+    }
+    len = MIN(s->async_len, ESP_FIFO_SZ);
+    len = MIN(len, fifo8_num_used(&s->fifo));
+    esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+    s->async_buf += len;
+    s->async_len -= len;
+    s->ti_size += len;
+
+    if (s->async_len == 0) {
+        scsi_req_continue(s->current_req);
+        return;
+    }
+
+    s->rregs[ESP_RINTR] |= INTR_BS;
+    esp_raise_irq(s);
+}
+
 static void esp_do_nodma(ESPState *s)
 {
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
-    int len, n;
+    int n;
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
@@ -743,27 +770,7 @@ static void esp_do_nodma(ESPState *s)
         break;
 
     case STAT_DO:
-        if (!s->current_req) {
-            return;
-        }
-        if (s->async_len == 0) {
-            /* Defer until data is available.  */
-            return;
-        }
-        len = MIN(s->async_len, ESP_FIFO_SZ);
-        len = MIN(len, fifo8_num_used(&s->fifo));
-        esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size += len;
-
-        if (s->async_len == 0) {
-            scsi_req_continue(s->current_req);
-            return;
-        }
-
-        s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
+        esp_nodma_ti_dataout(s);
         break;
 
     case STAT_DI:
-- 
2.39.2


