Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A597C4A9D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSki-0001s2-4j; Wed, 11 Oct 2023 02:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkc-0001rT-Ac
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkZ-0006rw-Dp
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caJEKmVWujjpSVdvPkOZgpYPoU/SvErrK0p0KeF9Zio=;
 b=PC/uGN/m31u0zL6YzZ0GGcca2jZ1ddRmSf9JzIBEZnWuYjvamnrDr0YbQqIAQR9e8IxCLA
 Jg9jKK77eNsq6JAMMhh03h/b1fynW6Ye17qAD1senV0QZHrX7TbmDAv367cpwu4hA6lcpj
 Edxb0TCiF0rzhsbPrZ46kZzlejjh7Gw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-roYU94WtNTOOOou7xTrTqQ-1; Wed, 11 Oct 2023 02:31:14 -0400
X-MC-Unique: roYU94WtNTOOOou7xTrTqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945021C0896A;
 Wed, 11 Oct 2023 06:31:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B794C5796D;
 Wed, 11 Oct 2023 06:31:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 2/8] hw/audio/es1370: replace bit-rotted code with tracepoints
Date: Wed, 11 Oct 2023 10:30:55 +0400
Message-ID: <20231011063101.258955-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

It seems that nobody has enabled the debug code of the ES1370
device for a long time. Since then, the code has bit-rotted.
Replace the bit-rotten code with tracepoints.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-2-vr_qemu@t-online.de>
---
 hw/audio/es1370.c     | 55 ++++++++++++++-----------------------------
 hw/audio/trace-events | 10 ++++++++
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 0567721eb7..2b55e31a9a 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "qom/object.h"
+#include "trace.h"
 
 /* Missing stuff:
    SCTRL_P[12](END|ST)INC
@@ -166,8 +167,6 @@ static void es1370_adc_callback (void *opaque, int avail);
 
 #ifdef DEBUG_ES1370
 
-#define ldebug(...) AUD_log ("es1370", __VA_ARGS__)
-
 static void print_ctl (uint32_t val)
 {
     char buf[1024];
@@ -239,7 +238,6 @@ static void print_sctl (uint32_t val)
         );
 }
 #else
-#define ldebug(...)
 #define print_ctl(...)
 #define print_sctl(...)
 #endif
@@ -411,12 +409,9 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
 
         if ((old_fmt != new_fmt) || (old_freq != new_freq)) {
             d->shift = (new_fmt & 1) + (new_fmt >> 1);
-            ldebug ("channel %zu, freq = %d, nchannels %d, fmt %d, shift %d\n",
-                    i,
-                    new_freq,
-                    1 << (new_fmt & 1),
-                    (new_fmt & 2) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8,
-                    d->shift);
+            trace_es1370_stream_format(i, new_freq,
+                new_fmt & 2 ? "s16" : "u8", new_fmt & 1 ? "stereo" : "mono",
+                d->shift);
             if (new_freq) {
                 struct audsettings as;
 
@@ -503,8 +498,8 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     case ES1370_REG_ADC_SCOUNT:
         d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
         d->scount = (val & 0xffff) << 16 | (val & 0xffff);
-        ldebug ("chan %td CURR_SAMP_CT %d, SAMP_CT %d\n",
-                d - &s->chan[0], val >> 16, (val & 0xffff));
+        trace_es1370_sample_count_wr(d - &s->chan[0],
+            d->scount >> 16, d->scount & 0xffff);
         break;
 
     case ES1370_REG_ADC_FRAMEADR:
@@ -515,7 +510,7 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
     frameadr:
         d->frame_addr = val;
-        ldebug ("chan %td frame address %#x\n", d - &s->chan[0], val);
+        trace_es1370_frame_address_wr(d - &s->chan[0], d->frame_addr);
         break;
 
     case ES1370_REG_PHANTOM_FRAMECNT:
@@ -534,8 +529,8 @@ static void es1370_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     framecnt:
         d->frame_cnt = val;
         d->leftover = 0;
-        ldebug ("chan %td frame count %d, buffer size %d\n",
-                d - &s->chan[0], val >> 16, val & 0xffff);
+        trace_es1370_frame_count_wr(d - &s->chan[0],
+            d->frame_cnt >> 16, d->frame_cnt & 0xffff);
         break;
 
     default:
@@ -573,17 +568,9 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
     case ES1370_REG_DAC2_SCOUNT:
     case ES1370_REG_ADC_SCOUNT:
         d += (addr - ES1370_REG_DAC1_SCOUNT) >> 2;
+        trace_es1370_sample_count_rd(d - &s->chan[0],
+            d->scount >> 16, d->scount & 0xffff);
         val = d->scount;
-#ifdef DEBUG_ES1370
-        {
-            uint32_t curr_count = d->scount >> 16;
-            uint32_t count = d->scount & 0xffff;
-
-            curr_count <<= d->shift;
-            count <<= d->shift;
-            dolog ("read scount curr %d, total %d\n", curr_count, count);
-        }
-#endif
         break;
 
     case ES1370_REG_ADC_FRAMECNT:
@@ -593,17 +580,9 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
     case ES1370_REG_DAC2_FRAMECNT:
         d += (addr - ES1370_REG_DAC1_FRAMECNT) >> 3;
     framecnt:
+        trace_es1370_frame_count_rd(d - &s->chan[0],
+            d->frame_cnt >> 16, d->frame_cnt & 0xffff);
         val = d->frame_cnt;
-#ifdef DEBUG_ES1370
-        {
-            uint32_t size = ((d->frame_cnt & 0xffff) + 1) << 2;
-            uint32_t curr = ((d->frame_cnt >> 16) + 1) << 2;
-            if (curr > size) {
-                dolog ("read framecnt curr %d, size %d %d\n", curr, size,
-                       curr > size);
-            }
-        }
-#endif
         break;
 
     case ES1370_REG_ADC_FRAMEADR:
@@ -613,6 +592,7 @@ static uint64_t es1370_read(void *opaque, hwaddr addr, unsigned size)
     case ES1370_REG_DAC2_FRAMEADR:
         d += (addr - ES1370_REG_DAC1_FRAMEADR) >> 3;
     frameadr:
+        trace_es1370_frame_address_rd(d - &s->chan[0], d->frame_addr);
         val = d->frame_addr;
         break;
 
@@ -689,9 +669,6 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     if (csc_bytes == transferred) {
         *irq = 1;
         d->scount = sc | (sc << 16);
-        ldebug ("sc = %d, rate = %f\n",
-                (sc + 1) << d->shift,
-                (sc + 1) / (double) 44100);
     }
     else {
         *irq = 0;
@@ -713,6 +690,10 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
     }
 
     d->leftover = (transferred + d->leftover) & 3;
+    trace_es1370_transfer_audio(index,
+        d->frame_cnt >> 16, d->frame_cnt & 0xffff,
+        d->scount >> 16, d->scount & 0xffff,
+        d->leftover, *irq);
 }
 
 static void es1370_run_channel (ES1370State *s, size_t chan, int free_or_avail)
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 89ef2996e5..9ae2f717b6 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -6,6 +6,16 @@ cs4231_mem_readl_reg(uint32_t reg, uint32_t ret) "read reg %d: 0x%08x"
 cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint32_t val) "write reg %d: 0x%08x -> 0x%08x"
 cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint32_t val) "write dreg %d: 0x%02x -> 0x%02x"
 
+# es1370.c
+es1370_frame_address_rd(int ch, uint32_t addr) "ch=%d addr=0x%08x"
+es1370_frame_address_wr(int ch, uint32_t addr) "ch=%d addr=0x%08x"
+es1370_frame_count_rd(int ch, uint32_t curr, uint32_t size) "ch=%d CURR_CT=%u BUF_SIZE=%u"
+es1370_frame_count_wr(int ch, uint32_t curr, uint32_t size) "ch=%d CURR_CT=%u BUF_SIZE=%u"
+es1370_sample_count_rd(int ch, uint32_t curr, uint32_t num) "ch=%d CURR_SAMP_CT=%u SAMP_CT=%u"
+es1370_sample_count_wr(int ch, uint32_t curr, uint32_t num) "ch=%d CURR_SAMP_CT=%u SAMP_CT=%u"
+es1370_stream_format(int ch, uint32_t freq, const char *fmt, const char *mode, uint32_t shift) "ch=%d fmt=%u:%s:%s shift=%u"
+es1370_transfer_audio(int ch, uint32_t f_curr, uint32_t f_size, uint32_t s_curr, uint32_t s_num, uint32_t leftover, int irq) "ch=%d CURR_CT=%u BUF_SIZE=%u CURR_SAMP_CT=%u SAMP_CT=%u leftover=%u irq=%d"
+
 # hda-codec.c
 hda_audio_running(const char *stream, int nr, bool running) "st %s, nr %d, run %d"
 hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s, %d x %s @ %d Hz"
-- 
2.41.0


