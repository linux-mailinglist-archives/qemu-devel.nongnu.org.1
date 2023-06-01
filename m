Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9B71996E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fP2-0002TL-1A; Thu, 01 Jun 2023 06:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4fOz-0002SM-Bd
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:19:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4fOx-0003KQ-OS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:19:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-514953b3aa6so1037975a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685614766; x=1688206766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUPPTHrrmmF7AmHwkQAkl81gL1fMGaREzxmlmvZ1Y8Y=;
 b=y4cLi2HAWtxX0aIAFzW4SLV05StnHRsulNklN+R0xB0BUHtUfBo6ATBnnYC1wG4Gjh
 B8KXUgywKXLTXQWegKBcFIec54lDj1wFdczK6fZGrA7znYuMt55/1fwaKryFrMfm9Z8B
 F3wpqXxPxDd5uYI5+yl0WCo/9zT5Xy+HuUV9Qm9KAooJWhl2KGI2ZoRD3dhwloqjJbgH
 vv2/WKqbXPNZjPuwI5PGSbgiAQDSl3xtVaK4y7SNo7P+Y/auy1g93UV6nRom5YmwPTkb
 ck+5grW/cIzCH6e9K42J1CIjcGLmNywhG1hlKty9bj+pNXfn8O7HmJAoW0n50rDjHQ2a
 zhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685614766; x=1688206766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUPPTHrrmmF7AmHwkQAkl81gL1fMGaREzxmlmvZ1Y8Y=;
 b=Ui0PKXmVI/Vzuf8TUYI1QTGzyNLrj1YWciqvxyb08UYs6exUIXSB+4jletvQ+JqvKN
 KVgkhx40NZR0E3MokRHAgWOHYfRYNkbfkd91q/ABq6X+ClGsGDZ4posH+2RzNzdH5AJ/
 BAdkq3DLj+FeP1xhqaaCvaHwEdqZNLM1UK7kdQjHpJWmiGztJTmQrBywJyAxv4n1JORD
 5hnw0Gk5boGXw3t4oHw+6uI5ioTsHximfhdrDM09pbwTeiH5p53aByMgZqfMICB06Ym3
 jtVmuELHe4jbeF2gIcdbAVo+mjDZ/oe6ao0oGmtQl3TbKexHH8pN3DYnHpgJjT7Ni9kF
 OTMg==
X-Gm-Message-State: AC+VfDxhWRfe0va66UV+fSvRjpv1aUy0DRgIgaqfime8p5fLcO2xtjz+
 HsWrT4Bho0fw95CxYeLB2wzK8uing8secw+mAhSWww==
X-Google-Smtp-Source: ACHHUZ7RPkqkjR1tX/Ia6GBMMZsol8QBghKtDw+QXmV5S0ZBxdKbOsttAe6djyAfbpy5XN39FTFMnyJwu4fdyzHx0Yo=
X-Received: by 2002:a05:6402:3ce:b0:514:eb2c:4822 with SMTP id
 t14-20020a05640203ce00b00514eb2c4822mr3057478edw.4.1685614765959; Thu, 01 Jun
 2023 03:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230601094625.39569-1-philmd@linaro.org>
 <20230601094625.39569-8-philmd@linaro.org>
In-Reply-To: <20230601094625.39569-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 11:19:14 +0100
Message-ID: <CAFEAcA8wgaEJd03G8gNtFOUFT0jpm=KLfaZSjeYcOgvTYdvhJQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] hw: Simplify using sysbus_init_irqs() [manual]
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 1 Jun 2023 at 10:48, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Audit the sysbus_init_irq() calls and manually convert
> to sysbus_init_irqs() when a loop is involved.
>
> In omap2_intc_init(), the parent_intr[] array contains
> 2 elements: use ARRAY_SIZE() to iterate over.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
> index c15f654738..dd2929d6e7 100644
> --- a/hw/timer/renesas_tmr.c
> +++ b/hw/timer/renesas_tmr.c
> @@ -428,17 +428,14 @@ static void rtmr_init(Object *obj)
>  {
>      SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
>      RTMRState *tmr =3D RTMR(obj);
> -    int i;
>
>      memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
>                            tmr, "renesas-tmr", 0x10);
>      sysbus_init_mmio(d, &tmr->memory);
>
> -    for (i =3D 0; i < ARRAY_SIZE(tmr->ovi); i++) {
> -        sysbus_init_irq(d, &tmr->cmia[i]);
> -        sysbus_init_irq(d, &tmr->cmib[i]);
> -        sysbus_init_irq(d, &tmr->ovi[i]);
> -    }
> +    sysbus_init_irqs(d, tmr->cmia, ARRAY_SIZE(tmr->cmia));
> +    sysbus_init_irqs(d, tmr->cmib, ARRAY_SIZE(tmr->cmib));
> +    sysbus_init_irqs(d, tmr->ovi, ARRAY_SIZE(tmr->ovi));

Doesn't this change the order of the IRQs? Previously
we had channel 0 CMIA, channel 0 CMIA, channel 0 OVI,
channel 1 CMIA, channel 1 CMIB, channel 1 OVI. Now
we have channel 0 CMIA, channel 1 CMIA, channel 0 CMIB,
channel 1 CMIB, channel 0 OVI, channel 1 OVI. So they'll
get miswired in the board code now...

thanks
-- PMM

