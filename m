Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DC7C8005
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD53-0004uj-4q; Fri, 13 Oct 2023 03:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4x-000478-5E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:27 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4u-0007Ay-6Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:26 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so8806761fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183962; x=1697788762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7CRH59E7WDah93GOZUBpOMCM1LCjMQKDPJEI6Vj50o=;
 b=OoVWGEsVxfZ8soUO9REQEPNfNdbBfWi7Ti/Bzd8olKNZDY6lcBGLjSoEebsBY2JSlw
 Mz38AioGIQ/O8KXg8Z5fE9H+w44xw/vpQG4+CLxpAVG/YlafFMmvH6MTW3JawqMovmMW
 5Fz4qnEQRrTGwEpSYwWLMmulujqQGdRQrEar/uwHv0cjtwhL/cG37ero4SHzKW6V8y1U
 GhP4y+55o1x13vF3CC6Ea1mKZLq4NdnK+BIlfBn7YmmQeri52cwA3fdiKjHrglOxZZXs
 PmJ/VHmu450s39TaGL4PsandAM5WjHIU4BNKo9PKATkjlBDkoYPgQvYJlY5CWzP/6UsO
 5aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183962; x=1697788762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7CRH59E7WDah93GOZUBpOMCM1LCjMQKDPJEI6Vj50o=;
 b=dX+pi1MTREDFdRMBg9q9D1jaIoOZ9qkGcQh1L8GH8DnbtcNlKg2KmJxctB847086dv
 2kmoQKKYjbatOncgAQJFi68gAHVwjbJrBAVF0VnVmxpHYwHjED6vehC1KUMPOb+VuZv2
 P62zGHksoiBzd22/Vf+ck6ftJK6FmESPRAiRnk3bhctZTALQIHlVpAToCVHkRL5tWuk9
 yoZC84MONV9MrqFg4UuNDslRvt5GBkBdqP5rIMZ+74JrMHktinL++lySqOsY0jyuHCWa
 7j9/1pT6WECRvPFzhDcaFKHEpfG3jmmaYjJi7gmT/65LvZ6R2FoaoJ+zub6VyOLeOl3/
 ZzLQ==
X-Gm-Message-State: AOJu0YybmYf0ZB2VlBlsFVzSI+1MXT+92lWRe2rYx8RhAA3fQH0BcO0l
 e2mrVt1JJRns5uaZ59TWs9gaJkPUsY2mPy+DBow=
X-Google-Smtp-Source: AGHT+IEtdY7mZnz10wXKFohaVCKhyqMw2HeW6BZTCGMKJovaeAt5C+XmGoPBG9PWgCj51uv5h6gWGQ==
X-Received: by 2002:a05:6512:753:b0:503:19d8:8dc3 with SMTP id
 c19-20020a056512075300b0050319d88dc3mr20284750lfs.31.1697183962077; 
 Fri, 13 Oct 2023 00:59:22 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:21 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH v2 50/78] hw/audio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:17 +0300
