Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F982C07F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH62-00051L-VU; Fri, 12 Jan 2024 07:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5x-0004oX-D0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5p-0007oB-HA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4I3vrCruvicw8FrV1AtQV3HKf1cbfLoGPnBOCRBxK8I=; b=Qkszo023LJyvLeUUdX4mTfqLD7
 R6xojjx9zNEKsv2XqJ4Ck/qbRmBHIIWu8SqOJrXGHb0kLVtSIVKRW4xt/cAqm0j4CkALllcd8z3Zv
 pGBgdR9NI4ERJ2BAdoHNDlPpAM80kfz83rO7odSGRyQGglGGVIBTX4VmVUGzDY5sgYnWjDQgZW5D8
 L062B0mTXEwN+RcBegOoquueaex2c5vfmgIulTYp7+oh/SoFu9TBJ6Z3gprXvMGWj51dO67iAeAi1
 tntqfOGggCuK6Y1QFUYlWQ7XILZbvp+cd5P+ByG9HXx/xkUfvhndnGEtjfuD5qcEuRc3R+0ua0eR+
 GJHl7V5FH9qdhMrzQk4kY59pKxNkvXO5VJ9oWm9oUMRBTDXDEMezk8KfuzyzuiGR4V8xI6vKIiso+
 yb/LZLYSmkbfvwGEvD3N2yZFvMJGjCLmMNpulkYmxS3HAwZqjMa+nMLQm6bHz7XZg0K9SiwdnL8e1
 qsxBjCLuNE+3w+946S9zeD8P35q9k7atRfyQGQIkfmdwfAi6ySapkgIteJB6xVsRb/HmDGzP4ljnG
 P6dI5GKL1aWT/1mwWJNQ1ziffKTWqfdD5ILo0YWpSAwS3CM6d+99GIME3o/i1HkmTStFAG0Xbgvht
 WvG4a09tjta6r9WeYkHXAoCAQtsTjqdqHq8utomQQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH54-0008jM-V9; Fri, 12 Jan 2024 12:56:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:31 +0000
Message-Id: <20240112125420.514425-40-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 39/88] esp.c: convert do_dma_pdma_db() to switch statement
 based upon SCSI phase
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
 hw/scsi/esp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 67d1d39db2..f6d05b0de7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -542,7 +542,6 @@ static void esp_dma_ti_check(ESPState *s)
 
 static void do_dma_pdma_cb(ESPState *s)
 {
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
     uint32_t n;
@@ -582,11 +581,11 @@ static void do_dma_pdma_cb(ESPState *s)
         return;
     }
 
-    if (!s->current_req) {
-        return;
-    }
-
-    if (to_device) {
+    switch (esp_get_phase(s)) {
+    case STAT_DO:
+        if (!s->current_req) {
+            return;
+        }
         /* Copy FIFO data to device */
         len = MIN(s->async_len, ESP_FIFO_SZ);
         len = MIN(len, fifo8_num_used(&s->fifo));
@@ -602,7 +601,12 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         esp_dma_ti_check(s);
-    } else {
+        break;
+
+    case STAT_DI:
+        if (!s->current_req) {
+            return;
+        }
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
         len = MIN(len, fifo8_num_free(&s->fifo));
@@ -620,6 +624,7 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         esp_dma_ti_check(s);
+        break;
     }
 }
 
-- 
2.39.2


