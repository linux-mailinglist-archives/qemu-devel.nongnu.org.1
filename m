Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF77D6CA0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:02:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdUt-0001DX-6e; Wed, 25 Oct 2023 09:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvdUi-0001C9-5I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:00:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvdUe-0001Me-Mr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:00:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso8507470a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698238812; x=1698843612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OZjvdPUkJnBdzOo5qN/r9+7BQ/bPVu2nmeJmZHWKKw=;
 b=Fpy1+h0AgphU1g5zry6tP8/gy7iDKKD3ajS06z+y6KDZOmfF65CZ+Dzy3+aYllH4O8
 VIT6YYVtHQV0NeaqtEKbglioy5jgDMvjPQTHiT4d4LOJy/ZFCNkcbbw7SInMaP23nNu7
 eOmM/LilArggjugseXNCc5nn1U4+Ro0L0lGSwin1//T4y2ErC7IcQgGOjRFTaPlYiFlu
 uSd4eeOzw2UVB0PBJG/Xjz4Q2TA67hEk/DWXsdmPKFOiLiB5IPrj/2wP+exsGGQbxKgH
 Xs/JGQnMf11BgSyopjYyRurVp+l6ikrzlJ7hP/E4IYXUpJZ4rbxR1DUDwLoAI19zTEDt
 OZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698238812; x=1698843612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OZjvdPUkJnBdzOo5qN/r9+7BQ/bPVu2nmeJmZHWKKw=;
 b=iveI5n31k9uAILtmM8N9etZdfIi2fVDDG2qlJqJiCnLWVcSLbDjPtkTly1ItEuQL9z
 tqoJ7pQkuA+Q4RVr3eNYrCPpOPt7Je3gHRA3gKrW9cSqo1smoPiqY05kgcc9QHJhkueE
 qY3LEKwJFIbftIZkjaT6b+dzO/M6vflv5MX3v/aWWtvinHs8HZ10HRoBXFsiY5ZP5MBd
 uVgRTGallvKA28JtznHAJpqanOGccpnZ5Oqoavele6qHxFFhU4Bv/mh78U09EWBrs+Tg
 d5zdCWVF+MYQqQsZeEvDJoDt1TitLzmEKHwjlQJaAXsZuS9G9blQ7LcLUOB9Ok2MP8WU
 zh+Q==
X-Gm-Message-State: AOJu0YyyVT1naRglZyYOkvb8x47njdKzJxMt/z/dRGeuH43nXj3dt3NK
 c9xwJnurJw1DyLjzb/e4GjKzD1Fav237D4JNwBS/ow==
X-Google-Smtp-Source: AGHT+IHD/G7Gxjl5baJ8CA81j6EOPXpnI9IXFSzvPWtJqr4jO7SLZsf16kiKATcTzwl9VJmr8If6nKelPQwnRohdzec=
X-Received: by 2002:a05:6402:5243:b0:53d:a4a3:e5cc with SMTP id
 t3-20020a056402524300b0053da4a3e5ccmr10851369edd.42.1698238811900; Wed, 25
 Oct 2023 06:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231024191945.4135036-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20231024191945.4135036-1-milesg@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2023 13:59:25 +0100
Message-ID: <CAFEAcA-9mPtVWfpx=fbALZEaOPX6b5aEAtcRgDCpzfH4keLEcQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] misc/led: LED state is set opposite of what is
 expected
To: Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, 
 andrew@codeconstruct.com.au, joel@jms.id.au, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 24 Oct 2023 at 20:20, Glenn Miles <milesg@linux.vnet.ibm.com> wrote:
>
> Testing of the LED state showed that when the LED polarity was
> set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
> the input GPIO of the LED, the LED was being turn off when it was
> expected to be turned on.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>
> Changes from v1:
>     - Changed logic for readability
>
>  hw/misc/led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> index f6d6d68bce..42bb43a39a 100644
> --- a/hw/misc/led.c
> +++ b/hw/misc/led.c
> @@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
>      LEDState *s = LED(opaque);
>
>      assert(line == 0);
> -    led_set_state(s, !!new_state != s->gpio_active_high);
> +    led_set_state(s, !!new_state == s->gpio_active_high);
>  }
>
>  static void led_reset(DeviceState *dev)
> --
> 2.31.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

