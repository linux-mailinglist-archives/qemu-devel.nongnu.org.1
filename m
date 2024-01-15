Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71382DE81
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:34:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQqY-0002R0-Vq; Mon, 15 Jan 2024 12:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQqW-0002Qk-Tn
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:34:00 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQqU-0007dK-Jk
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:34:00 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-555bd21f9fdso10037493a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705340037; x=1705944837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jYf2/VMT4LcJ0PXjcad73y6ZLkANqlpXuWeXM2OmQpo=;
 b=yNYPR2VxAjdmEUJy1y68mVwMmd2DE4uYwpc4a2XVdrnHujTwB+CWzdlDD8RJr8EB2n
 A47Ustpf+oMAidk0+P0DbfdAEKVfa8WHXlQIHRK0ndlQ1DuQsRsAnVy8WiRFaIiWlv3x
 c0X1ZI8K16LWsxNc+RYK3XLuss7tY7LqsHeD8KQ5TQ9vmk9DbfxqmGuaYWfOko94cUy8
 cQfYLKkS2MSAUDeXdZ8RXSnl15ztqqszJPCU2P9+DwOHD3t4nnl92NyCSBHjHQuTplM4
 K6IA19NsDUXhvvj/fpXM0Jm0BMNYmS+Mx4sCh5zr17pUyBJgaHusLLvd3TLAkJauriBh
 O1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705340037; x=1705944837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYf2/VMT4LcJ0PXjcad73y6ZLkANqlpXuWeXM2OmQpo=;
 b=AmZ7k7BLdnThw+ogkt2Lydxij4F81xE08JyYkSUMvo9CxS/d+AKs/alEWTNlscChwT
 A8rrLjpi/472zwpmllsxfCGzhq3jvkYlKQIBsU30RxoImv4Yk6tw0eCpXKKMid0O2WOu
 Ojcmh4clQ/kMVMg66gFH1kRT3bXJ3t7CVpyf2SBZmFFNp6oUpY3oOM47yAN83JPJiTTA
 bIMwevVaYrkE8pVdy5f3zfOkcZUNgOnEo3xIsg2LZcY/SPqBgqFTe5A7Ey9qjJIN35Rr
 iHbKJ9t+JL1pVjebKKXOr7W4qVTVVlulZQsTGvA3Ukf3nbwbPzyYiokpBAELjuxvfcEq
 5JSA==
X-Gm-Message-State: AOJu0YwYPf2ZW7mlu7gCuyiAPMAqPEtpOp4pXzlVua5xVG12/vLWASvZ
 HwdRqMxNOmKntsQHKTcSRw/IA53cpS6m/M1sJA/r+whl2VLdYQ==
X-Google-Smtp-Source: AGHT+IGnQVkG3fMrRK2BGUzphMQpgXYde4KEQxRqq/i1JZmm2uwrD0fXCqdsvk8a5wQvuOsHbZPR22wME4rCw09KKY8=
X-Received: by 2002:a50:ec91:0:b0:553:69e5:906a with SMTP id
 e17-20020a50ec91000000b0055369e5906amr3124860edr.6.1705340036829; Mon, 15 Jan
 2024 09:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20240111133350.66558-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240111133350.66558-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 17:33:45 +0000
Message-ID: <CAFEAcA-it-Mw+c=vo61GcAVaaYNBRZPUhLuAKmyWLXSp1O48Hw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/imx_serial: Implement receive FIFO and ageing
 timer for imx serial.
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 11 Jan 2024 at 13:33, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch implements a 32 half word FIFO as per imx serial device
> specifications. If a non empty FIFO is below the trigger level, an ageing
> timer will tick for a duration of 8 characters. On expiry, AGTIM will be set
> triggering an interrupt. AGTIM timer resets when there is activity in
> the receive FIFO.
>
> Otherwise, RRDY is set when trigger level is
> exceeded. The receive trigger level is 8 in newer kernel versions and 1 in
> older ones.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Hi; thanks for this patch. My main question is whether
we can use our generic FIFO implementation (include/qemu/fifo32.h)
rather than hand-rolling one. Otherwise the remarks below
are all minor things.

