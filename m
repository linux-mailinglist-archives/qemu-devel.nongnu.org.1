Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C147BCCA7
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCr-00085J-I4; Sun, 08 Oct 2023 02:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCq-000842-50
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCo-0007lQ-Eh
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:59 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MfqCF-1rValx1dKj-00gIVt; Sun, 08
 Oct 2023 08:23:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 08/20] asc: generate silence if FIFO empty but engine still
 running
Date: Sun,  8 Oct 2023 08:23:37 +0200
Message-ID: <20231008062349.2733552-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nod/Hl+yXfnuP8JYoN5qjxrm6MUcX3vJDxWA01f3ZnFnobZenUE
 aAwzMQTAedUZDsi0BlnNPXCwtYMVk6fwpxSC2LB2wUhQxN7eufbHURdZUYpaS6/VMrds+pF
 Y8DBTFW0slGw95uGYXFDFyeCe5c47GxY/xKoJE6nV1BRRww12W/LSOopm7hEb8LLmwI7l5A
 lLZ9cKVCJJv02e11ZDqug==
UI-OutboundReport: notjunk:1;M01:P0:wOZBQy0lR2Q=;+K9KpUlZ9D6wkU6Jy76Uisv9U4G
 tu1FEfMtoxjl4S/r5FzqdteFt0nJ6p9xp6fS5wqKbXTI9aZ5TFmyW1S42IYjfoYzaL/CqioyX
 ZcWIVNwxE5aa0UJUvgdm3AZqsyQVKcnmggOMRQ+/pqkYI75lsqS5/q9kwoYdEvJi8238FWscS
 UdAt5FrzSnYUbpibQ6C5zCQJG5uNTVWiJFlKy0A7rtxfsD7DxCOXTWXeQI83WQiCDY8Mj5Uob
 RoPKsEPvYnmXpna5kxovk5fgEyom+9fVTxfTINGo9N0j/8f8TvXCDujNvwX10e8xZDULsZin0
 XaiDN15yQiKXgVYdSE6Q/HyrGmgX228Wz5Y4IJbmC2nW3euQShuOCCLZwJU5afJwIQGUn9cR+
 JWuBc4I4NXq2FpwyQWhjOWcB9JRDGOUawCYG9wn7V/hR0oPkeHRRpjTQQ/qaKxdaBaw38KblU
 YL9TKXBBL8AJ91AJmNkA/+8uPN7lZUMeDvbNg4xQrJUsLyOhb+bIe2uMDvMT378xYIsr8h9TX
 gnqpFFKHL9aRTn7LJHyLKIsmKFgiEkOAq9CeJrxYopNOA9RRqi74wWL424U7umnnwwkg/TP+i
 jKGYn1rT49r5iEzIXystAEifH1+WDMl4y1NibX/l4jEj9c+RHn+AF9WplXmrVBiHKANOrEEnc
 BmaOYSWlu2yfRW4tF2JKT5D5NeuxxVzB2kmOQKzvIkU1uUHRr7Vry24pfnTFyj+KeLCdkzbfL
 95F7CAfMc+gm/XjVN2nQGTZfXuL++UbV9GL91olR3pJV180yyDkOjV6FT7ANXUpctxXJ8ZIq6
 NGhDJDf3DlrVhIjsQjLBIE0nOOpr/hTDEoI7TL6ym/bzbOkGh1vQWQgO7QXuhAePk3fFO7RmC
 vyR/ki5Ls2ZjkOg==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

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
Message-ID: <20231004083806.757242-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/audio/asc.h |  2 ++
 hw/audio/asc.c         | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
index d9412815c324..4741f92c4613 100644
--- a/include/hw/audio/asc.h
+++ b/include/hw/audio/asc.h
@@ -68,6 +68,8 @@ struct ASCState {
     int samples;
     int shift;
 
+    uint8_t *silentbuf;
+
     /* Time when we were last able to generate samples */
     int64_t fifo_empty_ns;
 
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 9084708eafab..0f36b4ce9b6f 100644
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
-- 
2.41.0


