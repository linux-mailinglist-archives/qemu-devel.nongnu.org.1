Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DEC1BB01
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 16:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE895-0007Ld-8A; Wed, 29 Oct 2025 11:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE890-0007Jk-1r
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:31:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE88o-00007w-RJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:31:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 562FB5972FD;
 Wed, 29 Oct 2025 16:31:09 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id rb0RF6W6zCLK; Wed, 29 Oct 2025 16:31:06 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D35855972E8; Wed, 29 Oct 2025 16:31:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D17B05972E3;
 Wed, 29 Oct 2025 16:31:06 +0100 (CET)
Date: Wed, 29 Oct 2025 16:31:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
In-Reply-To: <e3e36622-94fc-b892-6283-280b3ec5292d@eik.bme.hu>
Message-ID: <54125fb1-0d5a-43d1-197e-4feb86e5c6cc@eik.bme.hu>
References: <20251029140112.275456-1-chad@jablonski.xyz>
 <e3e36622-94fc-b892-6283-280b3ec5292d@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 29 Oct 2025, BALATON Zoltan wrote:
> Hello,
>
> On Wed, 29 Oct 2025, Chad Jablonski wrote:
>> HOST_DATA as a source for 2D blits (ROP3_SRCCOPY) was unimplemented,
>> preventing X.org text rendering with 2D acceleration enabled. This
>> implements monochrome HOST_DATA blits with color expansion, enabling
>> xterm to render text correctly.
>
> Great stuff, I meant to work on this but never got to it yet. Keep these 
> coming! It's not likely we can polish it enough to be in next release but 
> there's still a few days left, otherwise I take it as an RFC and here's a 
> quick review.
>
>> The blit itself has been implemented as a separate function to keep
>> things focused. Future work could refactor this, and the existing
>> blits, to use shared helpers for common patterns.
>> 
>> Changes:
>> - Add clipping register handlers (SC_TOP_LEFT, SC_BOTTOM_RIGHT,
>>  SRC_SC_BOTTOM_RIGHT) and defaulting
>> - Add DP_SRC_FRGD_CLR and DP_SRC_BKGD_CLR register write handlers to
>>  enable color expansion
>> - Implement expand_colors() to convert 1bpp monochrome data to 32bpp
>>  color
>> - Add ati_blt_mono_host_to_screen() for monochrome HOST_DATA blits
>
> That's a lot of changes for a single patch. Could this be split into a series 
> along the above lines to put each logical change into its own patch for 
> easier review?
>
>> The host data buffer has a fixed 4MiB size. This _should_ cover typical
>> use cases and overflow is logged. Future work could implement dynamic
>> allocation based on blit dimensions.
>> 
>> Tested on Rage 128. From what I understand the R100 also shares these
>> registers but that device has not been tested against Xorg. There
>> seem to be other issues preventing Xorg from starting with the radeon
>> driver.
>
> I think the problem with R100 is that it needs CCE and that's the main issue 
> with the driver, at least with Linux DRM and the Amiga like drivers I've 
> checked, I don't know about older Linux framebuffer and Xorg drivers.
>
>> Note: The xorg/xf86-video-r128 drivers support both CCE (DMA)
>> and MMIO acceleration. This implements MMIO, which the driver
>> uses when built with --disable-dri. CCE of course is another can of
>> worms.
>
> I know about two other uses of host data that this could be tested with:
>
> Solaris also uses it and could reproduce it with sol-10-u11-ga-x86-dvd.iso I 
> think it needs qemu-system-x86_64 -m 1G -cpu coreduo -device 
> ati-vga,model=rv100 but it was a long time ago I've last tried.
>
> MorphOS when rendering bitmap fonts as reported here: 
> https://morph.zone/modules/newbb_plus/viewtopic.php?forum=3&topic_id=13912&post_id=160655&viewmode=flat&sortorder=0&showonepost=1
> I could reproduce it with TVPaint under MorphOS.
>
> If you don't have these or can't test it I can eventually try with these but 
> just in case you need more test cases these are that I know of.
>
> Some more comments below.
>
>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>> ---
>> hw/display/ati.c      |  78 ++++++++++++++++++++++++++++--
>> hw/display/ati_2d.c   | 110 +++++++++++++++++++++++++++++++++++++++++-
>> hw/display/ati_dbg.c  |   9 ++++
>> hw/display/ati_int.h  |   6 +++
>> hw/display/ati_regs.h |  28 ++++++++++-
>> 5 files changed, 223 insertions(+), 8 deletions(-)
>> 
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index f7c0006a87..1dfaa79202 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -510,6 +510,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, 
>> unsigned int size)
>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>         val = s->regs.default_sc_bottom_right;
>>         break;
>> +    case SC_TOP_LEFT:
>> +        val = s->regs.sc_top_left;
>> +        break;
>> +    case SC_BOTTOM_RIGHT:
>> +        val = s->regs.sc_bottom_right;
>> +        break;
>> +    case SRC_SC_BOTTOM_RIGHT:
>> +        val = s->regs.src_sc_bottom_right;
>> +        break;
>>     default:
>>         break;
>>     }
>> @@ -804,9 +813,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>         }
>>         break;
>>     case DST_WIDTH:
>> +    {
>> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>>         s->regs.dst_width = data & 0x3fff;
>> -        ati_2d_blt(s);
>> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
>> +            ati_2d_blt(s);
>> +        }
>>         break;
>> +    }
>>     case DST_HEIGHT:
>>         s->regs.dst_height = data & 0x3fff;
>>         break;
>> @@ -853,21 +867,39 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>         s->regs.dst_y = (data >> 16) & 0x3fff;
>>         break;
>>     case DST_HEIGHT_WIDTH:
>> +    {
>> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>>         s->regs.dst_width = data & 0x3fff;
>>         s->regs.dst_height = (data >> 16) & 0x3fff;
>> -        ati_2d_blt(s);
>> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
>> +            ati_2d_blt(s);
>> +        }
>>         break;
>> +    }
>>     case DP_GUI_MASTER_CNTL:
>> -        s->regs.dp_gui_master_cntl = data & 0xf800000f;
>> +        s->regs.dp_gui_master_cntl = data & 0xff80000f;
>>         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
>>                               (data & 0x4000) << 16;
>>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
>> +
>> +        if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
>> +            s->regs.src_sc_bottom_right = s->regs.default_sc_bottom_right;
>> +        }
>> +        if ((data & GMC_DST_CLIPPING_MASK) == GMC_DST_CLIP_DEFAULT) {
>> +            s->regs.sc_top_left = 0;
>> +            s->regs.sc_bottom_right = s->regs.default_sc_bottom_right;
>> +        }
>>         break;
>>     case DST_WIDTH_X:
>> +    {
>> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>>         s->regs.dst_x = data & 0x3fff;
>>         s->regs.dst_width = (data >> 16) & 0x3fff;
>> -        ati_2d_blt(s);
>> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
>> +            ati_2d_blt(s);
>> +        }
>>         break;
>> +    }
>>     case SRC_X_Y:
>>         s->regs.src_y = data & 0x3fff;
>>         s->regs.src_x = (data >> 16) & 0x3fff;
>> @@ -877,10 +909,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>         s->regs.dst_x = (data >> 16) & 0x3fff;
>>         break;
>>     case DST_WIDTH_HEIGHT:
>> +    {
>> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>>         s->regs.dst_height = data & 0x3fff;
>>         s->regs.dst_width = (data >> 16) & 0x3fff;
>> -        ati_2d_blt(s);
>> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
>> +            ati_2d_blt(s);
>> +        }
>>         break;
>> +    }
>>     case DST_HEIGHT_Y:
>>         s->regs.dst_y = data & 0x3fff;
>>         s->regs.dst_height = (data >> 16) & 0x3fff;
>> @@ -909,6 +946,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>     case DP_CNTL:
>>         s->regs.dp_cntl = data;
>>         break;
>> +    case DP_SRC_FRGD_CLR:
>> +        s->regs.dp_src_frgd_clr = data;
>> +        break;
>> +    case DP_SRC_BKGD_CLR:
>> +        s->regs.dp_src_bkgd_clr = data;
>> +        break;
>>     case DP_DATATYPE:
>>         s->regs.dp_datatype = data & 0xe0070f0f;
>>         break;
>> @@ -937,6 +980,29 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
>>         break;
>> +    case SC_TOP_LEFT:
>> +        s->regs.sc_top_left = data;
>> +        break;
>> +    case SC_BOTTOM_RIGHT:
>> +        s->regs.sc_bottom_right = data;
>> +        break;
>> +    case SRC_SC_BOTTOM_RIGHT:
>> +        s->regs.src_sc_bottom_right = data;
>> +        break;
>> +    case HOST_DATA0 ... HOST_DATA7:
>> +    case HOST_DATA_LAST:
>> +        if (s->host_data_pos + 4 > sizeof(s->host_data_buffer)) {
>> +            qemu_log_mask(LOG_UNIMP, "HOST_DATA buffer overflow "
>> +                         "(buffer size: %zu bytes)\n",
>> +                          sizeof(s->host_data_buffer));
>> +            return;
>> +        }
>> +        stn_he_p(&s->host_data_buffer[s->host_data_pos], 4, data);
>> +        s->host_data_pos += 4;
>> +        if (addr == HOST_DATA_LAST) {
>> +            ati_2d_blt(s);
>> +        }
>> +        break;
>>     default:
>>         break;
>>     }
>> @@ -1018,6 +1084,7 @@ static void ati_vga_realize(PCIDevice *dev, Error 
>> **errp)
>>     /* most interrupts are not yet emulated but MacOS needs at least VBlank 
>> */
>>     dev->config[PCI_INTERRUPT_PIN] = 1;
>>     timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, ati_vga_vblank_irq, 
>> s);
>> +    s->host_data_pos = 0;
>
> You probably don't need this line because device state is 0 init and reset 
> will run after realize and overwrite it so it's enough to reset it in the 
> reset method below.
>
>> }
>> 
>> static void ati_vga_reset(DeviceState *dev)
>> @@ -1030,6 +1097,7 @@ static void ati_vga_reset(DeviceState *dev)
>>     /* reset vga */
>>     vga_common_reset(&s->vga);
>>     s->mode = VGA_MODE;
>> +    s->host_data_pos = 0;
>> }
>> 
>> static void ati_vga_exit(PCIDevice *dev)
>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>> index 309bb5ccb6..6b0b4775ff 100644
>> --- a/hw/display/ati_2d.c
>> +++ b/hw/display/ati_2d.c
>> @@ -24,6 +24,9 @@
>>  * possible.
>>  */
>> 
>> +#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & 
>> GMC_DST_PITCH_OFFSET_CNTL)
>
> May need a better name? There are different defaults so not clear which one 
> is this or is it used for all parameters?
>
>> +#define EXPANDED_SRC_BPP 32
>> +
>> static int ati_bpp_from_datatype(ATIVGAState *s)
>> {
>>     switch (s->regs.dp_datatype & 0xf) {
>> @@ -43,7 +46,106 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>>     }
>> }
>> 
>> -#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)

As this was there before, just disregard by above comment about it,

Regards,
BALATON Zoltan

