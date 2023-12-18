Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C78177A1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:37:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGau-00031Q-CZ; Mon, 18 Dec 2023 11:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGas-000315-Ur
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:35:50 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGar-0000We-2B
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:35:50 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e3c6f1c10so1307390e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702917347; x=1703522147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kIO0Il9LLINrqLrssLbrvYj3RvRqz983KtfXAKLTwXA=;
 b=LF23XuqGeoo/MK5+l58siFMosZF+v3aXgOSe73Hs6WLWRXOw3IjlA7G+HcnQTNGktz
 IsDLrBbvdfL4q3+wpZrZ9IEeGp2hyG8fxPRsyL6fa79a/bPGrr3h5SMyH4nmUE76Pl4r
 zKnO+ISO5DIh0ATKA7KmTuoc1jGaVjw9VXnnnWoVP6kebLgC4eQLm6Bp4l3GvHMeVrZV
 nzoC+xFlsBFYt7tw6oOiOG9s43IdL8MfOHwnZV+vU465W5ZZqBJzcteDQ/N3Je/nITE/
 u7zkwOmtQC1rTvF8T+6iAM9Ut3iDRYyT55fwFRPo3A36QPN7sZP2pB1q4zDjBaDt5Y59
 xc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702917347; x=1703522147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIO0Il9LLINrqLrssLbrvYj3RvRqz983KtfXAKLTwXA=;
 b=jCqMQcCIZrMoOwjhno5qZa1tmitTGg4CrPJgnxvJHh+Ynxh+inh0onmXaWzs+0E44q
 KWvhgkJIeheTL9RXYpn6zpsXFDSUiOx3LI/h9pk5Qd54AC4S6wYK6FjqHHTnxKv/DVlE
 BtoL19u2fETp0lcZxzzCEM81aHBt4YMfOIjxzQfPyXl6sqBzP0O5fmc+sUIx8wk2lmaI
 bLmOJ4rMWf0M6/fS3uQOcGH7TC13NQfw5N5WDoHtHyq1FkpmR5Kem6DpBQDJRKfH9z1f
 psnoceMT1V6ry3JYNEEbUiGm3cxdSEDJIrIfeUD+m5O0Z1yNDChTeOjITzYtuuv5O0UI
 pE7Q==
X-Gm-Message-State: AOJu0YxHHkPMtxee/da1Nj3QO3s5QIlctBbphtUt6zgB+cIBstwqGPac
 HhzO4C9u//+9KjFUTIi/mrCj32jlOYjeGxVaC9RHmg==
X-Google-Smtp-Source: AGHT+IEUh68S1jDgPNIRmce7+G3hSAv6Fsp6arq1dUUI/lYQgsY1LhHnt/14HFBpne8TLSr1Wku4H6xfHpF8xwS6JGk=
X-Received: by 2002:ac2:4892:0:b0:50e:297b:ed0a with SMTP id
 x18-20020ac24892000000b0050e297bed0amr717395lfc.132.1702917346876; Mon, 18
 Dec 2023 08:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-8-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-8-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:35:36 +0000
Message-ID: <CAFEAcA812WHybPZCw5vY_=ODgErU4+FzJoKPy7gPSwQQ-e4czw@mail.gmail.com>
Subject: Re: [PATCH v4 07/45] Implement BCM2838 GPIO functionality
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/gpio/bcm2838_gpio.c | 192 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 189 insertions(+), 3 deletions(-)

>  static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
>  {
> +    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
>      uint64_t value = 0;
>
> -    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
> -                  TYPE_BCM2838_GPIO, __func__, offset);
> +    switch (offset) {
> +    case GPFSEL0:
> +    case GPFSEL1:
> +    case GPFSEL2:
> +    case GPFSEL3:
> +    case GPFSEL4:
> +    case GPFSEL5:
> +        value = gpfsel_get(s, offset / BYTES_IN_WORD);
> +        break;
> +    case GPSET0:
> +    case GPSET1:
> +    case GPCLR0:
> +    case GPCLR1:
> +        /* Write Only */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt reading from write only"
> +                      " register. %lu will be returned. Address 0x%"HWADDR_PRIx
> +                      ", size %u\n", TYPE_BCM2838_GPIO, __func__, value, offset,
> +                      size);

'value' is a uint64_t, but you try to print it with a %lu format
string here. This won't compile on 32-bit machines. (In general
watch out for %lu %lx etc and don't use them unless the type
really is "long".)

You can get the compiler to tell you about these format issues by
any of the following options:
 * building for a 32-bit host (eg i386)
 * building for macos (the macos clang is stricter about these even
   when building for a 64-bit)
 * running your patches through the gitlab CI setup: fork the QEMU
   project on gitlab as an ordinary gitlab user; then push your
   branch to your fork of the repo with some environment variables
   set to trigger a CI pipeline run:
   https://www.qemu.org/docs/master/devel/ci.html#custom-ci-cd-variables


>  static void bcm2838_gpio_reset(DeviceState *dev)
>  {
>      BCM2838GpioState *s = BCM2838_GPIO(dev);
>
> +    memset(s->fsel, 0, sizeof(s->fsel));
> +
>      s->lev0 = 0;
>      s->lev1 = 0;

I think this bit should go in the previous patch since we added
s->fsel there and do the other reset code there already.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