> ---
>  hw/char/imx_serial.c         | 116 ++++++++++++++++++++++++++++++-----
>  include/hw/char/imx_serial.h |  22 ++++++-
>  2 files changed, 121 insertions(+), 17 deletions(-)
>
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index 1df862eb7f..6ec67be282 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -44,7 +44,11 @@ static const VMStateDescription vmstate_imx_serial = {
>      .version_id = 2,
>      .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_INT32(readbuff, IMXSerialState),
> +        VMSTATE_INT32_ARRAY(rx_fifo, IMXSerialState,
> +                            FIFO_SIZE),
> +        VMSTATE_UINT8(rx_start, IMXSerialState),
> +        VMSTATE_UINT8(rx_end, IMXSerialState),
> +        VMSTATE_UINT8(rx_used, IMXSerialState),

If we change the vmstate fields, we need to also increment
the version_id and minimum_version_id, because this is a
migration compatibility break. The compat break should also
be noted in the commit message.

(There are ways to maintain compatibility, but for the imx6
boards we don't really care about cross-version compat, so
bumping the version numbers lets us at least give the user
a comprehensible error message if they try something that
we don't support.)

>          VMSTATE_UINT32(usr1, IMXSerialState),
>          VMSTATE_UINT32(usr2, IMXSerialState),
>          VMSTATE_UINT32(ucr1, IMXSerialState),
> @@ -64,13 +68,16 @@ static void imx_update(IMXSerialState *s)
>      uint32_t usr1;
>      uint32_t usr2;
>      uint32_t mask;
> -
>      /*

Stray whitespace change.

>       * Lucky for us TRDY and RRDY has the same offset in both USR1 and
>       * UCR1, so we can get away with something as simple as the
>       * following:
>       */
>      usr1 = s->usr1 & s->ucr1 & (USR1_TRDY | USR1_RRDY);
> +    /*
> +     * Interrupt if AGTIM is set (ageing timer interrupt in RxFIFO)
> +     */
> +    usr1 |= (s->ucr2 & UCR2_ATEN) ? (s->usr1 & USR1_AGTIM) : 0;
>      /*
>       * Bits that we want in USR2 are not as conveniently laid out,
>       * unfortunately.
> @@ -85,11 +92,73 @@ static void imx_update(IMXSerialState *s)
>      usr2 = s->usr2 & mask;
>
>      qemu_set_irq(s->irq, usr1 || usr2);
> +

Another stray whitespace change.

>  }
>
> -static void imx_serial_reset(IMXSerialState *s)
> +static void imx_serial_rx_fifo_push(IMXSerialState *s, uint32_t value)
> +{
> +    uint8_t new_rx_end = (s->rx_end + 1) % FIFO_SIZE;
> +    s->rx_used++;
> +
> +    if (s->rx_used > FIFO_SIZE) {
> +        /*
> +         * Handle 33rd character in filled RxFIFO
> +         */
> +        s->rx_start = (s->rx_start + 1) % FIFO_SIZE;
> +        s->rx_used--;
> +    }
> +    s->rx_fifo[s->rx_end] = value;
> +    s->rx_end = new_rx_end;
> +}

Is there a reason we can't use our generic 32-bit
FIFO implementation (include/qemu/fifo32.h) ?

