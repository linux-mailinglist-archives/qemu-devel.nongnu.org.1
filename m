Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E07C7F17
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyR-0003R7-BS; Fri, 13 Oct 2023 03:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxr-0000sL-3A
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxW-0005ER-Nn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1678706f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183505; x=1697788305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFSG6N2uxNt6GHbM9eqwyrjOHkw0xm2XSOZPV6L6EYE=;
 b=K5VrBusRO3gNrsvp7rJXCCKRZ+G+NnAQUpyVLHp3zQR/Bu6mG1J4Tl8krJ5TuVNFvA
 C8QkP3LEIhP03MxCgCQEXdd+Y7KBw58eZMMjX4HsPfq0WIPOxGInaCQahE+2TLx1FS6T
 YIuuNus8Z55LlOsTDbzpeYA0uWwqnBlas+lO9CVeh779K9+pAVV3oGt6ZwCpfUdcBzXX
 iECDc92DgMQ9pZ9vFG/LL4KWwiXH7fG+3womIm+px8Ed/257JkCu8LY6gJu1VCKKb74g
 4iomMZAf3gIR9hdRF1ITuV01660XfdQrnF0rA+WMtuNL4DI2UUt2aGhmf1vAr98njz6W
 lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183505; x=1697788305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFSG6N2uxNt6GHbM9eqwyrjOHkw0xm2XSOZPV6L6EYE=;
 b=prIyuGm5iU9czs3QCzHSbumwteEZv5oCR13QD+IXG4ky+dK4Yvd7TupDIs31e7Z8O8
 g3/jZ0dRnNj1ubYw+o6MbWiiryVe2XNmWXl1x+kmstP/pVi2h+wEh4iahHnjZNFtdkom
 5EjKEJrBvHVCLEe0Mvv7UZ4WDd4fWZHnAIPUDZBVuzGgIvEV9fOpFL217ErKYVnJMyxx
 4IaLO7G2PUR9IQJ8FNQ1A0xh9SQnBEnqtEcEPDv1LI+inUBHa6037lSmu1LA5tMAXBR+
 3rVoYJc+hVd0zrgkyob5JX9fuoTn1rGi1HPNQIAWQmMCEUgJoFBPUY1yuPTCogDQI0LS
 VTXQ==
X-Gm-Message-State: AOJu0YzKGeCySyKe2vOcDRjUj4HZ9hRGRNju7/qfqNM317j/2sQfhsQD
 dObBXhb+4//mQfjIU2kjK4diyPhMLWSvczNJxow=
X-Google-Smtp-Source: AGHT+IFwf0v//Ws3HSblVtugCG9QB+ARir0IrcfFckC3BQ9msXVpLMhPWHX3Ncvb9T+QEcvPqi/eoQ==
X-Received: by 2002:a5d:6909:0:b0:314:dc0:2fca with SMTP id
 t9-20020a5d6909000000b003140dc02fcamr22729594wru.29.1697183504758; 
 Fri, 13 Oct 2023 00:51:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 49/75] hw/audio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:06 +0300
Message-Id: <adcf74cd58c36dc0bf7373c8a80cc8fea75286d8.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/cs4231a.c    | 2 +-
 hw/audio/gusemu_hal.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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


