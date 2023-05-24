Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A270FFE2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:15:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmp-0003Qd-3a; Wed, 24 May 2023 17:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmQ-0002rB-Mf
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmP-00028q-4z
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z7enXzJkiwGsDmHfTS9mzVlu1dkU2r/QMHKFybHGZg4=; b=wciHGVq2JjEFczP+TQGepabt93
 IGmAU6GY/EBRqLa7A+uhdCW4wanJy2UtgT204E95JPDCOGzFAZZj83+80y1jy654OgiABAD0ZBAn6
 ucf77WhOtJ/T0H3cgKwE6Mnp0Swd8oO8CDjnZp5+es3DSwkMfkGRBfajXpo0hPC9Sy1DRPwjjIb8x
 3Wla0iiyUuTGCIWwbmq8+N/r4OIGorWBuvTl8ukIasownZ9leJbDvf1L/wnAATsrBTRsYKIoTFAko
 PGV9M2bEQkI1YuKlqFL83YfKJlB0QdEesHVnupCSXZvSqR+2ogeNIDq4FMP6KgthnJ8zM5xua0mj1
 6Wf+bYCO+VysP+3sP2BkFL0TZ4rL/JT0WlJTSa+T7ETtgKwoSFx+n/ljmO0Nu0kCN7wc4LHwQApIN
 dZClpvgJyi03oFcuTSJX41KMaexV0606c/wmen/WIeTSAk/De6d8kphYrc7C4QudiHtANf0HvP80b
 r48nhXZFAqXcEe0KVND+DcP5aNTwwvNiEprvQzIgQNol5EmwV1YQrl0L2yCtWLOwBNag2in8cSnJy
 bgJM1i4l06ewfWcY7/I3+/A5SaZMf4CIe7IfoVb3Nc6am94eq/1tBo4jsVLutI0LWVP779QxQwF3H
 nRmzHwaRamQLvd1moCyTwP7RwGMcRx58BGtleyWR8=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmC-0005XR-Tw; Wed, 24 May 2023 22:12:13 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:49 +0100
Message-Id: <20230524211104.686087-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 15/30] asc: generate silence if FIFO empty but engine still
 running
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

MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
been written to the hardware, and expects the FIFO status flags and IRQ to be
updated continuously.

Since not all audio backends guarantee an all-zero output when no data is
provided, explicitly generate an all-zero output when this condition occurs to
avoid the audio backends re-using their internal buffers and looping audio once
the FIFOs are empty.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/audio/asc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 04194b1e43..c5173a8d35 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -158,8 +158,10 @@ static int generate_fifo(ASCState *s, int maxsamples)
     limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
 
     /*
-     * If starting a new run with no FIFO data present, update the IRQ and
-     * continue
+     * MacOS (un)helpfully leaves the FIFO engine running even when it has
+     * finished writing out samples. Since not all audio backends guarantee an
+     * all-zero output when no data is provided, zero out the sample buffer
+     * and then update the FIFO flags and IRQ as normal and continue
      */
     if (limit == 0 && s->fifos[0].int_status == 0 &&
             s->fifos[1].int_status == 0) {
@@ -168,8 +170,9 @@ static int generate_fifo(ASCState *s, int maxsamples)
         s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
                                   ASC_FIFO_STATUS_FULL_EMPTY;
 
+        memset(buf, 0x80, maxsamples << s->shift);
         asc_raise_irq(s);
-        return 0;
+        return maxsamples;
     }
 
     while (count < limit) {
-- 
2.30.2


