Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2C582C04D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:00:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH3w-0007hZ-8r; Fri, 12 Jan 2024 07:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3u-0007gy-Go
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3s-0006Vv-7o
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RVoheZPunkRsW7VL3P4H+EBYLDchD0JJLbv2AiQ5eLw=; b=GC6qrqwOjbewwjktQ8qKPxrUko
 4NVqnEfdfSUZ4y8c+VOwmuqrgUyrGS2OqY+Vy25TrNX+hu0jCn8eQQxq6Mrwx9g7ovWd5sSozgjeE
 AJYN7piLNV5TAp3NW5rZaw8lVUOVtrQhANI1SKevLg3wT+FpJA9S8OwGU1q1tqS4Ab7yZziO6A+aC
 GQhja3ORjM/sEDnqRuGv/22DvLRw0QnG4h6/y+l8XtfiJpYk7HsWqTZPmt0DbB/4oTP2xn7AIV1Wa
 o4CePpQZa9hxZayR6G7LAOGJdtiOYjBhdrkdKz00lBQe0r3aDj8jRxvMjhI/Ra71uuS8zBWGgmh3f
 09rWNOnv0hrH0E7byDjT40m4LcByb/xqaWD95wGQiCaKoPmR/HUkxacQK3jja51HV6cZ/RsC1Ic8J
 KSc06nk+XF1xyZMXv70XqFfm8L0Vg3OKgpWjv6IKogfyCdULNUgiY4XK9c9QmyEVtXQhr0RUGo7BJ
 asCTJNQHjn9wvutNJtzGJqn9pSKNzTS3BvXN5DweJqTJI7VoTHGLyNXFsDHk4LM090MRy8U6SR521
 gSuR2pcl6Ol4K/RBTkvUhA7gaY/FJa7QIbMTyHqLgePMbvmnDO1hn2bILSMW3VVtiWxUd2Z20nsJ7
 qKembai2HbgwsuvLxCn3KwYS43DFzHFrsA1Rau6mM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3E-0008jM-Fb; Fri, 12 Jan 2024 12:54:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:52:59 +0000
Message-Id: <20240112125420.514425-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/88] esp: start removal of manual STAT_TC setting when
 transfer counter reaches zero
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

This should be exclusively managed by esp_set_tc() rather than being manually
set in multiple places. Start by removing the occurrences exclusive to PDMA
and command completion which are those that can be currently removed without
affecting any test images.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c7b79a2949..e717b2e216 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -611,11 +611,6 @@ static void do_dma_pdma_cb(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
             esp_set_tc(s, esp_get_tc(s) - len);
-
-            if (esp_get_tc(s) == 0) {
-                /* Indicate transfer to FIFO is complete */
-                 s->rregs[ESP_RSTAT] |= STAT_TC;
-            }
             return;
         }
 
@@ -720,9 +715,6 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-
-            /* Indicate transfer to FIFO is complete */
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             return;
         }
     }
@@ -870,7 +862,8 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * transfers from the target the last byte is still in the FIFO
      */
     if (s->ti_size == 0) {
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+        s->rregs[ESP_RSTAT] &= ~7;
+        s->rregs[ESP_RSTAT] |= STAT_ST;
         esp_dma_done(s);
         esp_lower_drq(s);
     }
-- 
2.39.2


