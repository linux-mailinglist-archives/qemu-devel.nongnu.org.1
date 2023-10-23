Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBA7D2810
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 03:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qujsP-0001g8-9A; Sun, 22 Oct 2023 21:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujsN-0001fL-6f; Sun, 22 Oct 2023 21:37:03 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujsL-0002ob-P7; Sun, 22 Oct 2023 21:37:02 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7b652e785dbso1040031241.0; 
 Sun, 22 Oct 2023 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698025020; x=1698629820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKCog19UpRbCVEHNVCgHNEUYu8Mhg2C8RE/Hafk9Tqo=;
 b=J5dHGEwPUo6aRiWGGjLvQiw/mxqUIMU24uktFfP9z9xvyFk/1uwe5UtslQ5BM87sxA
 g8f8qvGIhC70Xly+Pv1OT2Gp1o7Q/OgYWYMZIIb2PyCmWjYF2ZW3oGxm2SDOoIPvk18E
 i6fsCuXuZTQg48HBy4mQzkBqpxKs+UE6PbO7V4Yx2lcAVVYGhUR3NtD2xdYlO1voA3oH
 2EL7Sc57hYBZl4quqoxW/aYt3lFEj++Y+yQD3m9hpSjJzImK07RII53LimRgP2Bv4OTI
 LBmjw3NtlpEtcxyAhjd+nQxESRjXLalvUcgqru0rarFJLunu9LLoyiERA1toRyNk3/DI
 MGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698025020; x=1698629820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKCog19UpRbCVEHNVCgHNEUYu8Mhg2C8RE/Hafk9Tqo=;
 b=ulSXrskIaHZATFGGYrDC5Md9KTMmq0n7HYUkSKYahj1KFeBdfA7y3VzbAzxpj+49yw
 PNc3B35IXjtX8LEferxxnx52QE3BEL6OKsjpL5++C0V+lIK5QmbdSPS3uWhws0CxXZyR
 TwXGrfZxduhzlz2H4zC8pu47tPG4wwxIAaDAifp8evjT+NE6+7J3lAsDFFjzv3nEKcig
 i14efqBsOkWaRo8WKSnLLTpT2iZLmy0P5E8S3srt/N6CENooTZTdWyeknUtm7erIQZdJ
 lsja+HzRl9rDyqEZD9gO7zQNf9NX/93G64w6O6RMFX3FzALbWtBtZ0Uk1q055yrVoUvf
 v9Tg==
X-Gm-Message-State: AOJu0YxnVbVsynrp+Dk2C8I4TcFL059Au5lSMCiur3s3qRnXdrlI/hEU
 R8dkqJl2QyY5bYYMfUf2IWPpVfODjyz0PRMKoY4=
X-Google-Smtp-Source: AGHT+IFgI5J5RNmGhms5Uk/JoV08tTqxmH+O+usmPgvZexWvafLXAVYMU+Oua3mXYz6Zy9JShj4Oln51rfwBV+xiDY0=
X-Received: by 2002:a67:e192:0:b0:457:e881:32c6 with SMTP id
 e18-20020a67e192000000b00457e88132c6mr6575076vsl.11.1698025020238; Sun, 22
 Oct 2023 18:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-3-philmd@linaro.org>
In-Reply-To: <20231020170009.86870-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Oct 2023 11:36:33 +1000
Message-ID: <CAKmqyKPJoyMmoNAX9JrHz6_SSphqRkEJPy3AUaV0eu+701Ow9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/char/stm32f2xx_usart: Update IRQ when SR is read
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Sat, Oct 21, 2023 at 4:12=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
>
> Signed-off-by: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
> [PMD: Split from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Is this required?

I don't think this is required

Alistair

> ---
>  hw/char/stm32f2xx_usart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 519d3461a3..46e29089bc 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -109,6 +109,7 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hw=
addr addr,
>      case USART_SR:
>          retvalue =3D s->usart_sr;
>          qemu_chr_fe_accept_input(&s->chr);
> +        stm32f2xx_update_irq(s);
>          return retvalue;
>      case USART_DR:
>          DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->us=
art_dr);
> --
> 2.41.0
>
>