> +
> +static int32_t imx_serial_rx_fifo_pop(IMXSerialState *s)
> +{
> +    int32_t front;
> +    if (s->rx_used == 0) {
> +        /*
> +         * FIFO is already empty
> +         */
> +        return URXD_ERR;
> +    }
> +    front = s->rx_fifo[s->rx_start];
> +
> +    s->rx_start = (s->rx_start + 1) % FIFO_SIZE;
> +    s->rx_used--;
> +
> +    return front;
> +}
> +
> +static void imx_serial_rx_fifo_ageing_timer_int(void *opaque)
> +{
> +    IMXSerialState* s = (IMXSerialState *) opaque;

You don't want a whitespace after the cast and before
'opaque', here and below. (I don't know if this is something
scripts/checkpatch.pl will warn about or not.)

> +    s->usr1 |= USR1_AGTIM;
> +
> +    imx_update(s);
> +}
> +
> +static void imx_serial_rx_fifo_ageing_timer_restart(void *opaque)
>  {
> +    /*
> +     * Ageing timer starts ticking when
> +     * RX FIFO is non empty and below trigger level.
> +     * Timer is reset if new character is received or
> +     * a FIFO read occurs.
> +     * Timer triggers an interrupt when duration of
> +     * 8 characters has passed ( assuming 115200 baudrate ).
> +     */
> +    IMXSerialState* s = (IMXSerialState *) opaque;
> +    uint8_t rxtl = s->ufcr & TL_MASK;
> +
> +    if (s->rx_used > 0 && s->rx_used < rxtl) {
> +        timer_mod_ns(&s->ageing_timer,
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + AGE_DURATION_NS);
> +    } else {
> +        timer_del(&s->ageing_timer);
> +    }
> +}
>
> +static void imx_serial_reset(IMXSerialState *s)
> +{
>      s->usr1 = USR1_TRDY | USR1_RXDS;
>      /*
>       * Fake attachment of a terminal: assert RTS.
> @@ -102,13 +171,20 @@ static void imx_serial_reset(IMXSerialState *s)
>      s->ucr3 = 0x700;
>      s->ubmr = 0;
>      s->ubrc = 4;
> -    s->readbuff = URXD_ERR;
> +
> +
> +    memset(s->rx_fifo, 0, sizeof(s->rx_fifo));
> +    s->rx_used = 0;
> +    s->rx_start = 0;
> +    s->rx_end = 0;
> +
> +    timer_init_ns(&s->ageing_timer, QEMU_CLOCK_VIRTUAL,
> +        imx_serial_rx_fifo_ageing_timer_int, s);

We should only initialize the timer once, in the device's
realize method. In this reset function, we only want to
call timer_del(), to ensure it is not running.

>  }
>
>  static void imx_serial_reset_at_boot(DeviceState *dev)
>  {
>      IMXSerialState *s = IMX_SERIAL(dev);
> -
>      imx_serial_reset(s);
>
>      /*

Another stray whitespace change.

> @@ -126,19 +202,24 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
>  {
>      IMXSerialState *s = (IMXSerialState *)opaque;
>      uint32_t c;
> -
> +    uint8_t rxtl = s->ufcr & TL_MASK;
>      DPRINTF("read(offset=0x%" HWADDR_PRIx ")\n", offset);
> -

Whitespace changes again.

>      switch (offset >> 2) {
>      case 0x0: /* URXD */
> -        c = s->readbuff;
> +        c = imx_serial_rx_fifo_pop(s);
>          if (!(s->uts1 & UTS1_RXEMPTY)) {
>              /* Character is valid */
>              c |= URXD_CHARRDY;
> -            s->usr1 &= ~USR1_RRDY;
> -            s->usr2 &= ~USR2_RDR;
> -            s->uts1 |= UTS1_RXEMPTY;
> +            /* Clear RRDY if below threshold */
> +            if (s->rx_used < rxtl) {
> +                s->usr1 &= ~USR1_RRDY;
> +            }
> +            if (s->rx_used == 0) {
> +                s->usr2 &= ~USR2_RDR;
> +                s->uts1 |= UTS1_RXEMPTY;
> +            }
>              imx_update(s);
> +            imx_serial_rx_fifo_ageing_timer_restart(s);
>              qemu_chr_fe_accept_input(&s->chr);
>          }
>          return c;
> @@ -300,19 +381,24 @@ static void imx_serial_write(void *opaque, hwaddr offset,
>  static int imx_can_receive(void *opaque)
>  {
>      IMXSerialState *s = (IMXSerialState *)opaque;
> -    return !(s->usr1 & USR1_RRDY);
> +    return s->ucr1 & UCR1_RRDYEN &&
> +        s->ucr2 & UCR2_RXEN && s->rx_used < FIFO_SIZE;
>  }
>
>  static void imx_put_data(void *opaque, uint32_t value)
>  {
>      IMXSerialState *s = (IMXSerialState *)opaque;
> -
> +    uint8_t rxtl = s->ufcr & TL_MASK;
>      DPRINTF("received char\n");
> +    imx_serial_rx_fifo_push(s, value);
> +    if (s->rx_used >= rxtl) {
> +        s->usr1 |= USR1_RRDY;
> +    }
> +
> +    imx_serial_rx_fifo_ageing_timer_restart(s);
>
> -    s->usr1 |= USR1_RRDY;
>      s->usr2 |= USR2_RDR;
>      s->uts1 &= ~UTS1_RXEMPTY;
> -    s->readbuff = value;
>      if (value & URXD_BRK) {
>          s->usr2 |= USR2_BRCD;
>      }
> diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
> index b823f94519..86a0a102a5 100644
> --- a/include/hw/char/imx_serial.h
> +++ b/include/hw/char/imx_serial.h
> @@ -25,6 +25,8 @@
>  #define TYPE_IMX_SERIAL "imx.serial"
>  OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
>
> +#define FIFO_SIZE       32
> +
>  #define URXD_CHARRDY    (1<<15)   /* character read is valid */
>  #define URXD_ERR        (1<<14)   /* Character has error */
>  #define URXD_FRMERR     (1<<12)   /* Character has frame error */
> @@ -65,6 +67,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
>  #define UCR1_TXMPTYEN   (1<<6)    /* Tx Empty Interrupt Enable */
>  #define UCR1_UARTEN     (1<<0)    /* UART Enable */
>
> +#define UCR2_ATEN       BIT(3)    /* Ageing Timer Enable */
>  #define UCR2_TXEN       (1<<2)    /* Transmitter enable */
>  #define UCR2_RXEN       (1<<1)    /* Receiver enable */
>  #define UCR2_SRST       (1<<0)    /* Reset complete */
> @@ -78,13 +81,28 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)
>  #define UTS1_TXFULL     (1<<4)
>  #define UTS1_RXFULL     (1<<3)
>
> +#define TL_MASK         0x3f
> +
> + /* Bit time in nanoseconds assuming maximum baud rate of 115200 */
> +#define BIT_TIME_NS     8681
> +
> +/* Assume 8 bits per character */
> +#define NUM_BITS        8
> +
> +/* Ageing timer triggers after 8 characters */
> +#define AGE_DURATION_NS (8 * NUM_BITS * BIT_TIME_NS)
> +
>  struct IMXSerialState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> -
>      /*< public >*/
>      MemoryRegion iomem;
> -    int32_t readbuff;
> +    QEMUTimer ageing_timer;
> +
> +    int32_t rx_fifo[FIFO_SIZE];
> +    uint8_t rx_start;
> +    uint8_t rx_end;
> +    uint8_t rx_used;
>
>      uint32_t usr1;
>      uint32_t usr2;
> --
> 2.34.1

thanks
-- PMM

