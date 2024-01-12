Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6182C05A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:02:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH5w-0004ef-0H; Fri, 12 Jan 2024 07:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5r-0004RD-K3
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:03 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH5o-0007nH-PU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9pl16iNldZ9IF0y564sSpZydusQK9ud+WmO8TtyxMWE=; b=qXadWR3PB43BNg4FyaWASBvlGB
 j+966r/CoMkdM9FudgsqJ1xKfc41KNYJzH7bu4nc8uvX4npfq6zVBusyN/QpoGG64UcwWAlKMEj3r
 rimbwT9T1JerKJFQhJPa+eHTO8nkd4BKbV8b4MnEgv8XhVPoI9/7oYpIKrVw956HKca5BJqVSTkzB
 YqlI+aKlemjJCOTpB4Vh+mMZ6KLHe4YtjBcep+GKiX/sEJF9m4iafJZOYAxmAUlRkx9jdXJWCkogL
 c9Ws+la+nu6fi6MltwJ9ifyaml3XBqUGBMufRP9VHYvUi08d41/ptA7VDnDj/uV4pU9dMku5zZQzU
 uGv8fqNUuVCSFbGdlZH/Eg9uYJkGzvat4blT+yTnfGdenty+kmezdVER+jQi9DKNlQPtL/E0wiSE/
 wF/em2U9d14UCUi/QJcTKVY0HsGEocDg+pwcKB8BV4duhKbIPBT0CATOWBEfsRzLbg8PGj3uUxnZm
 R4QMsoIe9Upr2l3RzYrEADAev8u9VumVsyU4mT6Qgt4o59Ya8Rg5xMYM/Mok4+Ngsp5Spdf7OQWtN
 N52uganedhWa32c3zR921c8WcJTStwZxx62fpkp92ETSdJ6N3SzbMuj4JsvQ54oPYMUYt2NFNAgtv
 29lDNJx9LlChHxRhcsyNRIPQq+JX9uqFeZgRQh90s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH50-0008jM-LW; Fri, 12 Jan 2024 12:56:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:30 +0000
Message-Id: <20240112125420.514425-39-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 38/88] esp.c: convert esp_do_dma() to switch statement based
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
 hw/scsi/esp.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index de8d98082a..67d1d39db2 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -626,7 +626,6 @@ static void do_dma_pdma_cb(ESPState *s)
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int n;
 
@@ -681,17 +680,19 @@ static void esp_do_dma(ESPState *s)
         }
         return;
     }
-    if (!s->current_req) {
-        return;
-    }
-    if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
-        /* Defer until data is available.  */
-        return;
-    }
-    if (len > s->async_len) {
-        len = s->async_len;
-    }
-    if (to_device) {
+
+    switch (esp_get_phase(s)) {
+    case STAT_DO:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+            /* Defer until data is available.  */
+            return;
+        }
+        if (len > s->async_len) {
+            len = s->async_len;
+        }
         if (s->dma_memory_read) {
             s->dma_memory_read(s->dma_opaque, s->async_buf, len);
 
@@ -727,7 +728,19 @@ static void esp_do_dma(ESPState *s)
 
             esp_dma_ti_check(s);
         }
-    } else {
+        break;
+
+    case STAT_DI:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0 && esp_get_tc(s) && s->ti_size) {
+            /* Defer until data is available.  */
+            return;
+        }
+        if (len > s->async_len) {
+            len = s->async_len;
+        }
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, s->async_buf, len);
 
@@ -762,6 +775,7 @@ static void esp_do_dma(ESPState *s)
 
             esp_dma_ti_check(s);
         }
+        break;
     }
 }
 
-- 
2.39.2


