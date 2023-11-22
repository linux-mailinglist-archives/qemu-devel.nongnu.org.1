Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C147F43F4
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 11:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5kWS-0004dM-3m; Wed, 22 Nov 2023 05:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5kWI-0004d6-KT; Wed, 22 Nov 2023 05:31:46 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5kWG-0001vK-I4; Wed, 22 Nov 2023 05:31:46 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2f507c03cso3809670b6e.2; 
 Wed, 22 Nov 2023 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700649102; x=1701253902; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xRnJgX5BPvayGYI69im8tUAMArxnMA1xQvESA9sv6s=;
 b=T4WdnHscMtzoMcoc057qJz4fE/8/tbRkUIhYAIEy6kvhRZqJCOujiGC7QEbNXXF/yP
 XLkxo+NCMCPiWRPbeR/367f3vr+z9vGnC6LNHu13h1Hwdkck/tQbw1xSjpeV687/VOn5
 onEixcyDZV2WWaFwQYYs2Et0jQ8pi6R+jb3NQCuaddkhkENuQ92ZWLTFo/DDFMwETWGv
 BeU4qcVV23LnLDA5AKsbGEBLwWI2U3AeyRJMZk3saL/m49Rsv6XRRsAmPw4nj4U2z06E
 JCDtuC3CrtIz4N0HUSKPbkm/tiFCrelk+8HOAnwRDw+mocuYgA/1zuEzsdu4nMYh7Kjm
 Ln1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700649102; x=1701253902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xRnJgX5BPvayGYI69im8tUAMArxnMA1xQvESA9sv6s=;
 b=Xikzzj+26T6zzS+oIsEPcjPYVDK7YYbbiNrh0vcuoYZvb+XAEsv68sAvRk2CcSC8fb
 VqZnCUUefbRZCuLi6cW1mouq4YaQYL4ruvy703HCVM0dZqNdVT0cUYpqn1o/XG+N/I99
 81N0HUz/NW3IOjRQM3jAU1g0I0iCVUuWxWkQ+YZtiPmlAoywenKdjDSSYmMO66XWFkym
 CXxLL9qxfRsQyJpCGsYQxidnAQFcXJc6g1ntgYSPXDf676cNOPbJ6/N0PPDVmlm1iQZ1
 XBFh9ovq46OZgrlxR1RTsyPwR+QZE/+AnOHjNj5/UXaBc/Qhcy1IMRyMa0EHHOee4mrk
 Gu7g==
X-Gm-Message-State: AOJu0YwLf7JoFyoX/pFkqCr2Ij+BzA3auMTlbIyTrKNeVxLEEs/Gos7s
 UFgAhgEoWv8CI4RzbMWYsvcRNeYzEaK95BFyk0A=
X-Google-Smtp-Source: AGHT+IFSwZ2tVyIF7zDmPQqBmcY/48fFavbAi8KvvI7Pu2yJI9yCB9NML+rb2KQb1fUHDiV2Gx5j/U7gCxqeKmm5Q0E=
X-Received: by 2002:a05:6870:8a0a:b0:1d5:eb1:c587 with SMTP id
 p10-20020a0568708a0a00b001d50eb1c587mr2457857oaq.19.1700649101745; Wed, 22
 Nov 2023 02:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-11-philmd@linaro.org>
In-Reply-To: <20231109192814.95977-11-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Nov 2023 14:31:29 +0400
Message-ID: <CAJ+F1CKFFU_VEA4nhgWw9RLDgc_gD0h-FPfvSP4LaFC1j4pP6Q@mail.gmail.com>
Subject: Re: [PATCH-for-8.2 v4 10/10] hw/char/pl011: Implement TX FIFO
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Thu, Nov 9, 2023 at 11:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> If the UART back-end chardev doesn't drain data as fast as stdout
> does or blocks, buffer in the TX FIFO to try again later.
>
> This avoids having the IO-thread busy waiting on chardev back-ends,
> reported recently when testing the Trusted Reference Stack and
> using the socket backend:
> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=3D149574
>
> Implement registering a front-end 'watch' callback on back-end
> events, so we can resume transmitting when the back-end is writable
> again, not blocking the main loop.

I do not have access to that Jira issue.

In general, chardev backends should have some buffering already
(socket, files etc).

If we want more, or extra control over buffering, maybe this should be
implemented at the chardev level, rather than each frontend implement
its own extra buffering logic...

Regardless, I think frontends should have an option to "drop" data
when the chardev/buffer is full, rather than hanging.


