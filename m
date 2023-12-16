Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7D815BA2
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 21:20:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEb7g-0003Od-Jh; Sat, 16 Dec 2023 15:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb7e-0003OV-BB
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:18:54 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb7c-0002HC-07
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:18:54 -0500
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-55319563d9cso273371a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 12:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702757930; x=1703362730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZOD20AmV3dIxiJDQ+0mrVW4rClFfypH0vSCLUhBmKs=;
 b=NW608DDvQ2EARnEIzfvjr1Q0UjT/iXvTz54E01H2HspoBGYrcQIM2SlpAxsXVzjoPf
 nePxTgxB/g5AOouRI37ewU9dT65tAWj0TqI3JfzCFWCrhNG9sRJunLwvWaYU4b3cXoB6
 Z95U6+K/yg7tjYNNZkcM7PE7cCSZA0V3/XH+2XqTgjf6APQYa5Vga76eF2Syiu8f8x2G
 PSP5Aj6Ky75DccEwL9LrDsliJezPOBUM06i0GQzh96r4DFyMDM4AyON/Y+WjMvsUKeQP
 qjy8atVMTZJCanvFBWxrmIRba36tkVoWUv1vtsiTfkdO4BBl0wZzvd2lH7oHIPgJF1qY
 r7bg==
X-Gm-Message-State: AOJu0Yw1x7F7HAdNBCXRSKkob0FdGn8q8tfdpTYdJ2IolAAF8dc0mmLi
 QzFae0RKlbh8/XGikCOf+PFA240312A=
X-Google-Smtp-Source: AGHT+IGXJgJBBUUSoyGltHR6mKVJP5CC53LdyKWHrY/Gd3JzVm/ZJT2G1dgx6Hv1RXcFAxyrgl+0PA==
X-Received: by 2002:a50:cd55:0:b0:553:2294:816f with SMTP id
 d21-20020a50cd55000000b005532294816fmr147554edj.3.1702757930122; 
 Sat, 16 Dec 2023 12:18:50 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 u14-20020aa7db8e000000b005530cb1464bsm518766edt.15.2023.12.16.12.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 12:18:49 -0800 (PST)
Date: Sat, 16 Dec 2023 21:18:48 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 09/12] next-cube.c: move static old_scr2 variable to NeXTPC
Message-ID: <20231216211848.2d9af1c9@fedora>
In-Reply-To: <20231215200009.346212-10-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.49; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f49.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 15 Dec 2023 20:00:06 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move the old_scr2 variable to NeXTPC so that the old SCR2 register state is
> stored along with the current SCR2 state.
> 
> Since the SCR2 register is 32-bits wide, convert old_scr2 to uint32_t and
> update the SCR2 register access code to allow unaligned writes.
> 
> Note that this is a migration break, but as nothing will currently boot then
> we do not need to worry about this now.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 7ffd1c412e..fd707b4b54 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -91,6 +91,7 @@ struct NeXTPC {
>  
>      uint32_t scr1;
>      uint32_t scr2;
> +    uint32_t old_scr2;
>      uint32_t int_mask;
>      uint32_t int_status;
>      uint32_t led;
> @@ -137,8 +138,7 @@ static void next_scr2_led_update(NeXTPC *s)
>  
>  static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>  {
> -    static uint8_t old_scr2;
> -    uint8_t scr2_2;
> +    uint8_t old_scr2, scr2_2;
>      NextRtc *rtc = &s->rtc;
>  
>      if (size == 4) {
> @@ -147,6 +147,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>          scr2_2 = val & 0xFF;
>      }
>  
> +    old_scr2 = (s->old_scr2 >> 8) & 0xff;
> +
>      if (scr2_2 & 0x1) {
>          /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>          if (rtc->phase == -1) {
> @@ -255,7 +257,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>      }
>      s->scr2 = val & 0xFFFF00FF;
>      s->scr2 |= scr2_2 << 8;
> -    old_scr2 = scr2_2;
>  }
>  
>  static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
> @@ -321,8 +322,11 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>          break;
>  
>      case 0xd000 ... 0xd003:
> +        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> +                            size << 3, val);
>          next_scr2_led_update(s);
>          nextscr2_write(s, val, size);
> +        s->old_scr2 = s->scr2;
>          break;

Ah, I see, now you set s->scr2 here already ... I think you should swap the
order of the patches 08 and 09...?

 Thomas

