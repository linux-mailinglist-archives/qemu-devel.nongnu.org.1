Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB382C028
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:56:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3t-0007fx-E0; Fri, 12 Jan 2024 07:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3j-0007dx-Td
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3g-0006OW-VC
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LrtHaOwavcENjDXgLckDEnbzM2gGcemUsTqaptRr640=; b=ruFMKuLlD3sIvbdkfO18SF7PRG
 XBr083CyZlTsO0bBYU3JUeDsVDHqZJKvJCMLiZcd4urzbgCnADrkNXZbiCEjDQqppJaJ4fv8g6uCu
 1tqmAcA69Ja4AE0ePMSxUX18Wgc9kZ6251g4U/Gzrx4h2mt0FQR9S18hG4tOjmD0NyIJjAEuuNZ1S
 /DkKoccLxLw5kMFapZj1L2IQVtDbA0CZQ4iJoTHVeINlhAlVFbI7kcx9DEkC5QDoB54sK0DNQ+r25
 Gf9wdKV5KCcW6YpDZmQF3PNnoInbxzE7Zfi//lMiv1pxBa0g5Ga1Z6xvROjzgxgRGA670qC408SDz
 VLOqHqUn31exalzJtLIKvWRJTWomId90CTi87BrNeG9PjxlGaW/5duInA73k4OeUTVVoMmUpjYc5p
 t+DC4kM561zK4+O6mF3luPqMoWAE87W9UgPl1TCSS0RICw42Ao4s16dT+36KloDmHZknn19U4S4yq
 46QhYVJBGWlwxhOHDBYKK0vGcOWM9cv8Pdt00E2xhETLajOeiAl5+iLJsJeEMe7Wlx++Q/+9j/3Bo
 jJ1YrfMsQqF5KPi10EpSwG07o2tFASeFEu/9m0ToBs7NqvuRj9kMWZ2rjtNNqqlpRrz1bCuErRrcr
 5uTVYgYmd4OjOYcWwgZA/OhA1KEp0ckg9zzXxZAqo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH31-0008jM-5K; Fri, 12 Jan 2024 12:54:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:55 +0000
Message-Id: <20240112125420.514425-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/88] esp.c: add FIFO wraparound support to esp_fifo_pop_buf()
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

The fifo8_pop_buf() function returns a pointer to the FIFO buffer up to the
specified length. Since the FIFO buffer is modelled as an array then once
the FIFO wraps around, only the continuous portion of the buffer can be
returned.

In future the use of continuous and unaligned accesses will advance the
internal FIFO head pointer, so modify esp_fifo_pop_buf() to ensure that
any wraparound content is also returned up to the requested length.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b382865426..8d8f6a817a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -121,17 +121,30 @@ static uint8_t esp_fifo_pop(Fifo8 *fifo)
 static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 {
     const uint8_t *buf;
-    uint32_t n;
+    uint32_t n, n2;
+    int len;
 
     if (maxlen == 0) {
         return 0;
     }
 
-    buf = fifo8_pop_buf(fifo, maxlen, &n);
+    len = maxlen;
+    buf = fifo8_pop_buf(fifo, len, &n);
     if (dest) {
         memcpy(dest, buf, n);
     }
 
+    /* Add FIFO wraparound if needed */
+    len -= n;
+    len = MIN(len, fifo8_num_used(fifo));
+    if (len) {
+        buf = fifo8_pop_buf(fifo, len, &n2);
+        if (dest) {
+            memcpy(&dest[n], buf, n2);
+        }
+        n += n2;
+    }
+
     return n;
 }
 
-- 
2.39.2


