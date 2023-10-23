Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F317D2811
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 03:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qujtE-00032K-5D; Sun, 22 Oct 2023 21:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujtB-0002zW-C5; Sun, 22 Oct 2023 21:37:53 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qujt9-0002sK-RS; Sun, 22 Oct 2023 21:37:53 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b6e3dc54e0so1818175241.1; 
 Sun, 22 Oct 2023 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698025070; x=1698629870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqseqGmsRb9aZIeDmS9PEuQ20yiaKMX4z00p0uiuwvw=;
 b=POg+gvD5vzOfuvavI8FryKGJD26wuuyz9pXk1CYO3+60/FDBnRKl3jYOVS+WrgA4bq
 6p3pMdMjCymn0J6w1h+jjsjiTZac/72lrfadGnaGz2/sz3hnhh6eqT31oRuR9i0j+m1B
 5SUs/2ldYiW5bVPRv8zJWldtAi6HmNmdgneni9Ardh6/RWSbPaFkE7G626zhvKb+lOs+
 p+sm76bjm3xiTtZ+W5xt8Ezw0s1b25o5Te6i4uSXnKyc4rBOOsbsOIoIngpeIEIPbCcG
 h9ptlJ6L+oMeDFzggMIPFaLKLMICkxg3Rm3C8kby2mkPAuvCxrWe/rjoncnrFowksq/b
 ZfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698025070; x=1698629870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqseqGmsRb9aZIeDmS9PEuQ20yiaKMX4z00p0uiuwvw=;
 b=adc7DfSeHWA6rAL1xuYlzBpNV8mZ3ptOycpsZOYPUInuCK+k6NUZtC4cGcvdIw5Gpf
 NALw8uBCIPDh2Yiopjt0TrdsatEDNKIrr17iaTtZJtdEjyFJ3JmGuXeJPdinoUb0ZWYP
 UKj0PuTxf3i6EK7JyFGRuseGHtsyCGOgto/x2IbwBGGXSHX75+3OPOKLh0uBG/d9Kf/g
 a3ZFDWHXWiZ5hl6Bd2IfQ5JHjWXxOQsbf3XSNsQn2RfpHuS3/O0Cf5wWb9JTF0zuKtmA
 mbRPAVZUwDUb1FGh1aHEnzcLE4IlwvQz5696AbZAdua8CidMxsahW49kMvO7H1VnvD28
 xGgg==
X-Gm-Message-State: AOJu0Ywq8mO7wzR7T3U3X5PSPTwpHyx83POh9GvP8Y3nKcn2pFBpSt1w
 Mm7dxWrv8BcS3aGHj/pa20vg9jVD89Jpk4S6L1Y=
X-Google-Smtp-Source: AGHT+IFU/N1cTYyvyQYuH4rvLdeo1Xh2jjt17TIByfdlS7GDcJpn0zqmdwEKMYv5w2MFB414MheWyGz4v3p9/D3uyho=
X-Received: by 2002:a05:6102:205b:b0:452:618b:13e3 with SMTP id
 q27-20020a056102205b00b00452618b13e3mr4201069vsr.9.1698025070472; Sun, 22 Oct
 2023 18:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231020170009.86870-1-philmd@linaro.org>
 <20231020170009.86870-4-philmd@linaro.org>
In-Reply-To: <20231020170009.86870-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Oct 2023 11:37:23 +1000
Message-ID: <CAKmqyKP39XHT5ny5UKvVj01sZRVy6tREZSe2+bXVvvT34UJk3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/char/stm32f2xx_usart: Update IRQ when DR is
 written
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Sat, Oct 21, 2023 at 3:01=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
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
>  hw/char/stm32f2xx_usart.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 46e29089bc..74f007591a 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -169,6 +169,7 @@ static void stm32f2xx_usart_write(void *opaque, hwadd=
r addr,
>                 clear TC by writing 0 to the SR register, so set it again
>                 on each write. */
>              s->usart_sr |=3D USART_SR_TC;
> +            stm32f2xx_update_irq(s);
>          }
>          return;
>      case USART_BRR:
> --
> 2.41.0
>
>

