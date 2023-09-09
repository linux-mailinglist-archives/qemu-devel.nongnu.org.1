Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986379972B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuaW-0005ko-Pe; Sat, 09 Sep 2023 05:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaV-0005kK-Fg
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaT-0005Iv-C7
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AA8s1jLClq+X8IUUxLYTPVljty8wsZNJ4UerQIUqDwI=; b=OZ2OXTEiG47k348JDgLeVU9m7I
 KBQkqiQCrWhALHCzkz1x2IZ48rJgE/3OsDJU43hwwuUSnZj3vHJI5a+xEvQqEkR/4G/TFdFdp6iHg
 tjCQC5PaRtggu1mLQboFxoVT2GY7L5BKGKIG2Okua9QaAhoDuQwCKjQzUhxTXn0Tf0LStwd3ZZC9g
 nGrnGns+FcYSYwOXSrmWeFmXjtvdzpAdhqGwNOlK+MRykKTYBL0BNdxo5MtXytE1cgr8zKjgbL1NU
 j+5Nzr1/xIoIHvbRzlVz8JUxLnRPnFLr0EevUtcOvYuE4PSs9uYa2Ht6cVFlQj3VqkEq5I7h/nGDe
 ZspIIgkIUai/YSYe6c2cWOUPo7azOCUMpuCfc90VzpR2KgzAdMnJsWuEZ5rbOnBIVYWpSI4vbAkrd
 bFwtomYnQnfMZN4tmWhaQCCPE7PqZPyaJ5y8/M8Xmvg7cdJvuc25WgwwLfZpxPjb1484mkvo/iRuy
 gyoE89Aqv+k4za4m4lH3Jhbg2Q5UN9ixA3RJXbEbLDhRGSZp3p127MZaFUH2YoYTSxSKa06xsfmEQ
 8cPogrQQ/0lAIXrgfLKrgyCoQbtaB7Z0nDHuVB+yjbCMe+onPVBidyOHkg/j3Ljl0Qgoem0ropSxF
 bZELfa643NgUmlezXpAsZUsi0TIUEt+7spumNJjWc=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaN-0000uO-88; Sat, 09 Sep 2023 10:49:07 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:15 +0100
Message-Id: <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine still
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

MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
been written to the hardware, and expects the FIFO status flags and IRQ to be
updated continuously.

There is an additional problem in that not all audio backends guarantee an
all-zero output when there is no FIFO data available, in particular the Windows
dsound backend which re-uses its internal circular buffer causing the last played
sound to loop indefinitely.

Whilst this is effectively a bug in the Windows dsound backend, work around it
for now using a simple heuristic: if the FIFO remains empty for half a cycle
(~23ms) then continuously fill the generated buffer with empty silence.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/audio/asc.c         | 19 +++++++++++++++++++
 include/hw/audio/asc.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 336ace0cd6..b01b285512 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -334,6 +334,21 @@ static void asc_out_cb(void *opaque, int free_b)
     }
 
     if (!generated) {
+        /* Workaround for audio underflow bug on Windows dsound backend */
+        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        int silent_samples = muldiv64(now - s->fifo_empty_ns,
+                                      NANOSECONDS_PER_SECOND, ASC_FREQ);
+
+        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
+            /*
+             * No new FIFO data within half a cycle time (~23ms) so fill the
+             * entire available buffer with silence. This prevents an issue
+             * with the Windows dsound backend whereby the sound appears to
+             * loop because the FIFO has run out of data, and the driver
+             * reuses the stale content in its circular audio buffer.
+             */
+            AUD_write(s->voice, s->silentbuf, samples << s->shift);
+        }
         return;
     }
 
@@ -611,6 +626,7 @@ static void asc_unrealize(DeviceState *dev)
     ASCState *s = ASC(dev);
 
     g_free(s->mixbuf);
+    g_free(s->silentbuf);
 
     AUD_remove_card(&s->card);
 }
@@ -633,6 +649,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
     s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
 
+    s->silentbuf = g_malloc0(s->samples << s->shift);
+    memset(s->silentbuf, 0x80, s->samples << s->shift);
+
     /* Add easc registers if required */
     if (s->type == ASC_TYPE_EASC) {
         memory_region_add_subregion(&s->asc, ASC_EXTREG_OFFSET,
diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index d9412815c3..4741f92c46 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -68,6 +68,8 @@ struct ASCState {
     int samples;
     int shift;
 
+    uint8_t *silentbuf;
+
     /* Time when we were last able to generate samples */
     int64_t fifo_empty_ns;
 
-- 
2.39.2


