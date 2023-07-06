Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B508674A49C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHV8G-0006Wp-Ei; Thu, 06 Jul 2023 15:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qHV88-0006WX-S4
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:59:08 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qHV84-0002Do-KN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:59:08 -0400
Received: from fwd86.dcpf.telekom.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout07.t-online.de (Postfix) with SMTP id 9C4A446FB9;
 Thu,  6 Jul 2023 21:58:55 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.151.121]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qHV7u-1CIVIP0; Thu, 6 Jul 2023 21:58:55 +0200
Message-ID: <abfcef29-2b3b-db89-ad61-73f8ecea220e@t-online.de>
Date: Thu, 6 Jul 2023 21:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/21] audio: add Apple Sound Chip (ASC) emulation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-8-mark.cave-ayland@ilande.co.uk>
Content-Language: de-DE
Cc: qemu-devel@nongnu.org
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230702154838.722809-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1688673535-F6FE3EBC-B932608E/0/0 CLEAN NORMAL
X-TOI-MSGID: cd2056e6-a332-4835-b0d8-a4007a034a3c
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>   MAINTAINERS            |   2 +
>   hw/audio/Kconfig       |   3 +
>   hw/audio/asc.c         | 685 +++++++++++++++++++++++++++++++++++++++++
>   hw/audio/meson.build   |   1 +
>   hw/audio/trace-events  |  10 +
>   hw/m68k/Kconfig        |   1 +
>   include/hw/audio/asc.h |  79 +++++
>   7 files changed, 781 insertions(+)
>   create mode 100644 hw/audio/asc.c
>   create mode 100644 include/hw/audio/asc.h

Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 88db6540ae..5ab23de2a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1233,6 +1233,7 @@ F: hw/display/macfb.c
>   F: hw/block/swim.c
>   F: hw/misc/djmemc.c
>   F: hw/misc/iosb.c
> +F: hw/audio/asc.c
>   F: hw/m68k/bootinfo.h
>   F: include/standard-headers/asm-m68k/bootinfo.h
>   F: include/standard-headers/asm-m68k/bootinfo-mac.h
> @@ -1244,6 +1245,7 @@ F: include/hw/m68k/q800.h
>   F: include/hw/m68k/q800-glue.h
>   F: include/hw/misc/djmemc.h
>   F: include/hw/misc/iosb.h
> +F: include/hw/audio/asc.h
>   
>   virt
>   M: Laurent Vivier <laurent@vivier.eu>
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index e76c69ca7e..d0993514a1 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -47,3 +47,6 @@ config PL041
>   
>   config CS4231
>       bool
> +
> +config ASC
> +    bool
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> new file mode 100644
> index 0000000000..ebcb8a97a6
> --- /dev/null
> +++ b/hw/audio/asc.c
> @@ -0,0 +1,685 @@
> +/*
> + * QEMU Apple Sound Chip emulation
> + *
> + * Apple Sound Chip (ASC) 344S0063
> + * Enhanced Apple Sound Chip (EASC) 343S1063
> + *
> + * Copyright (c) 2012-2018 Laurent Vivier <laurent@vivier.eu>
> + * Copyright (c) 2022 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +#include "audio/audio.h"
> +#include "hw/audio/asc.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +/*
> + * Linux doesn't provide information about ASC, see arch/m68k/mac/macboing.c
> + * and arch/m68k/include/asm/mac_asc.h
> + *
> + * best information is coming from MAME:
> + *   https://github.com/mamedev/mame/blob/master/src/devices/sound/asc.h
> + *   https://github.com/mamedev/mame/blob/master/src/devices/sound/asc.cpp
> + *   Emulation by R. Belmont
> + * or MESS:
> + *   http://mess.redump.net/mess/driver_info/easc
> + *
> + *     0x800: VERSION
> + *     0x801: MODE
> + *            1=FIFO mode,
> + *            2=wavetable mode
> + *     0x802: CONTROL
> + *            bit 0=analog or PWM output,
> + *                1=stereo/mono,
> + *                7=processing time exceeded
> + *     0x803: FIFO MODE
> + *            bit 7=clear FIFO,
> + *            bit 1="non-ROM companding",
> + *            bit 0="ROM companding")
> + *     0x804: FIFO IRQ STATUS
> + *            bit 0=ch A 1/2 full,
> + *                1=ch A full,
> + *                2=ch B 1/2 full,
> + *                3=ch B full)
> + *     0x805: WAVETABLE CONTROL
> + *            bits 0-3 wavetables 0-3 start
> + *     0x806: VOLUME
> + *            bits 2-4 = 3 bit internal ASC volume,
> + *            bits 5-7 = volume control sent to Sony sound chip
> + *     0x807: CLOCK RATE
> + *            0 = Mac 22257 Hz,
> + *            1 = undefined,
> + *            2 = 22050 Hz,
> + *            3 = 44100 Hz
> + *     0x80a: PLAY REC A
> + *     0x80f: TEST
> + *            bits 6-7 = digital test,
> + *            bits 4-5 = analog test
> + *     0x810: WAVETABLE 0 PHASE
> + *            big-endian 9.15 fixed-point, only 24 bits valid
> + *     0x814: WAVETABLE 0 INCREMENT
> + *            big-endian 9.15 fixed-point, only 24 bits valid
> + *     0x818: WAVETABLE 1 PHASE
> + *     0x81C: WAVETABLE 1 INCREMENT
> + *     0x820: WAVETABLE 2 PHASE
> + *     0x824: WAVETABLE 2 INCREMENT
> + *     0x828: WAVETABLE 3 PHASE
> + *     0x82C: WAVETABLE 3 INCREMENT
> + *     0x830: UNKNOWN START
> + *            NetBSD writes Wavetable data here (are there more
> + *            wavetables/channels than we know about?)
> + *     0x857: UNKNOWN END
> + */
> +
> +#define ASC_SIZE           0x2000
> +
> +enum {
> +    ASC_VERSION     = 0x00,
> +    ASC_MODE        = 0x01,
> +    ASC_CONTROL     = 0x02,
> +    ASC_FIFOMODE    = 0x03,
> +    ASC_FIFOIRQ     = 0x04,
> +    ASC_WAVECTRL    = 0x05,
> +    ASC_VOLUME      = 0x06,
> +    ASC_CLOCK       = 0x07,
> +    ASC_PLAYRECA    = 0x0a,
> +    ASC_TEST        = 0x0f,
> +    ASC_WAVETABLE   = 0x10
> +};
> +
> +#define ASC_FIFO_STATUS_HALF_FULL      1
> +#define ASC_FIFO_STATUS_FULL_EMPTY     2
> +
> +#define ASC_EXTREGS_FIFOCTRL           0x8
> +#define ASC_EXTREGS_INTCTRL            0x9
> +#define ASC_EXTREGS_CDXA_DECOMP_FILT   0x10
> +
> +
> +static void asc_raise_irq(ASCState *s)
> +{
> +    qemu_set_irq(s->irq, 1);
> +}
> +
> +static void asc_lower_irq(ASCState *s)
> +{
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static uint8_t asc_fifo_get(ASCFIFOState *fs)
> +{
> +    ASCState *s = container_of(fs, ASCState, fifos[fs->index]);
> +    bool fifo_half_irq_enabled = fs->extregs[ASC_EXTREGS_INTCTRL] & 1;
> +    uint8_t val;
> +
> +    assert(fs->cnt);
> +
> +    val = fs->fifo[fs->rptr];
> +    trace_asc_fifo_get('A' + fs->index, fs->rptr, fs->cnt, val);
> +
> +    fs->rptr++;
> +    fs->rptr &= 0x3ff;
> +    fs->cnt--;
> +
> +    if (fs->cnt <= 0x1ff) {
> +        /* FIFO less than half full */
> +        fs->int_status |= ASC_FIFO_STATUS_HALF_FULL;
> +    } else {
> +        /* FIFO more than half full */
> +        fs->int_status &= ~ASC_FIFO_STATUS_HALF_FULL;
> +    }
> +
> +    if (fs->cnt == 0x1ff && fifo_half_irq_enabled) {
> +        /* Raise FIFO half full IRQ */
> +        asc_raise_irq(s);
> +    }
> +
> +    if (fs->cnt == 0) {
> +        /* Raise FIFO empty IRQ */
> +        fs->int_status |= ASC_FIFO_STATUS_FULL_EMPTY;
> +        asc_raise_irq(s);
> +    }
> +
> +    return val;
> +}
> +
> +static int generate_fifo(ASCState *s, int maxsamples)
> +{
> +    uint8_t *buf = s->mixbuf;
> +    int i, limit, count = 0;
> +
> +    limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
> +
> +    /*
> +     * If starting a new run with no FIFO data present, update the IRQ and
> +     * continue
> +     */
> +    if (limit == 0 && s->fifos[0].int_status == 0 &&
> +            s->fifos[1].int_status == 0) {
> +        s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                  ASC_FIFO_STATUS_FULL_EMPTY;
> +        s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                  ASC_FIFO_STATUS_FULL_EMPTY;
> +
> +        asc_raise_irq(s);
> +        return 0;
> +    }
> +
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
> +    return count;
> +}
> +
> +static int generate_wavetable(ASCState *s, int maxsamples)
> +{
> +    uint8_t *buf = s->mixbuf;
> +    int channel, count = 0;
> +
> +    while (count < maxsamples) {
> +        uint32_t left = 0, right = 0;
> +        uint8_t sample;
> +
> +        for (channel = 0; channel < 4; channel++) {
> +            ASCFIFOState *fs = &s->fifos[channel >> 1];
> +            int chanreg = ASC_WAVETABLE + (channel << 3);
> +            uint32_t phase, incr, offset;
> +
> +            phase = ldl_be_p(&s->regs[chanreg]);
> +            incr = ldl_be_p(&s->regs[chanreg + sizeof(uint32_t)]);
> +
> +            phase += incr;
> +            offset = (phase >> 15) & 0x1ff;
> +            sample = fs->fifo[0x200 * (channel >> 1) + offset];
> +
> +            stl_be_p(&s->regs[chanreg], phase);
> +
> +            left += sample;
> +            right += sample;
> +        }
> +
> +        buf[count * 2] = left >> 2;
> +        buf[count * 2 + 1] = right >> 2;
> +
> +        count++;
> +    }
> +
> +    return count;
> +}
> +
> +static void asc_out_cb(void *opaque, int free_b)
> +{
> +    ASCState *s = opaque;
> +    int samples;
> +
> +    if (free_b == 0) {
> +        return;
> +    }
> +
> +    samples = MIN(s->samples, free_b >> s->shift);
> +
> +    switch (s->regs[ASC_MODE] & 3) {
> +    default:
> +        /* Off */
> +        samples = 0;
> +        break;
> +    case 1:
> +        /* FIFO mode */
> +        samples = generate_fifo(s, samples);
> +        break;
> +    case 2:
> +        /* Wave table mode */
> +        samples = generate_wavetable(s, samples);
> +        break;
> +    }
> +
> +    if (!samples) {
> +        return;
> +    }
> +
> +    AUD_write(s->voice, s->mixbuf, samples << s->shift);
> +}
> +
> +static uint64_t asc_fifo_read(void *opaque, hwaddr addr,
> +                              unsigned size)
> +{
> +    ASCFIFOState *fs = opaque;
> +
> +    trace_asc_read_fifo('A' + fs->index, addr, size, fs->fifo[addr]);
> +    return fs->fifo[addr];
> +}
> +
> +static void asc_fifo_write(void *opaque, hwaddr addr, uint64_t value,
> +                           unsigned size)
> +{
> +    ASCFIFOState *fs = opaque;
> +    ASCState *s = container_of(fs, ASCState, fifos[fs->index]);
> +    bool fifo_half_irq_enabled = fs->extregs[ASC_EXTREGS_INTCTRL] & 1;
> +
> +    trace_asc_write_fifo('A' + fs->index, addr, size, fs->wptr, fs->cnt, value);
> +
> +    if (s->regs[ASC_MODE] == 1) {
> +        fs->fifo[fs->wptr++] = value;
> +        fs->wptr &= 0x3ff;
> +        fs->cnt++;
> +
> +        if (fs->cnt <= 0x1ff) {
> +            /* FIFO less than half full */
> +            fs->int_status |= ASC_FIFO_STATUS_HALF_FULL;
> +        } else {
> +            /* FIFO at least half full */
> +            fs->int_status &= ~ASC_FIFO_STATUS_HALF_FULL;
> +        }
> +
> +        if (fs->cnt == 0x200 && fifo_half_irq_enabled) {
> +            /* Raise FIFO half full interrupt */
> +            asc_raise_irq(s);
> +        }
> +
> +        if (fs->cnt == 0x3ff) {
> +            /* Raise FIFO full interrupt */
> +            fs->int_status |= ASC_FIFO_STATUS_FULL_EMPTY;
> +            asc_raise_irq(s);
> +        }
> +    } else {
> +        fs->fifo[addr] = value;
> +    }
> +    return;
> +}
> +
> +static const MemoryRegionOps asc_fifo_ops = {
> +    .read = asc_fifo_read,
> +    .write = asc_fifo_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void asc_fifo_reset(ASCFIFOState *fs);
> +
> +static uint64_t asc_read(void *opaque, hwaddr addr,
> +                         unsigned size)
> +{
> +    ASCState *s = opaque;
> +    uint64_t prev, value;
> +
> +    switch (addr) {
> +    case ASC_VERSION:
> +        switch (s->type) {
> +        default:
> +        case ASC_TYPE_ASC:
> +            value = 0;
> +            break;
> +        case ASC_TYPE_EASC:
> +            value = 0xb0;
> +            break;
> +        }
> +        break;
> +    case ASC_FIFOIRQ:
> +        prev = (s->fifos[0].int_status & 0x3) |
> +                (s->fifos[1].int_status & 0x3) << 2;
> +
> +        s->fifos[0].int_status = 0;
> +        s->fifos[1].int_status = 0;
> +        asc_lower_irq(s);
> +        value = prev;
> +        break;
> +    default:
> +        value = s->regs[addr];
> +        break;
> +    }
> +
> +    trace_asc_read_reg(addr, size, value);
> +    return value;
> +}
> +
> +static void asc_write(void *opaque, hwaddr addr, uint64_t value,
> +                      unsigned size)
> +{
> +    ASCState *s = opaque;
> +
> +    switch (addr) {
> +    case ASC_MODE:
> +        value &= 3;
> +        if (value != s->regs[ASC_MODE]) {
> +            asc_fifo_reset(&s->fifos[0]);
> +            asc_fifo_reset(&s->fifos[1]);
> +            asc_lower_irq(s);
> +            if (value != 0) {
> +                AUD_set_active_out(s->voice, 1);
> +            } else {
> +                AUD_set_active_out(s->voice, 0);
> +            }
> +        }
> +        break;
> +    case ASC_FIFOMODE:
> +        if (value & 0x80) {
> +            asc_fifo_reset(&s->fifos[0]);
> +            asc_fifo_reset(&s->fifos[1]);
> +            asc_lower_irq(s);
> +        }
> +        break;
> +    case ASC_WAVECTRL:
> +        break;
> +    case ASC_VOLUME:
> +        {
> +            int vol = (value & 0xe0);
> +
> +            AUD_set_volume_out(s->voice, 0, vol, vol);
> +            break;
> +        }
> +    }
> +
> +    trace_asc_write_reg(addr, size, value);
> +    s->regs[addr] = value;
> +}
> +
> +static const MemoryRegionOps asc_regs_ops = {
> +    .read = asc_read,
> +    .write = asc_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    }
> +};
> +
> +static uint64_t asc_ext_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    ASCFIFOState *fs = opaque;
> +    uint64_t value;
> +
> +    value = fs->extregs[addr];
> +
> +    trace_asc_read_extreg('A' + fs->index, addr, size, value);
> +    return value;
> +}
> +
> +static void asc_ext_write(void *opaque, hwaddr addr, uint64_t value,
> +                          unsigned size)
> +{
> +    ASCFIFOState *fs = opaque;
> +
> +    trace_asc_write_extreg('A' + fs->index, addr, size, value);
> +
> +    fs->extregs[addr] = value;
> +}
> +
> +static const MemoryRegionOps asc_extregs_ops = {
> +    .read = asc_ext_read,
> +    .write = asc_ext_write,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static int asc_post_load(void *opaque, int version)
> +{
> +    ASCState *s = ASC(opaque);
> +
> +    if (s->regs[ASC_MODE] != 0) {
> +        AUD_set_active_out(s->voice, 1);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_asc_fifo = {
> +    .name = "apple-sound-chip.fifo",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(fifo, ASCFIFOState, ASC_FIFO_SIZE),
> +        VMSTATE_UINT8(int_status, ASCFIFOState),
> +        VMSTATE_INT32(cnt, ASCFIFOState),
> +        VMSTATE_INT32(wptr, ASCFIFOState),
> +        VMSTATE_INT32(rptr, ASCFIFOState),
> +        VMSTATE_UINT8_ARRAY(extregs, ASCFIFOState, ASC_EXTREG_SIZE),
> +        VMSTATE_INT32(xa_cnt, ASCFIFOState),
> +        VMSTATE_UINT8(xa_val, ASCFIFOState),
> +        VMSTATE_UINT8(xa_flags, ASCFIFOState),
> +        VMSTATE_INT16_ARRAY(xa_last, ASCFIFOState, 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_asc = {
> +    .name = "apple-sound-chip",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .post_load = asc_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(fifos, ASCState, 2, 0, vmstate_asc_fifo,
> +                             ASCFIFOState),
> +        VMSTATE_UINT8_ARRAY(regs, ASCState, ASC_REG_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void asc_fifo_reset(ASCFIFOState *fs)
> +{
> +    fs->wptr = 0;
> +    fs->rptr = 0;
> +    fs->cnt = 0;
> +    fs->xa_cnt = -1;
> +    fs->int_status = 0;
> +}
> +
> +static void asc_fifo_init(ASCFIFOState *fs, int index)
> +{
> +    ASCState *s = container_of(fs, ASCState, fifos[index]);
> +    char *name;
> +
> +    fs->index = index;
> +    name = g_strdup_printf("asc.fifo%c", 'A' + index);
> +    memory_region_init_io(&fs->mem_fifo, OBJECT(s), &asc_fifo_ops, fs,
> +                          name, ASC_FIFO_SIZE);
> +    g_free(name);
> +
> +    name = g_strdup_printf("asc.extregs%c", 'A' + index);
> +    memory_region_init_io(&fs->mem_extregs, OBJECT(s), &asc_extregs_ops,
> +                          fs, name, ASC_EXTREG_SIZE);
> +    g_free(name);
> +}
> +
> +static void asc_reset_hold(Object *obj)
> +{
> +    ASCState *s = ASC(obj);
> +
> +    AUD_set_active_out(s->voice, 0);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    asc_fifo_reset(&s->fifos[0]);
> +    asc_fifo_reset(&s->fifos[1]);
> +
> +    if (s->type == ASC_TYPE_ASC) {
> +        /* FIFO half full IRQs enabled by default */
> +        s->fifos[0].extregs[ASC_EXTREGS_INTCTRL] = 1;
> +        s->fifos[1].extregs[ASC_EXTREGS_INTCTRL] = 1;
> +    }
> +}
> +
> +static void asc_unrealize(DeviceState *dev)
> +{
> +    ASCState *s = ASC(dev);
> +
> +    g_free(s->mixbuf);
> +
> +    AUD_remove_card(&s->card);
> +}
> +
> +static void asc_realize(DeviceState *dev, Error **errp)
> +{
> +    ASCState *s = ASC(dev);
> +    struct audsettings as;
> +
> +    AUD_register_card("Apple Sound Chip", &s->card);
> +
> +    as.freq = 22257;
> +    as.nchannels = 2;
> +    as.fmt = AUDIO_FORMAT_U8;
> +    as.endianness = AUDIO_HOST_ENDIANNESS;
> +
> +    s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
> +                            &as);
> +    s->shift = 1;
> +    s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
> +    s->mixbuf = g_malloc0(s->samples << s->shift);
> +
> +    /* Add easc registers if required */
> +    if (s->type == ASC_TYPE_EASC) {
> +        memory_region_add_subregion(&s->asc, ASC_EXTREG_OFFSET,
> +                                    &s->fifos[0].mem_extregs);
> +        memory_region_add_subregion(&s->asc,
> +                                    ASC_EXTREG_OFFSET + ASC_EXTREG_SIZE,
> +                                    &s->fifos[1].mem_extregs);
> +    }
> +}
> +
> +static void asc_init(Object *obj)
> +{
> +    ASCState *s = ASC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init(&s->asc, OBJECT(obj), "asc", ASC_SIZE);
> +
> +    asc_fifo_init(&s->fifos[0], 0);
> +    asc_fifo_init(&s->fifos[1], 1);
> +
> +    memory_region_add_subregion(&s->asc, ASC_FIFO_OFFSET,
> +                                &s->fifos[0].mem_fifo);
> +    memory_region_add_subregion(&s->asc,
> +                                ASC_FIFO_OFFSET + ASC_FIFO_SIZE,
> +                                &s->fifos[1].mem_fifo);
> +
> +    memory_region_init_io(&s->mem_regs, OBJECT(obj), &asc_regs_ops, s,
> +                          "asc.regs", ASC_REG_SIZE);
> +    memory_region_add_subregion(&s->asc, ASC_REG_OFFSET, &s->mem_regs);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +    sysbus_init_mmio(sbd, &s->asc);
> +}
> +
> +static Property asc_properties[] = {
> +    DEFINE_AUDIO_PROPERTIES(ASCState, card),
> +    DEFINE_PROP_UINT8("asctype", ASCState, type, ASC_TYPE_ASC),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void asc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +
> +    dc->realize = asc_realize;
> +    dc->unrealize = asc_unrealize;
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +    dc->vmsd = &vmstate_asc;
> +    device_class_set_props(dc, asc_properties);
> +    rc->phases.hold = asc_reset_hold;
> +}
> +
> +static const TypeInfo asc_info_types[] = {
> +    {
> +        .name = TYPE_ASC,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(ASCState),
> +        .instance_init = asc_init,
> +        .class_init = asc_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(asc_info_types)
> diff --git a/hw/audio/meson.build b/hw/audio/meson.build
> index d0fda1009e..8805322f5c 100644
> --- a/hw/audio/meson.build
> +++ b/hw/audio/meson.build
> @@ -1,6 +1,7 @@
>   system_ss.add(files('soundhw.c'))
>   system_ss.add(when: 'CONFIG_AC97', if_true: files('ac97.c'))
>   system_ss.add(when: 'CONFIG_ADLIB', if_true: files('fmopl.c', 'adlib.c'))
> +system_ss.add(when: 'CONFIG_ASC', if_true: files('asc.c'))
>   system_ss.add(when: 'CONFIG_CS4231', if_true: files('cs4231.c'))
>   system_ss.add(when: 'CONFIG_CS4231A', if_true: files('cs4231a.c'))
>   system_ss.add(when: 'CONFIG_ES1370', if_true: files('es1370.c'))
> diff --git a/hw/audio/trace-events b/hw/audio/trace-events
> index 4dec48a4fd..89ef2996e5 100644
> --- a/hw/audio/trace-events
> +++ b/hw/audio/trace-events
> @@ -17,3 +17,13 @@ via_ac97_codec_write(uint8_t addr, uint16_t val) "0x%x <- 0x%x"
>   via_ac97_sgd_fetch(uint32_t curr, uint32_t addr, char stop, char eol, char flag, uint32_t len) "curr=0x%x addr=0x%x %c%c%c len=%d"
>   via_ac97_sgd_read(uint64_t addr, unsigned size, uint64_t val) "0x%"PRIx64" %d -> 0x%"PRIx64
>   via_ac97_sgd_write(uint64_t addr, unsigned size, uint64_t val) "0x%"PRIx64" %d <- 0x%"PRIx64
> +
> +# asc.c
> +asc_read_fifo(const char fifo, int reg, unsigned size, uint64_t value) "fifo %c reg=0x%03x size=%u value=0x%"PRIx64
> +asc_read_reg(int reg, unsigned size, uint64_t value) "reg=0x%03x size=%u value=0x%"PRIx64
> +asc_read_extreg(const char fifo, int reg, unsigned size, uint64_t value) "fifo %c reg=0x%03x size=%u value=0x%"PRIx64
> +asc_fifo_get(const char fifo, int rptr, int cnt, uint64_t value) "fifo %c rptr=0x%x cnt=0x%x value=0x%"PRIx64
> +asc_write_fifo(const char fifo, int reg, unsigned size, int wrptr, int cnt, uint64_t value) "fifo %c reg=0x%03x size=%u wptr=0x%x cnt=0x%x value=0x%"PRIx64
> +asc_write_reg(int reg, unsigned size, uint64_t value) "reg=0x%03x size=%u value=0x%"PRIx64
> +asc_write_extreg(const char fifo, int reg, unsigned size, uint64_t value) "fifo %c reg=0x%03x size=%u value=0x%"PRIx64
> +asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index 64fa70a0db..d88741ec9d 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -25,6 +25,7 @@ config Q800
>       select OR_IRQ
>       select DJMEMC
>       select IOSB
> +    select ASC
>   
>   config M68K_VIRT
>       bool
> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
> new file mode 100644
> index 0000000000..41c6cba8fa
> --- /dev/null
> +++ b/include/hw/audio/asc.h
> @@ -0,0 +1,79 @@
> +/*
> + * QEMU Apple Sound Chip emulation
> + *
> + * Apple Sound Chip (ASC) 344S0063
> + * Enhanced Apple Sound Chip (EASC) 343S1063
> + *
> + * Copyright (c) 2012-2018 Laurent Vivier <laurent@vivier.eu>
> + * Copyright (c) 2022 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_AUDIO_ASC_H
> +#define HW_AUDIO_ASC_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "audio/audio.h"
> +
> +enum {
> +    ASC_TYPE_ASC    = 0,  /* original discrete Apple Sound Chip */
> +    ASC_TYPE_EASC   = 1   /* discrete Enhanced Apple Sound Chip */
> +};
> +
> +#define ASC_FIFO_OFFSET    0x0
> +#define ASC_FIFO_SIZE      0x400
> +
> +#define ASC_REG_OFFSET     0x800
> +#define ASC_REG_SIZE       0x60
> +
> +#define ASC_EXTREG_OFFSET  0xf00
> +#define ASC_EXTREG_SIZE    0x20
> +
> +typedef struct ASCFIFOState {
> +    int index;
> +
> +    MemoryRegion mem_fifo;
> +    uint8_t fifo[ASC_FIFO_SIZE];
> +    uint8_t int_status;
> +
> +    int cnt;
> +    int wptr;
> +    int rptr;
> +
> +    MemoryRegion mem_extregs;
> +    uint8_t extregs[ASC_EXTREG_SIZE];
> +
> +    int xa_cnt;
> +    uint8_t xa_val;
> +    uint8_t xa_flags;
> +    int16_t xa_last[2];
> +} ASCFIFOState;
> +
> +struct ASCState {
> +    SysBusDevice parent_obj;
> +
> +    uint8_t type;
> +    MemoryRegion asc;
> +    MemoryRegion mem_fifo;
> +    MemoryRegion mem_regs;
> +    MemoryRegion mem_extregs;
> +
> +    QEMUSoundCard card;
> +    SWVoiceOut *voice;
> +    uint8_t *mixbuf;
> +    int samples;
> +    int shift;
> +
> +    qemu_irq irq;
> +
> +    ASCFIFOState fifos[2];
> +
> +    uint8_t regs[ASC_REG_SIZE];
> +};
> +
> +#define TYPE_ASC "apple-sound-chip"
> +OBJECT_DECLARE_SIMPLE_TYPE(ASCState, ASC)
> +
> +#endif


