Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9E81A73A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 20:21:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG27C-0002xC-D2; Wed, 20 Dec 2023 14:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rG278-0002x3-Pt
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:20:18 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rG276-0008RN-Mq
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:20:18 -0500
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so203535e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 11:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703100014; x=1703704814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNNerW0A0Y78SzfMPQfK84H4hlnaldHQC8UNOdUG2QQ=;
 b=p828LbOm/qNok9kD6uixYa4JTme3XTFf75ASe8Tv4pqAyt9r+hJv8Xc80R/uMbMt5T
 tNQg0Y2fDj2gStIOI8ddzPQH5k/Ykqw65mCAULqDSsrWhOe7+bjhwPegG7JPz3ZIbsIt
 eYX0XHYOXzPm9IeX9+ezBNBVpn94LWcYjEz6H+Km+vzFky08FXa+8Xcjf4CNwjTsK/0+
 Ojc/5hFbl9ME6lUMOPg0Eg9jzK+Z+f4OvMQSzvnSqz2JHw4YWQgKw7xDfGGOifhnkCS9
 hYLHzfH0Sn48IpNUv9XyuzVnml+3Zknonxo7HHRtQ6igBRcTRQIrlz9MxtuVXsHBf1Uy
 oRJQ==
X-Gm-Message-State: AOJu0Yw3ESJoZh5a1N5/NJgSqO0c8bEkHEXg8iZNez1sReU1EsBAYogz
 7bHDwT3hf7eZRHAB0+riJ3o=
X-Google-Smtp-Source: AGHT+IHWnFIOHz3mG3trsJ5I9UCViJOy8BnwPraGog3OQrQmBvG5TbxQiaO+SX2g0bQrWJKkxQNNTw==
X-Received: by 2002:a05:600c:1c12:b0:40d:2df3:fe2 with SMTP id
 j18-20020a05600c1c1200b0040d2df30fe2mr47052wms.272.1703100014292; 
 Wed, 20 Dec 2023 11:20:14 -0800 (PST)
Received: from fedora (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0040b4b2a15ebsm586159wmb.28.2023.12.20.11.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 11:20:13 -0800 (PST)
Date: Wed, 20 Dec 2023 20:20:12 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/11] next-cube.c: move static old_scr2 variable to
 NeXTPC
Message-ID: <20231220202012.34ce2b0a@fedora>
In-Reply-To: <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
 <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.41; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f41.google.com
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

Am Wed, 20 Dec 2023 13:16:38 +0000
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
> index f2222554fa..d53f73fb8b 100644
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
> @@ -125,8 +126,7 @@ static const uint8_t rtc_ram2[32] = {
>  
>  static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>  {
> -    static uint8_t old_scr2;
> -    uint8_t scr2_2;
> +    uint8_t old_scr2, scr2_2;
>      NextRtc *rtc = &s->rtc;
>  
>      if (size == 4) {
> @@ -144,6 +144,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>          }
>      }
>  
> +    old_scr2 = (s->old_scr2 >> 8) & 0xff;
> +
>      if (scr2_2 & 0x1) {
>          /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>          if (rtc->phase == -1) {
> @@ -252,7 +254,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>      }
>      s->scr2 = val & 0xFFFF00FF;
>      s->scr2 |= scr2_2 << 8;

So s->scr2 is updated with the "val" at the end of nextscr2_write() ... 

> -    old_scr2 = scr2_2;
>  }
>  
>  static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
> @@ -318,7 +319,10 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>          break;
>  
>      case 0xd000 ... 0xd003:
> +        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
> +                            size << 3, val);

... but here it is also updated before nextscr2_write() ? Looks somewhat
strange. Though I have to admit that I don't fully understand the logic
here anyway... Maybe we could peek at Previous to see how this register is
supposed to behave?

 Thomas

