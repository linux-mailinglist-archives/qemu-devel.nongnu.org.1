Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716F81B056
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEVJ-0001pm-Ox; Thu, 21 Dec 2023 03:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEVH-0001p0-Pu
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:34:03 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEVF-0004sM-GL
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:34:03 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-553729ee917so585929a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703147640; x=1703752440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w01/PVL6WClgvyMjQ0+2pMsdDLT4bs3S9uvjoTVomo0=;
 b=upVDV+9F18eTLQff1ZV4O0dtASpQnZKAwcd3slIPfMyc90yggbgwOTT7B2XTXTw0jm
 Tb6ho03b+GHU6GdKVu42Lu5nMrP7BHc9L8yib0unJRi6YNWjAJDrY0O/BX5doA2kd2wU
 CFdrtwaZ0qxdUuRoFwR4FlnNwogQybLnlc0uw5O3AAAFudxVpAAEcWBva1p3MFbwua2G
 JB/BD1oFo1prewpBQcvLYTTj4e7X2KxPOz9aDgZG18sYYPlwEx4kz91AiMFPCNSJGcn9
 kjcTWaFvpz4Fea/FnlKDSAGfMOEo8oGa8cWdsGE/4F136ZT4nxHqYHe65LPwseXs18tp
 OSdQ==
X-Gm-Message-State: AOJu0YyLY2UrKzGuojyXZk+Upv49EoS3aBFY7uFHPK3TfcXWLO3AjvvW
 GG24jhK6tYbt00Y1GHwexZMzqS9xLK4=
X-Google-Smtp-Source: AGHT+IEmr/qw5nW9s0tXl7t4Rb1JGsjmiSnp1R1IDGh9EB8LecpWH61NJnkxYRnab1G1ejpq42XSxQ==
X-Received: by 2002:a50:d642:0:b0:553:de76:f563 with SMTP id
 c2-20020a50d642000000b00553de76f563mr1419896edj.12.1703147639515; 
 Thu, 21 Dec 2023 00:33:59 -0800 (PST)
Received: from fedora (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a05640212d800b00553479c0494sm866050edx.38.2023.12.21.00.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 00:33:58 -0800 (PST)
Date: Thu, 21 Dec 2023 09:33:56 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/11] next-cube.c: move static old_scr2 variable to
 NeXTPC
Message-ID: <20231221093356.2520d64d@fedora>
In-Reply-To: <843e4a2f-ebf6-4d4f-857e-1ecfe82625ce@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
 <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
 <20231220202012.34ce2b0a@fedora>
 <843e4a2f-ebf6-4d4f-857e-1ecfe82625ce@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Wed, 20 Dec 2023 19:36:27 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 20/12/2023 19:20, Thomas Huth wrote:
> 
> > Am Wed, 20 Dec 2023 13:16:38 +0000
> > schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> >   
> >> Move the old_scr2 variable to NeXTPC so that the old SCR2 register state is
> >> stored along with the current SCR2 state.
> >>
> >> Since the SCR2 register is 32-bits wide, convert old_scr2 to uint32_t and
> >> update the SCR2 register access code to allow unaligned writes.
> >>
> >> Note that this is a migration break, but as nothing will currently boot then
> >> we do not need to worry about this now.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>   hw/m68k/next-cube.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> >> index f2222554fa..d53f73fb8b 100644
> >> --- a/hw/m68k/next-cube.c
> >> +++ b/hw/m68k/next-cube.c
> >> @@ -91,6 +91,7 @@ struct NeXTPC {
> >>   
> >>       uint32_t scr1;
> >>       uint32_t scr2;
> >> +    uint32_t old_scr2;
> >>       uint32_t int_mask;
> >>       uint32_t int_status;
> >>       uint32_t led;
> >> @@ -125,8 +126,7 @@ static const uint8_t rtc_ram2[32] = {
> >>   
> >>   static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
> >>   {
> >> -    static uint8_t old_scr2;
> >> -    uint8_t scr2_2;
> >> +    uint8_t old_scr2, scr2_2;
> >>       NextRtc *rtc = &s->rtc;
> >>   
> >>       if (size == 4) {
> >> @@ -144,6 +144,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
> >>           }
> >>       }
> >>   
> >> +    old_scr2 = (s->old_scr2 >> 8) & 0xff;
> >> +
> >>       if (scr2_2 & 0x1) {
> >>           /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
> >>           if (rtc->phase == -1) {
> >> @@ -252,7 +254,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
> >>       }
> >>       s->scr2 = val & 0xFFFF00FF;
> >>       s->scr2 |= scr2_2 << 8;  
> > 
> > So s->scr2 is updated with the "val" at the end of nextscr2_write() ...
> >   
> >> -    old_scr2 = scr2_2;
> >>   }
> >>   
> >>   static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
> >> @@ -318,7 +319,10 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
> >>           break;
> >>   
> >>       case 0xd000 ... 0xd003:
> >> +        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> >> +                            size << 3, val);  
> > 
> > ... but here it is also updated before nextscr2_write() ? Looks somewhat
> > strange. Though I have to admit that I don't fully understand the logic
> > here anyway... Maybe we could peek at Previous to see how this register is
> > supposed to behave?  
> 
> I'm fairly sure what's supposed to happen is that bits 8-15 of SCR2 are used to 
> bit-bang the RTC and all the other values are preserved, hence the logic at the end 
> of nextscr2_write(). What makes it slightly more confusing is that scr2_2 and 
> old_scr2 in the current version of nextscr2_write() represent just bits 8-15 of SCR2 
> and not the entire register.
> 
> This is something I tried to improve in the following 2 commits by splitting out the 
> LED logic into its own function, and then finally updating old_scr2 to a 32-bit value 
> to match scr2 and using extract32()/deposit32() in next_scr2_rtc_update() to make 
> this process clearer.

Ok, thanks, it makes sense to me now. I also looked at the Previous
handlers for these registers, and it also seems like they treat the four
bytes of the register independently there. So with the following two
patches, I think this is a valid clean up.

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


