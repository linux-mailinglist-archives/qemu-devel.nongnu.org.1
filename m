Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A437C4AAA
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSlL-0001w6-Th; Wed, 11 Oct 2023 02:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSl4-0001uz-1N
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSl1-0006w1-Cv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G44gyNiz8GhAVa1gvei7fQjgrYxKV9EzbY/xkhUjfLY=;
 b=CCKO87Tmk7OVEyhbT+qr2GqXbFuOyoqJeYz9G2gA6Xy2OC04CGMBMGZfh7zcUpMtAlwpKY
 3hLprpln9jookHbG8Y4ooAeCQ48ICcXgvcjHp8v8y3Cp0OKFL5FK98L0jnLIpnPMgyG9ZK
 ResU3w/BLQ0nXtKi+7VBU8zi9qJnFWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-kg7hM2uePGKsjpSE6ZDPyw-1; Wed, 11 Oct 2023 02:31:41 -0400
X-MC-Unique: kg7hM2uePGKsjpSE6ZDPyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0661C101AA44;
 Wed, 11 Oct 2023 06:31:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10F6D10F1BE7;
 Wed, 11 Oct 2023 06:31:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 8/8] hw/audio/es1370: trace lost interrupts
Date: Wed, 11 Oct 2023 10:31:01 +0400
Message-ID: <20231011063101.258955-9-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

It turns out that there are drivers which assume that interrupts
can't be lost. E.g. the AROS sb128 driver is such a driver. Add
a lost interrupt tracepoint to debug this kind of issues.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-8-vr_qemu@t-online.de>
---
 hw/audio/es1370.c     | 14 ++++++++++----
 hw/audio/trace-events |  3 ++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index b47794f786..91c47330ad 100644
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
index 9ae2f717b6..059ce451f5 100644
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
2.41.0


