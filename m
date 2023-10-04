Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470757B7A43
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxP6-0003xx-HN; Wed, 04 Oct 2023 04:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxP4-0003xW-Si
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxP3-0007bI-Aj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZ86OMPpMlnB3D4ENs44jqarXK1astQH1B1zhzFrNbM=; b=kEXvufS79XOYWgdD9NBRlQHiCt
 tKZl4U5H1mdMAlDViP9N1FnimLyw9qQeLIQH1EeVS8gpOE7t7QJp61rXCNAgA0DTTS4r4TN3HoJMJ
 mrZXtN62JeFux4mQN0SvUMxTFot3mblP4PAuMRG+ddHAsBMr52IyxyOyR+ROjy0/jgXpSg0gPQipE
 vXFk7RepJK57UQmvVCA2jxmt+hibITjaUJrzXw5DmlE3n56gcjttQy+rff5sdUr432yieailhF1vN
 M25PppBavISg+e8G/TRSbID4QaRfUWdHPvpHY0MqlFxsdahZfJNYiW/JVSZlNMuk8U1Cv9zkLFX+a
 1qqSN6hx+S+dQw6dE0ZXFWaLh4CFwiAxAgnqD7FCxe4yjSGgHir/N3P1NPOTa7EamscNY79VUxSYN
 rzG0cidDm845fzjjXbDkvhahK4Nxz64684EZgD554Q7uoFXXq5Z01zBvVN5Pa1lpqzPuPxAHCL86t
 ckoU6Y5B53rWNE9NR54AzTKaHE5HiWlRag7V+OgOxXOQylAR7TMqLBDhqlCKucETpm3FJv5R2TWhP
 YE5bUuSrPMeZ6Pbeu1kWMYk0XNeiN1dtSENbB3RID1xbpk3rgYV5LKe9BsJ6x45UiREoj5idOrvXI
 J86CXSlq48iR7Cg2Bq4sAbSmjOfpNmvLnZI0zn6K0=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOo-0006za-GD; Wed, 04 Oct 2023 09:38:34 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:37:54 +0100
Message-Id: <20231004083806.757242-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 08/20] asc: generate silence if FIFO empty but engine still
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
index 9084708eaf..0f36b4ce9b 100644
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
@@ -642,6 +658,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
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


