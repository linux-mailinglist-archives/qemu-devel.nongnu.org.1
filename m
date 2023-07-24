Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8946175FB91
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNy9F-0005xA-BF; Mon, 24 Jul 2023 12:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNy90-0005vd-3L
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:10:47 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNy8y-0005cz-5p
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:10:45 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so6739419e87.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690215042; x=1690819842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4A7HnlNR4y+LiYMI6gxgLeOOWyF7e54galRz7wGSfw=;
 b=xm9w+aKML9zzBDSeIXkf1KIrAjdJ2b99uCuaMcU7/UK7Yxtt/JkLw+f/8x49F8ZR6Q
 pzBgQI2bEQzEg8C8sRrf0Eas6xXm9frm43FQM8TLiVZ4qaf3+mT3ABLObGkxV3s1YBdR
 aWlAFYlxd3dQ8obyVpm8WHGQiSMnL4IRy2+Zl6rYwasTagjiLkZlzaXgAmz/F8eI4y2I
 49/6qaDPUBYWGT/nTxT+Nh3CBMhnPmiDkotkg/2sTDxV7jOJsxd8QcjMBtSczRDSVNrv
 WyvFF9vm8oUFpzs4xTtMZFlZnW1vmb84LOjxO/5DMAONQTG4VxSmnak633EKAHS04/3r
 P1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690215042; x=1690819842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p4A7HnlNR4y+LiYMI6gxgLeOOWyF7e54galRz7wGSfw=;
 b=OYVvaAG/QwI4Q4QgKS4k8+Ogal4nKGtgCCBX6fhVec+WB5z31lJLkOYaKO9a6Cg9cR
 OM7YdLnJmAwqhYFNZnhzb0UxZlRbn+9b3NelhbXnAvSQQAKMU8TFkSoBlpk1s0KgwKDK
 m+K1HA8ErfyIfQy+jlzCfayru+RROk4XMJ7jlzzPTimBWBYy08R3PJZE73dL0/GgzRSz
 hlDJqe/zmkC0xWeHoh1KjlWnSvvl4gtYluX41dNQgtYld03Ex1na85tsPakanx/wcg6/
 prNkNoHLXRyN88LFiXF+cL9wANTtKVHZU5/m/658eo5y6DK1NgiexojAVGxD8F0bKL+G
 u9hw==
X-Gm-Message-State: ABy/qLaMd62NDzr3otGp3xuLEJboMgUk5eEcPe2S/aXLS0mqBVo8Uhc5
 NPGjo1/ZSfE/8khpyiZ6vIKTDvI0JeN8vfj6qI/VIQ==
X-Google-Smtp-Source: APBJJlGAYoz5dBmMEZqopavMHOnoNmcC5Ds7+lB8C6U4YhR3tc4LjfU7khkDTtKNqR6g2S7eEnu71UfPhYvCTfnQsTQ=
X-Received: by 2002:a19:6450:0:b0:4f9:607a:6508 with SMTP id
 b16-20020a196450000000b004f9607a6508mr4434019lfj.50.1690215041844; Mon, 24
 Jul 2023 09:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
 <20230714232659.76434-2-chris@laplante.io>
In-Reply-To: <20230714232659.76434-2-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 17:10:30 +0100
Message-ID: <CAFEAcA9hqBqGWgVXVsxwxSAOUbW1_hsyEC2MqdF=rmPumtbaGw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/gpio/nrf51: implement DETECT signal
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Sat, 15 Jul 2023 at 00:27, Chris Laplante <chris@laplante.io> wrote:
>
> Implement nRF51 DETECT signal in the GPIO peripheral.
>
> The reference manual makes mention of a per-pin DETECT signal, but these
> are not exposed to the user. See https://devzone.nordicsemi.com/f/nordic-q-a/39858/gpio-per-pin-detect-signal-available
> for more information. Currently, I don't see a reason to model these.

I agree -- they seem to be internal to the GPIO module,
so we don't need to model them as qemu_irq lines.

> Signed-off-by: Chris Laplante <chris@laplante.io>
> ---
>  hw/arm/nrf51_soc.c           |  1 +
>  hw/gpio/nrf51_gpio.c         | 14 +++++++++++++-
>  include/hw/gpio/nrf51_gpio.h |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 34da0d62f0..7ae54e18be 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -150,6 +150,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>
>      /* Pass all GPIOs to the SOC layer so they are available to the board */
>      qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
> +    qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, "detect");

Is the DETECT line really exposed external to the SoC?
I had a look at the nRF51822 datasheet and it suggests not.
For purposes of supporting the wake-up-on-gpio functionality
we don't need to expose it to the board -- the SoC layer
can just wire it up to the POWER device. (In fact, exposing
it to the board makes it harder, because you can't connect
one qemu_irq to two places, so if we let the board connect
it somewhere then the SoC can't conveniently connect it
to the POWER device without doing extra work to split it.)

The logic for calculating DETECT looks good to me.

thanks
-- PMM

