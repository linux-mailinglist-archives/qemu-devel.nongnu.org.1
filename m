Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B6382C03F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:59:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH45-0007it-9m; Fri, 12 Jan 2024 07:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH43-0007iN-GY
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:11 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH41-0006mn-IR
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UWy1SFEHPyFakfRqBUrdjQtvIxVgd8l6c3BoIPJD0R4=; b=tl5yYtt57Xrqx+DZZF2tP1HxJj
 vPNiwTA0N8/WRavufjXFb6YrWKbXskQ4h87YjIiwMVoxfr6oiTm3EMSGZ5Yq02LcJzccJDRiE+ONv
 0d2DIqz6eCaVHaXNu7ZPVQM8uhw5LQz/pGJ/4ZBLh50aXWbiszXhf0Um6it+eSa19DASvdhK/rE+z
 Q8qroW5JvVFlp6S/D4qYcYls/P94OGs1J0hLi3bCmwO9HYJD17pNOAUAhufT89VT1sTpCNzGUioyj
 uOykA1J1ZYxDqyAoKrqpNIB17jdgQbLN+mRcIW0s0KemqyJ0Y+qDbSr+0wH/8lGBSAWuGccDzc2gJ
 Ycrh+6PP97SauVSfC/147KwgMXuJlqPhOtoABW/UKBg+wGhY07DYfTtO4keN//9X3mebzyJ7Hfedj
 S3EHFqUzhZLDVxBrFocZFW+gxhalqTiypyIq8SlaWzWTi8Qhn0Wgi8rBspx/Xyu4TbR6aHAa8pQgp
 tg8cOq8890V5JrPBFOmNG4Wv6Ts/mG+w03i0hdTk127vuEAOxl/OZ8NSizsKKyUB3RYUMM/oTrjgL
 SYwVVk/YE2jvzre4bASD70dnj/SNR72FBjy7Om5Kx3QykmjsEN+V//JsOkcFKx3RLXQcNuCA66Ehz
 m726Cq0uQmiN4KdApM0OmOncVcEE+7VKKXsLR2Xpc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3N-0008jM-60; Fri, 12 Jan 2024 12:54:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:01 +0000
Message-Id: <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to check
 for TC == 0
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

Invert the logic so that the end of DMA transfer check becomes one that checks
for TC == 0 in the from device path in do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index fecfef7c89..63c828c1b2 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) != 0) {
-            /* Copy device data to FIFO */
-            len = MIN(s->async_len, esp_get_tc(s));
-            len = MIN(len, fifo8_num_free(&s->fifo));
-            fifo8_push_all(&s->fifo, s->async_buf, len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-            esp_set_tc(s, esp_get_tc(s) - len);
-            return;
+        if (esp_get_tc(s) == 0) {
+            esp_lower_drq(s);
+            esp_dma_done(s);
         }
 
-        /* Partially filled a scsi buffer. Complete immediately.  */
-        esp_lower_drq(s);
-        esp_dma_done(s);
+        /* Copy device data to FIFO */
+        len = MIN(s->async_len, esp_get_tc(s));
+        len = MIN(len, fifo8_num_free(&s->fifo));
+        fifo8_push_all(&s->fifo, s->async_buf, len);
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size -= len;
+        esp_set_tc(s, esp_get_tc(s) - len);
     }
 }
 
-- 
2.39.2


