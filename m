Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97F853B8B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 20:48:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygx-0001FA-9t; Tue, 13 Feb 2024 14:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygn-0000mU-9n
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygb-0006Uw-4s
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3mv2UQoAA8iNjt3Y2Y/V81trk2GrrhQGmIBesJpxTBg=; b=rkXG3o+rwBMKCdeidVS5A9Movw
 bi4ts5diyoTbCRSAWimFdjvM4jH8v+eqOPoq7l1Fo84gnAZdCKuwz+hcp3Cuq9+fmnzaq0Mi+2jt0
 zdpM4riXMSF8liv30BLUDmx5fL5dtG7UiHxkIkMT1i1961iJqU0X/FKBTCgceNWsbuf8OPOBXcHxI
 7P0grWWU0jjX97F/J2sZmZ5UE4fW6iwWO10S5hrXnIOUEh/53831Tp73lHAzv5oM5q9oP/pTcEm/T
 75Ld6xZDH+w26oKJTvLhIltj9d5lpukPS+npT/RGKxNQ9eLUV2HGY6PFBY66Y3PvgR3ikT8fLzJ3g
 4SKsMe71KEGPhJgUAWo9cTKru31ljIcpVQwtsEuIikukjz3JBD7qtAMww8PYmMt5Uo+8cEleuSFpf
 ULjThvCab4XjUAhgecke0xVwRWs8kbsqRgQxXVWxHmEXWzqjTZZWaB3A1ru6US+pLhai4jIY3Lg6f
 CghU5gazBKavRYKM4JdbssUtUbo7hlWNwWxckKz2Y/SJG/XVagy7bjMtZRLFTYlS+Wr0kAcZfO5m/
 nvSb27JcbJpJ6fVD95VZYQExR/m+3lzGAxZPqK2z8ygIPtWfdKdfhajop+YMwkl4q/8wAidCLwUQl
 aba5ubn2D7Mfc9lJIkzRGtSTBrd3RuwTEra1yZ9lY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfm-0008m4-5k; Tue, 13 Feb 2024 19:42:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:02 +0000
Message-Id: <20240213194052.1162753-39-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 38/88] esp.c: convert esp_do_dma() to switch statement based
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
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-39-mark.cave-ayland@ilande.co.uk>
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