Message-Id: <5fd3f2429559990851dba1e57dea59a2d83c0b18.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/asc.c        | 2 +-
 hw/audio/cs4231a.c    | 2 +-
 hw/audio/gusemu_hal.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 0f36b4ce9b..336da09509 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -154,126 +154,126 @@ static uint8_t asc_fifo_get(ASCFIFOState *fs)
 static int generate_fifo(ASCState *s, int maxsamples)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint8_t *buf = s->mixbuf;
     int i, wcount = 0;
 
     while (wcount < maxsamples) {
         uint8_t val;
         int16_t d, f0, f1;
         int32_t t;
         int shift, filter;
         bool hasdata = false;
 
         for (i = 0; i < 2; i++) {
             ASCFIFOState *fs = &s->fifos[i];
 
             switch (fs->extregs[ASC_EXTREGS_FIFOCTRL] & 0x83) {
             case 0x82:
                 /*
                  * CD-XA BRR mode: decompress 15 bytes into 28 16-bit
                  * samples
                  */
                 if (!fs->cnt) {
                     val = 0x80;
                     break;
                 }
 
                 if (fs->xa_cnt == -1) {
                     /* Start of packet, get flags */
                     fs->xa_flags = asc_fifo_get(fs);
                     fs->xa_cnt = 0;
                 }
 
                 shift = fs->xa_flags & 0xf;
                 filter = fs->xa_flags >> 4;
                 f0 = (int8_t)fs->extregs[ASC_EXTREGS_CDXA_DECOMP_FILT +
                                  (filter << 1) + 1];
                 f1 = (int8_t)fs->extregs[ASC_EXTREGS_CDXA_DECOMP_FILT +
                                  (filter << 1)];
 
                 if ((fs->xa_cnt & 1) == 0) {
                     if (!fs->cnt) {
                         val = 0x80;
                         break;
                     }
 
                     fs->xa_val = asc_fifo_get(fs);
                     d = (fs->xa_val & 0xf) << 12;
                 } else {
                     d = (fs->xa_val & 0xf0) << 8;
                 }
                 t = (d >> shift) + (((fs->xa_last[0] * f0) +
                                      (fs->xa_last[1] * f1) + 32) >> 6);
                 if (t < -32768) {
                     t = -32768;
                 } else if (t > 32767) {
                     t = 32767;
                 }
 
                 /*
                  * CD-XA BRR generates 16-bit signed output, so convert to
                  * 8-bit before writing to buffer. Does real hardware do the
                  * same?
                  */
                 val = (uint8_t)(t / 256) ^ 0x80;
                 hasdata = true;
                 fs->xa_cnt++;
 
                 fs->xa_last[1] = fs->xa_last[0];
                 fs->xa_last[0] = (int16_t)t;
 
                 if (fs->xa_cnt == 28) {
                     /* End of packet */
                     fs->xa_cnt = -1;
                 }
                 break;
 
             default:
-                /* fallthrough */
+                fallthrough;
             case 0x80:
                 /* Raw mode */
                 if (fs->cnt) {
                     val = asc_fifo_get(fs);
                     hasdata = true;
                 } else {
                     val = 0x80;
                 }
                 break;
             }
 
             buf[wcount * 2 + i] = val;
         }
 
         if (!hasdata) {
             break;
         }
 
         wcount++;
     }
 
     /*
      * MacOS (un)helpfully leaves the FIFO engine running even when it has
      * finished writing out samples, but still expects the FIFO empty
      * interrupts to be generated for each FIFO cycle (without these interrupts
      * MacOS will freeze)
      */
     if (s->fifos[0].cnt == 0 && s->fifos[1].cnt == 0) {
         if (!s->fifo_empty_ns) {
             /* FIFO has completed first empty cycle */
             s->fifo_empty_ns = now;
         } else if (now > (s->fifo_empty_ns + ASC_FIFO_CYCLE_TIME)) {
             /* FIFO has completed entire cycle with no data */
             s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
                                       ASC_FIFO_STATUS_FULL_EMPTY;
             s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
                                       ASC_FIFO_STATUS_FULL_EMPTY;
             s->fifo_empty_ns = now;
             asc_raise_irq(s);
         }
     } else {
         /* FIFO contains data, reset empty time */
         s->fifo_empty_ns = 0;
     }
 
     return wcount;
 }
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3aa105748d..3bf0116c68 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -272,90 +272,90 @@ static void cs_audio_callback (void *opaque, int free)
 static void cs_reset_voices (CSState *s, uint32_t val)
 {
     int xtal;
     struct audsettings as;
     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
 
 #ifdef DEBUG_XLAW
     if (val == 0 || val == 32)
         val = (1 << 4) | (1 << 5);
 #endif
 
     xtal = val & 1;
     as.freq = freqs[xtal][(val >> 1) & 7];
 
     if (as.freq == -1) {
         lerr ("unsupported frequency (val=%#x)\n", val);
         goto error;
     }
 
     as.nchannels = (val & (1 << 4)) ? 2 : 1;
     as.endianness = 0;
     s->tab = NULL;
 
     switch ((val >> 5) & ((s->dregs[MODE_And_ID] & MODE2) ? 7 : 3)) {
     case 0:
         as.fmt = AUDIO_FORMAT_U8;
         s->shift = as.nchannels == 2;
         break;
 
     case 1:
         s->tab = MuLawDecompressTable;
         goto x_law;
     case 3:
         s->tab = ALawDecompressTable;
     x_law:
         as.fmt = AUDIO_FORMAT_S16;
         as.endianness = AUDIO_HOST_ENDIANNESS;
         s->shift = as.nchannels == 2;
         break;
 
     case 6:
         as.endianness = 1;
-        /* fall through */
+        fallthrough;
     case 2:
         as.fmt = AUDIO_FORMAT_S16;
         s->shift = as.nchannels;
         break;
 
     case 7:
     case 4:
         lerr ("attempt to use reserved format value (%#x)\n", val);
         goto error;
 
     case 5:
         lerr ("ADPCM 4 bit IMA compatible format is not supported\n");
         goto error;
     }
 
     s->voice = AUD_open_out (
         &s->card,
         s->voice,
         "cs4231a",
         s,
         cs_audio_callback,
         &as
         );
 
     if (s->dregs[Interface_Configuration] & PEN) {
         if (!s->dma_running) {
             k->hold_DREQ(s->isa_dma, s->dma);
             AUD_set_active_out (s->voice, 1);
             s->transferred = 0;
         }
         s->dma_running = 1;
     }
     else {
         if (s->dma_running) {
             k->release_DREQ(s->isa_dma, s->dma);
             AUD_set_active_out (s->voice, 0);
         }
         s->dma_running = 0;
     }
     return;
 
  error:
     if (s->dma_running) {
         k->release_DREQ(s->isa_dma, s->dma);
         AUD_set_active_out (s->voice, 0);
     }
 }
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index f159978b49..76dd906ea1 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -190,311 +190,311 @@ unsigned int gus_read(GUSEmuState * state, int port, int size)
 void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
 {
     uint8_t        *gusptr;
     gusptr = state->gusdatapos;
     GUSregd(portaccesses)++;
 
     switch (port & 0xff0f)
     {
     case 0x200:                 /* MixerCtrlReg */
         GUSregb(MixerCtrlReg2x0) = (uint8_t) data;
         break;
     case 0x206:                 /* IRQstatReg / SB2x6IRQ */
         if (GUSregb(GUS45TimerCtrl) & 0x20) /* SB IRQ enabled? -> set 2x6IRQ bit */
         {
             GUSregb(TimerStatus2x8) |= 0x08;
             GUSregb(IRQStatReg2x6) = 0x10;
             GUS_irqrequest(state, state->gusirq, 1);
         }
         break;
     case 0x308:                /* AdLib 388h */
     case 0x208:                /* AdLibCommandReg */
         GUSregb(AdLibCommand2xA) = (uint8_t) data;
         break;
     case 0x309:                /* AdLib 389h */
     case 0x209:                /* AdLibDataReg */
         if ((GUSregb(AdLibCommand2xA) == 0x04) && (!(GUSregb(GUS45TimerCtrl) & 1))) /* GUS auto timer mode enabled? */
         {
             if (data & 0x80)
                 GUSregb(TimerStatus2x8) &= 0x1f; /* AdLib IRQ reset? -> clear maskable adl. timer int regs */
             else
                 GUSregb(TimerDataReg2x9) = (uint8_t) data;
         }
         else
         {
             GUSregb(AdLibData2x9) = (uint8_t) data;
             if (GUSregb(GUS45TimerCtrl) & 0x02)
             {
                 GUSregb(TimerStatus2x8) |= 0x01;
                 GUSregb(IRQStatReg2x6) = 0x10;
                 GUS_irqrequest(state, state->gusirq, 1);
             }
         }
         break;
     case 0x20A:
         GUSregb(AdLibStatus2x8) = (uint8_t) data;
         break;                 /* AdLibStatus2x8 */
     case 0x20B:                /* GUS hidden registers */
         switch (GUSregb(RegCtrl_2xF) & 0x7)
         {
         case 0:
             if (GUSregb(MixerCtrlReg2x0) & 0x40)
                 GUSregb(IRQ_2xB) = (uint8_t) data; /* control register select bit */
             else
                 GUSregb(DMA_2xB) = (uint8_t) data;
             break;
             /* case 1-4: general purpose emulation regs */
         case 5:                                    /* clear stat reg 2xF */
             GUSregb(StatRead_2xF) = 0; /* ToDo: is this identical with GUS classic? */
             if (!GUSregb(IRQStatReg2x6))
                 GUS_irqclear(state, state->gusirq);
             break;
         case 6:                                    /* Jumper reg (Joystick/MIDI enable) */
             GUSregb(Jumper_2xB) = (uint8_t) data;
             break;
         default:;
         }
         break;
     case 0x20C:                /* SB2xCd */
         if (GUSregb(GUS45TimerCtrl) & 0x20)
         {
             GUSregb(TimerStatus2x8) |= 0x10; /* SB IRQ enabled? -> set 2xCIRQ bit */
             GUSregb(IRQStatReg2x6) = 0x10;
             GUS_irqrequest(state, state->gusirq, 1);
         }
-        /* fall through */
+        fallthrough;
     case 0x20D:                /* SB2xCd no IRQ */
         GUSregb(SB2xCd) = (uint8_t) data;
         break;
     case 0x20E:                /* SB2xE */
         GUSregb(SB2xE) = (uint8_t) data;
         break;
     case 0x20F:
         GUSregb(RegCtrl_2xF) = (uint8_t) data;
         break;                 /* CtrlReg2xF */
     case 0x302:                /* VoiceSelReg */
         GUSregb(VoiceSelReg3x2) = (uint8_t) data;
         break;
     case 0x303:                /* FunkSelReg */
         GUSregb(FunkSelReg3x3) = (uint8_t) data;
         if ((uint8_t) data == 0x8f) /* set irqstatreg, get voicereg and clear IRQ */
         {
             int             voice;
             if (GUSregd(voicewavetableirq)) /* WavetableIRQ */
             {
                 for (voice = 0; voice < 31; voice++)
                 {
                     if (GUSregd(voicewavetableirq) & (1 << voice))
                     {
                         GUSregd(voicewavetableirq) ^= (1 << voice); /* clear IRQ bit */
                         GUSregb(voice << 5) &= 0x7f; /* clear voice reg irq bit */
                         if (!GUSregd(voicewavetableirq))
                             GUSregb(IRQStatReg2x6) &= 0xdf;
                         if (!GUSregb(IRQStatReg2x6))
                             GUS_irqclear(state, state->gusirq);
                         GUSregb(SynVoiceIRQ8f) = voice | 0x60; /* (bit==0 => IRQ wartend) */
                         return;
                     }
                 }
             }
             else if (GUSregd(voicevolrampirq)) /* VolRamp IRQ */
             {
                 for (voice = 0; voice < 31; voice++)
                 {
                     if (GUSregd(voicevolrampirq) & (1 << voice))
                     {
                         GUSregd(voicevolrampirq) ^= (1 << voice); /* clear IRQ bit */
                         GUSregb((voice << 5) + VSRVolRampControl) &= 0x7f; /* clear voice volume reg irq bit */
                         if (!GUSregd(voicevolrampirq))
                             GUSregb(IRQStatReg2x6) &= 0xbf;
                         if (!GUSregb(IRQStatReg2x6))
                             GUS_irqclear(state, state->gusirq);
                         GUSregb(SynVoiceIRQ8f) = voice | 0x80; /* (bit==0 => IRQ wartend) */
                         return;
                     }
                 }
             }
             GUSregb(SynVoiceIRQ8f) = 0xe8; /* kein IRQ wartet */
         }
         break;
     case 0x304:
     case 0x305:
         {
             uint16_t         writedata = (uint16_t) data;
             uint16_t         readmask = 0x0000;
             if (size == 1)
             {
                 readmask = 0xff00;
                 writedata &= 0xff;
                 if ((port & 0xff0f) == 0x305)
                 {
                     writedata = (uint16_t) (writedata << 8);
                     readmask = 0x00ff;
                 }
             }
             switch (GUSregb(FunkSelReg3x3))
             {
                 /* voice specific functions */
             case 0x00:
             case 0x01:
             case 0x02:
             case 0x03:
             case 0x04:
             case 0x05:
             case 0x06:
             case 0x07:
             case 0x08:
             case 0x09:
             case 0x0a:
             case 0x0b:
             case 0x0c:
             case 0x0d:
                 {
                     int             offset;
                     if (!(GUSregb(GUS4cReset) & 0x01))
                         break;  /* reset flag active? */
                     offset = 2 * (GUSregb(FunkSelReg3x3) & 0x0f);
                     offset += (GUSregb(VoiceSelReg3x2) & 0x1f) << 5; /*  = Voice*32 + Function*2 */
                     GUSregw(offset) = (uint16_t) ((GUSregw(offset) & readmask) | writedata);
                 }
                 break;
                 /* voice unspecific functions */
             case 0x0e:         /* NumVoices */
                 GUSregb(NumVoices) = (uint8_t) data;
                 break;
             /* case 0x0f:      */ /* read only */
                 /* common functions */
             case 0x41:         /* DramDMAContrReg */
                 GUSregb(GUS41DMACtrl) = (uint8_t) data;
                 if (data & 0x01)
                     GUS_dmarequest(state);
                 break;
             case 0x42:         /* DramDMAmemPosReg */
                 GUSregw(GUS42DMAStart) = (GUSregw(GUS42DMAStart) & readmask) | writedata;
                 GUSregb(GUS50DMAHigh) &= 0xf; /* compatibility stuff... */
                 break;
             case 0x43:         /* DRAMaddrLo */
                 GUSregd(GUSDRAMPOS24bit) =
                     (GUSregd(GUSDRAMPOS24bit) & (readmask | 0xff0000)) | writedata;
                 break;
             case 0x44:         /* DRAMaddrHi */
                 GUSregd(GUSDRAMPOS24bit) =
                     (GUSregd(GUSDRAMPOS24bit) & 0xffff) | ((data & 0x0f) << 16);
                 break;
             case 0x45:         /* TCtrlReg */
                 GUSregb(GUS45TimerCtrl) = (uint8_t) data;
                 if (!(data & 0x20))
                     GUSregb(TimerStatus2x8) &= 0xe7;    /* sb IRQ dis? -> clear 2x8/2xC sb IRQ flags */
                 if (!(data & 0x02))
                     GUSregb(TimerStatus2x8) &= 0xfe;    /* adlib data IRQ dis? -> clear 2x8 adlib IRQ flag */
                 if (!(GUSregb(TimerStatus2x8) & 0x19))
                     GUSregb(IRQStatReg2x6) &= 0xef;     /* 0xe6; $$clear IRQ if both IRQ bits are inactive or cleared */
                 /* catch up delayed timer IRQs: */
                 if ((GUSregw(TimerIRQs) > 1) && (GUSregb(TimerDataReg2x9) & 3))
                 {
                     if (GUSregb(TimerDataReg2x9) & 1)   /* start timer 1 (80us decrement rate) */
                     {
                         if (!(GUSregb(TimerDataReg2x9) & 0x40))
                             GUSregb(TimerStatus2x8) |= 0xc0;    /* maskable bits */
                         if (data & 4) /* timer1 irq enable */
                         {
                             GUSregb(TimerStatus2x8) |= 4;       /* nonmaskable bit */
                             GUSregb(IRQStatReg2x6) |= 4;        /* timer 1 irq pending */
                         }
                     }
                     if (GUSregb(TimerDataReg2x9) & 2)   /* start timer 2 (320us decrement rate) */
                     {
                         if (!(GUSregb(TimerDataReg2x9) & 0x20))
                             GUSregb(TimerStatus2x8) |= 0xa0;    /* maskable bits */
                         if (data & 8) /* timer2 irq enable */
                         {
                             GUSregb(TimerStatus2x8) |= 2;       /* nonmaskable bit */
                             GUSregb(IRQStatReg2x6) |= 8;        /* timer 2 irq pending */
                         }
                     }
                     GUSregw(TimerIRQs)--;
                     if (GUSregw(BusyTimerIRQs) > 1)
                         GUSregw(BusyTimerIRQs)--;
                     else
                         GUSregw(BusyTimerIRQs) =
                             GUS_irqrequest(state, state->gusirq, GUSregw(TimerIRQs));
                 }
                 else
                     GUSregw(TimerIRQs) = 0;
 
                 if (!(data & 0x04))
                 {
                     GUSregb(TimerStatus2x8) &= 0xfb; /* clear non-maskable timer1 bit */
                     GUSregb(IRQStatReg2x6)  &= 0xfb;
                 }
                 if (!(data & 0x08))
                 {
                     GUSregb(TimerStatus2x8) &= 0xfd; /* clear non-maskable timer2 bit */
                     GUSregb(IRQStatReg2x6)  &= 0xf7;
                 }
                 if (!GUSregb(IRQStatReg2x6))
                     GUS_irqclear(state, state->gusirq);
                 break;
             case 0x46:          /* Counter1 */
                 GUSregb(GUS46Counter1) = (uint8_t) data;
                 break;
             case 0x47:          /* Counter2 */
                 GUSregb(GUS47Counter2) = (uint8_t) data;
                 break;
             /* case 0x48:       */ /* sampling freq reg not emulated (same as interwave) */
             case 0x49:          /* SampCtrlReg */
                 GUSregb(GUS49SampCtrl) = (uint8_t) data;
                 break;
             /* case 0x4b:       */ /* joystick trim not emulated */
             case 0x4c:          /* GUSreset */
                 GUSregb(GUS4cReset) = (uint8_t) data;
                 if (!(GUSregb(GUS4cReset) & 1)) /* reset... */
                 {
                     GUSregd(voicewavetableirq) = 0;
                     GUSregd(voicevolrampirq) = 0;
                     GUSregw(TimerIRQs) = 0;
                     GUSregw(BusyTimerIRQs) = 0;
                     GUSregb(NumVoices) = 0xcd;
                     GUSregb(IRQStatReg2x6) = 0;
                     GUSregb(TimerStatus2x8) = 0;
                     GUSregb(AdLibData2x9) = 0;
                     GUSregb(TimerDataReg2x9) = 0;
                     GUSregb(GUS41DMACtrl) = 0;
                     GUSregb(GUS45TimerCtrl) = 0;
                     GUSregb(GUS49SampCtrl) = 0;
                     GUSregb(GUS4cReset) &= 0xf9; /* clear IRQ and DAC enable bits */
                     GUS_irqclear(state, state->gusirq);
                 }
                 /* IRQ enable bit checked elsewhere */
                 /* EnableDAC bit may be used by external callers */
                 break;
             }
         }
         break;
     case 0x307:                /* DRAMaccess */
         {
             uint8_t        *adr;
             adr = state->himemaddr + (GUSregd(GUSDRAMPOS24bit) & 0xfffff);
             *adr = (uint8_t) data;
         }
         break;
     }
 }
 
 /* Attention when breaking up a single DMA transfer to multiple ones:
  * it may lead to multiple terminal count interrupts and broken transfers:
  *
  * 1. Whenever you transfer a piece of data, the gusemu callback is invoked
  * 2. The callback may generate a TC irq (if the register was set up to do so)
  * 3. The irq may result in the program using the GUS to reprogram the GUS
  *
  * Some programs also decide to upload by just checking if TC occurs
  * (via interrupt or a cleared GUS dma flag)
  * and then start the next transfer, without checking DMA state
  *
  * Thus: Always make sure to set the TC flag correctly!
  *
  * Note that the genuine GUS had a granularity of 16 bytes/words for low/high DMA
  * while later cards had atomic granularity provided by an additional GUS50DMAHigh register
  * GUSemu also uses this register to support byte-granular transfers for better compatibility
  * with emulators other than GUSemu32
  */
-- 
2.39.2


