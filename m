Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D079FCCD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggQu-0001qv-In; Thu, 14 Sep 2023 03:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qggQq-0001qU-HM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:06:32 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qggQo-0004tq-4q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:06:32 -0400
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
 by mailout10.t-online.de (Postfix) with SMTP id E5C4F1A81A;
 Thu, 14 Sep 2023 09:06:10 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.89]) by fwd79.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qggQS-3JDhzd0; Thu, 14 Sep 2023 09:06:08 +0200
Message-ID: <373b3abd-a726-e795-eaee-0389a25c662f@t-online.de>
Date: Thu, 14 Sep 2023 09:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 07/20] audio: add Apple Sound Chip (ASC) emulation
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-8-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20230909094827.33871-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694675168-FD4002E6-3F938C64/0/0 CLEAN NORMAL
X-TOI-MSGID: b18a47e4-8237-4895-be1f-76e98f1b8342
Received-SPF: none client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Am 09.09.23 um 11:48 schrieb Mark Cave-Ayland:
> The Apple Sound Chip was primarily used by the Macintosh II to generate sound
> in hardware which was previously handled by the toolbox ROM with software
> interrupts.
>
> Implement both the standard ASC and also the enhanced ASC (EASC) functionality
> which is used in the Quadra 800.
>
> Note that whilst real ASC hardware uses AUDIO_FORMAT_S8, this implementation uses
> AUDIO_FORMAT_U8 instead because AUDIO_FORMAT_S8 is rarely used and not supported
> by some audio backends like PulseAudio and DirectSound when played directly with
> -audiodev out.mixing-engine=off.
>
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Co-developed-by: Volker Rümelin <vr_qemu@t-online.de>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  MAINTAINERS            |   2 +
>  hw/audio/Kconfig       |   3 +
>  hw/audio/asc.c         | 699 +++++++++++++++++++++++++++++++++++++++++
>  hw/audio/meson.build   |   1 +
>  hw/audio/trace-events  |  10 +
>  hw/m68k/Kconfig        |   1 +
>  include/hw/audio/asc.h |  84 +++++
>  7 files changed, 800 insertions(+)
>  create mode 100644 hw/audio/asc.c
>  create mode 100644 include/hw/audio/asc.h

Hi Mark,

the function generate_fifo() has four issues. Only the first one
is noticeable.

1. The calculation of the variable limit assumes generate_fifo()
generates one output sample from every input byte. This is correct
for the raw mode, but not for the CD-XA BRR mode. This mode
generates 28 output samples from 15 input bytes. This is the
reason for the stuttering end of a CD-XA BRR mode sound. Every
generate_fifo() call generates approximately only half of the
possible samples when the fifo bytes are running low.

2. generate_fifo() doesn't generate the last output sample from
a CD-XA BRR mode sound. The last sample is generated from internal
state and the code will not be called without at least one byte
in the fifo.

3. It's not necessary to wait for a complete 15 byte packet in
CD-XA BRR mode. Audio playback devices should write all
requested samples immediately if possible.

4. The saturation function in CD-XA BRR mode works with 16 bit
integers. It should saturate at +32767 and -32768.

Since I think a few lines of code explain the issues better
than my words, I've attached a patch below.

With best regards,
Volker

> +static int generate_fifo(ASCState *s, int maxsamples)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    uint8_t *buf = s->mixbuf;
> +    int i, limit, count = 0;
> +
> +    limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
> +    while (count < limit) {
> +        uint8_t val;
> +        int16_t d, f0, f1;
> +        int32_t t;
> +        int shift, filter;
> +        bool hasdata = true;
> +
> +        for (i = 0; i < 2; i++) {
> +            ASCFIFOState *fs = &s->fifos[i];
> +
> +            switch (fs->extregs[ASC_EXTREGS_FIFOCTRL] & 0x83) {
> +            case 0x82:
> +                /*
> +                 * CD-XA BRR mode: exit if there isn't enough data in the FIFO
> +                 * for a complete 15 byte packet
> +                 */
> +                if (fs->xa_cnt == -1 && fs->cnt < 15) {
> +                    hasdata = false;
> +                    continue;
> +                }
> +
> +                if (fs->xa_cnt == -1) {
> +                    /* Start of packet, get flags */
> +                    fs->xa_flags = asc_fifo_get(fs);
> +                    fs->xa_cnt = 0;
> +                }
> +
> +                shift = fs->xa_flags & 0xf;
> +                filter = fs->xa_flags >> 4;
> +                f0 = (int8_t)fs->extregs[ASC_EXTREGS_CDXA_DECOMP_FILT +
> +                                 (filter << 1) + 1];
> +                f1 = (int8_t)fs->extregs[ASC_EXTREGS_CDXA_DECOMP_FILT +
> +                                 (filter << 1)];
> +                if ((fs->xa_cnt & 1) == 0) {
> +                    fs->xa_val = asc_fifo_get(fs);
> +                    d = (fs->xa_val & 0xf) << 12;
> +                } else {
> +                    d = (fs->xa_val & 0xf0) << 8;
> +                }
> +                t = (d >> shift) + (((fs->xa_last[0] * f0) +
> +                                     (fs->xa_last[1] * f1) + 32) >> 6);
> +                if (t < -32768) {
> +                    t = -32768;
> +                } else if (t > 32768) {
> +                    t = 32768;
> +                }
> +
> +                /*
> +                 * CD-XA BRR generates 16-bit signed output, so convert to
> +                 * 8-bit before writing to buffer. Does real hardware do the
> +                 * same?
> +                 */
> +                buf[count * 2 + i] = (uint8_t)(t / 256) ^ 0x80;
> +                fs->xa_cnt++;
> +
> +                fs->xa_last[1] = fs->xa_last[0];
> +                fs->xa_last[0] = (int16_t)t;
> +
> +                if (fs->xa_cnt == 28) {
> +                    /* End of packet */
> +                    fs->xa_cnt = -1;
> +                }
> +                break;
> +
> +            default:
> +                /* fallthrough */
> +            case 0x80:
> +                /* Raw mode */
> +                if (fs->cnt) {
> +                    val = asc_fifo_get(fs);
> +                } else {
> +                    val = 0x80;
> +                }
> +
> +                buf[count * 2 + i] = val;
> +                break;
> +            }
> +        }
> +
> +        if (!hasdata) {
> +            break;
> +        }
> +
> +        count++;
> +    }
> +
> +    /*
> +     * MacOS (un)helpfully leaves the FIFO engine running even when it has
> +     * finished writing out samples, but still expects the FIFO empty
> +     * interrupts to be generated for each FIFO cycle (without these interrupts
> +     * MacOS will freeze)
> +     */
> +    if (s->fifos[0].cnt == 0 && s->fifos[1].cnt == 0) {
> +        if (!s->fifo_empty_ns) {
> +            /* FIFO has completed first empty cycle */
> +            s->fifo_empty_ns = now;
> +        } else if (now > (s->fifo_empty_ns + ASC_FIFO_CYCLE_TIME)) {
> +            /* FIFO has completed entire cycle with no data */
> +            s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
> +            s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
> +            s->fifo_empty_ns = now;
> +            asc_raise_irq(s);
> +        }
> +    } else {
> +        /* FIFO contains data, reset empty time */
> +        s->fifo_empty_ns = 0;
> +    }
> +
> +    return count;
> +}
>

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index b01b285512..74988fef9c 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -155,31 +155,26 @@ static int generate_fifo(ASCState *s, int maxsamples)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint8_t *buf = s->mixbuf;
-    int i, limit, count = 0;
+    int i, wcount = 0;
 
