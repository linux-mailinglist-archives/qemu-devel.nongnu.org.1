Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BE1887E9D
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Mar 2024 20:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMK-0007us-Au; Sun, 24 Mar 2024 15:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMH-0007u9-P9
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMG-0005NE-BK
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cyr38K6bXWOZTNFEzg3zHFck8OrFkwBPav8q251PP5s=; b=mCrpIIxvJre3ToBWH3D5XMS0FL
 rJS2F2pDgmQEewYXbEzORPXKwCGKuyeaK8c2pSjFgXg+0vfMzcGMblXzSyF4igmqIfhjqvc7VKW0r
 Qb1NrjFBfBe1yem+bO07O3/0APJHzkoIlPveTssakg+oU2jJdc1gglo/JTUe0pHCBf+1gdFzpUAp0
 XbfXWiRNX/pi7SETh6ODbDHw/dg3SdeXP4znXL3ENoUhy7D0MtrZdyDFkCxuHx8Ykamwvq+NxT6/8
 tL4YBCjQuTg3ujwzCbAU0knCfSDUpIrpuIESFQoTTH9xnzPGddu1BtdXP3qjBXMfuLfPowo+ZaS+n
 nc4IJQWzBqY4N7ubNxk9HXDIDwmRphIpZZKDQXYsNKVPf0CJws24cdPrV0cOtWWST3y9xulJZZqwD
 ctNhCVFBs23eWgxkYGNREcYx5pP3Wkht2/R4R+I5ypY81MpXINNFonaU0wc5OYTWM/BeZagYJ19gY
 RaBNCpvVtY58xZEHz0LO8dMLCgD/J45LVas/rbMOZvax88J0LndUH23DlpH4EX9T8mRzv38GLS6Zk
 8saeSlgOR5G5X9XRWeWMwVZWFaabocnJ1pEjpUHyAwU8yDF3QjihdOrV1JSsxDi3N4DxfICEuU7YV
 yy24ioSyX8xzzdt/kKvAcHHf2N6mEl0S8MjZo0Lz0=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLH-0000dj-Tk; Sun, 24 Mar 2024 19:17:19 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:03 +0000
Message-Id: <20240324191707.623175-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 14/17] esp.c: introduce esp_update_drq() and update
 esp_fifo_{push, pop}_buf() to use it
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

This new function sets the DRQ line correctly according to the current transfer
mode, direction and FIFO contents. Update esp_fifo_push_buf() and esp_fifo_pop_buf()
to use it so that DRQ is always set correctly when reading/writing multiple bytes
to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9e35c00927..6fd1a12f23 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -124,6 +124,48 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
+static void esp_update_drq(ESPState *s)
+{
+    bool to_device;
+
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
+    case STAT_DO:
+        to_device = true;
+        break;
+
+    case STAT_DI:
+    case STAT_ST:
+    case STAT_MI:
+        to_device = false;
+        break;
+
+    default:
+        return;
+    }
+
+    if (s->dma) {
+        /* DMA request so update DRQ according to transfer direction */
+        if (to_device) {
+            if (fifo8_num_free(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        } else {
+            if (fifo8_num_used(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        }
+    } else {
+        /* Not a DMA request */
+        esp_lower_drq(s);
+    }
+}
+
 static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
@@ -137,6 +179,7 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 {
     fifo8_push_all(&s->fifo, buf, len);
+    esp_update_drq(s);
 }
 
 static uint8_t esp_fifo_pop(ESPState *s)
@@ -180,7 +223,10 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 
 static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
 {
-    return esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
+    uint32_t len = esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
+
+    esp_update_drq(s);
+    return len;
 }
 
 static uint32_t esp_get_tc(ESPState *s)
-- 
2.39.2


