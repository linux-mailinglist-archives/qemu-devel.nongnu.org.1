Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972497E752F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 00:35:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1EXd-0004p4-DW; Thu, 09 Nov 2023 18:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EXb-0004om-8O
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:34:27 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1EXZ-0001DX-A6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 18:34:26 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b5aee410f2so810881b6e.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 15:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699572864; x=1700177664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v3jppUeEd320Y8fdOz/rUSZHbzt53xKH4zhdrGWNlDo=;
 b=t7Jap5Ot5+LGUjHIVTCUgWb/mngAVTkAJMOXwd1+zghJCrfLrphEfkmG9Ke+VbB1d1
 QU454vq9E8NBPrd3fPLqi359lTZRytIX/4wdP9JhiadH89InRohAZTPelhp4JZFGrRV0
 FHMg6ZaEb43zKjNmvDq3DPPQeOnZFHSRU+3siH/Ld4m6IlVi4oQh1djgADBC5JaJqENx
 eDn9x2kWlClzKfAaaYel9qllaq6Tv2ZWcgn/XTH11EpHaamNE1mlwLheiVlr8ZQwPSXS
 I8xellCUnc4vc6YFu2aAIYmhGqHpTM72brNwC7TSP94qqA4enL8+K1oyrEyFYQc5L97p
 01pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699572864; x=1700177664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3jppUeEd320Y8fdOz/rUSZHbzt53xKH4zhdrGWNlDo=;
 b=etucPBmi+0QWiQmde5P2QsA70Trx5+vvXx071/KHraKGD7b3BgQUKPsA7rqie3j4o2
 I9YmOUgA4xY2lsyghIee5/owYw2hhAn1R6USCVl9dH2+5QXixpfQaNog0v1NvqR0+0aY
 6k1cFxJfl3T8eqN4uKCbEMNVy3B0KFEaKwhanGGQfe/8WkCxmn57Z6mfRxzVBUTbAauy
 0vHTCZwmG3DM96WPVSLVbQZSWmGFo6zmDULMpooSjrSA6mPwP9ZZWt9tTVEBO/N2MBOC
 nY6H7AJ2hLMHMCfDpIgR7A2gV7TpdZBSFvIgJoosHoQXJnDo9YnDnZsg/Jf349L5G7X9
 V5KA==
X-Gm-Message-State: AOJu0YzVTNKPfck8/v+z1leTqAijPcHfogF6V4uhl0PC/eBDYoIHd6Ih
 oZJ+MfKXpRBiZhipkD7C3P8d6Q==
X-Google-Smtp-Source: AGHT+IFvAMWOwhO7wqRrIv2YKQqzWdvtS3FVFZLPhIW4lhB0BAwve4GdIdZKbU9n3ixE+P1cJ7kZ5A==
X-Received: by 2002:a05:6808:4c4:b0:3b2:dfa0:aea3 with SMTP id
 a4-20020a05680804c400b003b2dfa0aea3mr3849934oie.3.1699572863810; 
 Thu, 09 Nov 2023 15:34:23 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ee6:29b:6626:64c4:1b48:c565?
 ([2607:fb91:1ee6:29b:6626:64c4:1b48:c565])
 by smtp.gmail.com with ESMTPSA id
 29-20020a630a1d000000b0057412d84d25sm5191779pgk.4.2023.11.09.15.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 15:34:23 -0800 (PST)
Message-ID: <858ea782-e9da-4eed-a065-ef0266e01591@linaro.org>
Date: Thu, 9 Nov 2023 15:34:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 10/10] hw/char/pl011: Implement TX FIFO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231109192814.95977-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
> If the UART back-end chardev doesn't drain data as fast as stdout
> does or blocks, buffer in the TX FIFO to try again later.
> 
> This avoids having the IO-thread busy waiting on chardev back-ends,
> reported recently when testing the Trusted Reference Stack and
> using the socket backend:
> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574
> 
> Implement registering a front-end 'watch' callback on back-end
> events, so we can resume transmitting when the back-end is writable
> again, not blocking the main loop.
> 
> Similarly to the RX FIFO path, FIFO level selection is not
> implemented (interrupt is triggered when a single byte is available
> in the FIFO).
> 
> We only migrate the TX FIFO if it is in use.
> 
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/pl011.c      | 107 ++++++++++++++++++++++++++++++++++++++++---
>   hw/char/trace-events |   4 ++
>   2 files changed, 105 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index f474f56780..a14ece4f07 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -57,6 +57,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
>   /* Data Register, UARTDR */
>   #define DR_BE   (1 << 10)
>   
> +/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
> +#define RSR_OE  (1 << 3)
> +
>   /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
>   #define INT_OE (1 << 10)
>   #define INT_BE (1 << 9)
> @@ -156,6 +159,68 @@ static void pl011_reset_tx_fifo(PL011State *s)
>       fifo8_reset(&s->xmit_fifo);
>   }
>   
> +static gboolean pl011_drain_tx(PL011State *s)
> +{
> +    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
> +    pl011_reset_tx_fifo(s);
> +    s->rsr &= ~RSR_OE;
> +    return G_SOURCE_REMOVE;
> +}
> +
> +static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *opaque)
> +{
> +    PL011State *s = opaque;
> +    int ret;
> +    const uint8_t *buf;
> +    uint32_t buflen;
> +    uint32_t count;
> +    bool tx_enabled;
> +
> +    tx_enabled = (s->cr & CR_UARTEN) && (s->cr & CR_TXE);
> +    if (!tx_enabled) {
> +        /*
> +         * If TX is disabled, nothing to do.
> +         * Keep the potentially used FIFO as is.
> +         */
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +        /* Instant drain the fifo when there's no back-end */
> +        return pl011_drain_tx(s);
> +    }
> +
> +    count = fifo8_num_used(&s->xmit_fifo);
> +    if (count < 1) {
> +        /* FIFO empty */
> +        return G_SOURCE_REMOVE;
> +    }

Could swap these two blocks.  Certainly the fifo does not need draining if it is empty...

> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /* Reschedule another transmission if we couldn't transmit all */
> +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> +                                        pl011_xmit, s);
> +        if (!r) {
> +            /* Error in back-end? */
> +            return pl011_drain_tx(s);
> +        }
> +    }
> +
> +    pl011_update(s);
> +
> +    return G_SOURCE_REMOVE;

The documentation for FEWatchFunc says you should be returning G_SOURCE_CONTINUE to leave 
the source in the main loop.  That certainly makes more sense than re-adding a watch when 
the fifo is not empty.  There's also no error handling to do then.  Just


     pl011_update(s);
     return fifo8_is_empty(&s->xmit_fifo) ? G_SOURCE_REMOVE : G_SOURCE_CONTINUE;

> +    case 12: /* UARTCR */ {
> +        uint16_t en_bits = s->cr & (CR_UARTEN | CR_TXE | CR_RXE);
> +        uint16_t dis_bits = value & (CR_UARTEN | CR_TXE | CR_RXE);
> +        if (en_bits ^ dis_bits && !fifo8_is_empty(&s->xmit_fifo)) {
> +            /*
> +             * If the UART is disabled in the middle of transmission
> +             * or reception, it completes the current character before
> +             * stopping.
> +             */
> +            pl011_xmit(NULL, G_IO_OUT, s);

This seems wrong.  You don't know that the host device is ready.

We will never transmit a partial character because the host will never accept less than 
one character at a time.  Therefore there's absolutely nothing we need to do in order to 
"complete the current character", which is the one we started with the *previous* pl011_xmit.

Just set the CR bits with no further comment.


r~

