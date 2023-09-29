Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CFA7B3989
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHmf-0002xn-0Y; Fri, 29 Sep 2023 14:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmb-0002xB-4w
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmY-0005di-UT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3kKqZugEfEHGzQ2tS1CcD3nZQNmUXDPcM5fGBBF2aLs=; b=ATvwWhg+qkfIwZpJQEjtUEYJoJ
 r2BWUixwnXHfNOfpN8r1tJnNP0F+cNiXBQsJu7v0z/4tZiQMNhRnXtbkefzD84Scg97+sEsTjM8Rm
 r3tx5lNFLSN4aHK3jMDacORW51Q2ZQCEYJXIBscKv9eOuWIq3aSDRVLQuVBa/YbhWWIipmJ1vXGAo
 x0cU9Q2CHlUTK9gHVSeIlJ7uSEZyFI6+03BuRwJmQ3mcwhLDoUK5B8QRoIYty+7NYImrSM1vYDE+U
 AIeZkZ9WTKKdXL2a8WJWUQR13RNKY/zmdieuKv0hHoNK50P0m6XMofEwhod6yIEF/rkiryE1XQhtP
 Sydw61kFprklsk8VfMsOp/H9hqF/sf5VU29KLU42zm7qX0b6pKUwqvPx3vFwhGlzHUSEZ5l2i9Buv
 fIhR3p7xYeDyN5OZXfSOPm4D1uD1uT2wGdvu/jSQrq14L0Q5PkDn8LOYU9f0Vq6BsqAVXWfBBvYKw
 8LjXOwGVAmd+bPjTviV6MVYeaihMe01fQiXEE3SqA6PIB9eZ/43hyDwLPdODTErqp6K6B2DzkluJk
 FA6hkuCjexubZ6gC2AwWKpfrmnZYXrXDCk129n5yc/IqXANYj4po2CTM/lnN3hcWIz7io8krWxI//
 OQCsZvyIwacIcI1+VXFpcUbKrFQPHB1XSVYMsFE4M=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmL-00033Y-4o; Fri, 29 Sep 2023 18:59:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:05 +0100
Message-Id: <20230929175917.511133-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 08/20] asc: generate silence if FIFO empty but engine still
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/audio/asc.c         | 19 +++++++++++++++++++
 include/hw/audio/asc.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 54f288c6f9..213f349727 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -341,6 +341,21 @@ static void asc_out_cb(void *opaque, int free_b)
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
 
@@ -618,6 +633,7 @@ static void asc_unrealize(DeviceState *dev)
     ASCState *s = ASC(dev);
 
     g_free(s->mixbuf);
+    g_free(s->silentbuf);
 
     AUD_remove_card(&s->card);
 }
@@ -640,6 +656,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
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