>
> Similarly to the RX FIFO path, FIFO level selection is not
> implemented (interrupt is triggered when a single byte is available
> in the FIFO).
>
> We only migrate the TX FIFO if it is in use.
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/char/pl011.c      | 107 ++++++++++++++++++++++++++++++++++++++++---
>  hw/char/trace-events |   4 ++
>  2 files changed, 105 insertions(+), 6 deletions(-)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index f474f56780..a14ece4f07 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -57,6 +57,9 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Ch=
ardev *chr)
>  /* Data Register, UARTDR */
>  #define DR_BE   (1 << 10)
>
> +/* Receive Status Register/Error Clear Register, UARTRSR/UARTECR */
> +#define RSR_OE  (1 << 3)
> +
>  /* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
>  #define INT_OE (1 << 10)
>  #define INT_BE (1 << 9)
> @@ -156,6 +159,68 @@ static void pl011_reset_tx_fifo(PL011State *s)
>      fifo8_reset(&s->xmit_fifo);
>  }
>
> +static gboolean pl011_drain_tx(PL011State *s)
> +{
> +    trace_pl011_fifo_tx_drain(fifo8_num_used(&s->xmit_fifo));
> +    pl011_reset_tx_fifo(s);
> +    s->rsr &=3D ~RSR_OE;
> +    return G_SOURCE_REMOVE;
> +}
> +
> +static gboolean pl011_xmit(void *do_not_use, GIOCondition cond, void *op=
aque)
> +{
> +    PL011State *s =3D opaque;
> +    int ret;
> +    const uint8_t *buf;
> +    uint32_t buflen;
> +    uint32_t count;
> +    bool tx_enabled;
> +
> +    tx_enabled =3D (s->cr & CR_UARTEN) && (s->cr & CR_TXE);
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
> +    count =3D fifo8_num_used(&s->xmit_fifo);
> +    if (count < 1) {
> +        /* FIFO empty */
> +        return G_SOURCE_REMOVE;
> +    }
> +
> +    /* Transmit as much data as we can */
> +    buf =3D fifo8_peek_buf(&s->xmit_fifo, count, &buflen);
> +    ret =3D qemu_chr_fe_write(&s->chr, buf, buflen);
> +    if (ret >=3D 0) {
> +        /* Pop the data we could transmit */
> +        trace_pl011_fifo_tx_xmit(ret);
> +        fifo8_pop_buf(&s->xmit_fifo, ret, NULL);
> +        s->int_level |=3D INT_TX;
> +    }
> +
> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /* Reschedule another transmission if we couldn't transmit all *=
/
> +        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
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
> +}
> +
>  static void pl011_write_txdata(PL011State *s, uint8_t data)
>  {
>      if (!(s->cr & CR_UARTEN)) {
> @@ -165,11 +230,25 @@ static void pl011_write_txdata(PL011State *s, uint8=
_t data)
>          qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled T=
X UART\n");
>      }
>
> -    /* XXX this blocks entire thread. Rewrite to use
> -     * qemu_chr_fe_write and background I/O callbacks */
> -    qemu_chr_fe_write_all(&s->chr, &data, 1);
> -    s->int_level |=3D INT_TX;
> -    pl011_update(s);
> +    if (fifo8_is_full(&s->xmit_fifo)) {
> +        /*
> +         * The FIFO contents remain valid because no more data is
> +         * written when the FIFO is full, only the contents of the
> +         * shift register are overwritten. The CPU must now read
> +         * the data, to empty the FIFO.
> +         */
> +        trace_pl011_fifo_tx_overrun();
> +        s->rsr |=3D RSR_OE;
> +        return;
> +    }
> +
> +    trace_pl011_fifo_tx_put(data);
> +    fifo8_push(&s->xmit_fifo, data);
> +    if (fifo8_is_full(&s->xmit_fifo)) {
> +        s->flags |=3D PL011_FLAG_TXFF;
> +    }
> +
> +    pl011_xmit(NULL, G_IO_OUT, s);
>  }
>
>  static uint32_t pl011_read_rxdata(PL011State *s)
> @@ -331,10 +410,21 @@ static void pl011_write(void *opaque, hwaddr offset=
,
>          s->lcr =3D value;
>          pl011_set_read_trigger(s);
>          break;
> -    case 12: /* UARTCR */
> +    case 12: /* UARTCR */ {
> +        uint16_t en_bits =3D s->cr & (CR_UARTEN | CR_TXE | CR_RXE);
> +        uint16_t dis_bits =3D value & (CR_UARTEN | CR_TXE | CR_RXE);
> +        if (en_bits ^ dis_bits && !fifo8_is_empty(&s->xmit_fifo)) {
> +            /*
> +             * If the UART is disabled in the middle of transmission
> +             * or reception, it completes the current character before
> +             * stopping.
> +             */
> +            pl011_xmit(NULL, G_IO_OUT, s);
> +        }
>          /* ??? Need to implement the enable and loopback bits.  */
>          s->cr =3D value;
>          break;
> +    }
>      case 13: /* UARTIFS */
>          s->ifl =3D value;
>          pl011_set_read_trigger(s);
> @@ -477,6 +567,11 @@ static int pl011_post_load(void *opaque, int version=
_id)
>          s->read_pos =3D 0;
>      }
>
> +    if (!fifo8_is_empty(&s->xmit_fifo)) {
> +        /* Reschedule another transmission */
> +        qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP, pl011_xmit, =
s);
> +    }
> +
>      return 0;
>  }
>
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index bc9e84261f..ee00af0c66 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -60,6 +60,10 @@ pl011_write(uint32_t addr, uint32_t value, const char =
*regname) "addr 0x%03x val
>  pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_=
count %d returning %d"
>  pl011_fifo_rx_put(uint32_t c, int read_count) "new char 0x%02x read_coun=
t now %d"
>  pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
> +pl011_fifo_tx_put(uint8_t byte) "TX FIFO push [0x%02x]"
> +pl011_fifo_tx_xmit(int count) "TX FIFO pop %d"
> +pl011_fifo_tx_overrun(void) "TX FIFO overrun"
> +pl011_fifo_tx_drain(unsigned drained) "TX FIFO draining %u"
>  pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ib=
rd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ",=
 fbrd: %" PRIu32 ")"
>
>  # cmsdk-apb-uart.c
> --
> 2.41.0
>
>


--
Marc-Andr=C3=A9 Lureau