-    limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
-    while (count < limit) {
+    while (wcount < maxsamples) {
         uint8_t val;
         int16_t d, f0, f1;
         int32_t t;
         int shift, filter;
-        bool hasdata = true;
+        bool hasdata = false;
 
         for (i = 0; i < 2; i++) {
             ASCFIFOState *fs = &s->fifos[i];
 
             switch (fs->extregs[ASC_EXTREGS_FIFOCTRL] & 0x83) {
             case 0x82:
-                /*
-                 * CD-XA BRR mode: exit if there isn't enough data in
the FIFO
-                 * for a complete 15 byte packet
-                 */
-                if (fs->xa_cnt == -1 && fs->cnt < 15) {
-                    hasdata = false;
-                    continue;
-                }
-
+                /* CD-XA BRR mode: decompress 15 bytes into 28 16bit
samples */
                 if (fs->xa_cnt == -1) {
+                    if (!fs->cnt) {
+                        val = 0x80;
+                        break;
+                    }
                     /* Start of packet, get flags */
                     fs->xa_flags = asc_fifo_get(fs);
                     fs->xa_cnt = 0;
@@ -192,6 +187,10 @@ static int generate_fifo(ASCState *s, int maxsamples)
                 f1 = (int8_t)fs->extregs[ASC_EXTREGS_CDXA_DECOMP_FILT +
                                  (filter << 1)];
                 if ((fs->xa_cnt & 1) == 0) {
+                    if (!fs->cnt) {
+                        val = 0x80;
+                        break;
+                    }
                     fs->xa_val = asc_fifo_get(fs);
                     d = (fs->xa_val & 0xf) << 12;
                 } else {
@@ -201,8 +200,8 @@ static int generate_fifo(ASCState *s, int maxsamples)
                                      (fs->xa_last[1] * f1) + 32) >> 6);
                 if (t < -32768) {
                     t = -32768;
-                } else if (t > 32768) {
-                    t = 32768;
+                } else if (t > 32767) {
+                    t = 32767;
                 }
 
                 /*
@@ -210,7 +209,8 @@ static int generate_fifo(ASCState *s, int maxsamples)
                  * 8-bit before writing to buffer. Does real hardware
do the
                  * same?
                  */
-                buf[count * 2 + i] = (uint8_t)(t / 256) ^ 0x80;
+                val = (uint8_t)(t / 256) ^ 0x80;
+                hasdata = true;
                 fs->xa_cnt++;
 
                 fs->xa_last[1] = fs->xa_last[0];
@@ -228,20 +228,21 @@ static int generate_fifo(ASCState *s, int maxsamples)
                 /* Raw mode */
                 if (fs->cnt) {
                     val = asc_fifo_get(fs);
+                    hasdata = true;
                 } else {
                     val = 0x80;
                 }
-
-                buf[count * 2 + i] = val;
                 break;
             }
+
+            buf[wcount * 2 + i] = val;
         }
 
         if (!hasdata) {
             break;
         }
 
-        count++;
+        wcount++;
     }
 
     /*
@@ -268,7 +269,7 @@ static int generate_fifo(ASCState *s, int maxsamples)
         s->fifo_empty_ns = 0;
     }
 
-    return count;
+    return wcount;
 }
 
 static int generate_wavetable(ASCState *s, int maxsamples)
-- 
2.35.3


