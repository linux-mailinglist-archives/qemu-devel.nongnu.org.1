Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1978A82C06F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:05:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH68-0005Ak-E4; Fri, 12 Jan 2024 07:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5z-0004t2-Hf
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5s-0007sT-NH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=62bCXuS7Ab7j+3JsZ13NQqjjmERHQQn64Giv3KrN3Ik=; b=ls6c6+Hnbebv0AMVKIadIFswG7
 kbOO7h6qp3rqa7mtAWuedn10jzM6lgr95fTMAj/X7Ft5fUcws1FUA02wfPEQXj53dFCLB7CJ94nvz
 MvneAT7F1gUVQG1eKkzhIfmeFMEIBsCxajWGCRVjxlWcg4vrnxiWD4TphzPOK/Dpdh6ifzPD4W0Np
 xfe/ktQvfJ7ncDyzxk+3f8cINbpwK0huDYZRMJKcCEgORTsh5Pl0VNfbCVXs6LwOYXW3wXZ1gYgHw
 7E8yv8TU1tk9tnCFLaZI6Qcn3kE5Pqv4QtJyN4GSvE5XRcN2FEMYXpPfKZB236BEial0el08eftDD
 cbanaiOiSNDwJV1i9g9JaSEVFInhB+2r/Y9Mdj2MnOro1jnuhvODL16gpwoF8X2tcjZeu5sl6PQ1j
 irl7e5BeLbHaFOoRtiEPd0rGJIRyyY5QkjfRC2TSP4BGWdqJQA/Z0nWTo2n5ONbLC9iT7a6+22BbO
 9wujuk1B+Y8Wqwl1FFjzytiGJ0XYcyJ2Jo22d/7EdW1DPzqXb9PhyJTexwBwna8LdAXj6WWNCb3LR
 TcQWSTuBPP2zAQ1vivoN1UTQA085S4GJ6nVfeE3cKMJL5fmf/UEdVlMPSoi54JsQUqjnowOF7OoXV
 1ko08nGRUld08+o/beWVMP6ZUz1dEjKAKQ1a0ng+c=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH55-0008jM-C1; Fri, 12 Jan 2024 12:56:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:32 +0000
Message-Id: <20240112125420.514425-41-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 40/88] esp.c: convert esp_do_nodma() to switch statement based
 upon SCSI phase
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

Currently only the DATA IN and DATA OUT phases are supported.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 54 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f6d05b0de7..c1b44e5f18 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -786,7 +786,6 @@ static void esp_do_dma(ESPState *s)
 
 static void esp_do_nodma(ESPState *s)
 {
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
     int len, n;
@@ -823,38 +822,55 @@ static void esp_do_nodma(ESPState *s)
         return;
     }
 
-    if (!s->current_req) {
-        return;
-    }
-
-    if (s->async_len == 0) {
-        /* Defer until data is available.  */
-        return;
-    }
-
-    if (to_device) {
+    switch (esp_get_phase(s)) {
+    case STAT_DO:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0) {
+            /* Defer until data is available.  */
+            return;
+        }
         len = MIN(s->async_len, ESP_FIFO_SZ);
         len = MIN(len, fifo8_num_used(&s->fifo));
         esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
         s->async_buf += len;
         s->async_len -= len;
         s->ti_size += len;
-    } else {
+
+        if (s->async_len == 0) {
+            scsi_req_continue(s->current_req);
+            return;
+        }
+
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+
+    case STAT_DI:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0) {
+            /* Defer until data is available.  */
+            return;
+        }
         if (fifo8_is_empty(&s->fifo)) {
             fifo8_push(&s->fifo, s->async_buf[0]);
             s->async_buf++;
             s->async_len--;
             s->ti_size--;
         }
-    }
 
-    if (s->async_len == 0) {
-        scsi_req_continue(s->current_req);
-        return;
-    }
+        if (s->async_len == 0) {
+            scsi_req_continue(s->current_req);
+            return;
+        }
 
-    s->rregs[ESP_RINTR] |= INTR_BS;
-    esp_raise_irq(s);
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+    }
 }
 
 static void esp_pdma_cb(ESPState *s)
-- 
2.39.2


