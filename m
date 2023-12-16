Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E51815B97
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 21:14:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEb2b-00020s-Uj; Sat, 16 Dec 2023 15:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb2a-000207-3q
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:13:40 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEb2Y-0000Wv-J9
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:13:39 -0500
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-a1ec87a7631so145623566b.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 12:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702757617; x=1703362417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yF+CkwwFK8Fki1vhgGa9vW1O6nvrVwHJfUHVd8gD0B8=;
 b=DHWvMqbyQs3Kw3WwSeViVIc+1mQtGcSOKUOc4VV6TgkSUKh4aCWs2ZWu+mfaR9YHt7
 9YaGcbtxqW6uACQOP0C8z/7SgHiXl+uqBn9pA31P/pkXNjmk8ShGNSEnZUBysB7qiTVP
 5sP3jHI44uYbmP7d8sxrxhwYJ4tAqRCf6sWaNnSr/vfdWeQySVetqHarwBRuq1qCCiF/
 BGIXipQV/bdMI5FdxJbC0aOSoHNr4rSsd0hEDWBMjgbuaSWL0T39dqi8t13bMQOnbkF9
 7XPpqnlDv0w2VXXnblqZVPuc786GHrRWHzEkQABcTPJIXf6jxboFVtZn+zNwmeeUgpKW
 MNkA==
X-Gm-Message-State: AOJu0Yz3SSLDTGhAT+V+ptJreLzS6o+jSmCs2U6Ll63x5ah6AmY5wXpY
 PtWQxwZ1/5N+/D2LzcARm5ejPOPOvF8=
X-Google-Smtp-Source: AGHT+IEQ5arpO6hVLiK9M+fvZred/xAFN3FD1UUUjskAF8S5ckdc2POJY5hi0mCBYRFR7V9FC5LozQ==
X-Received: by 2002:a17:906:6d06:b0:9b2:d554:da0e with SMTP id
 m6-20020a1709066d0600b009b2d554da0emr7314059ejr.69.1702757616799; 
 Sat, 16 Dec 2023 12:13:36 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 tx17-20020a1709078e9100b00a1b75e0e061sm12289369ejc.130.2023.12.16.12.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 12:13:36 -0800 (PST)
Date: Sat, 16 Dec 2023 21:13:34 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/12] next-cube.c: move LED logic to new
 next_scr2_led_update() function
Message-ID: <20231216211334.633f7684@fedora>
In-Reply-To: <20231215200009.346212-9-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.44; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f44.google.com
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

Am Fri, 15 Dec 2023 20:00:05 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Ensure that the LED status is updated by calling next_scr2_led_update() whenever
> the SC2 register is written.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index f2222554fa..7ffd1c412e 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -123,6 +123,18 @@ static const uint8_t rtc_ram2[32] = {
>  #define SCR2_RTDATA 0x4
>  #define SCR2_TOBCD(x) (((x / 10) << 4) + (x % 10))
>  
> +static void next_scr2_led_update(NeXTPC *s)
> +{
> +    if (s->scr2 & 0x1) {
> +        DPRINTF("fault!\n");
> +        s->led++;
> +        if (s->led == 10) {
> +            DPRINTF("LED flashing, possible fault!\n");
> +            s->led = 0;
> +        }
> +    }
> +}

This will now operate on the old value of scr2 ...

>  static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>  {
>      static uint8_t old_scr2;
> @@ -135,15 +147,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
>          scr2_2 = val & 0xFF;
>      }
>  
> -    if (val & 0x1) {
> -        DPRINTF("fault!\n");
> -        s->led++;
> -        if (s->led == 10) {
> -            DPRINTF("LED flashing, possible fault!\n");
> -            s->led = 0;
> -        }
> -    }

.. while this was using the new value that was just written.
So this looks wrong to me ... or do I miss something?

 Thomas


>      if (scr2_2 & 0x1) {
>          /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
>          if (rtc->phase == -1) {
> @@ -318,6 +321,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>          break;
>  
>      case 0xd000 ... 0xd003:
> +        next_scr2_led_update(s);
>          nextscr2_write(s, val, size);
>          break;
>  

