Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC1D7D280E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 03:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qujql-0000rc-7U; Sun, 22 Oct 2023 21:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujqi-0000rO-J5; Sun, 22 Oct 2023 21:35:20 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujqg-0002Gx-VO; Sun, 22 Oct 2023 21:35:20 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7b6b4c2f1a0so927059241.1; 
 Sun, 22 Oct 2023 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698024917; x=1698629717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jFT7RT7/jwMRXUcnlJlAXnQ6WZxK2zqDoUqTOO/Ut4=;
 b=BAC8syW6+QZ1DgP+4UJE54n+ImsAY/1urojMyxplx8JUiydZmaWm+Mxgdx1ZEunvkX
 aW6mz8Dzil8mx4477lgDFTY7StaC/NZRy4irrHYTrezNxXqvXBZaz5+CyDiZVJxtOCeM
 QPOLs6HbXvhYwO6pMASM7EEYPs3EhbTFQDWzV1or3bpjsvSlR5vsw00nMefF7qorgSWa
 5zuZSOEdJ+Hd/rr14Hs0UX0V24Rly/OYY/Iy9tVntbfBosWMpdDBuBn76Thr6Rmq/pCI
 3uPpD1TSQK7WJeLtEcHXBFJSsFNUcsDL9T24jHKK4ZQXBiQdtEwG65HacCOZaNEDYO+X
 mXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698024917; x=1698629717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jFT7RT7/jwMRXUcnlJlAXnQ6WZxK2zqDoUqTOO/Ut4=;
 b=gWj7KEKtccsmZTyXhxJxOquu4QxCjxV0iEY4gbBsMwnDstJRWSydo7EYKopOFps37W
 Zc02G3RHQuUCZ5y/xJ+qCTqaS3ZJ4GcysjD/jUSrxDYeFSIKw2ge6igRLxhzB73R8OrA
 2Ud+M3+li/lYHAPcTkfTG10MQwRDkPX4/EiGmN5oVygS6AMnOtVzWdpGDvdgRxnrRmFD
 eKADUMsojHJo7Tvjr6U74RqPN0VcpPtKezkO797NxPhP7IZroBn97GppjUF1ViTDKQmn
 8B+o3M13SA+MieThhJBHamQbknMhaol8U6qAJ04+45W0ANOx1osblTAU6i5LMzSvY55+
 PJJA==
X-Gm-Message-State: AOJu0YwE7sMRWguGCFqAN0C/R4O5bPXmgf97KuNKi6sEmqPl51DWkkmM
 ym5sY2d/6QMmJd+uWtX9xxxTyvrKEPc7xYo9MYU=
X-Google-Smtp-Source: AGHT+IF4V2sUb6gwR/t7wGdGaJmqsUPVskz3JuZPcXaUiNn+3brYcCPCphDUpDiMPvIB8amBSjCNcL5iF7WZKlPDajU=
X-Received: by 2002:a05:6102:4715:b0:457:b01c:4a8e with SMTP id
 ei21-20020a056102471500b00457b01c4a8emr7547206vsb.7.1698024917455; Sun, 22
 Oct 2023 18:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-2-philmd@linaro.org>
In-Reply-To: <20231020170009.86870-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Oct 2023 11:34:50 +1000
Message-ID: <CAKmqyKM0uu_0WdteAQLxPA3L=dDnHGtM9o8M8T4SNN8rjoHAKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/char/stm32f2xx_usart: Extract common IRQ update
 code to update_irq()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Oct 21, 2023 at 4:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
>
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> [PMD: Split from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/stm32f2xx_usart.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index fde67f4f03..519d3461a3 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -53,6 +53,17 @@ static int stm32f2xx_usart_can_receive(void *opaque)
>      return 0;
>  }
>
> +static void stm32f2xx_update_irq(STM32F2XXUsartState *s)
> +{
> +    uint32_t mask =3D s->usart_sr & s->usart_cr1;
> +
> +    if (mask & (USART_SR_TXE | USART_SR_TC | USART_SR_RXNE)) {
> +        qemu_set_irq(s->irq, 1);
> +    } else {
> +        qemu_set_irq(s->irq, 0);
> +    }
> +}
> +
>  static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, in=
t size)
>  {
>      STM32F2XXUsartState *s =3D opaque;
> @@ -66,9 +77,7 @@ static void stm32f2xx_usart_receive(void *opaque, const=
 uint8_t *buf, int size)
>      s->usart_dr =3D *buf;
>      s->usart_sr |=3D USART_SR_RXNE;
>
> -    if (s->usart_cr1 & USART_CR1_RXNEIE) {
> -        qemu_set_irq(s->irq, 1);
> -    }
> +    stm32f2xx_update_irq(s);
>
>      DB_PRINT("Receiving: %c\n", s->usart_dr);
>  }
> @@ -85,7 +94,7 @@ static void stm32f2xx_usart_reset(DeviceState *dev)
>      s->usart_cr3 =3D 0x00000000;
>      s->usart_gtpr =3D 0x00000000;
>
> -    qemu_set_irq(s->irq, 0);
> +    stm32f2xx_update_irq(s);
>  }
>
>  static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
> @@ -106,7 +115,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hw=
addr addr,
>          retvalue =3D s->usart_dr & 0x3FF;
>          s->usart_sr &=3D ~USART_SR_RXNE;
>          qemu_chr_fe_accept_input(&s->chr);
> -        qemu_set_irq(s->irq, 0);
> +        stm32f2xx_update_irq(s);
>          return retvalue;
>      case USART_BRR:
>          return s->usart_brr;
> @@ -145,9 +154,7 @@ static void stm32f2xx_usart_write(void *opaque, hwadd=
r addr,
>          } else {
>              s->usart_sr &=3D value;
>          }
> -        if (!(s->usart_sr & USART_SR_RXNE)) {
> -            qemu_set_irq(s->irq, 0);
> -        }
> +        stm32f2xx_update_irq(s);
>          return;
>      case USART_DR:
>          if (value < 0xF000) {
> @@ -168,10 +175,7 @@ static void stm32f2xx_usart_write(void *opaque, hwad=
dr addr,
>          return;
>      case USART_CR1:
>          s->usart_cr1 =3D value;
> -            if (s->usart_cr1 & USART_CR1_RXNEIE &&
> -                s->usart_sr & USART_SR_RXNE) {
> -                qemu_set_irq(s->irq, 1);
> -            }
> +        stm32f2xx_update_irq(s);
>          return;
>      case USART_CR2:
>          s->usart_cr2 =3D value;
> --
> 2.41.0
>
>

