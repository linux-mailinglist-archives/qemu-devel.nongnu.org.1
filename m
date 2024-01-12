Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 336AC82C0A0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:14:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOH4s-0000qR-Ua; Fri, 12 Jan 2024 07:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4p-0000jB-RR
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH4n-00073T-3h
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4rPKcFLbX8niKpWjf2P8IvVU6A5UW/0xlz5tWOi3+k=; b=kIyF1TcoOvMnkuaX01cYS99Bpn
 xk1ZmjGmkTYx68IreI3a5m48bi44d0tzmSg8Ybj+oCybI44n9x0Ig7nGlwrcsOqEqCm5VzpchOshX
 a51Kgx6Nl83gtxXQXBodHIGTPEUCiLCYvh9HYP/UkRNyCzgHMq/W1yfp3i70puR+BiKyky72ZQRcF
 AHwAmVu4MvszVZK21zThfcaHqHow055hzjTLlZBLJertyXlPO9p/gnwk2ngF13t/fcfY+RhGEY846
 SsGlvngtGXkO3osHl6uFDQT5ObxXlLHS77y+pze/L/ezVKMAHRd6jnHDUEwx2/ViRr3oKeLxP3Nx2
 QBUoa1YV7u8rgMZLPL6zw9fQZzVEqrxhQC+Ri9a8lsAdggCCLiD/CFVaEJJsue7GQQUz6amfUWOIT
 lRJdZfXwCoUrBGAPueLgHxPqHm0Qva8qLBCP1+eJy9Kif0fyiyAV6sJLhnF6VkIrbIVe+e3E4GByI
 +Ykr2yRo8SGm4k5WSeb+h6E16wrTVKkNjCM6q/SnNpuVdFFPojJbf3U2qtFyszgBc/VZbglodMLmU
 mff53vfVy1ZDbh0PFlB2gVsy8rqNH89R24D8iup/3VVltJvVoOBunuS/dC34NAYf2Y8WvzIDzZyfx
 viE0axamDU6OyXXWm4aqR0T6AfU4SHTxgsFctwM1Y=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH3v-0008jM-WD; Fri, 12 Jan 2024 12:55:08 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:10 +0000
Message-Id: <20240112125420.514425-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 18/88] esp.c: don't clear RFLAGS register when DMA is complete
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

The internal state of the ESP sequencer is not affected when raising an interrupt
to indicate the end of a DMA transfer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index a4a1f41a40..5b9c3f1e5e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -546,7 +546,6 @@ static void write_response(ESPState *s)
 static void esp_dma_done(ESPState *s)
 {
     s->rregs[ESP_RINTR] |= INTR_BS;
-    s->rregs[ESP_RFLAGS] = 0;
     esp_raise_irq(s);
 }
 
-- 
2.39.2


