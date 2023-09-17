Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8F7A3406
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 08:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhljq-0006vh-Hr; Sun, 17 Sep 2023 02:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljn-0006v8-QU
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:35 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1qhljm-000552-49
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 02:58:35 -0400
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
 by mailout01.t-online.de (Postfix) with SMTP id 5D1CA10125;
 Sun, 17 Sep 2023 08:58:32 +0200 (CEST)
Received: from linpower.localnet ([79.208.31.89]) by fwd89.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhlji-2mKRIP0; Sun, 17 Sep 2023 08:58:30 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A924E200209; Sun, 17 Sep 2023 08:58:13 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 8/8] hw/audio/es1370: trace lost interrupts
Date: Sun, 17 Sep 2023 08:58:13 +0200
Message-Id: <20230917065813.6692-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694933910-BF7E49BF-B142A45C/0/0 CLEAN NORMAL
X-TOI-MSGID: 99bbe9f7-0738-44ab-ad2b-b42ac29d903b
Received-SPF: none client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

It turns out that there are drivers which assume that interrupts
can't be lost. E.g. the AROS sb128 driver is such a driver. Add
a lost interrupt tracepoint to debug this kind of issues.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/es1370.c     | 14 ++++++++++----
 hw/audio/trace-events |  3 ++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 6d2aff57f2..4966f72ae6 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -602,7 +602,7 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
-                                   int max, int *irq)
+                                   int max, bool *irq)
 {
     uint8_t tmpbuf[4096];
     size_t to_transfer;
@@ -657,10 +657,13 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     }
 
     if (csc_bytes == transferred) {
-        *irq = 1;
+        if (*irq) {
+            trace_es1370_lost_interrupt(index);
+        }
+        *irq = true;
         d->scount = sc | (sc << 16);
     } else {
-        *irq = 0;
+        *irq = false;
         d->scount = sc | (((csc_bytes - transferred - 1) >> d->shift) << 16);
     }
 
@@ -688,7 +691,8 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 static void es1370_run_channel (ES1370State *s, size_t chan, int free_or_avail)
 {
     uint32_t new_status = s->status;
-    int max_bytes, irq;
+    int max_bytes;
+    bool irq;
     struct chan *d = &s->chan[chan];
     const struct chan_bits *b = &es1370_chan_bits[chan];
 
@@ -702,6 +706,8 @@ static void es1370_run_channel (ES1370State *s, size_t chan, int free_or_avail)
         return;
     }
 
+    irq = s->sctl & b->sctl_inten && s->status & b->stat_int;
+
     es1370_transfer_audio (s, d, b->sctl_loopsel, max_bytes, &irq);
 
     if (irq) {
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 00f9e45158..ccbc8dabd5 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -11,10 +11,11 @@ es1370_frame_address_rd(int ch, uint32_t addr) "ch=%d addr=0x%08x"
 es1370_frame_address_wr(int ch, uint32_t addr) "ch=%d addr=0x%08x"
 es1370_frame_count_rd(int ch, uint32_t curr, uint32_t size) "ch=%d CURR_CT=%u BUF_SIZE=%u"
 es1370_frame_count_wr(int ch, uint32_t curr, uint32_t size) "ch=%d CURR_CT=%u BUF_SIZE=%u"
+es1370_lost_interrupt(int ch) "ch=%d lost interrupt"
 es1370_sample_count_rd(int ch, uint32_t curr, uint32_t num) "ch=%d CURR_SAMP_CT=%u SAMP_CT=%u"
 es1370_sample_count_wr(int ch, uint32_t curr, uint32_t num) "ch=%d CURR_SAMP_CT=%u SAMP_CT=%u"
 es1370_stream_format(int ch, uint32_t freq, const char *fmt, const char *mode, uint32_t shift) "ch=%d fmt=%u:%s:%s shift=%u"
-es1370_transfer_audio(int ch, uint32_t f_curr, uint32_t f_size, uint32_t s_curr, uint32_t s_num, uint32_t leftover, int irq) "ch=%d CURR_CT=%u BUF_SIZE=%u CURR_SAMP_CT=%u SAMP_CT=%u leftover=%u irq=%d"
+es1370_transfer_audio(int ch, uint32_t f_curr, uint32_t f_size, uint32_t s_curr, uint32_t s_num, uint32_t leftover, bool irq) "ch=%d CURR_CT=%u BUF_SIZE=%u CURR_SAMP_CT=%u SAMP_CT=%u leftover=%u irq=%d"
 
 # hda-codec.c
 hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
-- 
2.35.3


